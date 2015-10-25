# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="Frame-accurate video cutting with only small quality loss"
HOMEPAGE="http://github.com/anyc/avcut.git"
EGIT_REPO_URI="https://github.com/anyc/avcut.git"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

DOCS=( README )

src_install() {
	dobin avcut
}
