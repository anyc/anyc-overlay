# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib-minimal

DESCRIPTION="Set of XPIDL files, headers and tools to develop XPCOM components"
HOMEPAGE="https://developer.mozilla.org/en-US/docs/Gecko_SDK"

BASE_SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/xulrunner/releases/${PV}/sdk/xulrunner-${PV}.en-US.linux-"
SRC_URI="
	abi_x86_32? ( ${BASE_SRC_URI}i686.sdk.tar.bz2 ) 
	abi_x86_64? ( ${BASE_SRC_URI}x86_64.sdk.tar.bz2 )
	"

LICENSE=""
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

S=${WORKDIR}

src_unpack() {
	local files=( ${A} )
	multilib_src_unpack() {
                mkdir -p "${BUILD_DIR}" || die
                cd "${BUILD_DIR}" || die

                # we need to filter out the other archive(s)
                local other_abi
                [[ ${ABI} == amd64 ]] && other_abi=i686 || other_abi=x86_64
                unpack ${files[@]//*${other_abi}*/}

#		sed -i "s/typedef PRUint16 PRUnichar;/typedef char16_t PRUnichar;/" xulrunner-sdk/include/nspr/prtypes.h || die
        }

        multilib_parallel_foreach_abi multilib_src_unpack
}

multilib_src_install() {
	# make .py files executable
	find xulrunner-sdk -name "*.py" -exec chmod +x {} \;

	mkdir -p "${D}/opt/xulrunner-sdk/${ABI}/"
	cp -r xulrunner-sdk/* "${D}/opt/xulrunner-sdk/${ABI}/"
}
