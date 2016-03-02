# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils unpacker

DESCRIPTION="Running Android apps on x86 Linux"
HOMEPAGE="http://www.shashlik.io"
SRC_URI="http://static.davidedmundson.co.uk/shashlik/shashlik_${PV}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	kde-apps/kdialog
	virtual/opengl[abi_x86_32]
	"

S=${WORKDIR}

src_unpack() {
	unpack_deb "${A}"

	# fix directory permission
	chmod u+w ${S}/opt/shashlik/android/system/ || die
}

src_install() {
	insinto /opt/shashlik/bin/
	insopts -m0755
	doins -r opt/shashlik/bin/*
	rm opt/shashlik/bin/*

	insinto /opt/shashlik/
	insopts -m0644
	doins -r opt/shashlik/*

	dosym /opt/shashlik/bin/shashlik-run /usr/bin/
	dosym /opt/shashlik/bin/shashlik-install /usr/bin/
}

pkg_postinst() {
	elog "Please create the directory ~/.local/share/system/ in your"
	elog "home folder if it does not already exist."
	elog ""
	elog "Install an APK with: shashlik-install your.apk"
	elog ""
	elog "Start an APK with: shashlik-run com.your.apkid yourapp"
	elog ""
	elog "Make sure your user is in the kvm and video group."
}
