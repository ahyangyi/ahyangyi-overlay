EAPI=8

DESCRIPTION="Reworked base graphics set for OpenTTD"
HOMEPAGE="https://github.com/OpenTTD/OpenGFX2"
SRC_URI="classic? ( https://github.com/OpenTTD/OpenGFX2/releases/download/${PV}/OpenGFX2_Classic-${PV}.tar -> ${P}_Classic.tar ) "
SRC_URI+="highdef? ( https://github.com/OpenTTD/OpenGFX2/releases/download/${PV}/OpenGFX2_HighDef-${PV}.tar -> ${P}_HighDef.tar )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="+classic +highdef"
REQUIRED_USE="|| ( classic highdef )"

S="${DISTDIR}"

DOCS=( "readme.md" "changelog.md" )

src_install() {
	insinto "/usr/share/openttd/baseset/"
	use classic && doins ${P}_Classic.tar
	use highdef && doins ${P}_HighDef.tar

	if use classic; then
		cd ${WORKDIR}/OpenGFX2_Classic-${PV}/
		einstalldocs
	else
		cd ${WORKDIR}/OpenGFX2_HighDef-${PV}/
		einstalldocs
	fi
}
