EAPI=7

inherit font

DESCRIPTION="A serif typeface designed by Eben Sorkin. From Google."
HOMEPAGE="https://fonts.google.com/specimen/Merriweather"
SRC_URI="https://fonts.google.com/download?family=Merriweather -> ${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
