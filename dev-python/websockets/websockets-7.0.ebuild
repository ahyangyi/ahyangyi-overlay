EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7} )
inherit distutils-r1
SRC_URI="https://github.com/aaugustin/websockets/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Library for building WebSocket servers and clients in Python."
HOMEPAGE="https://github.com/aaugustin/websockets"

LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="
"

DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
