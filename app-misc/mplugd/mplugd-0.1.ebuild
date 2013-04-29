# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="Daemon that executes event-triggered actions"
HOMEPAGE="http://github.com/anyc/mplugd"
SRC_URI="http://github.com/anyc/mplugd/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/dbus-python
	dev-python/python-xlib"

S=${WORKDIR}/${PN}-${P}
