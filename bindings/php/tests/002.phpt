--TEST--
zencode_exec() public and private keys generation test
--SKIPIF--
<?php
if (!extension_loaded('zenroom')) {
	echo 'skip';
}
?>
--FILE--
<?php
$script = <<<'EOD'
"Scenario coconut petition
rule check version 1.0
Given that I am known as 'identifier'
When I create the credential keypair
Then print all data
"
EOD;

$result = zencode_exec($script);
$json = json_decode($result);
if (isset($json['public']) && !empty($json['public'])) {
	echo "Public key generated\n";
}
if (isset($json['private']) && !empty($json['private'])) {
	echo "Private key generated\n";
}
?>
--EXPECT--
Public key generated
Private key generated
