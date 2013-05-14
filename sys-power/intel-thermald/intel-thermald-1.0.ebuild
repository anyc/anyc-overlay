# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit systemd

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="https://01.org/linux-thermal-daemon"
SRC_URI="http://github.com/01org/thermal_daemon/raw/master/rpms/thermal_daemon-${PV}.tar.gz"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
S=${WORKDIR}/thermal_daemon-${PV}

DEPEND="dev-libs/dbus-glib
	dev-libs/libxml2"

src_configure() {
	econf --with-systemdsystemunitdir=$(systemd_get_unitdir)
}
