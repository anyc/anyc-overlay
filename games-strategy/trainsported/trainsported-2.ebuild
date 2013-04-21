# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games gnome2-utils

MY_PN=trAInsported

DESCRIPTION="Program an AI to control trains"
HOMEPAGE="http://trainsportedgame.no-ip.org/"
SRC_URI="http://trainsportedgame.no-ip.org/download/${MY_PN}${PV}.love -> ${PN}.zip
	http://media.indiedb.com/images/games/1/22/21584/Icon.png -> trainsported.png"
LICENSE="trainsported DoWhatTheFuckYouWant UbuntuFontLicense-1.0"

SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""
RDEPEND=">=games-engines/love-0.8"

S=${WORKDIR}

src_unpack() {
	unpack ${PN}.zip
}

src_install() {
	dodoc Documentation.* README.md MakingMaps.md TODO.md
	rm *.html *.md

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r *

	doicon "${DISTDIR}/trainsported.png"
	games_make_wrapper ${PN} "love ${GAMES_DATADIR}/${PN}"
	make_desktop_entry ${PN} ${MY_PN}

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	elog "${MY_PN} AI files are stored in: \$XDG_DATA_HOME/love/${MY_PN}/AI/"
	elog "e.g., ~/.local/share/love/${MY_PN}/AI/"

	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
