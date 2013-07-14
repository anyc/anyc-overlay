# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://foo.example.org/"
SRC_URI="http://downloads.sourceforge.net/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtgui:4
	net-wireless/wireless-tools
	>=x11-libs/qwt-6
	"
RDEPEND="${DEPEND}"

src_prepare() {
	# fix hard-coded gcc version
	sed -i 's/gcc-4\.6/gcc/' linssid.pro
	sed -i 's/g++-4\.6/g++/' linssid.pro

	# get and use QWT version
	QWT_VERSION="$(best_version x11-libs/qwt | cut -d "-" -f3 | cut -d "." -f1)"
	sed -i "s/\/usr\/include\/qwt/\/usr\/include\/qwt${QWT_VERSION}/g" linssid.pro || die
	sed -i "s/\/usr\/lib\/libqwt.so/-lqwt${QWT_VERSION}/g" linssid.pro || die

	sed -i 's/\/usr\/lib\/libboost_regex-mt\.a/-lboost_regex/' linssid.pro || die

	# use uniform include style for qwt
	sed -i "s/#include <qwt\//#include </" *.h || die

	# fix QA warnings
	sed -i "s/Version=.*//" linssid.desktop || die
	sed -i "s/Categories=.*/Categories=Network;/" linssid.desktop || die
}
