EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1

DESCRIPTION="Model Context Protocol SDK"
HOMEPAGE="https://modelcontextprotocol.io https://github.com/modelcontextprotocol/python-sdk"
SRC_URI="https://github.com/modelcontextprotocol/python-sdk/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/anyio-4.5[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.27[${PYTHON_USEDEP}]
	>=dev-python/httpx-sse-0.4[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.7.2[${PYTHON_USEDEP}]
	>=dev-python/pydantic-settings-2.5.2[${PYTHON_USEDEP}]
	>=dev-python/sse-starlette-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/starlette-0.27[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.23.1[${PYTHON_USEDEP}]
"

S="${WORKDIR}/python-sdk-${PV}"
