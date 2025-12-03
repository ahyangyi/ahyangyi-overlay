EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_13 )
inherit distutils-r1
SRC_URI="https://github.com/MoonshotAI/kosong/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="The LLM abstraction layer for modern AI agent applications."
HOMEPAGE="https://github.com/MoonshotAI/kosong"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RDEPEND="
	dev-python/loguru[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
"
