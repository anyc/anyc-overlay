# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="Library for working with XMP metadata stored in many different file formats"
HOMEPAGE="http://code.google.com/p/python-xmp-toolkit/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="media-libs/exempi"

src_install() {
	distutils_src_install

	use doc && dohtml -r docs/html/*
}
