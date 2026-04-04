EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1

DESCRIPTION="The fast, Pythonic way to build MCP servers and clients"
HOMEPAGE="https://gofastmcp.com"
SRC_URI="https://github.com/PrefectHQ/fastmcp/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/fastmcp-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/python-dotenv-1.1[${PYTHON_USEDEP}]
	>=dev-python/exceptiongroup-1.2.2[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
	>=dev-python/mcp-1.12.4[${PYTHON_USEDEP}]
	<dev-python/mcp-1.17.0[${PYTHON_USEDEP}]
	>=dev-python/openapi-pydantic-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/rich-13.9.4[${PYTHON_USEDEP}]
	>=dev-python/cyclopts-3.0[${PYTHON_USEDEP}]
	>=dev-python/authlib-1.5.2[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.11.7[${PYTHON_USEDEP}]
	>=dev-python/pyperclip-1.9[${PYTHON_USEDEP}]
	>=dev-python/openapi-core-0.19.5[${PYTHON_USEDEP}]
"

src_prepare() {
	# Replace dynamic version with static version
	sed -i "s/^dynamic = \\[\"version\"\\]/version = \"${PV}\"/" pyproject.toml || die
	distutils-r1_src_prepare
}
