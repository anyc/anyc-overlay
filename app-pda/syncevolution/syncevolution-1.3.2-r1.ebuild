# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils gnome2

DESCRIPTION="SyncEvolution synchronizes personal information management (PIM) data via various protocols"
HOMEPAGE="http://syncevolution.org/"
SRC_URI="http://downloads.syncevolution.org/syncevolution/sources/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="akonadi bluetooth curl dbus eds gnome gtk keyring kwallet libnotify soup sqlite webdav xmlrpc"

RDEPEND="
	>=dev-libs/boost-1.35
	>=dev-libs/glib-2.16:2
	dev-util/cppunit
	dev-python/twisted-web

	akonadi? ( kde-base/kdepim-common-libs )
	curl? ( net-misc/curl )
	dbus? ( >=sys-apps/dbus-1.2 )
	keyring? ( >=gnome-base/gnome-keyring-2.20 )
	libnotify? ( x11-libs/libnotify )
	soup? ( >=net-libs/libsoup-2.4:2.4 )

	bluetooth? (
		>=net-wireless/bluez-4
		>=dev-libs/openobex-1.5
		gnome? ( >=net-wireless/gnome-bluetooth-2.28 )
		)
	eds? (
		>=gnome-extra/evolution-data-server-1.2
		>=dev-libs/libical-0.43
		)
	gtk? (
		>=x11-libs/gtk+-2.18:2
		dev-libs/libunique:1
		)
	xmlrpc? (
		>=dev-libs/xmlrpc-c-1.06
		>=dev-db/sqlite-3.7.2
		)
	"

DEPEND="${RDEPEND}
	dev-python/docutils
	virtual/pkgconfig
	>=dev-util/intltool-0.37.1"

REQUIRED_USE="
	xmlrpc? ( sqlite )
	gnome? ( bluetooth )
	gtk? ( dbus )
	"

DOCS="AUTHORS Doxyfile ChangeLog"

src_configure() {
	if use gtk; then
		GUI="gtk"
	else
		GUI="no"
	fi

	## deps I could not confirm and possible useflags that do not work yet:
	# >=gnome-base/gconf-2:2
	# $(use_enable activesync) requires libeasclient from evolution activesync subdir
	# $(use_enable doc) doc? ( app-doc/doxygen ) fails due to missing makefile to generate docbook html, dev-libs/libxslt
	gnome2_src_configure \
		--enable-gui=${GUI} \
		--with-rst2man=/usr/bin/rst2man.py \
		--with-rst2html=/usr/bin/rst2html.py \
		$(use_enable akonadi) \
		$(use_enable bluetooth) \
		$(use_enable curl libcurl) \
		$(use_enable dbus dbus-service) \
		$(use_enable eds ebook) \
		$(use_enable eds ecal) \
		$(use_enable gnome gnome-bluetooth-panel-plugin) \
		$(use_enable keyring gnome-keyring) \
		$(use_enable kwallet) \
		$(use_enable libnotify notify) \
		$(use_enable sqlite) \
		$(use_enable soup libsoup) \
		$(use_enable webdav dav) \
		$(use_enable xmlrpc) \
		$(use_enable xmlrpc sqlite) \
		$(use_enable xmlrpc file)
}

src_prepare() {
	epatch "${FILESDIR}/syncevolution-sqlite-header.patch"
}