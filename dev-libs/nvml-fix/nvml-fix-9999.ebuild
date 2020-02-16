# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Workaround to enable nvidia-smi for GeForce cards"
HOMEPAGE="https://github.com/CFSworks/nvml_fix"
EGIT_REPO_URI="https://github.com/CFSworks/nvml_fix.git"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

NV_VERSIONS="331.20 325.15 325.08 319.32 319.23"
for x in ${NV_VERSIONS}; do
	IUSE="${IUSE} v${x}"
done

REQUIRED_USE="^^ ( ${IUSE} )"

get_version() {
	local version
	for x in ${NV_VERSIONS}; do
		if use v$x; then
			echo $x
		fi
	done
}

src_compile() {
	version=$(get_version)
	emake TARGET_VER=${version}
}

src_install() {
	version=$(get_version)
	emake libdir=${D}/usr/lib/${PN} TARGET_VER=${version} install
}

pkg_postinst() {
	elog "To use nvml-fix, start nvidia-smi as follows:"
	elog "LD_LIBRARY_PATH=\"/usr/lib/${PN}/\" nvidia-smi"
}
