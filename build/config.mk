# included by makefile

pwd := $(shell pwd)
mil := ${pwd}/build/milagro
extras := ${pwd}/docs/demo

# --------
# defaults
gcc := gcc
ar := ar
ranlib := ranlib
cflags_protection := -fstack-protector-all -D_FORTIFY_SOURCE=2 -fno-strict-overflow
cflags := -O2 ${cflags_protection}
musl := ${pwd}/build/musl
platform := posix

# ------------
# lua settings
luasrc := ${pwd}/lib/lua53/src
ldadd := ${pwd}/lib/lua53/src/liblua.a
ldadd += ${pwd}/lib/lpeglabel/lpeglabel.a

# ----------------
# milagro settings
rsa_bits := ""
ecc_curves := ED25519,BLS383,GOLDILOCKS,SECP256K1
milagro_cmake_flags := -DBUILD_SHARED_LIBS=OFF -DBUILD_PYTHON=OFF -DBUILD_DOXYGEN=OFF -DWORD_SIZE=32 -DAMCL_CURVE=${ecc_curves} -DAMCL_RSA=${rsa_bits} -DCMAKE_SHARED_LIBRARY_LINK_FLAGS="" -DC99=1 -DPAIRING_FRIENDLY_BLS383='BLS'
milib := ${pwd}/lib/milagro-crypto-c/lib
ldadd += ${milib}/libamcl_curve_ED25519.a
ldadd += ${milib}/libamcl_curve_BLS383.a
ldadd += ${milib}/libamcl_pairing_BLS383.a
ldadd += ${milib}/libamcl_curve_GOLDILOCKS.a
ldadd += ${milib}/libamcl_curve_SECP256K1.a
ldadd += ${milib}/libamcl_core.a

# ------------------------
# target specific settings

ifneq (,$(findstring win,$(MAKECMDGOALS)))
gcc := x86_64-w64-mingw32-gcc
ar  := x86_64-w64-mingw32-ar
ranlib := x86_64-w64-mingw32-ranlib
cflags := ${cflags_protection} -D'ARCH=\"WIN\"' -DARCH_WIN -O3 -Wall -Wextra -pedantic -std=gnu99
ldflags := -L/usr/x86_64-w64-mingw32/lib
ldadd += ${ldadd} -l:libm.a -l:libpthread.a -lssp
endif


ifneq (,$(findstring musl,$(MAKECMDGOALS)))
gcc := musl-gcc
cflags := -Os -static -Wall -std=gnu99 -fPIC ${cflags_protection} -D'ARCH=\"MUSL\"' -D__MUSL__ -DARCH_MUSL
ldflags := -static
endif

ifneq (,$(findstring linux,$(MAKECMDGOALS)))
cflags := ${cflags} -fPIC ${cflags_protection} -D'ARCH=\"LINUX\"' -DARCH_LINUX
ldflags := -lm -lpthread
endif

ifneq (,$(findstring osx,$(MAKECMDGOALS)))
cflags := ${cflags} -fPIC ${cflags_protection} -D'ARCH=\"OSX\"' -DARCH_OSX
ldflags := -lm
endif

ifneq (,$(findstring js,$(MAKECMDGOALS)))
gcc := ${EMSCRIPTEN}/emcc
ar := ${EMSCRIPTEN}/emar
ldflags := -s "EXPORTED_FUNCTIONS='[\"_zenroom_exec\",\"_zenroom_exec_tobuf\",\"_zenroom_parse_ast\",\"_set_debug\"]'" -s "EXTRA_EXPORTED_RUNTIME_METHODS='[\"ccall\",\"cwrap\"]'" -s USE_SDL=0 -s USE_PTHREADS=0
cflags := -O2 -Wall -I ${EMSCRIPTEN}/system/include/libc -DLIBRARY
ldflags := -lm
endif


# ifneq (,$(findstring ios,$(MAKECMDGOALS)))
# gcc := $(shell xcrun --sdk iphoneos -f gcc 2>/dev/null)
# ar := $(shell xcrun --sdk iphoneos -f ar 2>/dev/null)
# ld := $(shell xcrun --sdk iphoneos -f ld 2>/dev/null)
# ldflags := lm
# ranlib := $(shell xcrun --sdk iphoneos -f ranlib 2>/dev/null)
# SDK := $(shell xcrun --sdk iphoneos --show-sdk-path 2>/dev/null)
# cflags := -O2 -fPIC ${cflags_protection} -D'ARCH=\"OSX\"' -isysroot ${SDK} -arch ${ARCH} -D NO_SYSTEM -DARCH_OSX
# endif
