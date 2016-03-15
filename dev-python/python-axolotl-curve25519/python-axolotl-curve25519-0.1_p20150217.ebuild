# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# base on ebuild from jm-overlay

EAPI=6
PYTHON_COMPAT=( python2_7 python3_3 python3_4 python3_5 pypy pypy3 )
GIT_COMMIT=e4a9c4de0eae27223200579c58d1f8f6d20637e2

inherit distutils-r1

DESCRIPTION="Python wrapper for the curve25519 library"
HOMEPAGE="https://github.com/tgalal/python-axolotl-curve25519"
SRC_URI="https://github.com/tgalal/python-axolotl-curve25519/archive/${GIT_COMMIT}.tar.gz -> ${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( README.md )

src_unpack() {
	default

	mv "${WORKDIR}"/* "${S}"
}
