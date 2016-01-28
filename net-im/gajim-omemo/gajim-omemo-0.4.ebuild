# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# based on the ebuild from flow overlay

EAPI=6

PYTHON_COMPAT=( python2_7 )

if [[ "${PV}" = "9999" ]] ; then
	MY_INHERIT=git-r3
fi

inherit python-single-r1 ${MY_INHERIT}

DESCRIPTION="Gajim plugin for XEP proposal: OMEMO Encryption"
HOMEPAGE="https://github.com/omemo/gajim-omemo"

if [[ "${PV}" = "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/omemo/gajim-omemo.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/omemo/gajim-omemo/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}
	dev-python/python-omemo[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_install() {
	# use "omemo_enc" in order to avoid name collision with python-omemo
	local PLUGINDIR="/usr/share/gajim/plugins/omemo_enc"

	dodoc CHANGELOG README.md

	insinto "${PLUGINDIR}"
	doins *.py manifest.ini omemo.png || die "Installing files failed"
}
