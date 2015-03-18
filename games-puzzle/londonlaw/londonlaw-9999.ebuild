# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

if [ "${PV}" == "9999" ]; then
	MY_INHERIT=git-r3
fi

inherit eutils python-single-r1 games $MY_INHERIT

DESCRIPTION="Clone of the famous Scotland Yard board game"
HOMEPAGE="http://pessimization.com/software/londonlaw/"
if [ "${PV}" == "9999" ]; then
	EGIT_REPO_URI=https://github.com/anyc/londonlaw.git
else
	SRC_URI="https://github.com/anyc/londonlaw/archive/v${PV}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated"

DEPEND="dev-python/twisted-core[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]

	!dedicated? ( dev-python/wxpython:3.0[${PYTHON_USEDEP}] )
	${PYTHON_DEPS}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	if use dedicated ; then
		local f
		rm -r londonlaw/{london-client,london-client.py,guiclient/}
		sed -i \
			-e "s:'londonlaw.guiclient',::" \
			-e "s:'londonlaw/london-client',::" \
			setup.py \
			|| die "sed failed"
	fi

	for f in londonlaw.rc londonlaw.confd
	do
		sed \
			-e "s/GAMES_USER_DED/${GAMES_USER_DED}/" \
			-e "s:GAMES_BINDIR:${GAMES_BINDIR}:" \
			-e "s:GAMES_LOGDIR:${GAMES_LOGDIR}:" \
			-e "s:PN:${PN}:" \
			"${FILESDIR}/${f}" > "${T}/${f}" \
			|| die "sed failed"
	done

	sed -i \
		-e "s:^LONDONLAW_DBDIR=.*$:LONDONLAW_DBDIR=${GAMES_STATEDIR}/${PN}:" \
		"${T}/londonlaw.confd" \
		|| die "sed failed"

	python_fix_shebang .
}

src_install() {
	"${PYTHON}" setup.py install \
		--root="${D}" \
		--prefix="${GAMES_PREFIX}" \
		--install-lib=$(python_get_sitedir) \
		--install-data="${GAMES_DATADIR}" \
		|| die "install failed"

	dodoc doc/ChangeLog README.md doc/TODO doc/manual.tex doc/readme.protocol
	dohtml doc/manual.html

	newinitd "${T}/londonlaw.rc" londonlaw
	newconfd "${T}/londonlaw.confd" londonlaw

	dodir "${GAMES_LOGDIR}"
	touch "${D}/${GAMES_LOGDIR}"/${PN}.log

	keepdir "${GAMES_STATEDIR}/${PN}"
	fowners ${GAMES_USER_DED}:${GAMES_GROUP} \
		"${GAMES_STATEDIR}/${PN}" "${GAMES_LOGDIR}"/${PN}.log

	fperms ug+rwx "${GAMES_STATEDIR}/${PN}"
	fperms ug+rw "${GAMES_LOGDIR}"/${PN}.log

	prepgamesdirs
}

pkg_setup() {
	python-single-r1_pkg_setup
	games_pkg_setup
}

pkg_postinst() {
	games_pkg_postinst
	if ! use dedicated ; then
		echo
		elog "To play, first start the server (london-server), then connect"
		elog "with the client (london-client)."
		echo
	fi
}
