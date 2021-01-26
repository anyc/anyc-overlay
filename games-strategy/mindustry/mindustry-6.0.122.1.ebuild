# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2

BUILDVER=$(ver_cut 3-)

DESCRIPTION="Sandbox tower defense game"
HOMEPAGE="https://mindustrygame.github.io/"
SRC_URI="https://github.com/Anuken/Mindustry/releases/download/v${BUILDVER}/Mindustry.jar -> ${P}.jar"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	|| (
		>=virtual/jre-1.8
		>=virtual/jdk-1.8
	)
"

S="${WORKDIR}"

src_unpack() {
	# Don't unpack that jar, just copy it to WORKDIR
	cp "${DISTDIR}"/${A} "${WORKDIR}/${PN}.jar" || die
}

src_compile() {
	:;
}

src_install() {
	java-pkg_newjar ${PN}.jar ${PN}.jar
	java-pkg_dolauncher ${PN} --jar ${PN}.jar --java_args "\${JAVA_OPTS}"
}
