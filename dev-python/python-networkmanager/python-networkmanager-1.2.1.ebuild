# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python wrapper for Networkmanager's D-Bus API"
HOMEPAGE="https://github.com/seveas/python-networkmanager/"
SRC_URI="https://github.com/seveas/python-networkmanager/archive/${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

