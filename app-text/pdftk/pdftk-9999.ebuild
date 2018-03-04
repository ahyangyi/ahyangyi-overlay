# Grabbed from: http://repo.or.cz/marcv-overlay.git/tree/HEAD:/app-text/pdftk
EAPI=6

EGIT_REPO_URI="https://gitlab.com/marcvinyals/pdftk/"

JAVA_PKG_STRICT=true
EANT_GENTOO_CLASSPATH="
	bcprov
	commons-lang-3.6
"
JAVA_ANT_REWRITE_CLASSPATH="true"

inherit git-r3 java-pkg-2 java-ant-2

#SRC_URI="https://gitlab.com/marcvinyals/pdftk/repository/master/archive.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

CDEPEND="
dev-java/bcprov:0
dev-java/commons-lang:3.6
"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.7"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.7"

src_install() {
	java-pkg_newjar "build/jar/pdftk.jar"
	java-pkg_dolauncher pdftk --main pdftk
}
