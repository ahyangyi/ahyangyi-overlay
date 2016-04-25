EAPI="5"

DESCRIPTION="Gonville fonts for lilypond"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/gonville/"
SRC_URI="http://mirrors.ahyangyi.org/gentoo/distfiles/gonville-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="
	media-gfx/fontforge
	"
RDEPEND="${DEPEND}"

PREFIX="/usr/share/lilypond/fonts.avail/gonville"

S=${WORKDIR}/gonville-${PV}

src_compile() {
	cd ${WORKDIR}/gonville-${PV}
	./glyphs.py -lily
}

src_install() {
	for dir in otf type1 svg; do
		dodir ${PREFIX}/${dir}
		insinto ${PREFIX}/${dir}
		doins ${WORKDIR}/gonville-${PV}/lilyfonts/${dir}/*
	done
}
