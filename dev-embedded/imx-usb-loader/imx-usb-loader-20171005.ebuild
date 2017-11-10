# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="Usb loader for imx51/53/6x"
HOMEPAGE="https://github.com/boundarydevices/imx_usb_loader"
EGIT_REPO_URI="https://github.com/boundarydevices/imx_usb_loader.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"

src_compile() {
	emake sysconfdir=/etc
}

src_install() {
	emake DESTDIR="${D}" sysconfdir=/etc install
}
