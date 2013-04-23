# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Tool for memory locality characterization and analysis on NUMA systems"
HOMEPAGE="https://01.org/numatop/"
SRC_URI="https://01.org/sites/default/files/downloads/numatop_linux_${PV}.tar_4.gz -> numatop-${PV}.tar.gz"

LICENSE="intel-numatop"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

S="${WORKDIR}/${PN}"

DEPEND="
	sys-libs/ncurses
	sys-process/numactl
	"

src_prepare() {
	epatch "${FILESDIR}"/Makefile-std-variables.patch
}

src_compile() {
	# $(LD)=ld fails with default LDFLAGS
	emake LD=$(tc-getCC)
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr install
	
	dodoc README AUTHORS
}
