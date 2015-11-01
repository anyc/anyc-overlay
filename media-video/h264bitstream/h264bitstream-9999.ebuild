# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools

DESCRIPTION="read and write H.264 video bitstreams"
HOMEPAGE="https://github.com/aizvorski/h264bitstream"
SRC_URI="https://github.com/aizvorski/h264bitstream/archive/master.zip"

LICENSE="GPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_unpack() {
	default

	mv "${WORKDIR}"/* "${S}"
}

src_prepare() {
	eautoreconf
}
