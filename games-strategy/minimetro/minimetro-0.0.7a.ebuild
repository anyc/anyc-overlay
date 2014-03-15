# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games

MY_PN=MiniMetro-alpha7a-linux

DESCRIPTION="Minimalistic subway layout game"
HOMEPAGE="http://dinopoloclub.com/minimetro/"
SRC_URI="http://static.dinopoloclub.com/minimetro/builds/alpha7/${MY_PN}.tar.gz"

LICENSE="" # TODO, no license in package
KEYWORDS="~amd64 ~x86"

SLOT="0"
IUSE=""

# TODO: sort out X deps
RDEPEND=""

S=${WORKDIR}

src_install() {
	if use amd64; then
		arch=x86_64
	else
		arch=x86
	fi

	exeinto "/opt/${PN}"
	doexe ${MY_PN}.${arch}

	fperms 750 ${MY_PN}_Data/Mono/${arch}/libmono.so

	insinto "/opt/${PN}"
	doins -r ${MY_PN}_Data

	games_make_wrapper ${PN} "/opt/${PN}/${MY_PN}.${arch}"
	
	prepgamesdirs
}
