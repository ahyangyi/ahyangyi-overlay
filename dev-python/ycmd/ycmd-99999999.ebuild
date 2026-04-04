EAPI=8

PYTHON_COMPAT=( python3_{10..14} )

inherit cmake multilib python-single-r1 git-r3 vcs-clean

EGIT_REPO_URI="https://github.com/ycm-core/ycmd.git"
DESCRIPTION="A code-completion & code-comprehension server"
HOMEPAGE="https://github.com/ycm-core/ycmd/"
EGIT_SUBMODULES=(
	'*'
	'-third_party/bottle'
	'-third_party/waitress'
	'-third_party/jedi_deps/numpydoc'
)

LICENSE="GPL-3"
SLOT="0"
IUSE="+clang doc test rust"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="
	${PYTHON_DEPS}
	clang? ( >=sys-devel/clang-3.3 )
	$(python_gen_cond_dep 'dev-libs/boost[python,threads,${PYTHON_USEDEP}]')
"
RDEPEND="
	${COMMON_DEPEND}
	$(python_gen_cond_dep 'dev-python/bottle[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/future[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/sh[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/waitress[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/watchdog[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/requests[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/jedi[${PYTHON_USEDEP}]')
"
DEPEND="
	${COMMON_DEPEND}
	rust? (
		|| ( dev-lang/rust dev-lang/rust-bin )
		|| ( dev-util/cargo dev-util/cargo-bin )
	)
	test? (
		$(python_gen_cond_dep '>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]')
		dev-cpp/gmock
		dev-cpp/gtest
	)
"

CMAKE_IN_SOURCE_BUILD=1
CMAKE_USE_DIR=${S}/cpp

src_unpack() {
	use rust || EGIT_SUBMODULES+=('-third_party/racerd')
	git-r3_src_unpack
}

src_prepare() {
	if ! use test ; then
		sed -i '/^add_subdirectory( tests )/d' cpp/ycm/CMakeLists.txt || die
	fi

	python_fix_shebang -f third_party/cregex/tools/build_regex_unicode.py

	for third_party_module in bottle waitress; do
		rm -r "${S}"/third_party/${third_party_module} || die "Failed to remove third party module ${third_party_module}"
	done
	for third_party_module in jedi parso numpydoc; do
		rm -r "${S}"/third_party/jedi_deps/${third_party_module} || die "Failed to remove third party module ${third_party_module}"
	done
	for third_party_module in requests idna certifi chardet urllib3; do
		rm -r "${S}"/third_party/requests_deps/${third_party_module} || die "Failed to remove third party module ${third_party_module}"
	done
	rm -r "${S}"/cpp/BoostParts || die "Failed to remove bundled boost"

	rm -r "${S}"/third_party/cregex/regex_2 || die "Failed to remove third party module cregex_2"
	rm -r "${S}"/third_party/watchdog_deps || die "Failed to remove third party module watchdog_deps"

	sed -i 's/APPEND Boost_COMPONENTS python3/APPEND Boost_COMPONENTS python/g' "${S}"/cpp/ycm/CMakeLists.txt

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_CLANG_COMPLETER="$(usex clang)"
		-DUSE_SYSTEM_LIBCLANG="$(usex clang)"
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_GMOCK=ON
		-DUSE_PYTHON2=OFF
	)
	cmake_src_configure
}

src_test() {
	cd "${S}/cpp/ycm/tests" || die
	LD_LIBRARY_PATH="${EROOT}"/usr/$(get_libdir)/llvm \
		./ycm_core_tests || die
}

src_install() {
	dodoc *.md *.md
	rm -r *.md *.sh COPYING.txt cpp || die
	if use rust; then
		rm -r third_party/racerd/target/release/build/ || die
		rm -r third_party/racerd/target/release/deps/ || die
		rm -r third_party/racerd/target/release/.fingerprint/ || die
	fi
	egit_clean
	rm third_party/clang/lib/libclang.so* || die
	rm -r ycmd/tests || die

	python_domodule ycmd
}
