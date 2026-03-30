EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1

DESCRIPTION="The official Python library for the OpenAI API"
HOMEPAGE="https://github.com/openai/openai-python"
SRC_URI="https://github.com/openai/openai-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/httpx-0.23[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.9[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.11[${PYTHON_USEDEP}]
	>=dev-python/anyio-3.5[${PYTHON_USEDEP}]
	>=dev-python/distro-1.7[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	>=dev-python/jiter-0.10[${PYTHON_USEDEP}]
"

S="${WORKDIR}/openai-python-${PV}"
