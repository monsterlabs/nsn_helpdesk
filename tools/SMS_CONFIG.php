<?php
// - Este archivo es su licencia para acceder al servicio remoto de env�o de SMS, queda bajo su responsabilidad el uso que le de al mismo y queda estrictamente prohibida su distribuci�n y/o comercializaci�n.
//Estos son los par�metros de configuraci�n, y deber�n ser establecidos conforme las instrucciones del personal t�cnico de Auronix.

define('HOST','www.enviasms.com.mx');
define('PORT',80);
define('TIMEOUT',40);
define('CLIENTE',10265);
define('PASSWORD','02c33b7a46ebab258c2ae13abc0985049f40884d4ebd60340a5b6f02bd330be8');
define('USER','jlmendez@yahoo.com');

function checkValidSession(){
	//Esta funci�n debe devolver TRUE cuando la sesi�n actual es v�lida para env�o de SMS, y FALSE en cuanquier otro caso.
	return true;
}
?>
