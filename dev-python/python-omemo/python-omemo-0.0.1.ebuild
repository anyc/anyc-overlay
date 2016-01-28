# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=(python2_7)

inherit distutils-r1

DESCRIPTION="python implementation of axolotl encryption"
HOMEPAGE="https://github.com/omemo/python-omemo.git"
SRC_URI="https://github.com/omemo/${PN}/archive/${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}
	>=dev-libs/protobuf-2.6[python]
	>=dev-python/pycrypto-2.6.1[${PYTHON_USEDEP}]
	>=dev-python/python-axolotl-0.1.6[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_prepare() {
	# apply patch from bundled python-omemo in net-im/gajim-omemo
	epatch "${FILESDIR}/detect_own_devices.patch"
}
