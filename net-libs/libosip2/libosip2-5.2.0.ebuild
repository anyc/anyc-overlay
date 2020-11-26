# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils autotools versionator

DESCRIPTION="a simple way to support the Session Initiation Protocol"
HOMEPAGE="https://www.gnu.org/software/osip/"
SRC_URI="mirror://gnu/osip/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~ppc-macos ~x86-macos"
IUSE="+async test"

DEPEND="async? ( net-dns/c-ares )"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_enable test)
}
