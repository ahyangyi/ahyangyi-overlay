# Patchset maintained at https://github.com/ahyangyi/WhiteButterfly

EAPI=7

DESCRIPTION="Shoot-em-up game with strange 8-bit pastel colours and partly random music. Three stages, five fighters, many hours of agonising frustration."
HOMEPAGE="https://www.allegro.cc/depot/WhiteButterfly"
SRC_URI="https://d1cxvcw9gjxu2x.cloudfront.net/projects/2187#Butterfly_v11_src.zip -> Butterfly_v11_src.zip
         https://d1cxvcw9gjxu2x.cloudfront.net/projects/2186#Butterfly_v11_win.zip -> Butterfly_v11_win.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

RDEPEND="media-libs/allegro:0"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_prepare() {
	eapply ${FILESDIR}/white-butterfly-1.1-r4.patch
	sed -i -s 's|"gfx|"'${ROOT}/usr/share/games/white-butterfly/gfx'|g' ${S}/display_init.c
	sed -i -s 's|\.//wavs//|'${ROOT}/usr/share/games/white-butterfly/wavs/'|g' ${S}/sound.c
	sed -i -s 's|\.//beat//|'${ROOT}/usr/share/games/white-butterfly/beat/'|g' ${S}/sound.c
	sed -i -s 's|char sfile_name \[50\]|char sfile_name [512]|g' ${S}/sound.c
	eapply_user
}

src_compile() {
	cd ${S}
	emake
}

src_install() {
	dobin white-butterfly
	insinto /usr/share/games/white-butterfly
	doins -r beat gfx wavs
}
