# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils gnome2

DESCRIPTION="SyncEvolution synchronizes personal information management (PIM) data via various protocols"
HOMEPAGE="http://syncevolution.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="akonadi sqlite gtk eds bluetooth +gnome keyring kwallet xmlrpc"

SRC_URI="http://downloads.syncevolution.org/syncevolution/sources/${P}.tar.gz"

RDEPEND=">=gnome-base/gconf-2:2
	>=dev-libs/glib-2.16:2
	>=net-libs/libsoup-2.4:2.4
	>=sys-apps/dbus-1.2
	x11-libs/libnotify
	dev-util/cppunit
	keyring? ( >=gnome-base/gnome-keyring-2.20 )
	dev-python/twisted-web
	>=dev-libs/boost-1.35
	akonadi? ( kde-base/kdepim-common-libs )
	gtk? ( >=x11-libs/gtk+-2.18:2
		dev-libs/libunique:1 )
	eds? ( >=gnome-extra/evolution-data-server-1.2
		>=dev-libs/libical-0.43 )
	xmlrpc? ( >=dev-libs/xmlrpc-c-1.06
		>=dev-db/sqlite-3.7.2 )
	bluetooth? (
		>=net-wireless/bluez-4
		>=dev-libs/openobex-1.5
		gnome? ( >=net-wireless/gnome-bluetooth-2.28 ) )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-python/docutils
	virtual/pkgconfig
	>=dev-util/intltool-0.37.1"

DOCS="README NEWS AUTHORS HACKING"

REQUIRED_USE="xmlrpc? ( sqlite )"

pkg_setup() {
	G2CONF="--with-rst2man=/usr/bin/rst2man.py
		--with-rst2html=/usr/bin/rst2html.py
		--enable-dbus-service
		$(use_enable akonadi)
		$(use_enable bluetooth)
		$(use_enable sqlite)
		$(use_enable eds ebook)
		$(use_enable eds ecal)
		$(use_enable keyring gnome-keyring)
		$(use_enable kwallet)
		$(use_enable xmlrpc)
		$(use_enable xmlrpc sqlite)
		$(use_enable xmlrpc file)"
	if use bluetooth; then
		G2CONF="${G2CONF}
			$(use_enable gnome gnome-bluetooth-panel-plugin)"
	else
		G2CONF="${G2CONF} --disable-gnome-bluetooth-panel-plugin"
	fi
	if use gtk; then
		G2CONF="${G2CONF} --enable-gui=gtk"
	else
		G2CONF="${G2CONF} --enable-gui=no"
	fi
}

src_prepare() {
	epatch "${FILESDIR}/syncevolution-sqlite-header.patch"
}
