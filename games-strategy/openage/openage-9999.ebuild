# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python3_3 )

inherit cmake-utils python-any-r1 git-r3

DESCRIPTION="Open source clone of the Age of Empires II engine"
HOMEPAGE="http://openage.sft.mx/"
EGIT_REPO_URI="https://github.com/SFTtech/openage.git"

LICENSE="GPL-3 LGPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="${PYTHON_DEPS}

	media-libs/fontconfig
	media-libs/freetype
	media-libs/ftgl
	media-libs/glew
	media-libs/libsdl2
	media-libs/opusfile
	media-libs/sdl2-image
	virtual/opengl
	"	

RDEPEND="${DEPEND}
	media-fonts/dejavu

	# convert tool
	dev-python/numpy
	dev-python/pillow
	media-sound/opus-tools
	"

pkg_pretend() {
        local ver=4.8.0
        local msg="${PN} needs at least GCC ${ver} set to compile."

        if [[ ${MERGE_TYPE} != binary ]]; then
                if [[ $(tc-getCXX) == *g++ ]] && ! version_is_at_least ${ver} $(gcc-fullversion); then
                        eerror ${msg}
                        die ${msg}
                fi
        fi
}
