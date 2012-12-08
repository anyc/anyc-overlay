# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils cdrom

DESCRIPTION="Numerical computing environment and fourth-generation programming language"
HOMEPAGE="http://www.mathworks.com/"

LICENSE=""
SLOT="0"
KEYWORDS="-* x86"

RESTRICT="binchecks strip"
IUSE="matlab_only"

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}
DEST_DIR="/opt/matlab/"

matlab_uncomment() {
	sed -i "s,#${1}$,${1}," "${2}"
}


pkg_setup() {
	einfo ""
	einfo "Please mount the ISO to an root-accessible path, e.g.,"
	einfo ""
	einfo "fuseiso matlab.iso my_path/ -o allow_root"
	einfo ""
	einfo "and provide the path using CDROM_ROOT environment variable,"
	einfo "as well as MATLAB_LICENSE_FILE and MATLAB_INSTALLATION_KEY or"
	einfo "MATLAB_INSTALLATION_KEY_FILE"
}


src_install() {
	if [ "${MATLAB_INSTALLATION_KEY}" == "" ] && [ "${MATLAB_INSTALLATION_KEY_FILE}" == "" ]; then
		ewarn "Please provide either MATLAB_INSTALLATION_KEY or MATLAB_INSTALLATION_KEY_FILE as \
			environment variable."
		ewarn ""
		die "Please provide either MATLAB_INSTALLATION_KEY or MATLAB_INSTALLATION_KEY_FILE as \
			environment variable."
	fi
	
	if [ "${MATLAB_LICENSE_FILE}" == "" ]; then
		ewarn "Please provide MATLAB_LICENSE_FILE as environment variable."
		ewarn ""
		die "Please provide MATLAB_LICENSE_FILE as environment variable."
	fi
	
	cdrom_get_cds \
		install \
		activate.ini \
		installer_input.txt
	
	insinto "${DEST_DIR}"
	doins "${CDROM_ROOT}/installer_input.txt"
	doins "${CDROM_ROOT}/activate.ini"
	
	sed -i "s,# destinationFolder=,destinationFolder=${D}/${DEST_DIR}," "${D}/${DEST_DIR}/installer_input.txt"
	sed -i "s,# agreeToLicense=,agreeToLicense=yes," "${D}/${DEST_DIR}/installer_input.txt"
	sed -i "s,# mode=,mode=silent," "${D}/${DEST_DIR}/installer_input.txt"
	sed -i "s,# activationPropertiesFile=,activationPropertiesFile=${D}/${DEST_DIR}/activate.ini," "${D}/${DEST_DIR}/installer_input.txt"
	
	if [ "${MATLAB_INSTALLATION_KEY}" == "" ]; then
		MATLAB_INSTALLATION_KEY="$(cat ${MATLAB_INSTALLATION_KEY_FILE})"
	fi
	sed -i "s,# fileInstallationKey=,fileInstallationKey=${MATLAB_INSTALLATION_KEY}," "${D}/${DEST_DIR}/installer_input.txt"
	
	sed -i "s,^activateCommand=,activateCommand=activateOffline," "${D}/${DEST_DIR}/activate.ini"
	sed -i "s,^licenseFile=,licenseFile=${MATLAB_LICENSE_FILE}," "${D}/${DEST_DIR}/activate.ini"
	
	if use matlab_only ; then
		matlab_uncomment "product.MATLAB" "${D}/${DEST_DIR}/installer_input.txt"
	fi
	
	${CDROM_ROOT}/install -root "${CDROM_ROOT}" -inputFile "${D}/${DEST_DIR}/installer_input.txt" || die
	
	make_desktop_entry /opt/matlab/bin/matlab matlab /opt/matlab/X11/icons/matlab64c_icon.xpm Office
	
	einfo "To start MatLab without the menu shortcut, add /opt/matlab/bin/ to your PATH variable."
	einfo ""
	einfo "export PATH=\"\${PATH}:${DEST_DIR}\""
}
