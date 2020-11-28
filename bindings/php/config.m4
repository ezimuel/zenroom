PHP_ARG_ENABLE([zenroom],
  [whether to enable zenroom support],
  [AS_HELP_STRING([--enable-zenroom],
    [Enable zenroom support])],
  [no])

if test "$PHP_ZENROOM" != "no"; then
  dnl Write more examples of tests here...

  dnl Remove this code block if the library does not support pkg-config.
  dnl PKG_CHECK_MODULES([LIBFOO], [zenroom])
  dnl PHP_EVAL_INCLINE($LIBFOO_CFLAGS)
  dnl PHP_EVAL_LIBLINE($LIBFOO_LIBS, ZENROOM_SHARED_LIBADD)

  dnl If you need to check for a particular library version using PKG_CHECK_MODULES,
  dnl you can use comparison operators. For example:
  dnl PKG_CHECK_MODULES([LIBFOO], [foo >= 1.2.3])
  dnl PKG_CHECK_MODULES([LIBFOO], [foo < 3.4])
  dnl PKG_CHECK_MODULES([LIBFOO], [foo = 1.2.3])

  dnl Remove this code block if the library supports pkg-config.
  dnl --with-zenroom -> check with-path
  dnl SEARCH_PATH="../../"
  dnl SEARCH_FOR="src/zenroom.h"
  dnl if test -r $PHP_ZENROOM/$SEARCH_FOR; then # path given as parameter
  dnl  ZENROOM_DIR=$PHP_ZENROOM
  dnl else # search default path list
  dnl  AC_MSG_CHECKING([for zenroom files in default path])
  dnl  for i in $SEARCH_PATH ; do
  dnl    if test -r $i/$SEARCH_FOR; then
  dnl      ZENROOM_DIR=$i
  dnl      AC_MSG_RESULT(found in $i)
  dnl    fi
  dnl  done
  dnl fi
  
  dnl if test -z "$ZENROOM_DIR"; then
  dnl  AC_MSG_RESULT([not found])
  dnl  AC_MSG_ERROR([Please reinstall the zenroom distribution])
  dnl fi

  dnl Remove this code block if the library supports pkg-config.
  dnl --with-zenroom -> add include path
  dnl PHP_ADD_INCLUDE($ZENROOM_DIR)

  dnl Remove this code block if the library supports pkg-config.
  dnl --with-zenroom -> check for lib and symbol presence
  dnl LIBNAME=zenroom # you may want to change this
  dnl LIBSYMBOL=zencode_exec_tobuf # you most likely want to change this

  dnl If you need to check for a particular library function (e.g. a conditional
  dnl or version-dependent feature) and you are using pkg-config:
  dnl PHP_CHECK_LIBRARY($LIBNAME, $LIBSYMBOL,
  dnl [
  dnl   AC_DEFINE(HAVE_ZENROOM_FEATURE, 1, [ ])
  dnl ],[
  dnl   AC_MSG_ERROR([FEATURE not supported by your zenroom library.])
  dnl ], [
  dnl   $LIBFOO_LIBS
  dnl ])

  dnl If you need to check for a particular library function (e.g. a conditional
  dnl or version-dependent feature) and you are not using pkg-config:
  dnl PHP_CHECK_LIBRARY($LIBNAME, $LIBSYMBOL,
  dnl [
  dnl  PHP_ADD_LIBRARY_WITH_PATH($LIBNAME, $ZENROOM_DIR/$PHP_LIBDIR, ZENROOM_SHARED_LIBADD)
  dnl  AC_DEFINE(HAVE_ZENROOM_FEATURE, 1, [ ])
  dnl ],[
  dnl  AC_MSG_ERROR([FEATURE not supported by your zenroom library.])
  dnl ],[
  dnl -L$ZENROOM_DIR/$PHP_LIBDIR -lm
  dnl ])
  
  dnl PHP_SUBST(ZENROOM_SHARED_LIBADD)

  ZENROOM_DIR="../.."
  PHP_ADD_INCLUDE($ZENROOM_DIR/src)
  PHP_ADD_INCLUDE($ZENROOM_DIR/lib/lua53/src)
  PHP_ADD_INCLUDE($ZENROOM_DIR/lib/milagro-crypto-c/include)

  dnl In case of no dependencies
  AC_DEFINE(HAVE_ZENROOM, 1, [ Have zenroom support ])

  PHP_NEW_EXTENSION(zenroom, zenroom.c, $ext_shared)
fi
