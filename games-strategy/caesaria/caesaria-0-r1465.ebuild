# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ "${PV}" == "9999" ]]; then
	MY_INHERIT=git-r3
fi

inherit games $MY_INHERIT cmake-utils

DESCRIPTION="Remake of the Caesar III strategy game"
HOMEPAGE="https://bitbucket.org/dalerank/caesaria"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://bitbucket.org/dalerank/caesaria.git"
else
	SRC_URI="https://bitbucket.org/dalerank/caesaria/get/35f1851.tar.gz -> ${PF}.tar.gz"
fi


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sgreader"

DEPEND="media-libs/libsdl
	media-libs/libpng
	media-libs/sdl-ttf
	media-libs/sdl-mixer

	sgreader? ( x11-libs/libqxt )
	"
RDEPEND="${DEPEND}"

MY_DATADIR="${GAMES_DATADIR}"/${PN}

src_unpack() {
	if [[ "${PV}" != "9999" ]]; then
		default
		mv "${WORKDIR}"/* "${WORKDIR}/${P}"
	else
		git-r3_src_unpack
	fi
}

src_prepare() {
	# use system libraries if possible
	epatch ${FILESDIR}/caesaria-systemlibs.patch

	# disable updater
	sed -i "s/add_subdirectory(updater updater)//g" CMakeLists.txt || die

	if use sgreader; then
		echo "add_subdirectory(sgreader sgreader)" >> CMakeLists.txt
	fi
}

src_configure() {
	# use builtin LZMA, linking with p7zip fails
	# use builtin AES, custom implementation
	local mycmakeargs=(
                -DBUILD_ZLIB=OFF
		-DBUILD_AES=ON
		-DBUILD_BZIP=OFF
		-DBUILD_LZMA=ON
		-DBUILD_CURL=OFF
		-DBUILD_PNG=OFF
        )
        cmake-utils_src_configure
}

src_install() {
	echo -e "#!/bin/sh\n\ncaesaria.linux -R ${MY_DATADIR}" > caesaria

	dogamesbin caesaria
	dogamesbin ${WORKDIR}/caesaria-test/caesaria.linux

	use sgreader && dogamesbin ${BUILD_DIR}/sgreader/sgreader

	dodoc docs/*

	keepdir "${MY_DATADIR}/resources/"

	prepgamesdirs
}

pkg_postinst() {
	elog "This ebuild only installs the executable _without_ artwork and"
	elog "other required files for this game. See their homepage"
	elog "${HOMEPAGE}"
	elog "for more information and for instructions how to obtain those"
	elog "files from the official Caesar CD. Then put them into:"
	elog "${MY_DATADIR}/resources/"
}
