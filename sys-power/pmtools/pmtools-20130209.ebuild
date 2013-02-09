# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Collection of tools for ACPI and power management"
HOMEPAGE="https://github.com/anyc/pmtools/"
SRC_URI="https://github.com/anyc/pmtools/tarball/${PV} -> ${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=sys-power/iasl-20090521
	"

S="${WORKDIR}/pmtools"

src_unpack() {
	unpack ${A}
	mv anyc-pmtools-* "${S}"
}

src_prepare() {
	strip-unsupported-flags
}

src_compile() {
	# respect user's LDFLAGS
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dosbin acpidump/acpidump
	newbin acpixtract/acpixtract acpixtract-pmtools
	dobin madt/madt

	dodoc README madt/README.madt
}

pkg_postinst() {
	ewarn "Please note that acpixtract is now named acpixtract-pmtools to avoid"
	ewarn "conflicts with the new tool of the same name from the iasl package."
	ewarn "turbostat is now provided by sys-apps/linux-misc-apps"
}
