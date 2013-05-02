# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ "${PV}" == "9999" ]]; then
	MY_INHERIT=git-2
fi

inherit cmake-utils $MY_INHERIT

DESCRIPTION="The Beignet GPGPU System for Intel Ivybridge GPUs"
HOMEPAGE="http://cgit.freedesktop.org/beignet/tree/README.md"
if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="git://anongit.freedesktop.org/beignet"
else
	SRC_URI="http://cgit.freedesktop.org/beignet/snapshot/Release_v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"

if [[ "${PV}" == "9999" ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

DEPENDS=">=sys-devel/gcc-4.6"
RDEPENDS="
	app-admin/eselect-opencl
	media-libs/mesa
	>=sys-devel/llvm-3.1
	x11-libs/libdrm
	x11-libs/libXext
	x11-libs/libXfixes
	"

src_unpack() {
	if [[ "${PV}" != "9999" ]]; then
		default
		mv "${WORKDIR}"/* "${S}"
	else
		git-2_src_unpack
	fi
}

src_prepare() {
	# disable tests for now
	sed -i "s/ADD_SUBDIRECTORY(utests)/#ADD_SUBDIRECTORY(utests)/" CMakeLists.txt || die "sed failed"

	echo "/usr/lib64/OpenCL/vendors/intel-beignet/libcl.so" > intelbeignet.icd
}

src_install() {
	cmake-utils_src_install

	insinto /etc/OpenCL/vendors/
	doins intelbeignet.icd

	dodoc README.md

	einfo "Moving files into vendor-specific position..."

	cd "${D}"
	IBEIGNET_DIR=usr/"$(get_libdir)"/OpenCL/vendors/intel-beignet/
	mkdir -p ${IBEIGNET_DIR} || die "mkdir failed"

	mv usr/lib/* "${IBEIGNET_DIR}" || die "mv failed"
	dosym libcl.so "${IBEIGNET_DIR}"/libOpenCL.so.1
	dosym libcl.so "${IBEIGNET_DIR}"/libOpenCL.so
	mv usr/include "${IBEIGNET_DIR}" || die "mv failed"
}
