# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit systemd autotools

DESCRIPTION="Thermal daemon for Intel architectures"
HOMEPAGE="https://01.org/linux-thermal-daemon"
SRC_URI="https://github.com/01org/thermal_daemon/archive/v${PV}.tar.gz -> thermal_daemon-${PV}.tar.gz"

LICENSE="GPL2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
S=${WORKDIR}/thermal_daemon-${PV}

DEPEND="dev-libs/dbus-glib
	dev-libs/libxml2"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --with-systemdsystemunitdir=$(systemd_get_unitdir)
}

src_install() {
	default
	
	dobin tools/thermald_set_pref.sh
	doinitd "${FILESDIR}/thermald"
}
