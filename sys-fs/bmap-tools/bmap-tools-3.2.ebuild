# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

#inherit python-single-r1
inherit distutils-r1

DESCRIPTION="Create and apply sparse images of block devices"
HOMEPAGE="https://source.tizen.org/documentation/reference/bmaptool/bmap-tools-project"
SRC_URI="ftp://ftp.infradead.org/pub/bmap-tools/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPENDS="dev-python/pygpgme"
