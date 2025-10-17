EAPI=8

LUA_COMPAT=( lua5-1 )
inherit lua-single rust cmake

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

inherit cargo

DESCRIPTION="Dora (Special Super Rare) Game Engine"
HOMEPAGE="https://dora-ssr.net/"

BGFX_COMMIT=ea24c0b7e22b16b2071db3bebf388bf91abdeda4
BIMG_COMMIT=cf7ecb6dd56217d0178b5a1d3430e0b09f65b9b9
BX_COMMIT=13f0e6c61495615047422c22d7539cdf02d739f0
GENIE_COMMIT=3757e9085b1450db1a46fff84de395f2804385b0

SRC_URI="https://codeload.github.com/IppClub/Dora-SSR/tar.gz/refs/tags/v${PV} -> dora-ssr-v${PV}.tar.gz
	https://github.com/pigpigyyy/bgfx/archive/${BGFX_COMMIT}.tar.gz -> bgfx-${BGFX_COMMIT}.tar.gz
	https://github.com/pigpigyyy/bimg/archive/${BIMG_COMMIT}.tar.gz -> bimg-${BIMG_COMMIT}.tar.gz
	https://github.com/pigpigyyy/bx/archive/${BX_COMMIT}.tar.gz -> bx-${BX_COMMIT}.tar.gz
	https://github.com/pigpigyyy/GENie/archive/${GENIE_COMMIT}.tar.gz -> GENie-${GENIE_COMMIT}.tar.gz
	${CARGO_CRATE_URIS}"
KEYWORDS="~amd64 ~arm64"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

REQUIRED_USE="${LUA_REQUIRED_USE}"
DEPEND="${RDEPEND}"
RDEPEND="
	${LUA_DEPS}
	media-libs/libsdl2
	media-libs/mesa
	dev-libs/openssl
	dev-lua/luafilesystem
	dev-lang/rust-bin
"
BDEPEND="virtual/pkgconfig"
S="${WORKDIR}/Dora-SSR-${PV}"

pkg_setup() {
	lua-single_pkg_setup
	rust_pkg_setup
}

src_prepare() {
	eapply_user

	sed -i '/rustup/d' Tools/build-scripts/build_lib_linux_x86_64.sh

	cd Projects/Linux
	cmake_src_prepare
}

src_compile() {
	export LUA_VERSION="$(lua_get_version)"
	# Lua bindings
	(
		cd Tools/tolua++ && ${LUA} tolua++.lua || die 
	)

	# Rust bindings
	(
		cd Source/Rust && ${CARGO} build --release --target x86_64-unknown-linux-gnu || die
	)

	cd Projects/Linux
	cp -r ../../../bgfx-${BGFX_COMMIT} 3rdParty/bgfx
	cp -r ../../../bimg-${BIMG_COMMIT} 3rdParty/bimg
	cp -r ../../../bx-${BX_COMMIT} 3rdParty/bx
	cp -r ../../../GENie-${GENIE_COMMIT} 3rdParty/GENie
	emake dep_x86_64 lib_x86_64 ARCH=""

	cmake_src_configure
	cmake_build
}

src_install() {
	dobin Projects/Linux_build/dora-ssr

	insinto /usr/share/dora-ssr
	doins -r Assets/*
}
