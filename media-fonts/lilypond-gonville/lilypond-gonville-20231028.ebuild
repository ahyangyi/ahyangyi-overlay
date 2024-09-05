EAPI="7"

DESCRIPTION="Gonville fonts for lilypond"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/gonville/"
HASH="4ec6d4f"
SRC_URI="https://www.chiark.greenend.org.uk/~sgtatham/gonville/gonville-${PV}.${HASH}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="
	>=media-sound/lilypond-2.22
	"
RDEPEND="${DEPEND}"

PREFIX="/usr/share/lilypond/fonts/"

S=${WORKDIR}/gonville-${PV}.${HASH}

src_install() {
	for dir in otf svg; do
		dodir ${PREFIX}/${dir}
		insinto ${PREFIX}/${dir}
		doins ${S}/*.${dir}
	done
}
