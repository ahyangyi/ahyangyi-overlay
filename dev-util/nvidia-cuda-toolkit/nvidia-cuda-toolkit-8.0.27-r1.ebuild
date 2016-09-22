EAPI=6

inherit check-reqs cuda unpacker versionator

MYD=$(get_version_component_range 1-2)

DESCRIPTION="NVIDIA CUDA Toolkit (compiler and friends)"
HOMEPAGE="https://developer.nvidia.com/cuda-downloads"
CURI="https://developer.nvidia.com/cuda-release-candidate-download"
SRC_URI="cuda_${PV}_linux.run
cuda_${PV}.1_linux.run"

SLOT="0/${PV}"
LICENSE="NVIDIA-CUDA"
KEYWORDS="-* ~amd64 ~amd64-linux"
IUSE="debugger doc eclipse profiler"

DEPEND=""
RDEPEND="${DEPEND}
	>=sys-devel/gcc-4.7[cxx]
	>=x11-drivers/nvidia-drivers-361.42[uvm]
	debugger? (
		sys-libs/libtermcap-compat
		sys-libs/ncurses[tinfo]
		)
	eclipse? ( >=virtual/jre-1.6 )
	profiler? ( >=virtual/jre-1.6 )"
RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please download the Ubuntu 16.04 \"runfile (local)\" installers"
	einfo "  - cuda_${PV}_linux.run"
	einfo "  - cuda_${PV}.1_linux.run"
	einfo "from ${CURI} and place it in ${DISTDIR}"
}

S="${WORKDIR}"

QA_PREBUILT="opt/cuda/*"

CHECKREQS_DISK_BUILD="1500M"

pkg_setup() {
	# We don't like to run cuda_pkg_setup as it depends on us
	check-reqs_pkg_setup
}

src_unpack() {
	unpacker cuda_${PV}_linux.run
	unpacker run_files/cuda-linux*.run
	unpacker cuda_${PV}.1_linux.run
}

src_prepare() {
	local cuda_supported_gcc

	cuda_supported_gcc="4.7 4.8 4.9 5.1 5.2 5.3 5.4"

	sed \
		-e "s:CUDA_SUPPORTED_GCC:${cuda_supported_gcc}:g" \
		"${FILESDIR}"/cuda-config.in > "${T}"/cuda-config || die

	default
}

src_install() {
	local i j
	local remove="doc jre run_files install-linux.pl "
	local cudadir=/opt/cuda
	local ecudadir="${EPREFIX}"${cudadir}

	# dodoc doc/*txt
	if use doc; then
		dodoc doc/pdf/*
		dohtml -r doc/html/*
	fi

	mv payload/cuda-linux64-mixed-rel-nightly/include/host_config.h include/host_config.h

	mv doc/man/man3/{,cuda-}deprecated.3 || die
	doman doc/man/man*/*

	use debugger || remove+=" bin/cuda-gdb extras/Debugger extras/cuda-gdb-${PV}.src.tar.gz"
	( use profiler || use eclipse ) || remove+=" libnsight"
	remove+=" cuda-installer.pl"

	if use profiler; then
		# hack found in install-linux.pl
		for j in nvvp nsight; do
			cat > bin/${j} <<- EOF
				#!${EPREFIX}/bin/sh
				LD_LIBRARY_PATH=\${LD_LIBRARY_PATH}:${ecudadir}/lib:${ecudadir}/lib64 \
					UBUNTU_MENUPROXY=0 LIBOVERLAY_SCROLLBAR=0 \
					${ecudadir}/lib${j}/${j} -vm ${EPREFIX}/usr/bin/java
			EOF
			chmod a+x bin/${j}
		done
	else
		use eclipse || remove+=" libnvvp"
		remove+=" extras/CUPTI"
	fi

	for i in ${remove}; do
	ebegin "Cleaning ${i}..."
		if [[ -e ${i} ]]; then
			find ${i} -delete || die
			eend
		else
			eend $1
		fi
	done

	ln -sf lib lib32 || die

	dodir ${cudadir}
	mv * "${ED}"${cudadir} || die

	cat > "${T}"/99cuda <<- EOF
		PATH=${ecudadir}/bin$(use profiler && echo ":${ecudadir}/libnvvp")
		ROOTPATH=${ecudadir}/bin
		LDPATH=${ecudadir}/lib64:${ecudadir}/lib:${ecudadir}/nvvm/lib64
	EOF
	doenvd "${T}"/99cuda

	use profiler && \
		make_wrapper nvprof "${EPREFIX}"${cudadir}/bin/nvprof "." ${ecudadir}/lib64:${ecudadir}/lib

	dobin "${T}"/cuda-config
}

pkg_postinst_check() {
	local a b
	a="$(version_sort $(cuda-config -s))"; a=( $a )
	# greatest supported version
	b=${a[${#a[@]}-1]}

	# if gcc and if not gcc-version is at least greatesst supported
	if [[ $(tc-getCC) == *gcc* ]] && \
		! version_is_at_least $(gcc-version) ${b}; then
			echo
			ewarn "gcc >= ${b} will not work with CUDA"
			ewarn "Make sure you set an earlier version of gcc with gcc-config"
			ewarn "or append --compiler-bindir= pointing to a gcc bindir like"
			ewarn "--compiler-bindir=${EPREFIX}/usr/*pc-linux-gnu/gcc-bin/gcc${b}"
			ewarn "to the nvcc compiler flags"
			echo
	fi
}

pkg_postinst() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		pkg_postinst_check
	fi
}
