EAPI=8

inherit qmake-utils xdg

DESCRIPTION="A soundfont editor for quickly designing musical instruments."
HOMEPAGE="https://www.polyphone-soundfonts.com/"
SRC_URI="https://www.polyphone-soundfonts.com/download/file/893-polyphone-2-3-1-zip/latest/download -> polyphone-2.3.1.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

BDEPEND="dev-qt/linguist-tools:5"
DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	virtual/jack
	media-libs/portaudio
	media-libs/rtmidi
	media-libs/stk
	dev-libs/qcustomplot
"
RDEPEND="${DEPEND}
	dev-qt/qtsvg:5
"
S="${WORKDIR}"

src_configure() {
	eqmake5 PREFIX="/usr"
}

src_install() {
    emake INSTALL_ROOT="${D}" install
    einstalldocs
}
