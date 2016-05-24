EAPI="5"

inherit git-r3

DESCRIPTION="Gonville fonts for lilypond"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/gonville/"
EGIT_REPO_URI="git://git.tartarus.org/simon/gonville.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-lang/python:2.7
	media-gfx/fontforge
	media-gfx/potrace
	"
RDEPEND="${DEPEND}"

PREFIX="/usr/share/lilypond/fonts.avail/gonville"

src_compile() {
	python2 glyphs.py -lily
}

src_install() {
	for dir in otf type1 svg; do
		dodir ${PREFIX}/${dir}
		insinto ${PREFIX}/${dir}
		doins ${WORKDIR}/${P}/lilyfonts/${dir}/*
	done
}
