# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="Open source re-implementation of Roller Coaster Tycoon 2"
HOMEPAGE="https://github.com/IntelOrca/OpenRCT2"
if [ "${PV}" == "9999" ]; then
	SRC_URI="https://github.com/OpenRCT2/OpenRCT2/archive/develop.zip"
else
	SRC_URI="https://github.com/OpenRCT2/OpenRCT2/archive/v${PV}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl openssl jansson"

DEPEND="media-libs/libsdl2[abi_x86_32]
	media-libs/sdl2-ttf[abi_x86_32]
	media-libs/speex[abi_x86_32]
	media-libs/fontconfig[abi_x86_32]
	curl? ( net-misc/curl[abi_x86_32] )
	openssl? ( dev-libs/openssl[abi_x86_32] )
	jansson? ( dev-libs/jansson[abi_x86_32] )"
RDEPEND="${DEPENDS}"

if [ "${PV}" == "9999" ]; then
	S="${WORKDIR}/OpenRCT2-develop"
else
	S="${WORKDIR}/OpenRCT2-${PV}"
fi

pkg_postinst() {
	elog "Please note, you still need the original game assets"
	elog "to play this game. See also: https://openrct2.com/"
}
