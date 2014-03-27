# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs multilib-minimal

DESCRIPTION="Hardware-based performance monitoring interface for Linux"
HOMEPAGE="http://perfmon2.sourceforge.net"
SRC_URI="mirror://sourceforge/perfmon2/${PN}4/${P}.tar.gz"

LICENSE="GPL-2 MIT"
SLOT="0/4"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

src_prepare() {
	multilib_copy_sources
}

multilib_src_configure() {
	sed -e "s:SLDFLAGS=:SLDFLAGS=\$(LDFLAGS) :g" \
		-i lib/Makefile || die
	sed -e "s:LIBDIR=\$(PREFIX)/lib:LIBDIR=\$(PREFIX)/$(get_libdir):g" \
		-i config.mk || die
}

multilib_src_compile() {
	emake CC="$(tc-getCC)"
}

multilib_src_install() {
	emake DESTDIR="${D}" LDCONFIG=true PREFIX="${EPREFIX}/usr"  install
	use static-libs || find "${ED}" -name '*.a' -exec rm -f '{}' +
}
