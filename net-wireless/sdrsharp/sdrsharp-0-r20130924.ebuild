# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit user git-r3

DESCRIPTION="simple, intuitive, small and fast DSP application for SDR"
HOMEPAGE="http://sdrsharp.com/"
EGIT_REPO_URI="https://github.com/cgommel/sdrsharp.git"

LICENSE="MIT MS-RSL"
SLOT="0"
KEYWORDS=""
IUSE="hackrf sdriq"

#The MS-RSL license forbid modification and redistribution
RESTRICT="mirror bindist"

DEPEND="dev-lang/mono
	media-libs/portaudio
	net-wireless/rtl-sdr"
RDEPEND="${DEPEND}"

src_compile() {
	xbuild /t:Rebuild /p:Configuration=Release /p:Platform=x86 SDRSharp.sln || die
}

pkg_setup() {
	enewgroup sdrsharp
}

src_install() {
	cd "${S}"/Release

	#remove windows only stuff
	sed -i -e "/FUNcube/d" SDRSharp.exe.config
	sed -i -e "/SoftRock/d" SDRSharp.exe.config
	use hackrf || sed -i -e "/HackRF/d" SDRSharp.exe.config
	use sdriq || sed -i -e "/SDRIQ/d" SDRSharp.exe.config
	rm -f SDRSharp.FUNcube.dll SDRSharp.SoftRock.dll

	#install
	insinto /usr/$(get_libdir)/${PN}
	doins SDRSharp.exe* *.dll

	echo -e "#! /bin/sh\nmono /usr/$(get_libdir)/sdrsharp/SDRSharp.exe\n" > sdrsharp
	dobin sdrsharp

	# sdrsharp wants to access the config, read-only does not work
	fowners :sdrsharp /usr/$(get_libdir)/sdrsharp/SDRSharp.exe.config
	fperms g+rw /usr/$(get_libdir)/sdrsharp/SDRSharp.exe.config
}

pkg_postinst() {
	ewarn "Please add your user to the group \"sdrsharp\""
	ewarn ""
	ewarn "Accessing a RTLSDR dongle directly did not work."
	ewarn "You have to start \"rtl_tcp\" locally and use the"
	ewarn "\"RTLSDR / TCP\" source in SDRSharp."
}
