# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [ "${PV}" == "9999" ]; then
	MY_INHERIT="git-2"
fi

inherit games gnome2-utils $MY_INHERIT

MY_PN=trAInsported

DESCRIPTION="Program an AI to control trains"
HOMEPAGE="http://trainsportedgame.no-ip.org/"
LICENSE="trainsported DoWhatTheFuckYouWant UbuntuFontLicense-1.0"

if [ "${PV}" == "9999" ]; then
	EGIT_REPO_URI="https://github.com/Germanunkol/${MY_PN}.git"
	SRC_URI="http://media.indiedb.com/images/games/1/22/21584/Icon.png -> trainsported.png"
	KEYWORDS=""
else
	SRC_URI="http://trainsportedgame.no-ip.org/download/${MY_PN}${PV}.love -> ${PN}.zip
		http://media.indiedb.com/images/games/1/22/21584/Icon.png -> trainsported.png"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
IUSE=""
RDEPEND=">=games-engines/love-0.8"

S=${WORKDIR}

src_unpack() {
	if [ "${PV}" == "9999" ]; then
		EGIT_NOUNPACK=1
		git-2_src_unpack
	else
		unpack ${PN}.zip
	fi
}

src_install() {
	dodoc Documentation.* README.md MakingMaps.md TODO.md
	rm -f *.html *.md *.txt

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
