# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
MY_PN=repo

inherit eutils python-single-r1

DESCRIPTION="The multiple repository tool from Android"
HOMEPAGE="http://code.google.com/p/git-repo/"
SRC_URI="https://storage.googleapis.com/git-repo-downloads/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-vcs/git ${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}"
}

src_install() {
	newbin "${MY_PN}-${PV}" "${PN}" || die
}
