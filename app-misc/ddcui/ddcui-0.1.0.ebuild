# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake-utils

DESCRIPTION="Graphical user interface for ddcutil"
HOMEPAGE="https://github.com/rockowitz/ddcui"
SRC_URI="https://github.com/rockowitz/ddcui/archive/v${PV}.tar.gz"

RESTRICT=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

DOCS="README.md"

RDEPEND="
	>=app-misc/ddcutil-0.9.8
        dev-qt/qtcore:5
        dev-qt/qtgui:5
	dev-qt/qthelp:5
	dev-qt/qtwidgets"
DEPEND="${RDEPEND}
	dev-libs/glib
        virtual/pkgconfig"
