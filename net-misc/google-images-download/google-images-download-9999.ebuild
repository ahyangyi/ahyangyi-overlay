EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit distutils-r1
EGIT_REPO_URI="https://github.com/hardikvasa/google-images-download.git"
inherit git-r3

DESCRIPTION="Python Script for 'searching' and 'downloading' hundreds of Google images to the local hard disk!"
HOMEPAGE="https://github.com/hardikvasa/google-images-download"

LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="
"
DEPEND="
	${RDEPEND}
"
