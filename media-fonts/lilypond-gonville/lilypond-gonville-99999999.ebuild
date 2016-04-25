EAPI="5"

inherit subversion

DESCRIPTION="Gonville fonts for lilypond"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/gonville/"
ESVN_REPO_URI="svn://svn.tartarus.org/sgt/gonville"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="
	media-gfx/fontforge
	"
RDEPEND="${DEPEND}"

PREFIX="/usr/share/lilypond/fonts.avail/gonville"

src_compile() {
	./glyphs.py -lily
}

src_install() {
	for dir in otf type1 svg; do
		dodir ${PREFIX}/${dir}
		insinto ${PREFIX}/${dir}
		doins ${WORKDIR}/${P}/lilyfonts/${dir}/*
	done
}
