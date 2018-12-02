# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

PYTHON_COMPAT=(python2_7 python3_4 python3_5 python3_6)

inherit eutils distutils-r1

DESCRIPTION="GUI library which exports HTML with a builtin webserver"
HOMEPAGE="https://github.com/dddomodossola/remi"
SRC_URI="https://github.com/dddomodossola/remi/archive/${PV}.tar.gz -> ${P}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"
