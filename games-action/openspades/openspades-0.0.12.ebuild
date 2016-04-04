# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils versionator toolchain-funcs

DESCRIPTION="OpenSpades is a clone of Voxlap Ace of Spades 0.75"
HOMEPAGE="http://github.com/yvt/openspades"
SRC_URI="https://github.com/yvt/openspades/archive/v${PV}.tar.gz
		https://github.com/yvt/openspades/releases/download/v${PV}/OpenSpades-${PV}b-Windows.zip
		http://yvt.jp/files/programs/osppaks/DevPaks27.zip"
IUSE=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=sys-devel/gcc-4.8
	>=media-libs/libsdl2-2.0.2
	media-libs/sdl2-image
	net-misc/curl
	virtual/opengl
	x11-libs/fltk
	"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
}

src_prepare() {
	# fix build error, maybe related to https://bugs.gentoo.org/show_bug.cgi?id=383179
	epatch "${FILESDIR}/openspades-zlib.patch"

	# disable downloading additional files during compilation
	echo -e "#!/bin/sh\nexit 0" > "${S}"/Resources/downloadpak.sh || die
}


src_configure() {
	local ver=4.8.0
	local msg="${PN} needs at least GCC ${ver} set to compile."

	if ! version_is_at_least ${ver} $(gcc-fullversion); then
		eerror ${msg}
		die ${msg}
	fi

	# install to /opt as it keeps everything under one directory
	local mycmakeargs=(
		-DOPENSPADES_INSTALL_BINARY=bin
		-DOPENSPADES_INSTALL_RESOURCES=share/openspades/Resources
	)
	cmake-utils_src_configure
}

src_install() {
	mkdir "${BUILD_DIR}"/Resources/DevPak || die
	mv "${WORKDIR}"/*.pak "${BUILD_DIR}"/Resources/DevPak/ || die

	cmake-utils_src_install
}
