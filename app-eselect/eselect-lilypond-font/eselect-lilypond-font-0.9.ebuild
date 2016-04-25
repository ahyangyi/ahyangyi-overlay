EAPI=5

DESCRIPTION="Manages lilypond font replacements"
HOMEPAGE="http://mirrors.ahyangyi.org"
SRC_URI="http://mirrors.ahyangyi.org/gentoo/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="app-admin/eselect"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto /usr/share/eselect/modules
	doins lilypond-font.eselect
}
