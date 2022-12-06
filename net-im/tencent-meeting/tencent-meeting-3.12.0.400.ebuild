# grabbed from gentoo-zh
# Please consider using gentoo-zh directly!

EAPI=7
MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop multilib-build unpacker xdg-utils

DESCRIPTION="Tencent Meeting"
HOMEPAGE="https://meeting.tencent.com/"
LICENSE="Tencent"
RESTRICT="bindist mirror"

SRC_URI="https://updatecdn.meeting.qq.com/cos/e078bf97365540d9f0ff063f93372a9c/TencentMeeting_0300000000_3.12.0.400_x86_64_default.publish.deb"

SLOT="0"
KEYWORDS="amd64"

# NOTE: sys-devel/gcc and sys-libs/glibc are omitted, not sure if this is right
RDEPEND="
	dev-libs/glib:2[${MULTILIB_USEDEP}]
	dev-libs/nspr:0[${MULTILIB_USEDEP}]
	dev-libs/nss:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:2[${MULTILIB_USEDEP}]
	x11-libs/libX11:0[${MULTILIB_USEDEP}]
	x11-libs/pango:0[${MULTILIB_USEDEP}]
"

DEPEND=""
BDEPEND=""

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	default
}

src_install() {
	insinto /opt
	doins -r opt/wemeet/
	fperms 0755 /opt/wemeet/bin/{wemeetapp,QtWebEngineProcess}
	dosym ../../opt/wemeet/bin/wemeetapp usr/bin/wemeetapp
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
