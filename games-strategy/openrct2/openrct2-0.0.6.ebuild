# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Open source re-implementation of Roller Coaster Tycoon 2"
HOMEPAGE="https://openrct2.website/"
SRC_URI="https://github.com/OpenRCT2/OpenRCT2/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/OpenRCT2/title-sequences/releases/download/v0.0.5/title-sequence-v0.0.5.zip -> ${PN}-title-sequences-0.0.5.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+multiplayer +opengl +ttf +twitch"

DEPEND="dev-libs/jansson:0
	dev-libs/libzip:0
	media-libs/libpng:0
	media-libs/libsdl2:0
	media-libs/speex:0
	multiplayer? (
		|| (
			dev-libs/openssl:0
			dev-libs/libressl:0
			)
		)
	opengl? ( virtual/opengl )
	ttf? (
		media-libs/fontconfig:1.0
		media-libs/sdl2-ttf:0
		)
	twitch? ( net-misc/curl:0 )
	"
RDEPEND="${DEPEND}"
REQUIRED_USE="multiplayer? ( twitch )"

S="${WORKDIR}/OpenRCT2-${PV}"

#src_prepare() {
#	sed -i 's/-Werror //' CMakeLists.txt
#
#	default
#}

#src_unpack() {
#	unpack "${P}.tar.gz"
#}

src_prepare() {
	sed -i "/^install(CODE \"file(DOWNLOAD/d" CMakeLists.txt || die

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DDISABLE_NETWORK=$(usex multiplayer off on)
		-DDISABLE_OPENGL=$(usex opengl off on)
		-DDISABLE_TTF=$(usex ttf off on)
		-DDISABLE_HTTP_TWITCH=$(usex twitch off on)
	)

	cmake-utils_src_configure
}

src_install() {
	mkdir -p "${D}/usr/share/${PN}/title/" || die
	mv "${DISTDIR}/${PN}-title-sequences-0.0.5.zip" "${D}/usr/share/${PN}/title/title-sequences.zip" || die

	cmake-utils_src_install
}
