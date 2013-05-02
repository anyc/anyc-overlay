# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Simplifies access to RAPL values in modern Intel CPUs"
HOMEPAGE="http://github.com/anyc/librapl"
EGIT_REPO_URI="http://github.com/anyc/librapl.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="tools"

src_compile() {
	default

	use tools && emake tools
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr install
	use tools && emake -C tools DESTDIR="${D}" prefix=/usr install
}
