EAPI="7"

inherit rpm

SRC_URI="https://qd.myapp.com/myapp/qqteam/linuxQQ/linuxqq_2.0.0-b1-1024_x86_64.rpm"
DESCRIPTION="Chat with millions of new friends on QQ."
HOMEPAGE="https://im.qq.com/linuxqq"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* amd64"

RESTRICT="mirror"
RDEPEND="
	x11-libs/libX11
	dev-libs/glib
	x11-libs/gtk+:2
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
	>=dev-libs/nss-3
	>=dev-libs/nspr-4
"

S=${WORKDIR}

src_install() {
	insinto /usr/share/tencent-qq
	doins ${WORKDIR}/usr/share/tencent-qq/{qq.bmp,qq.png,res.db}

	insinto /usr/share/applications
	doins ${WORKDIR}/usr/share/applications/qq.desktop

	exeinto /usr/share/tencent-qq
	doexe ${WORKDIR}/usr/share/tencent-qq/qq
}
