# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools

DESCRIPTION="Simple tool to generate JSON objects"
HOMEPAGE="https://github.com/jpmens/jo"
SRC_URI="https://github.com/jpmens/jo/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	eautoreconf

	default
}
