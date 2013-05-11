# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 distutils

DESCRIPTION="Daemon that executes event-triggered actions"
HOMEPAGE="http://github.com/anyc/mplugd"
EGIT_REPO_URI="https://github.com/anyc/mplugd.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="pulseaudio X udev"

RDEPEND="
	pulseaudio? ( dev-python/dbus-python )
	X? ( dev-python/python-xlib )
	udev? ( dev-python/pyudev )
	"
