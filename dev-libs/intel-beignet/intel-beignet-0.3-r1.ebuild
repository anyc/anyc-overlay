# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="The Beignet GPGPU System for Intel Ivybridge GPUs"
HOMEPAGE="http://wiki.freedesktop.org/www/Software/Beignet/"

# we cannot use the snapshots as the checksum changes for every download
EGIT_REPO_URI="git://anongit.freedesktop.org/beignet"
EGIT_COMMIT="Release_v${PV}"

LICENSE="GPL-2"
SLOT="0"
IUSE="icd"

if [[ "${PV}" == "9999" ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

DEPEND=">=sys-devel/gcc-4.6
	icd? ( dev-libs/ocl-icd )"
RDEPEND="
	app-admin/eselect-opencl
	media-libs/mesa
	sys-devel/clang
	>=sys-devel/llvm-3.1
	x11-libs/libdrm
	x11-libs/libXext
	x11-libs/libXfixes
	"

src_prepare() {
	# disable tests for now
	sed -i "s/ADD_SUBDIRECTORY(utests)/#ADD_SUBDIRECTORY(utests)/" CMakeLists.txt || die "sed failed"

	echo "/usr/$(get_libdir)/OpenCL/vendors/intel-beignet/libcl.so" > intelbeignet.icd

	# use system OpenCL headers but keep cl_intel.h extension
	rm -rf include/CL/{cl.h,cl.hpp,cl_d3d10.h,cl_ext.h,cl_gl.h,cl_gl_ext.h,cl_platform.h,opencl.h}

	cmake-utils_src_prepare
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
