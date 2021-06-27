EAPI=7

inherit font

DESCRIPTION="Rambla is a humanist sans for medium-long texts. By Martin Sommaruga."
HOMEPAGE="https://www.fontsquirrel.com/fonts/rambla"
SRC_URI="https://www.fontsquirrel.com/fonts/download/rambla -> ${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="otf"

src_unpack()
{
	unpack ${A}
	mv Rambla-Italic.ttf Rambla-Italic.otf
}
