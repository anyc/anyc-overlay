# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="Control the additional features of Sharkoon Skiller keyboards"
HOMEPAGE="https://github.com/anyc/skiller-ctl/"
#EGIT_REPO_URI="https://github.com/anyc/skiller-ctl/"
EGIT_REPO_URI="/home/anyc/Projekte/github/skiller-ctl/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-libs/libusb-1.0.0"
RDEPEND="${DEPEND}"

