# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit java-pkg-2

DESCRIPTION="Download files from the public broadcasting services"
HOMEPAGE="http://zdfmediathk.sourceforge.net/"
SRC_URI="mirror://sourceforge/zdfmediathk/Mediathek/Mediathek%20${PV}/MediathekView_${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=virtual/jdk-1.7"
RDEPEND=">=virtual/jre-1.7
	media-video/vlc
	media-video/flvstreamer
	>=dev-java/commons-compress-1.4
	dev-java/swingx:1.6
	>=dev-java/jgoodies-forms-1.3.0"

S=${WORKDIR}

src_compile() {
	:
}

src_install() {
	java-pkg_dojar MediathekView.jar
	java-pkg_dojar lib/jide-oss-3.5.9.jar
	java-pkg_dojar lib/MSearch.jar
	java-pkg_dojar lib/jackson-core-2.2.3.jar

	insinto /usr/share/${PN}/lib/bin/
	doins bin/flv.sh || die

	java-pkg_register-dependency commons-compress commons-compress.jar
	java-pkg_register-dependency jgoodies-forms forms.jar
	java-pkg_register-dependency swingx-1.6 swingx.jar

	java-pkg_dolauncher ${PN} --main mediathek.Main
}
