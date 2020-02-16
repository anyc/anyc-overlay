# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ "${PV}" == "9999" ]]; then
	MY_INHERIT="git-r3"
fi

inherit $MY_INHERIT games

MY_PN=trAInsported

DESCRIPTION="Program an AI to control trains"
HOMEPAGE="http://trainsportedgame.no-ip.org/"
LICENSE="trainsported DoWhatTheFuckYouWant UbuntuFontLicense-1.0"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/Germanunkol/${MY_PN}.git"
	KEYWORDS=""
else
	SRC_URI="http://trainsportedgame.no-ip.org/download/${MY_PN}${PV}.love -> ${P}.zip
		http://media.indiedb.com/images/games/1/22/21584/Icon.png -> trainsported.png"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
IUSE=""
RDEPEND="games-engines/love:0"

S=${WORKDIR}

src_unpack() {
	if [[ "${PV}" == "9999" ]]; then
		EGIT_NOUNPACK=1
		git-2_src_unpack
	else
		unpack ${P}.zip
	fi
}

src_install() {
	dodoc Documentation.* README.md MakingMaps.md TODO.md

	insinto "${GAMES_DATADIR}/love/${PN}"
	doins -r *
	rm -f "${D}"/*.html "${D}"/*.md "${D}"/*.txt || die

	games_make_wrapper ${PN} "love ${GAMES_DATADIR}/love/${PN}"
	if [[ "${PV}" == "9999" ]]; then
		newicon "${WORKDIR}/Icon.ico" trainsported.ico
		make_desktop_entry ${PN} ${MY_PN} /usr/share/pixmaps/trainsported.ico
	else
		doicon "${DISTDIR}"/trainsported.png
		make_desktop_entry ${PN} ${MY_PN}
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "${MY_PN} AI files are stored in: \$XDG_DATA_HOME/love/${MY_PN}/AI/"
	elog "e.g., ~/.local/share/love/${MY_PN}/AI/"
}
