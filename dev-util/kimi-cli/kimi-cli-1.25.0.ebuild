EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_13 )
inherit distutils-r1

DESCRIPTION="A CLI agent for software development and terminal operations."
HOMEPAGE="https://github.com/MoonshotAI/kimi-cli"
SRC_URI="https://github.com/MoonshotAI/kimi-cli/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/agent-client-protocol-0.8[${PYTHON_USEDEP}]
	>=dev-python/aiofiles-24[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.13[${PYTHON_USEDEP}]
	>=dev-python/fastmcp-2.12.5[${PYTHON_USEDEP}]
	>=dev-python/fastapi-0.115[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.28[${PYTHON_USEDEP}]
	>=dev-python/jinja2-3.1[${PYTHON_USEDEP}]
	>=dev-python/keyring-25.7[${PYTHON_USEDEP}]
	>=dev-python/loguru-0.6[${PYTHON_USEDEP}]
	>=dev-python/lxml-6.0[${PYTHON_USEDEP}]
	dev-python/lxml-html-clean[${PYTHON_USEDEP}]
	>=dev-python/pillow-12.1[${PYTHON_USEDEP}]
	>=dev-python/prompt-toolkit-3.0.52[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.12[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1.2[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/rich-14.2[${PYTHON_USEDEP}]
	>=dev-python/ripgrepy-2.2[${PYTHON_USEDEP}]
	>=dev-python/scalar-fastapi-1.5[${PYTHON_USEDEP}]
	>=dev-python/setproctitle-1.3[${PYTHON_USEDEP}]
	>=dev-python/streamingjson-0.0.5[${PYTHON_USEDEP}]
	>=dev-python/tenacity-9.1[${PYTHON_USEDEP}]
	>=dev-python/tomlkit-0.14[${PYTHON_USEDEP}]
	>=dev-python/trafilatura-2.0[${PYTHON_USEDEP}]
	>=dev-python/typer-0.21[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.32[${PYTHON_USEDEP}]
	>=dev-python/websockets-14[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/uv-build[${PYTHON_USEDEP}]
"

python_compile() {
	# Build kosong workspace package first
	pushd "${S}/packages/kosong" > /dev/null || die
	distutils_pep517_install "${BUILD_DIR}/install"
	popd > /dev/null || die

	# Build pykaos workspace package
	pushd "${S}/packages/kaos" > /dev/null || die
	distutils_pep517_install "${BUILD_DIR}/install"
	popd > /dev/null || die

	# Build main package
	pushd "${S}" > /dev/null || die
	distutils_pep517_install "${BUILD_DIR}/install"
	popd > /dev/null || die
}
