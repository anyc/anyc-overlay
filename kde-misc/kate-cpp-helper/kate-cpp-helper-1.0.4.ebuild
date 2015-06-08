# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
KDE_MINIMAL=4.8

inherit kde4-base

DESCRIPTION="Kate C++ Helper plugin"
HOMEPAGE="http://zaufi.github.io/kate-cpp-helper-plugin.html"
SRC_URI="https://github.com/zaufi/kate-cpp-helper-plugin/archive/version-${PV}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"

DEPEND="
	$(add_kdeapps_dep kate)

	>=dev-libs/boost-1.49
	>=dev-libs/xapian-1.2.12
	>=dev-util/cmake-2.8.12
	>=sys-devel/clang-3.3
	|| ( >=sys-devel/gcc-4.9 >=sys-devel/clang-3.5 )
	"
RDEPEND="${DEPEND}"

pkg_pretend() {
	local ver=4.9.0
	local msg="${PN} needs at least GCC ${ver} set to compile."

	if [[ ${MERGE_TYPE} != binary ]]; then
		if [[ $(tc-getCXX) == *g++ ]] && ! version_is_at_least ${ver} $(gcc-fullversion); then
			eerror ${msg}
			die ${msg}
		fi
	fi
}

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/* ${S}
}
