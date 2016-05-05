# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=(python2_7)
GIT_COMMIT=9f4dbb8c0a07b855c5871a7abccbb7c499f28934

inherit eutils distutils-r1

DESCRIPTION="python implementation of axolotl encryption"
HOMEPAGE="https://github.com/omemo/python-omemo.git"
SRC_URI="https://github.com/omemo/python-omemo/archive/${GIT_COMMIT}.tar.gz -> ${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}
	>=dev-libs/protobuf-2.6[python]
	>=dev-python/pycrypto-2.6.1[${PYTHON_USEDEP}]
	dev-python/python-axolotl[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_unpack() {
	default

	mv "${WORKDIR}"/* "${S}"
}
