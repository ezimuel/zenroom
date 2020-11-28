--TEST--
zenroom_exec() print Hello World test
--SKIPIF--
<?php
if (!extension_loaded('zenroom')) {
	echo 'skip';
}
?>
--FILE--
<?php
$script = "print('Hello World')";
$result = zenroom_exec($script);
var_dump($result);
?>
--EXPECT--
string(11) "Hello World"
