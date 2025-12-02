EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_13 )
inherit distutils-r1
SRC_URI="https://github.com/MoonshotAI/kimi-cli/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="A CLI agent for software development and terminal operations."
HOMEPAGE="https://github.com/MoonshotAI/kimi-cli"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RDEPEND="
	dev-python/typer[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
"
