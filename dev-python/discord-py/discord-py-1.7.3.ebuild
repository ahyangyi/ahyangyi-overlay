EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )
inherit distutils-r1

DESCRIPTION="An API wrapper for Discord written in Python."
HOMEPAGE="https://github.com/Rapptz/discord.py"
SRC_URI="https://github.com/Rapptz/discord.py/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/discord.py-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/websockets[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
"
