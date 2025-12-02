EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11,12,13} )
inherit distutils-r1 pypi

DESCRIPTION="A streamlined, user-friendly JSON streaming preprocessor"
HOMEPAGE="https://github.com/karminski/streaming-json-py"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
