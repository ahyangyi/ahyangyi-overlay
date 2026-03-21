EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{10,11,12,13} )

CRATES="
	ahash@0.8.12
	autocfg@1.5.0
	bitvec@1.0.1
	cfg-if@1.0.4
	funty@2.0.0
	getrandom@0.3.4
	heck@0.5.0
	lexical-parse-float@1.0.6
	lexical-parse-integer@1.0.6
	lexical-util@1.0.7
	libc@0.2.183
	num-bigint@0.4.6
	num-integer@0.1.46
	num-traits@0.2.19
	once_cell@1.21.4
	proc-macro2@1.0.106
	pyo3-build-config@0.28.2
	pyo3-ffi@0.28.2
	pyo3-macros-backend@0.28.2
	pyo3-macros@0.28.2
	pyo3@0.28.2
	quote@1.0.45
	radium@0.7.0
	smallvec@1.15.1
	syn@2.0.117
	tap@1.0.1
	target-lexicon@0.13.5
	unicode-ident@1.0.24
	version_check@0.9.5
	wyz@0.5.1
	zerocopy-derive@0.8.47
	zerocopy@0.8.47
"

inherit cargo distutils-r1

DESCRIPTION="Fast iterable JSON parser"
HOMEPAGE="https://github.com/pydantic/jiter"
SRC_URI="
	https://github.com/pydantic/jiter/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0-with-LLVM-exceptions MIT MPL-2.0 Unicode-3.0
	ZLIB
"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/jiter-${PV}"

QA_FLAGS_IGNORED=".*"

src_unpack() {
	default
	cargo_src_unpack
}

src_prepare() {
	distutils-r1_src_prepare
	cargo_gen_config
}

src_compile() {
	cd "${S}/crates/jiter-python" || die
	distutils-r1_src_compile
}

src_install() {
	cd "${S}/crates/jiter-python" || die
	distutils-r1_src_install
}
