EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11,12,13,14} )
inherit distutils-r1 pypi

DESCRIPTION="Extract the top level domain (TLD) from the URL given"
HOMEPAGE="https://github.com/barseghyanartur/tld"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
