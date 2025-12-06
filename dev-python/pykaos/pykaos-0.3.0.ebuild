EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_13 )
inherit distutils-r1
SRC_URI="https://github.com/MoonshotAI/pykaos/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="Kimi Agent Operating System (KAOS) Python implementation."
HOMEPAGE="https://github.com/MoonshotAI/pykaos"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RDEPEND="
	>=dev-python/aiofiles-25.1.0[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
"
