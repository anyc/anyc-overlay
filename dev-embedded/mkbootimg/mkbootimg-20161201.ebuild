# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="Tool to create and unpack Android boot.img files"
HOMEPAGE="https://github.com/osm0sis/mkbootimg"
EGIT_REPO_URI="https://github.com/osm0sis/mkbootimg.git"
EGIT_COMMIT="f7472523d6195fa756db4e2cdac7bdeecec8bada"

IUSE="mkbootimg"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

# android-tools also installs mkbootimg
DEPENDS="mkbootimg? ( !dev-utils/android-tools )"

src_compile() {
	emake -j1
}

src_install() {
	use mkbootimg && dobin mkbootimg
	dobin unpackbootimg
}
