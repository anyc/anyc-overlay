# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit versionator

#MY_P="JLink_Linux_V${PV/\./}_$(usex amd64 'x86_64' 'i386')"
#MY_P="JLink_Linux_V620h_x86_64"
INSTALLDIR="/opt/${PN}"

DESCRIPTION="Tools for Segger J-Link JTAG adapters"
HOMEPAGE="http://www.segger.com/jlink-software.html"
SRC_URI="amd64? ( JLink_Linux_V${PV/\./}_x86_64.tgz )
	x86? ( JLink_Linux_V${PV/\./}_i386.tgz )"
LICENSE="J-Link Terms of Use"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
QA_PREBUILT="*"

RESTRICT="fetch strip"
DEPEND=""
RDEPEND="${DEPEND}
	dev-libs/libedit"

#S=${WORKDIR}/${MY_P}

pkg_setup() {
	export S=${WORKDIR}/"JLink_Linux_V${PV/\./}_$(usex amd64 'x86_64' 'i386')"
}

#pkg_nofetch() {
#    einfo "Segger requires you to download the needed files manually after"
#    einfo "entering the serial number of your debugging probe."
#    einfo
#    einfo "Download ${SRC_URI}"
#    einfo "from ${HOMEPAGE} and place it in ${DISTDIR}"
#}

src_install() {
#	dodir ${INSTALLDIR} || die
#	dodir ${INSTALLDIR}/lib || die
#	dodir ${INSTALLDIR}/doc || die

	local BINS="JFlashSPI_CL JLinkExe JLinkGDBServer JLinkLicenseManager JLinkRegistration
		JLinkRemoteServer JLinkRTTClient JLinkRTTLogger JLinkSTM32 JLinkSWOViewer
		JTAGLoadExe"
	for wrapper in $BINS ; do
		make_wrapper $wrapper ./$wrapper ${INSTALLDIR} lib
	done

	exeinto ${INSTALLDIR}
	doexe $BINS || die

	P_NUMBER=$(( $(printf "%d" "'$(get_version_component_range get_last_version_component_index)") - 96 ))
	exeinto ${INSTALLDIR}

	for SUFFIX in "" _x86; do
		doexe "libjlinkarm${SUFFIX}.so.${PV/[a-z]/}.${P_NUMBER}" || die
		dosym "libjlinkarm${SUFFIX}.so.${PV/[a-z]/}.${P_NUMBER}" "${INSTALLDIR}/libjlinkarm${SUFFIX}.so.$(get_major_version)" || die
		dosym "libjlinkarm${SUFFIX}.so.$(get_major_version)" "${INSTALLDIR}/libjlinkarm${SUFFIX}.so" || die
	done

	doexe GDBServer/*

	insinto ${INSTALLDIR}
	doins -r x86 || die

	insinto ${INSTALLDIR}/doc
	pushd Doc
	doins -r * || die
	popd
	doins README.txt

	insinto ${INSTALLDIR}
	doins -r Samples || die
	doins -r Devices || die

	insinto /lib/udev/rules.d/
	doins 99-jlink.rules || die
}

pkg_postinst() {
	enewgroup plugdev
	elog "To be able to access the jlink usb adapter, you have to be"
	elog "a member of the 'plugdev' group."
}
