# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

MY_PV=${PV}.0

DESCRIPTION="Kate C++ Helper plugin"
HOMEPAGE="http://github.com/zaufi/kate-cpp-helper-plugin"
SRC_URI="https://github.com/zaufi/kate-cpp-helper-plugin/archive/version-${MY_PV}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"

DEPEND="
	$(add_kdeapps_dep kate)
	>=sys-devel/clang-3.0
	>=sys-devel/gcc-4.7
	"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/* ${S}
}
