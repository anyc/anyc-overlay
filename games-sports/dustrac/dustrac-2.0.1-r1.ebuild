# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils gnome2-utils cmake-utils

DESCRIPTION="Top-down car racing game"
HOMEPAGE="http://juzzlin.github.io/DustRacing2D/"
#SRC_URI="https://github.com/juzzlin/DustRacing2D/archive/${PV}.tar.gz -> ${P}.tar.gz"
COMMIT="7e240803c564c5fe5682d3ca3a4d668ded4b0782"
SRC_URI="https://github.com/juzzlin/DustRacing2D/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+ CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	dev-qt/qtxml:5
	media-libs/libvorbis
	media-libs/openal
	virtual/opengl"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5
	dev-qt/qttest:5
	virtual/pkgconfig"

#S="${WORKDIR}/DustRacing2D-${PV}"
S="${WORKDIR}/DustRacing2D-${COMMIT}"

src_configure() {
	# -DGLES=ON didn't build for me but maybe just need use flags on some QT package?
	# Maybe add a local gles use flag
	local mycmakeargs=(
		-DReleaseBuild=ON
		-DDATA_PATH="/usr/share/${PN}"
		-DBIN_PATH="/usr/bin"
		-DDOC_PATH=/usr/share/doc/${PF}
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
