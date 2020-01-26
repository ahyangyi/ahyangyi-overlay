EAPI=7
inherit eutils

DESCRIPTION="A musical shoot-em-up influenced by rRootage, Radiant Silvergun and Rez."
HOMEPAGE="https://www.allegro.cc/depot/GardenofColouredLights"
SRC_URI="https://d1cxvcw9gjxu2x.cloudfront.net/projects/1981#Source_v102.zip -> GardenofColouredLights_v102_src.zip
         https://d1cxvcw9gjxu2x.cloudfront.net/projects/1980#Garden_v102.zip -> GardenofColouredLights_v102_win.zip"

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

RDEPEND="media-libs/allegro:0"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_prepare() {
	eapply ${FILESDIR}/garden-of-coloured-lights-1.02-r3.patch
	sed -i -s 's|"gfx|"'${ROOT}/usr/share/games/garden-of-coloured-lights/gfx'|g' ${S}/Source/display_init.c ${S}/Source/menu.c
	sed -i -s 's|\.//wavs//|'${ROOT}/usr/share/games/garden-of-coloured-lights/wavs/'|g' ${S}/Source/sound.c
	sed -i -s 's|\.//beat//|'${ROOT}/usr/share/games/garden-of-coloured-lights/beat/'|g' ${S}/Source/sound.c
	sed -i -s 's|char sfile_name \[50\]|char sfile_name [512]|g' ${S}/Source/sound.c
	eapply_user
}

src_compile() {
	cd ${S}/Source
	emake
}

src_install() {
	dobin Source/garden-of-coloured-lights
	insinto /usr/share/games/garden-of-coloured-lights
	doins -r Garden/{beat,gfx,wavs}
}
