# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils versionator toolchain-funcs

DESCRIPTION="OpenSpades is a clone of Voxlap Ace of Spades 0.75"
HOMEPAGE="http://github.com/yvt/openspades"
SRC_URI="https://github.com/yvt/openspades/archive/v${PV}.tar.gz
		https://github.com/yvt/openspades-paks/releases/download/r33/OpenSpadesDevPackage-r33.zip"
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

src_prepare() {
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
	mkdir "${BUILD_DIR}"/Resources/
	mv "${WORKDIR}"/Nonfree/*.pak "${BUILD_DIR}"/Resources/ || die
	mv "${WORKDIR}"/OfficialMods/*.pak "${BUILD_DIR}"/Resources/ || die

	cmake-utils_src_install
}
