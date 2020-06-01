EAPI=7

PYTHON_COMPAT=( python{2_{6,7},3_{4,5,6,7,8}} )

inherit eutils multilib python-single-r1 cmake-utils vim-plugin git-r3 vcs-clean

EGIT_REPO_URI="https://github.com/Valloric/YouCompleteMe.git"
DESCRIPTION="vim plugin: a code-completion engine for Vim"
HOMEPAGE="https://valloric.github.io/YouCompleteMe/"
EGIT_SUBMODULES=(
	'*'
	'-third_party/OmniSharpServer'
	'-third_party/argparse'
	'-third_party/bottle'
	'-third_party/waitress'
	'-third_party/requests'
	'-third_party/gocode'
	'-third_party/godef'
	'-third_party/python-future'
	'-vendor/waitress'
	'-vendor/jedi'
	'-vendor/bottle'
	'-vendor/argparse'
	)

LICENSE="GPL-3"
IUSE="+clang doc test rust"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="
	${PYTHON_DEPS}
	clang? ( >=sys-devel/clang-3.3 )
	$(python_gen_cond_dep 'dev-libs/boost[python,threads,${PYTHON_USEDEP}]')
	|| (
		app-editors/vim[python,${PYTHON_SINGLE_USEDEP}]
		app-editors/gvim[python,${PYTHON_SINGLE_USEDEP}]
	)
"
RDEPEND="
	${COMMON_DEPEND}
	$(python_gen_cond_dep 'dev-python/bottle[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'virtual/python-futures[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/future[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/sh[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/waitress[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/watchdog[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/requests[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/jedi[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/futures[${PYTHON_USEDEP}]' -2)
"
DEPEND="
	${COMMON_DEPEND}
	rust? (
		|| ( dev-lang/rust dev-lang/rust-bin )
		|| ( dev-util/cargo dev-util/cargo-bin )
	)
	test? (
		$(python_gen_cond_dep '>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]')
		$(python_gen_cond_dep '>=dev-python/nose-1.3.0[${PYTHON_USEDEP}]')
		dev-cpp/gmock
		dev-cpp/gtest
	)
"

CMAKE_IN_SOURCE_BUILD=1
CMAKE_USE_DIR=${S}/third_party/ycmd/cpp

VIM_PLUGIN_HELPFILES="${PN}"

src_unpack() {
	use rust || EGIT_SUBMODULES+=('-third_party/racerd')
	git-r3_src_unpack
}

src_prepare() {
	if ! use test ; then
		sed -i '/^add_subdirectory( tests )/d' third_party/ycmd/cpp/ycm/CMakeLists.txt || die
	fi

	sed -i '/^#! python3.7/d' third_party/ycmd/third_party/cregex/tools/build_regex_unicode.py || die

	# Argparse is included in python 2.7 / 3
	for third_party_module in bottle waitress; do
		rm -r "${S}"/third_party/ycmd/third_party/${third_party_module} || die "Failed to remove third party module ${third_party_module}"
	done
	for third_party_module in jedi parso numpydoc; do
		rm -r "${S}"/third_party/ycmd/third_party/jedi_deps/${third_party_module} || die "Failed to remove third party module ${third_party_module}"
	done
	for third_party_module in requests idna certifi chardet urllib3; do
		rm -r "${S}"/third_party/requests_deps/${third_party_module} || die "Failed to remove third party module ${third_party_module}"
		rm -r "${S}"/third_party/ycmd/third_party/requests_deps/${third_party_module} || die "Failed to remove third party module ${third_party_module}"
	done
	rm -r "${S}"/third_party/ycmd/cpp/BoostParts || die "Failed to remove bundled boost"

	if [ $(echo ${EPYTHON} | grep python2 > /dev/null) ]
	then
		rm -r "${S}"/third_party/ycmd/third_party/cregex/regex_3 || die "Failed to remove third party module cregex_3"
	else
		rm -r "${S}"/third_party/ycmd/third_party/cregex/regex_2 || die "Failed to remove third party module cregex_2"
		rm -r "${S}"/third_party/ycmd/third_party/watchdog_deps || die "Failed to remove third party module watchdog_deps"
	fi

	# boost::python is installed as is on Gentoo for both python2 & python3; hence we modify their CMakeLists accordingly
	sed -i 's/APPEND Boost_COMPONENTS python3/APPEND Boost_COMPONENTS python/g' "${S}"/third_party/ycmd/cpp/ycm/CMakeLists.txt

	cmake-utils_src_prepare

	eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DUSE_CLANG_COMPLETER="$(usex clang)"
		-DUSE_SYSTEM_LIBCLANG="$(usex clang)"
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_GMOCK=ON
	)
	if [ $(echo ${EPYTHON} | grep python2 > /dev/null) ]
	then
		mycmakeargs+=( -DUSE_PYTHON2=ON )
	else
		mycmakeargs+=( -DUSE_PYTHON2=OFF )
	fi
	cmake-utils_src_configure
}

src_test() {
	cd "${S}/third_party/ycmd/cpp/ycm/tests"
	LD_LIBRARY_PATH="${EROOT}"/usr/$(get_libdir)/llvm \
		./ycm_core_tests || die

	cd "${S}"/python/ycm

	local dirs=( "${S}"/third_party/*/ "${S}"/third_party/ycmd/third_party/*/ )
	local -x PYTHONPATH=${PYTHONPATH}:$(IFS=:; echo "${dirs[*]}")

	nosetests --verbose || die
}

src_install() {
	dodoc *.md third_party/ycmd/*.md
	rm -r *.md *.sh COPYING.txt third_party/ycmd/cpp || die
	rm -r third_party/ycmd/{*.md,*.sh,examples} || die
	if use rust; then
		rm -r third_party/ycmd/third_party/racerd/target/release/build/ || die
		rm -r third_party/ycmd/third_party/racerd/target/release/deps/ || die
		rm -r third_party/ycmd/third_party/racerd/target/release/.fingerprint/ || die
	fi
	find python third_party/ycmd -name '*test*' -exec rm -rf {} + || die
	find python third_party/ycmd -name '*doc*' -exec rm -rf {} + || die
	egit_clean
	rm third_party/ycmd/third_party/clang/lib/libclang.so* || die

	vim-plugin_src_install

	if use rust; then
		einfo "Fix permissions for racerd"
		chmod a+x "${ED}"/usr/share/vim/vimfiles/third_party/ycmd/third_party/racerd/target/release/racerd
	fi

	python_optimize "${ED}"
	python_fix_shebang "${ED}"
}
