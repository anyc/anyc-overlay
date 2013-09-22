# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-multilib toolchain-funcs python subversion

DESCRIPTION="EXIF and IPTC metadata C++ library and command line utility"
HOMEPAGE="http://www.exiv2.org/"

ESVN_REPO_URI="svn://dev.exiv2.org/svn/trunk@2991"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE_LINGUAS="de es fi fr pl ru sk"
IUSE="doc examples nls png xmp static-libs $(printf 'linguas_%s ' ${IUSE_LINGUAS})"

RDEPEND="
	virtual/libiconv
	nls? ( virtual/libintl )
	xmp? ( dev-libs/expat )
	png? (
		sys-libs/zlib
		media-libs/libpng
	)
"

DEPEND="${RDEPEND}
	doc? (
		app-doc/doxygen
		dev-libs/libxslt
		virtual/pkgconfig
		media-gfx/graphviz
		=dev-lang/python-2*
	)
	nls? ( sys-devel/gettext )
"

DOCS=( README doc/ChangeLog doc/cmd.txt )

src_prepare() {
	# convert docs to UTF-8
	local i
	for i in doc/cmd.txt; do
		einfo "Converting "${i}" to UTF-8"
		iconv -f LATIN1 -t UTF-8 "${i}" > "${i}~" && mv -f "${i}~" "${i}" || rm -f "${i}~"
	done

	if use doc; then
		einfo "Updating doxygen config"
		doxygen 2>&1 >/dev/null -u config/Doxyfile
		python_convert_shebangs -r 2 doc/templates
	fi

	# set locale to safe value for the sed commands (bug #382731)
	sed -i -r "s,(\s+)sed\s,\1LC_ALL="C" sed ,g" src/Makefile

	sed -i -r "s,DESTINATION man/man1,DESTINATION share/man/man1," src/CMakeLists.txt
	
	epatch "${FILESDIR}/exiv2-multilib.patch"
}

exiv2_flag() {
	if use $2; then
		val=ON
	else
		val=OFF
	fi
	echo "-DEXIV2_ENABLE_$1=$val"
}

src_configure() {
	local mycmakeargs=()

	mycmakeargs+=( 
		$(exiv2_flag XMP xmp)
		$(exiv2_flag PNG png)
		$(exiv2_flag NLS nls)
		$(exiv2_flag BUILD_SAMPLES examples)
		-DEXIV2_ENABLE_BUILD_PO=ON
		)
	
	cmake-multilib_src_configure
}

src_install() {
	cmake-multilib_src_install

	use xmp && dodoc doc/{COPYING-XMPSDK,README-XMP,cmdxmp.txt}
	use doc && dohtml -r doc/html/.

	for l in ${IUSE_LINGUAS}; do
		if ! use linguas_$l ; then
			rm "${D}/usr/share/locale/${l}/LC_MESSAGES/exiv2.mo"
		fi
	done
}
