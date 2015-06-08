# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5

MY_PV=2.0-7

inherit unpacker

DESCRIPTION="Canon CQUE driver suite"
HOMEPAGE="http://software.canon-europe.com/"
SRC_URI="g148tde_lintgz_32_64_0207.tar.zip -> cque-${PV}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch"

RDEPEND="media-libs/libpng:1.2
	media-libs/fontconfig
	net-print/cups
	virtual/jpeg:62
	x11-libs/libX11"
# TODO: and other X deps

S=${WORKDIR}/cque-de-${MY_PV}
DESTDIR="/opt/cel"

pkg_nofetch() {
	einfo "Please go to: ${HOMEPAGE}"
	einfo "and download the appropriate package to:"
	einfo " ${DISTDIR}/${A}"
}

src_unpack() {
	default

	if use amd64; then
		unpacker cque-de-2.0-7.x86_64.tar.gz
	else
		unpacker cque-de-2.0-7.tar.gz
	fi
}

src_install() {
	into ${DESTDIR}
	dobin CQue.exe MAKEXPP sicgsfilter  sicnc
	#cque2.0.png

	insinto ${DESTDIR}
	doins -r doc images ppd

	dosym ${DESTDIR}/bin/sicgsfilter usr/bin/sicgsfilter
}
