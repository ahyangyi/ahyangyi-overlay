EAPI="5"

DESCRIPTION="Gonville fonts for lilypond"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/gonville/"
HASH="bedc4d7-old"
SRC_URI="https://www.chiark.greenend.org.uk/~sgtatham/gonville/gonville-${PV}.${HASH}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="
	"
RDEPEND="${DEPEND}"

PREFIX="/usr/share/lilypond/fonts.avail/gonville"

S=${WORKDIR}/gonville-${PV}.${HASH}

src_install() {
	for dir in otf svg; do
		dodir ${PREFIX}/${dir}
		insinto ${PREFIX}/${dir}
		doins ${S}/fontdir/${dir}/*
	done
}
