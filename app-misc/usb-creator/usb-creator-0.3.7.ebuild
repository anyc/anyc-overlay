# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_5 python3_6 )

inherit distutils-r1 git-r3

DESCRIPTION="Create a startup disk using a CD or disc image"
HOMEPAGE="https://launchpad.net/ubuntu/+source/usb-creator"
EGIT_REPO_URI="https://git.launchpad.net/ubuntu/+source/usb-creator"
EGIT_COMMIT="import/${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	"
RDEPEND="${DEPEND}
	sys-fs/udisks[introspection]
	"
