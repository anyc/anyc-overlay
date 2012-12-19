# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="TinySTM is a lightweight and efficient word-based STM implementation"
HOMEPAGE="http://tinystm.org/tinystm/"
SRC_URI="http://tmware.org/sites/tmware.org/files/tinySTM/tinySTM-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

DEPEND="dev-libs/libatomic_ops"
RDEPEND="${DEPEND}"

S="${WORKDIR}/tinySTM-${PV}/"

src_compile() {
	if ! tc-has-tls; then
		export NOTLS=1
	fi

	ROOT="${S}" LIBAO_HOME="/usr/" emake || die "emake failed"
}

src_install() {
	dolib.a lib/libstm.a

	dodir /usr/include/${PN}/
	insinto /usr/include/${PN}/
	doins include/*

	dodoc ChangeLog Doxyfile
	dohtml doc/html/*
}
