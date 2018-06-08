# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit versionator

DESCRIPTION="library to use the SIP protocol for multimedia session establishement"
HOMEPAGE="https://savannah.nongnu.org/projects/exosip/"
SRC_URI="mirror://nongnu/exosip/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86 ~ppc-macos ~x86-macos"
SLOT="0"
LICENSE="GPL-2"
IUSE="libressl +srv ssl"

DEPEND=">=net-libs/libosip2-5.0.0:=
	ssl? (
		libressl? ( dev-libs/libressl:0= )
		!libressl? ( dev-libs/openssl:0= )
	)
	"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_enable ssl openssl) \
		$(use_enable srv srvrec)
}
