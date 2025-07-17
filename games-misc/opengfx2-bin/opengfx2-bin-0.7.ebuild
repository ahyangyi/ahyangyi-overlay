EAPI=8

DESCRIPTION="Reworked base graphics set for OpenTTD"
HOMEPAGE="https://github.com/OpenTTD/OpenGFX2"
SRC_URI="normal_zoom? ( https://github.com/OpenTTD/OpenGFX2/releases/download/v${PV}/opengfx2_8.tar -> ${P}_8.tar ) "
SRC_URI+="extra_zoom? ( https://github.com/OpenTTD/OpenGFX2/releases/download/v${PV}/opengfx2_32ez.tar -> ${P}_32ez.tar )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="+normal_zoom +extra_zoom"
REQUIRED_USE="|| ( normal_zoom extra_zoom )"

S="${DISTDIR}"

DOCS=( "readme.md" "changelog.md" )

src_install() {
	insinto "/usr/share/openttd/baseset/"
	use normal_zoom && doins ${P}_8.tar
	use extra_zoom && doins ${P}_32ez.tar

	if use normal_zoom; then
		cd ${WORKDIR}/opengfx2_8/
		einstalldocs
	else
		cd ${WORKDIR}/opengfx2_32ez/
		einstalldocs
	fi
}
