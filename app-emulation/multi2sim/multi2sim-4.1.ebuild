# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A CPU-GPU Simulator for Heterogeneous Computing"
HOMEPAGE="http://www.multi2sim.org"
SRC_URI="http://www.multi2sim.org/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="gtk opengl"

# todo opengl deps
DEPEND="x11-libs/gtk+:3"

src_configure() {
	econf \
		$(use_enable gtk) \
		$(use_enable opengl)
}

src_install() {
	# installs conflicting libraries, moving into own directory
	emake DESTDIR="${D}" libdir=/usr/lib/m2s/ install

	dodoc AUTHORS ChangeLog NEWS README TODO
}
