# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 cmake-utils toolchain-funcs

DESCRIPTION="NXP i.MX Chip image deploy tools"
HOMEPAGE="https://github.com/NXPmicro/mfgtools"
EGIT_REPO_URI="https://github.com/NXPmicro/mfgtools"

LICENSE="BSD CPOL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	virtual/libusb:1"

mtl=MfgToolLib
CMAKE_USE_DIR="${S}/${mtl}"

src_compile() {
	cmake-utils_src_compile

	pushd TestPrgm
	CXX=$(tc-getCXX)
	${CXX} mfgtoolCLI.cpp -L${BUILD_DIR} -l${mtl} -I../${mtl} $(pkg-config --cflags --libs libusb-1.0) -std=c++11 -lpthread -fpermissive -o mfgtool
	popd
}

src_install() {
	dolib "${BUILD_DIR}/lib${mtl}.so"
	dobin TestPrgm/mfgtool
}

