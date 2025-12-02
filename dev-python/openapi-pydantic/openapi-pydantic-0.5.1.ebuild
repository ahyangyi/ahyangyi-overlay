EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1 pypi

DESCRIPTION="Pydantic models for OpenAPI specifications"
HOMEPAGE="https://github.com/kuimono/openapi-pydantic"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/pydantic-1.8[${PYTHON_USEDEP}]
"
