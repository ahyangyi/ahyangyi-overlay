EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7} )
inherit distutils-r1
SRC_URI="https://github.com/Rapptz/discord.py/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="An API wrapper for Discord written in Python."
HOMEPAGE="https://github.com/Rapptz/discord.py"

LICENSE="BSD"
SLOT="0"
IUSE=""

S=${WORKDIR}/discord.py-${PV}

RDEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/websockets[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
