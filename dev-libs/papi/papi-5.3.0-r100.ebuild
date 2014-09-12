# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

AUTOTOOLS_IN_SOURCE_BUILD=1
inherit versionator autotools-utils

DESCRIPTION="Performance Application Programming Interface"
HOMEPAGE="http://icl.cs.utk.edu/papi/"
SRC_URI="http://icl.cs.utk.edu/projects/${PN}/downloads/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="static-libs cuda"

DEPEND="
	dev-libs/libpfm[static-libs]
	virtual/mpi

	cuda? ( dev-util/nvidia-cuda-toolkit[profiler] )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)/src"

src_configure() {
	local COMPONENTS=""
	if use cuda; then
		pushd "${S}"/components/cuda/
		econf \
			--with-cuda-dir=/opt/cuda/ \
			--with-cupti-dir=/opt/cuda/extras/CUPTI/
		popd
		
		COMPONENTS="${COMPONENTS}cuda "
	fi

	local myeconfargs=(
		--with-shlib
		--with-perf-events
		--with-pfm-prefix="${EPREFIX}/usr"
		--with-components="${COMPONENTS}"
	)
	ECONF_SOURCE="${S}" autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	dodoc ../RE*
}
