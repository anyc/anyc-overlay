# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="OpenSpades is a clone of Voxlap Ace of Spades 0.75"
HOMEPAGE="http://github.com/yvt/openspades"
SRC_URI="https://github.com/yvt/openspades/archive/v${PV}.tar.gz
		https://github.com/yvt/openspades/releases/download/v${PV}/OpenSpades-${PV}-Windows-msvc.zip"

IUSE=""
LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"

DEPEND="
	media-libs/libsdl
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
	
	mv ${WORKDIR}/OpenSpades-0.0.9-Windows-msvc/Resources/pak002-Models.pak \
		${WORKDIR}/OpenSpades-0.0.9-Windows-msvc/Resources/pak001-Models.pak
	
	mv ${WORKDIR}/OpenSpades-0.0.9-Windows-msvc/Resources/pak001-Sounds.pak \
		${WORKDIR}/OpenSpades-0.0.9-Windows-msvc/Resources/pak002-Sounds.pak
}


src_configure() {
	# install to /opt as it keeps everything under one directory
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/opt/${PN}
		-DOPENSPADES_RESDIR:STRING=${WORKDIR}/OpenSpades-0.0.9-Windows-msvc/Resources/
	)
	cmake-utils_src_configure
}

src_install() {
	into /opt
	dobin "${FILESDIR}/openspades"

	cmake-utils_src_install
}