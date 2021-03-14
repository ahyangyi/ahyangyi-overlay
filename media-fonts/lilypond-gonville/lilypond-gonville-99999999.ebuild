EAPI="5"

inherit git-r3

DESCRIPTION="Gonville fonts for lilypond"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/gonville/"
EGIT_REPO_URI="https://git.tartarus.org/simon/gonville.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-lang/python
	media-gfx/fontforge
	media-gfx/potrace
	>=media-sound/lilypond-2.22
	"
RDEPEND="${DEPEND}"

PREFIX="/usr/share/lilypond/fonts"

src_compile() {
	python glyphs.py --lily || die
}

src_install() {
	for dir in otf svg; do
		dodir ${PREFIX}/${dir}
		insinto ${PREFIX}/${dir}
		doins ${WORKDIR}/${P}/lilyfonts/*.${dir}
	done
}
