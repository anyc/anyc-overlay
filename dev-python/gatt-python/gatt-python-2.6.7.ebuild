# Copyright 2014-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gkeys/gkeys-9999.ebuild,v 1.2 2014/12/25 20:58:50 dolsen Exp $

EAPI="5"

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Bluetooth GATT SDK for Python"
HOMEPAGE="http://github.com/getsenic/gatt-python/"
COMMIT="1061676812cbc66d0641e992ff7748f0ab03d61e"
SRC_URI="https://github.com/getsenic/gatt-python/archive/${COMMIT}.tar.gz -> ${P}-${COMMIT}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86"

CDEPEND="dev-python/dbus-python[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"

src_unpack() {
	default

	mv "${WORKDIR}"/* "${S}"
}
