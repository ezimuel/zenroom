/* zenroom extension for PHP */

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif

#include "php.h"
#include "ext/standard/info.h"
#include "zend_exceptions.h"
#include "ext/spl/spl_exceptions.h"
#include "php_zenroom.h"
#include "zenroom.h"

/* For compatibility with older PHP versions */
#ifndef ZEND_PARSE_PARAMETERS_NONE
#define ZEND_PARSE_PARAMETERS_NONE() \
	ZEND_PARSE_PARAMETERS_START(0, 0) \
	ZEND_PARSE_PARAMETERS_END()
#endif

zend_class_entry *zenroom_exception_ce;

/* {{{ string zencode_exec( string $script [, string $conf [, string $keys [, string $data ]]] ) */
PHP_FUNCTION(zencode_exec)
{
	char *script;
	size_t script_len;
	char *conf;
	size_t conf_len;
	char *keys;
	size_t keys_len;
	char *data;
	size_t data_len;
	zend_string *retval;
	
	char *stdout_buf;
	size_t stdout_len;
	char *stderr_buf;
	size_t stderr_len;
	int result;

	ZEND_PARSE_PARAMETERS_START(1, 4)
		Z_PARAM_STRING(script, script_len)
		Z_PARAM_OPTIONAL
		Z_PARAM_STRING(conf, conf_len)
		Z_PARAM_STRING(keys, keys_len)
		Z_PARAM_STRING(data, data_len)
	ZEND_PARSE_PARAMETERS_END();

	result = zencode_exec_tobuf(script, conf, keys, data, stdout_buf, stdout_len, stderr_buf, stderr_len);

	if (result == EXIT_FAILURE) {
		zend_throw_exception(zenroom_exception_ce, stderr_buf, 0);
	}
	retval = zend_string_init(stdout_buf, stdout_len, 0);

	RETURN_STR(retval);
}
/* }}} */

/* {{{ string zenroom_exec( string $script [, string $conf [, string $keys [, string $data ]]] ) */
PHP_FUNCTION(zenroom_exec)
{
	char *script;
	size_t script_len;
	char *conf;
	size_t conf_len;
	char *keys;
	size_t keys_len;
	char *data;
	size_t data_len;
	zend_string *retval;
	
	char *stdout_buf;
	size_t stdout_len;
	char *stderr_buf;
	size_t stderr_len;
	int result;

	ZEND_PARSE_PARAMETERS_START(1, 4)
		Z_PARAM_STRING(script, script_len)
		Z_PARAM_OPTIONAL
		Z_PARAM_STRING(conf, conf_len)
		Z_PARAM_STRING(keys, keys_len)
		Z_PARAM_STRING(data, data_len)
	ZEND_PARSE_PARAMETERS_END();

	result = zenroom_exec_tobuf(script, conf, keys, data, stdout_buf, stdout_len, stderr_buf, stderr_len);

	if (result == EXIT_FAILURE) {
		zend_throw_exception(zenroom_exception_ce, stderr_buf, 0);
	}
	retval = zend_string_init(stdout_buf, stdout_len, 0);

	RETURN_STR(retval);
}
/* }}}*/

/* {{{ PHP_RINIT_FUNCTION
 */
PHP_RINIT_FUNCTION(zenroom)
{
#if defined(ZTS) && defined(COMPILE_DL_ZENROOM)
	ZEND_TSRMLS_CACHE_UPDATE();
#endif

	return SUCCESS;
}
/* }}} */

/* {{{ PHP_MINFO_FUNCTION
 */
PHP_MINFO_FUNCTION(zenroom)
{
	php_info_print_table_start();
	php_info_print_table_header(2, "zenroom support", "enabled");
	php_info_print_table_end();
}
/* }}} */

/* {{{ PHP_MINIT_FUNCTION
 */
PHP_MINIT_FUNCTION(zenroom)
{
    zend_class_entry tmp_ce;

    INIT_CLASS_ENTRY(tmp_ce, "ZenroomException", NULL);
    zenroom_exception_ce = zend_register_internal_class_ex(&tmp_ce, zend_ce_exception);

    return SUCCESS;
}
/* }}} */

/* {{{ arginfo
 */
ZEND_BEGIN_ARG_INFO(arginfo_zencode_exec, 0)
	ZEND_ARG_INFO(0, str)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_INFO(arginfo_zenroom_exec, 0)
	ZEND_ARG_INFO(0, str)
ZEND_END_ARG_INFO()
/* }}} */

/* {{{ zenroom_functions[]
 */
static const zend_function_entry zenroom_functions[] = {
	PHP_FE(zencode_exec,		arginfo_zencode_exec)
	PHP_FE(zenroom_exec,		arginfo_zenroom_exec)
	PHP_FE_END
};
/* }}} */

/* {{{ zenroom_module_entry
 */
zend_module_entry zenroom_module_entry = {
	STANDARD_MODULE_HEADER,
	"zenroom",					/* Extension name */
	zenroom_functions,			/* zend_function_entry */
	PHP_MINIT(zenroom),			/* PHP_MINIT - Module initialization */
	NULL,						/* PHP_MSHUTDOWN - Module shutdown */
	PHP_RINIT(zenroom),			/* PHP_RINIT - Request initialization */
	NULL,						/* PHP_RSHUTDOWN - Request shutdown */
	PHP_MINFO(zenroom),			/* PHP_MINFO - Module info */
	PHP_ZENROOM_VERSION,		/* Version */
	STANDARD_MODULE_PROPERTIES
};
/* }}} */

#ifdef COMPILE_DL_ZENROOM
# ifdef ZTS
ZEND_TSRMLS_CACHE_DEFINE()
# endif
ZEND_GET_MODULE(zenroom)
#endif
