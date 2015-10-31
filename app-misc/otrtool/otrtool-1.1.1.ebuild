# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Decode .otrkey files from onlinetvrecorder.com"
HOMEPAGE="http://otrtool.github.io/otrtool/"
SRC_URI="http://github.com/otrtool/otrtool/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="CC0-1.0-Universal"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="net-misc/curl
	dev-libs/libmcrypt"
RDEPEND="${DEPEND}"

src_unpack() {
	default

	mv "${WORKDIR}"/* "${S}"
}

src_install() {
	dobin otrtool
	doman doc/otrtool.1
	dodoc README TODO
}
