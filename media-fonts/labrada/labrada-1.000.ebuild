EAPI=7

inherit font

DESCRIPTION="Labrada is a typeface family designed by Mercedes Jáuregui."
HOMEPAGE="https://fonts.google.com/specimen/Labrada"
SRC_URI="https://github.com/google/fonts/raw/5ecbfea181adb637a32f19860753e679f1114024/ofl/labrada/Labrada%5Bwght%5D.ttf -> Labrada-${PV}.ttf
https://github.com/google/fonts/raw/5ecbfea181adb637a32f19860753e679f1114024/ofl/labrada/Labrada-Italic%5Bwght%5D.ttf -> Labrada-Italic-${PV}.ttf"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="ttf"

src_unpack()
{
	cp ${DISTDIR}/*.ttf .
}
