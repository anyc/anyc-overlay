# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
PYTHON_COMPAT=( python3_{6..9} )

if [ "${PV}" == "9999" ]; then
	inherit git-r3
fi

inherit distutils-r1 user

DESCRIPTION="Clone of the famous Scotland Yard board game"
HOMEPAGE="http://pessimization.com/software/londonlaw/"
if [ "${PV}" == "9999" ]; then
	EGIT_REPO_URI=https://github.com/anyc/londonlaw.git
	KEYWORDS=""
else
	SRC_URI="https://github.com/anyc/londonlaw/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="dedicated"

RDEPEND="dev-python/twisted[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	!dedicated? ( dev-python/wxpython[${PYTHON_USEDEP}] )
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	default
	2to3 --write --nobackups --no-diffs -j "$(makeopts_jobs "${MAKEOPTS}" INF)" . || die "2to3 failed."
	#2to3 setup.py
	sed -i -e 's/string.find(arg, /arg.find(/' \
		-e 's/import os/import os, os.path/' \
		-e "/os.path.walk('londonlaw\/guiclient\/images.*$/d" \
		-e "/os.path.walk('londonlaw\/locale.*$/d" \
		setup.py || die "sed failed."
	#remove "sets" imports (now builtin) and fix "set()" usage
	sed -i \
		-e '/import sets/d' -e 's/ sets,//' -e 's/, sets$//' -e '/from sets/d' \
		-e 's/sets.Set/set/g' -e 's/Set(/set(/g' \
		londonlaw/{server/{GameRegistry.py,Game.py,Team.py},common/path.py,aiclients/{detective_simple.py,base.py},guiclient/SetHash.py} \
		|| die "sed failed."
	#fix gettext usage
	sed -i -e 's/, unicode=True//g' londonlaw/london-{client,server} || die
	#fix wx compatibility an other things
	sed -i -e '/import wxversion/,+5d' londonlaw/guiclient/__init__.py || die
	sed -i -e '/maskImage =/d' londonlaw/guiclient/graphicalmap.py || die
	sed -i -e '/import util/a import os.path, configparser, shelve, time' \
		-e 's/.encode("utf-8")//' \
		-e 's/self._expiration     = None/self._expiration     = 240/' \
		londonlaw/server/GameRegistry.py || die
	#ugly hacks to get python3/twisted sendLine/lineReceived utf8 problems fixed
	#	side effect: user name 'b' crashes the client
	sed -i -e '/self._history    = \[\]/a \ \ \ \ \ \ self._state=None' \
		-e 's/self.sendLine.*/self.sendLine(s.encode())/' \
		-e "/def lineReceived/a \ \ \ \ \ \ line=line.decode().lstrip('b')\n\ \ \ \ \ \ line=' '.join(s.replace('b\\\'','').replace('\\\'','') for s in line.split())" \
		-e 's/.encode("utf-8")//g' \
		-e 's/.decode("utf-8")//g' \
		-e "/data      =/ s/data.*/data      = [d.replace('b\\\'','').replace('\\\'','') for d in tokens[2:]]/" \
			londonlaw/guiclient/Protocol.py \
			londonlaw/aiclients/{base.py,detective_simple_launcher.py,x_simple_launcher.py} || die
	sed -i -e 's/self.sendLine.*/self.sendLine(s.encode())/' \
		-e 's/.decode("utf-8")//g' \
		-e 's/shlex.split(line)/shlex.split(line.decode())/' \
		londonlaw/server/Protocol.py || die
	#does not exist anymore
	sed -i -e 's/self.InsertColumnInfo/self.InsertColumn/' londonlaw/guiclient/AutoListCtrl.py || die
	#don't know what was originally tried to achieve here
	#	anyhow: now it fills always detective's team if mr. x is already set
	sed -i -e 's/teams.sort(comparer)/if len(teams)>1 and teams[1].getNumPlayers() > teams[0].getNumPlayers(): teams[0]=teams[1]/' \
		londonlaw/server/Game.py || die
	#does not exist anymore
	sed -i -e '/BeginDrawing/d' -e '/EndDrawing/d' londonlaw/guiclient/{PlayerIcon.py,MapWindow.py} || die
	sed -i -e 's:MAPSIZE\[0\]/GRIDSIZE\[0\]:int(MAPSIZE[0]/GRIDSIZE[0]):' \
		-e 's:MAPSIZE\[1\]/GRIDSIZE\[1\]:int(MAPSIZE[1]/GRIDSIZE[1]):' \
		londonlaw/guiclient/graphicalmap.py || die
	sed -i -e '/\.Remove/d' londonlaw/guiclient/{HistoryWindow.py,MoveDialog.py} || die
	sed -i -e 's/GetClientSizeTuple/GetClientSize/' londonlaw/guiclient/MapWindow.py || die
	sed -i -e 's/union_update/update/' londonlaw/{aiclients/detective_simple.py,common/path.py} || die
	sed -i -e 's/ugettext/gettext/' londonlaw/{server/Protocol.py,common/Pawn.py} || die
	if use dedicated ; then
		rm -r londonlaw/{london-client,guiclient} || die
		sed -i \
			-e "s:'londonlaw.guiclient',::" \
			-e "s:'londonlaw/london-client',::" \
			setup.py \
			|| die "sed failed"
	fi
}

python_install() {

	distutils-r1_python_install --install-lib="$(python_get_sitedir)" --install-data=/var/games/londonlaw sdist

	if ! use dedicated ; then
		insinto /usr/share/londonlaw/guiclient
		doins -r londonlaw/guiclient/images
	fi

	insinto /usr/share
	doins -r londonlaw/locale
	rm ${D}/usr/share/locale/{Makefile,londonlaw.pot}
	rm ${D}/usr/share/locale/*/*/*.po


	dodoc doc/ChangeLog README.md doc/TODO doc/manual.tex doc/readme.protocol

	newinitd "${FILESDIR}/londonlaw.rc" londonlaw
	newconfd "${FILESDIR}/londonlaw.confd" londonlaw

	keepdir "/var/games/londonlaw"

}

pkg_preinst() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
	keepdir /var/{run,lib,log}/londonlaw
	fowners ${PN}:${PN} /var/{run,lib,log}/londonlaw
}

pkg_postinst() {
	if ! use dedicated ; then
		echo
		elog "To play, first start the server (london-server), then connect"
		elog "with the client (london-client)."
		elog "The admin client won't work without setting up an admin password."
		elog "Create a file called ~/.londonlaw/server/config that looks like this:"
		elog "[server]"
		elog "admin_password: PASSWORD"
		elog "game_expiration: 240"
		echo
	fi
}
