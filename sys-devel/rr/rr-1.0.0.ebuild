# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="Record application execution and replay with GDB"
HOMEPAGE="http://rr-project.org/"
SRC_URI="https://github.com/mozilla/${PN}/archive/${PV}.tar.gz"

RESTRICT="test"
LICENSE=""
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

DOCS="README.md doc/rr.html doc/rr.pdf"

DEPEND="dev-embedded/libdisasm[abi_x86_32]
	>=dev-libs/libpfm-4.5.0[abi_x86_32]"

src_prepare() {
	# script that executes cmake
	rm configure
	# tests fail to build with it
	sed -i "s/-Werror//" CMakeLists.txt || die
}
