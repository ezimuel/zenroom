--TEST--
Check if zenroom is loaded
--SKIPIF--
<?php
if (!extension_loaded('zenroom')) {
	echo 'skip';
}
?>
--FILE--
<?php
echo 'The extension "zenroom" is available';
?>
--EXPECT--
The extension "zenroom" is available
