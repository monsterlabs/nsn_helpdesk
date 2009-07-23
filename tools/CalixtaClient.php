<?php
	require_once("CalixtaAPI.php");
	$calixta = new CalixtaAPI();
	//Mensaje de texto.
	$phone_number = $argv[1];
	$message = $argv[2];
	$ret=$calixta->enviaMensaje($phone_number, $message);
	if ( $ret===0 ){
		echo 't';
	}else{
		echo 'f';
	}
?>