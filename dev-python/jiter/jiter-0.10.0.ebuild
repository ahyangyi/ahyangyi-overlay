EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{10,11,12,13} )

CRATES="
	ahash@0.8.12
	anyhow@1.0.102
	arbitrary@1.4.2
	autocfg@1.5.0
	bencher@0.1.5
	bitflags@2.11.0
	bitvec@1.0.1
	bumpalo@3.20.2
	cc@1.2.57
	cfg-if@1.0.4
	codspeed-bencher-compat@2.10.1
	codspeed@2.10.1
	colored@2.2.0
	equivalent@1.0.2
	find-msvc-tools@0.1.9
	foldhash@0.1.5
	funty@2.0.0
	getrandom@0.3.4
	getrandom@0.4.2
	hashbrown@0.15.5
	hashbrown@0.16.1
	heck@0.5.0
	id-arena@2.3.0
	indexmap@2.13.0
	indoc@2.0.7
	itoa@1.0.17
	jobserver@0.1.34
	js-sys@0.3.91
	lazy_static@1.5.0
	leb128fmt@0.1.0
	lexical-parse-float@1.0.6
	lexical-parse-integer@1.0.6
	lexical-util@1.0.7
	libc@0.2.183
	libfuzzer-sys@0.4.12
	log@0.4.29
	memchr@2.8.0
	memoffset@0.9.1
	num-bigint@0.4.6
	num-integer@0.1.46
	num-traits@0.2.19
	once_cell@1.21.4
	paste@1.0.15
	portable-atomic@1.13.1
	prettyplease@0.2.37
	proc-macro2@1.0.106
	pyo3-build-config@0.25.1
	pyo3-ffi@0.25.1
	pyo3-macros-backend@0.25.1
	pyo3-macros@0.25.1
	pyo3@0.25.1
	python3-dll-a@0.2.14
	quote@1.0.45
	r-efi@5.3.0
	r-efi@6.0.0
	radium@0.7.0
	rustversion@1.0.22
	semver@1.0.27
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.149
	shlex@1.3.0
	smallvec@1.15.1
	syn@2.0.117
	tap@1.0.1
	target-lexicon@0.13.5
	unicode-ident@1.0.24
	unicode-xid@0.2.6
	unindent@0.2.4
	uuid@1.22.0
	version_check@0.9.5
	wasip2@1.0.2+wasi-0.2.9
	wasip3@0.4.0+wasi-0.3.0-rc-2026-01-06
	wasm-bindgen-macro-support@0.2.114
	wasm-bindgen-macro@0.2.114
	wasm-bindgen-shared@0.2.114
	wasm-bindgen@0.2.114
	wasm-encoder@0.244.0
	wasm-metadata@0.244.0
	wasmparser@0.244.0
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	wit-bindgen-core@0.51.0
	wit-bindgen-rust-macro@0.51.0
	wit-bindgen-rust@0.51.0
	wit-bindgen@0.51.0
	wit-component@0.244.0
	wit-parser@0.244.0
	wyz@0.5.1
	zerocopy-derive@0.8.42
	zerocopy@0.8.42
	zmij@1.0.21
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
	Apache-2.0-with-LLVM-exceptions MIT MPL-2.0 UoI-NCSA Unicode-3.0
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
