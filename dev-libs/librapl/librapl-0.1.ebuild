# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Simplifies access to RAPL values in modern Intel CPUs"
HOMEPAGE="http://github.com/anyc/librapl"
SRC_URI="http://github.com/anyc/librapl/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="tools"

S=${WORKDIR}/${PN}-${P}/

src_compile() {
	default

	use tools && emake tools
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr install
	use tools && emake -C tools DESTDIR="${D}" prefix=/usr install
}
