# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake-utils

DESCRIPTION="Source measure unit GUI for sigrok"
HOMEPAGE="https://github.com/knarfS/smuview/"
SRC_URI="https://github.com/knarfS/smuview/archive/3b05ce6fbabafa1024f2c3ad4f57b424868fd565.zip"

RESTRICT=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

#DOCS="README.md"

RDEPEND="
        dev-qt/qtcore:5
        dev-qt/qtgui:5
	dev-qt/qthelp:5
	dev-qt/qtwidgets:5
	dev-qt/qtsvg:5
	>=x11-libs/qwt-6.1.2"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.54
        virtual/pkgconfig"

src_unpack() {
	unpack "${A}"
	mv * "${P}"
}
