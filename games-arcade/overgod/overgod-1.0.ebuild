EAPI=7

DESCRIPTION="For too long has humanity been ruled by cruel and disputatious gods! Fly through the various layers of the Celestial Oversphere to unseat those who control the universe."
HOMEPAGE="https://www.allegro.cc/depot/Overgod"
SRC_URI="https://d1cxvcw9gjxu2x.cloudfront.net/projects/1699#ogsrc10.zip -> Overgod_v10_src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

RDEPEND="media-libs/allegro:0"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_prepare() {
	eapply ${FILESDIR}/overgod-1.0.patch
	sed -i -s 's|"gfx|"'${ROOT}/usr/share/games/overgod/gfx'|g' ${S}/displ_in.c ${S}/menu.c
	sed -i -s 's|\.//wavs//|'${ROOT}/usr/share/games/overgod/wavs/'|g' ${S}/sound.c
	eapply_user
}

src_compile() {
	cd ${S}
	emake
}

src_install() {
	dobin overgod
	insinto /usr/share/games/overgod
	doins -r gfx wavs
}
