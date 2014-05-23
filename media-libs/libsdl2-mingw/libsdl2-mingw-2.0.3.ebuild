# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# TODO: convert FusionSound #484250

EAPI=5
inherit autotools flag-o-matic toolchain-funcs eutils multilib-minimal

MY_P=SDL2-${PV}
DESCRIPTION="Simple Direct Media Layer"
HOMEPAGE="http://www.libsdl.org"
SRC_URI="http://www.libsdl.org/release/${MY_P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="3dnow alsa altivec custom-cflags dbus fusionsound gles haptic +joystick mmx nas opengl oss pulseaudio +sound sse sse2 static-libs +threads tslib udev +video wayland X xinerama xscreensaver"
REQUIRED_USE="
	alsa? ( sound )
	fusionsound? ( sound )
	gles? ( video )
	nas? ( sound )
	opengl? ( video )
	pulseaudio? ( sound )
	xinerama? ( X )
	xscreensaver? ( X )"

if [[ "${CHOST}" == *mingw* ]]; then
	WIN_DEPS="app-emulation/wine"
fi

RDEPEND="
	alsa? ( media-libs/alsa-lib[${MULTILIB_USEDEP}] )
	dbus? ( sys-apps/dbus[${MULTILIB_USEDEP}] )
	fusionsound? ( || ( >=media-libs/FusionSound-1.1.1 >=dev-libs/DirectFB-1.7.1[fusionsound] ) )
	gles? ( media-libs/mesa[${MULTILIB_USEDEP},gles2] )
	nas? ( media-libs/nas[${MULTILIB_USEDEP}] )
	opengl? (
		virtual/opengl[${MULTILIB_USEDEP}]
		virtual/glu[${MULTILIB_USEDEP}]
	)
	pulseaudio? ( media-sound/pulseaudio[${MULTILIB_USEDEP}] )
	tslib? ( x11-libs/tslib[${MULTILIB_USEDEP}] )
	udev? ( virtual/udev[${MULTILIB_USEDEP}] )
	wayland? (
		dev-libs/wayland[${MULTILIB_USEDEP}]
		media-libs/mesa[${MULTILIB_USEDEP},wayland]
		x11-libs/libxkbcommon[${MULTILIB_USEDEP}]
	)
	X? (
		x11-libs/libX11[${MULTILIB_USEDEP}]
		x11-libs/libXcursor[${MULTILIB_USEDEP}]
		x11-libs/libXext[${MULTILIB_USEDEP}]
		x11-libs/libXi[${MULTILIB_USEDEP}]
		x11-libs/libXrandr[${MULTILIB_USEDEP}]
		x11-libs/libXt[${MULTILIB_USEDEP}]
		x11-libs/libXxf86vm[${MULTILIB_USEDEP}]
		xinerama? ( x11-libs/libXinerama[${MULTILIB_USEDEP}] )
		xscreensaver? ( x11-libs/libXScrnSaver[${MULTILIB_USEDEP}] )
	)"
DEPEND="${RDEPEND}
	${WIN_DEPS}
	X? (
		x11-proto/xextproto[${MULTILIB_USEDEP}]
		x11-proto/xproto[${MULTILIB_USEDEP}]
	)
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# https://bugzilla.libsdl.org/show_bug.cgi?id=1431
	epatch "${FILESDIR}"/${P}-static-libs.patch \
		"${FILESDIR}"/${P}-gles-wayland.patch

	if [[ "${CHOST}" == *mingw* ]]; then
		epatch "${FILESDIR}"/disable-dynapi.patch \
			"${FILESDIR}"/${P}-fix-platform-detection-for-mingw.patch
	fi
	AT_M4DIR="/usr/share/aclocal acinclude" eautoreconf
}

multilib_src_configure() {
	use custom-cflags || strip-flags

	if [[ "${CHOST}" == *mingw* ]]; then
		append-cppflags "-I/usr/include/wine/windows/"
		OS_FLAGS="--enable-directx \
			--enable-render-d3d \
			--enable-loadso --disable-video-dummy --enable-video-opengl"
	else
		OS_FLAGS="--disable-directx \
			--disable-render-d3d \
			--disable-loadso"
	fi

	# sorted by `./configure --help`
	ECONF_SOURCE="${S}" econf \
		$(use_enable static-libs static) \
		$(use_enable sound audio) \
		$(use_enable video) \
		--enable-render \
		--enable-events \
		$(use_enable joystick) \
		$(use_enable haptic) \
		--enable-power \
		$(use_enable threads) \
		--enable-timers \
		--enable-file \
		--enable-cpuinfo \
		--enable-atomic \
		--enable-assembly \
		$(use_enable sse ssemath) \
		$(use_enable mmx) \
		$(use_enable 3dnow) \
		$(use_enable sse) \
		$(use_enable sse2) \
		$(use_enable altivec) \
		$(use_enable oss) \
		$(use_enable alsa) \
		--disable-alsa-shared \
		--disable-esd \
		$(use_enable pulseaudio) \
		--disable-pulseaudio-shared \
		--disable-arts \
		$(use_enable nas) \
		--disable-nas-shared \
		--disable-sndio \
		--disable-sndio-shared \
		$(use_enable sound diskaudio) \
		$(use_enable sound dummyaudio) \
		$(use_enable X video-x11) \
		--disable-x11-shared \
		$(use_enable wayland video-wayland) \
		--disable-wayland-shared \
		$(use_enable X video-x11-xcursor) \
		$(use_enable xinerama video-x11-xinerama) \
		$(use_enable X video-x11-xinput) \
		$(use_enable X video-x11-xrandr) \
		$(use_enable xscreensaver video-x11-scrnsaver) \
		$(use_enable X video-x11-xshape) \
		$(use_enable X video-x11-vm) \
		--disable-video-cocoa \
		--disable-video-directfb \
		$(multilib_native_use_enable fusionsound) \
		--disable-fusionsound-shared \
		$(use_enable opengl video-opengl) \
		$(use_enable gles video-opengles) \
		$(use_enable udev libudev) \
		$(use_enable dbus) \
		$(use_enable tslib input-tslib) \
		--disable-rpath \
		$(use_with X x) \
		${OS_FLAGS}
}

multilib_src_install() {
	emake DESTDIR="${D}" install
}

multilib_src_install_all() {
	use static-libs || prune_libtool_files
	dodoc {BUGS,CREDITS,README,README-SDL,README-hg,TODO,WhatsNew}.txt
}
