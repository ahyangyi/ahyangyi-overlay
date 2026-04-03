EAPI=8

LUA_COMPAT=( lua5-1 lua5-3 lua5-4 )
CRATES="
	anstream@0.6.18
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.7
	anstyle@1.0.10
	bitflags@1.3.2
	cfixed-string@1.0.0
	clap@4.5.26
	clap_builder@4.5.26
	clap_derive@4.5.24
	clap_lex@0.7.4
	colorchoice@1.0.3
	enumflags2@0.7.10
	enumflags2_derive@0.7.10
	heck@0.5.0
	is_terminal_polyfill@1.70.1
	once_cell@1.20.2
	paste@1.0.15
	proc-macro2@1.0.92
	quote@1.0.37
	strsim@0.11.1
	syn@2.0.89
	unicode-ident@1.0.14
	utf8parse@0.2.2
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
"

inherit lua-single cargo cmake

DESCRIPTION="Dora (Special Super Rare) Game Engine"
HOMEPAGE="https://dora-ssr.net/"

BGFX_COMMIT=e451db0ca9322a0c135f57f6b81680a99bd6817e
BIMG_COMMIT=a1a2ae3c129d8c33e765eecd91801bffd985c317
BX_COMMIT=de7b3408fc1dd19532c7b3424359f58b2f20c614
GENIE_COMMIT=83c2411fe04a8a5b71c5610d9debeebba07a64e4

SRC_URI="https://github.com/IppClub/Dora-SSR/archive/refs/tags/v${PV}.tar.gz -> dora-ssr-v${PV}.tar.gz
	https://github.com/pigpigyyy/bgfx/archive/${BGFX_COMMIT}.tar.gz -> bgfx-${BGFX_COMMIT}.tar.gz
	https://github.com/pigpigyyy/bimg/archive/${BIMG_COMMIT}.tar.gz -> bimg-${BIMG_COMMIT}.tar.gz
	https://github.com/pigpigyyy/bx/archive/${BX_COMMIT}.tar.gz -> bx-${BX_COMMIT}.tar.gz
	https://github.com/pigpigyyy/GENie/archive/${GENIE_COMMIT}.tar.gz -> GENie-${GENIE_COMMIT}.tar.gz
	${CARGO_CRATE_URIS}"

S="${WORKDIR}/Dora-SSR-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	${LUA_DEPS}
	media-libs/libsdl2
	media-libs/mesa
	dev-libs/openssl
	sys-apps/dbus
	dev-lua/luafilesystem
"

DEPEND="${RDEPEND}"

BDEPEND="
	virtual/pkgconfig
"

pkg_setup() {
	lua-single_pkg_setup
	rust_pkg_setup
}

src_prepare() {
	default

	# Remove rustup call since we use system Rust
	sed -i '/rustup/d' Tools/build-scripts/build_lib_linux_x86_64.sh || die
	sed -i '/rustup/d' Tools/build-scripts/build_lib_linux_aarch64.sh 2>/dev/null || true

	# Prepare 3rdParty directory to use pre-fetched sources
	mkdir -p Projects/Linux/3rdParty || die
	cp -r "${WORKDIR}/bgfx-${BGFX_COMMIT}" Projects/Linux/3rdParty/bgfx || die
	cp -r "${WORKDIR}/bimg-${BIMG_COMMIT}" Projects/Linux/3rdParty/bimg || die
	cp -r "${WORKDIR}/bx-${BX_COMMIT}" Projects/Linux/3rdParty/bx || die
	cp -r "${WORKDIR}/GENie-${GENIE_COMMIT}" Projects/Linux/3rdParty/GENie || die

	# Mark 3rdParty libs as fetched to skip git clone
	touch Projects/Linux/3rdParty/bgfx/.git || die
	touch Projects/Linux/3rdParty/bimg/.git || die
	touch Projects/Linux/3rdParty/bx/.git || die
	touch Projects/Linux/3rdParty/GENie/.git || die

	cmake_src_prepare
}

src_compile() {
	export LUA_VERSION="$(lua_get_version)"

	# Lua bindings generation
	pushd Tools/tolua++ > /dev/null || die
	${LUA} tolua++.lua || die "tolua++ failed"
	popd > /dev/null || die

	# Build static libraries (bgfx, bx, bimg)
	pushd Projects/Linux/3rdParty > /dev/null || die

	# Build GENie
	emake -C GENie
	cp GENie/bin/linux/genie bx/tools/bin/linux/genie || die

	# Build bgfx
	pushd bgfx > /dev/null || die
	../bx/tools/bin/linux/genie --gcc=linux-gcc gmake || die "genie failed"
	popd > /dev/null || die

	emake -R -C bgfx/.build/projects/gmake-linux-gcc config=release64 || die "bgfx build failed"

	mkdir -p libs || die
	cp -r bgfx/.build/linux64_gcc/bin/* libs/ || die
	cp "${S}/Source/3rdParty/Wa/Lib/Linux/amd64/libwa.a" libs/ || die

	popd > /dev/null || die

	# Build Rust library
	pushd Source/Rust > /dev/null || die
	cargo_src_compile --target x86_64-unknown-linux-gnu
	mkdir -p lib/Linux/x86_64 || die
	cp "$(cargo_target_dir)/x86_64-unknown-linux-gnu/release/libdora_runtime.a" lib/Linux/x86_64/ || die
	popd > /dev/null || die

	cp "${S}/Source/Rust/lib/Linux/x86_64/libdora_runtime.a" Projects/Linux/3rdParty/libs/ || die

	# Build the main application
	pushd Projects/Linux > /dev/null || die
	cmake_src_configure
	cmake_build
	popd > /dev/null || die
}

src_install() {
	# Install binary
	dobin Projects/Linux/build/dora-ssr

	# Install assets
	insinto /usr/share/dora-ssr
	doins -r Assets/*
}
