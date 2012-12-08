# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Tool to fix stuck pixel in a LCD display"
HOMEPAGE="http://en.congelli.eu/prog_info_lcdnurse.html"
SRC_URI="http://en.congelli.eu/download/lcdnurse/${P}.tar.gz"
LICENSE="GPL-3"

RESTRICT="fetch"

RDEPEND=">=x11-libs/wxGTK-2.8.4"