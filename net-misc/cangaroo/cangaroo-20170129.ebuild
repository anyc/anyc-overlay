# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Can bus analyzer with QT5 GUI"
HOMEPAGE="https://github.com/HubertD/cangaroo/"
SRC_URI="https://github.com/HubertD/cangaroo/archive/1f898eef8b5f8dbf92a986fe682db1098507c6c2.tar.gz -> ${P}.tar.gz"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPENDS="dev-qt/qtgui:5"
DEPENDS="${RDEPENDS}"

src_unpack() {
	default
	mv "${WORKDIR}"/* "${S}"
}

src_configure() {
	eqmake5
}

src_install() {
	dobin bin/cangaroo
	dosbin canifconfig/canifconfig
}
