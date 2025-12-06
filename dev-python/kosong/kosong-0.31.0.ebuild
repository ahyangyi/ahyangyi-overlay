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
	>=dev-python/loguru-0.7.3[${PYTHON_USEDEP}]
	>=dev-python/anthropic-0.75.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.25.1[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.12.5[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
"
