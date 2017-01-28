# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="a tool for analysing captured signals from software-defined radio receivers"
HOMEPAGE="https://github.com/miek/inspectrum"
SRC_URI="https://github.com/miek/inspectrum/archive/fc9acfe376e797b72458304a110dc7369f88ca75.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3+"
SLOT="0"
IUSE=""

RDEPEND="sci-libs/fftw:3.0=
	dev-libs/boost:=
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtcore:5
	dev-qt/qtconcurrent:5
	net-wireless/gnuradio:=
	net-wireless/liquid-dsp"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

src_unpack() {
	default

	mv "${WORKDIR}"/* "${S}"
}
