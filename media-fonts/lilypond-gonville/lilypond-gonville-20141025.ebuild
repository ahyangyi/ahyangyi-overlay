EAPI="5"

DESCRIPTION="Gonville fonts for lilypond"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/gonville/"
SRC_URI="http://www.chiark.greenend.org.uk/~sgtatham/gonville/gonville-20141025.177659a.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="
	"
RDEPEND="${DEPEND}"

PREFIX="/usr/share/lilypond/fonts.avail/gonville"

S=${WORKDIR}/gonville-${PV}.177659a

src_install() {
	for dir in otf type1 svg; do
		dodir ${PREFIX}/${dir}
		insinto ${PREFIX}/${dir}
		doins ${S}/lilyfonts/${dir}/*
	done
}
