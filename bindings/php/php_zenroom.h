/* zenroom extension for PHP */

#ifndef PHP_ZENROOM_H
# define PHP_ZENROOM_H

extern zend_module_entry zenroom_module_entry;
# define phpext_zenroom_ptr &zenroom_module_entry

# define PHP_ZENROOM_VERSION "0.1.0"

# if defined(ZTS) && defined(COMPILE_DL_ZENROOM)
ZEND_TSRMLS_CACHE_EXTERN()
# endif

#endif	/* PHP_ZENROOM_H */
