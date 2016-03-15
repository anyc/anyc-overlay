# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# based on ebuild from jm-overlay

EAPI=6

PYTHON_COMPAT=( python2_7 )
GIT_COMMIT=b2a55b12e15cea08f7d3c90d14b9081bf43bc9a7

inherit distutils-r1

DESCRIPTION="Python port of libaxolotl"
HOMEPAGE="https://github.com/tgalal/python-axolotl"
SRC_URI="https://github.com/tgalal/python-axolotl/archive/${GIT_COMMIT}.tar.gz -> ${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/protobuf-2.6[${PYTHON_USEDEP}]
	dev-python/pycrypto[${PYTHON_USEDEP}]
	dev-python/python-axolotl-curve25519[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( README.md )

src_unpack() {
	default

	mv "${WORKDIR}"/* "${S}"
}
