<?php

/**
 * SMS API para PHP
 * Versión 2.0
 * Abril 2008
 * Aurotek
 *
 * Instrucciones:
 * - Este archivo debe colocarse en una ruta dentro del servidor que esté incluida en el INCLUDE_PATH de PHP.
 * - Este archivo no debe ser modificado o editado sin autorización previa de Aurotek.
 */

class CalixtaAPI{
	private static  function getHashCode($x){
		if (gettype($x)=='object' || gettype($x)=='array')
			return sha1(serialize($x));
		else
			return sha1($x);
	}
	private  static function genLock($seed){
		$lockString=self::getHashCode($seed);
		$pos=strlen($lockString)%2?(strlen($lockString)+1)/2:strlen($lockString)/2;
		$lockString=substr($lockString,$pos,strlen($lockString)).substr($lockString,0,$pos);
		return $lockString;
	}

	private static function _enviaMensajeCSV($csv,$msg,$mtipo,$fechaInicio=null){

		require_once("SMS_CONFIG.php");
		if (!checkValidSession()) return -1;
		$retVal=0;

		if ($csv && $msg){
				$clienteId=CLIENTE;
				$encpwd=PASSWORD;
				$email=USER;
				$id=rand(1,99999999);
				$key=self::getHashCode($id);
				//$seed=$ip.$id.$key.$clienteId;
				$seed=$id.$key.$clienteId;
				$lock=self::genLock($seed);

                $boundary="---------------------------7d81282c144055e";

                //$req = "msg=$msg&numtel=$num&cte=$clienteId&id=$id&lock=$lock&encpwd=$encpwd&email=$email&mtipo=$mtipo";

				$req = "--$boundary\r\n";
				$req.= "Content-Disposition: form-data; name=\"encpwd\"\r\n\r\n$encpwd\r\n";
				$req.= "--$boundary\r\n";
				$req.= "Content-Disposition: form-data; name=\"email\"\r\n\r\n$email\r\n";
				$req.= "--$boundary\r\n";
				$req.= "Content-Disposition: form-data; name=\"mensaje\"\r\n\r\n$msg\r\n";
				$req.= "--$boundary\r\n";
				$req.= "Content-Disposition: form-data; name=\"cte\"\r\n\r\n$clienteId\r\n";
				$req.= "--$boundary\r\n";
				$req.= "Content-Disposition: form-data; name=\"id\"\r\n\r\n$id\r\n";
				$req.= "--$boundary\r\n";
				$req.= "Content-Disposition: form-data; name=\"lock\"\r\n\r\n$lock\r\n";
				$req.= "--$boundary\r\n";
				$req.= "Content-Disposition: form-data; name=\"mtipo\"\r\n\r\n$mtipo\r\n";
				$req.= "--$boundary\r\n";
				if ($fechaInicio){
				    $req.= "Content-Disposition: form-data; name=\"fechaInicio\"\r\n\r\n$fechaInicio\r\n";
    				$req.= "--$boundary\r\n";
				}
				$req.= "Content-Disposition: form-data; name=\"tipoDestino\"\r\n\r\n2\r\n";
				$req.= "--$boundary\r\n";
				$req.= "Content-Disposition: form-data; name=\"archivo\"; filename=\"c:\PHP_CSV.csv\"\r\n";
                $req.= "Content-Type: text/plain\r\n\r\n";
                $req.= $csv."\r\n";
				$req.= "--$boundary--\r\n";

				//Abre la conexión.
				$header="";

                $header .= "POST /Controller.php/__a/sms.extsend.remote.sa HTTP/1.1\r\n"; //ok
				$header .= "Content-Type: multipart/form-data; boundary=$boundary\r\n"; //ok
				$header .= "User-Agent: RemoteSMS_PHP 1.1\r\n"; //ok
				$header .= "Host: ".HOST."\r\n";

				$header .= "Content-Length: " . strlen($req) . "\r\n\r\n"; //Falta contemplar el CSV

				$fp = @fsockopen (HOST,PORT, $errno, $errstr,TIMEOUT);

				if (!$fp) {
					//No se pudo establecer la comunicacion.
					$retVal= -2;
				} else {
					fputs ($fp, $header . $req);
					$res = '';
					$headerdone = false;
					while (!feof($fp)) {
						$line = fgets ($fp, 1024);
						if (strcmp($line, "\r\n") == 0) {
							$headerdone = true;
						}else if ($headerdone){
							$res .= $line;
						}
					}
					//echo $res;
					$res=urldecode($res);
					if (strpos($res,'OK')===FALSE){
						//Ocurrio un error al procesarlo.
						$retVal= -3;
					}else{
					    $retVal=substr($res,3);
					}
					//Aqui el mensaje fue enviado.
				}
				fclose ($fp);
		}else{
			//Error de parametros.
			return -4;
		}
		return $retVal;
	}

	/**
	 * Devuelve el estado de un grupo de envíos.
	 *
	 * @param string $idEnvios Cadena con los identificadores de envíos separados por comas.
	 * @return unknown Devuelve un arreglo con los saldos, o un entero negativo en caso de error.
	 */
	public static function estadoEnvios($idEnvios){
		require_once("SMS_CONFIG.php");
		if (!checkValidSession()) return -1;
		$retVal=0;

		if ($idEnvios){
				$clienteId=CLIENTE;
				$encpwd=PASSWORD;
				$email=USER;
				$id=rand(1,99999999);
				$key=self::getHashCode($id);
				$seed=$id.$key.$clienteId;
				$lock=self::genLock($seed);

				$clienteId=urlencode($clienteId);
				$id=urlencode($id);
				$lock=urlencode($lock);

				$req = "idenvios=$idEnvios&cte=$clienteId&id=$id&lock=$lock&encpwd=$encpwd&email=$email";
				//Abre la conexión.
				$header="";
				$header .= "POST /Controller.php/__a/sms.remote.campanas.sa HTTP/1.1\r\n";
				$header .= "Content-Type: application/x-www-form-urlencoded\r\n";
				$header .= "User-Agent: RemoteSMS_PHP 1.1\r\n";
				$header .= "Host: ".HOST."\r\n";

				$header .= "Content-Length: " . strlen($req) . "\r\n\r\n";

				$fp = @fsockopen (HOST,PORT, $errno, $errstr,TIMEOUT);

				if (!$fp) {
					//No se pudo establecer la comunicacion.
					$retVal= -2;
				} else {
					fputs ($fp, $header . $req);
					$res = '';
					$headerdone = false;
					while (!feof($fp)) {
						$line = fgets ($fp, 1024);
						if (strcmp($line, "\r\n") == 0) {
							$headerdone = true;
						}else if ($headerdone){
							$res .= $line;
						}
					}
					$res=urldecode($res);
					if (strpos($res,'OK')===FALSE){
						//Ocurrio un error al procesarlo.
						$retVal= -3;
					}else{
					    $retVal=substr($res,5);
					}
					//Aqui el mensaje fue enviado.
				}
				fclose ($fp);
		}else{
			//Error de parametros.
			return -4;
		}
		return $retVal;
	}

	public static function detalleEnvio($idEnvio){
		require_once("SMS_CONFIG.php");
		if (!checkValidSession()) return -1;
		$retVal=0;

		if ($idEnvio){
				$clienteId=CLIENTE;
				$encpwd=PASSWORD;
				$email=USER;
				$id=rand(1,99999999);
				$key=self::getHashCode($id);
				$seed=$id.$key.$clienteId;
				$lock=self::genLock($seed);

				$clienteId=urlencode($clienteId);
				$id=urlencode($id);
				$lock=urlencode($lock);

				$req = "filtro_idCampana=$idEnvio&cte=$clienteId&id=$id&lock=$lock&encpwd=$encpwd&email=$email";
				//Abre la conexión.
				$header="";
				$header .= "POST /Controller.php/__a/sms.remote.logs.sa HTTP/1.1\r\n";
				$header .= "Content-Type: application/x-www-form-urlencoded\r\n";
				$header .= "User-Agent: RemoteSMS_PHP 1.1\r\n";
				$header .= "Host: ".HOST."\r\n";

				$header .= "Content-Length: " . strlen($req) . "\r\n\r\n";

				$fp = @fsockopen (HOST,PORT, $errno, $errstr,TIMEOUT);

				if (!$fp) {
					//No se pudo establecer la comunicacion.
					$retVal= -2;
				} else {
					fputs ($fp, $header . $req);
					$res = '';
					$headerdone = false;
					while (!feof($fp)) {
						$line = fgets ($fp, 1024);
						if (strcmp($line, "\r\n") == 0) {
							$headerdone = true;
						}else if ($headerdone){
							$res .= $line;
						}
					}
					$res=urldecode($res);
					$retVal=$res;
					//Aqui el mensaje fue enviado.
				}
				fclose ($fp);
		}else{
			//Error de parametros.
			return -4;
		}
		return $retVal;
	}



	public static function getSaldos(){
		require_once("SMS_CONFIG.php");
		if (!checkValidSession()) return -1;
		$retVal=0;

		$clienteId=CLIENTE;
		$encpwd=PASSWORD;
		$email=USER;
		$id=rand(1,99999999);
		$key=self::getHashCode($id);
		$seed=$id.$key.$clienteId;
		$lock=self::genLock($seed);

		$clienteId=urlencode($clienteId);
		$id=urlencode($id);
		$lock=urlencode($lock);

		$req = "cte=$clienteId&id=$id&lock=$lock&encpwd=$encpwd&email=$email";
		//Abre la conexión.
		$header="";
		$header .= "POST /Controller.php/__a/sms.remote.getsaldo.sa HTTP/1.1\r\n";
		$header .= "Content-Type: application/x-www-form-urlencoded\r\n";
		$header .= "User-Agent: RemoteSMS_PHP 1.1\r\n";
		$header .= "Host: ".HOST."\r\n";

		$header .= "Content-Length: " . strlen($req) . "\r\n\r\n";

		$fp = @fsockopen (HOST,PORT, $errno, $errstr,TIMEOUT);

		if (!$fp) {
			//No se pudo establecer la comunicacion.
			$retVal= -2;
		} else {
			fputs ($fp, $header . $req);
			$res = '';
			$headerdone = false;
			while (!feof($fp)) {
				$line = fgets ($fp, 1024);
				if (strcmp($line, "\r\n") == 0) {
					$headerdone = true;
				}else if ($headerdone){
					$res .= $line;
				}
			}

			$res=urldecode($res);
			if (strpos($res,'OK')===FALSE){
				//Ocurrio un error al procesarlo.
				$retVal= -3;
			}else{
			    $retVal=substr($res,5);
			    str_ireplace("\r","",$retVal);
			    $strSaldos=explode("\n",$retVal);
			    $saldos=array();
			    foreach ($strSaldos as $strSaldo){
			        $saldoParts=explode(",",$strSaldo);
			        if (count($saldoParts)>=3){ //renglón válido
			            if ($saldoParts[0]=="0"){ //Es dinero
                            $dinero=(double)$saldoParts[1]+(double)$saldoParts[2];
                            if ($dinero>0){
                                $saldos[0]=$dinero;
                            }
			            }else{
			                $monto=(double)$saldoParts[1];
			                if ($monto>0){
			                    $saldos[(int)$saldoParts[0]]=$monto;
			                }
			            }
			        }
			    }
			    $retVal=$saldos;

			}
			//Aqui el mensaje fue enviado.
		}
		fclose ($fp);
		return $retVal;
	}

	private static function _enviaMensaje($dest,$msg,$mtipo,$fechaInicio=null){
		require_once("SMS_CONFIG.php");
		if (!checkValidSession()) return -1;
		$retVal=0;

		if ($dest && $msg){
				$num=$dest;
				//$ip=$_SERVER["SERVER_ADDR"];
				$clienteId=CLIENTE;
				$encpwd=PASSWORD;
				$email=USER;
				$id=rand(1,99999999);
				$key=self::getHashCode($id);
				//$seed=$ip.$id.$key.$clienteId;
				$seed=$id.$key.$clienteId;
				$lock=self::genLock($seed);

				$msg=urlencode($msg);
				$num=urlencode($num);
				$clienteId=urlencode($clienteId);
				$id=urlencode($id);
				$lock=urlencode($lock);

				$req = "msg=$msg&numtel=$num&cte=$clienteId&id=$id&lock=$lock&encpwd=$encpwd&email=$email&mtipo=$mtipo";
				if ($fechaInicio){
				    $req.="&fechaInicio=$fechaInicio";
				}
				//Abre la conexión.
				$header="";
				$header .= "POST /Controller.php/__a/sms.send.remote.portal HTTP/1.1\r\n";
				$header .= "Content-Type: application/x-www-form-urlencoded\r\n";
				$header .= "User-Agent: RemoteSMS_PHP 1.1\r\n";
				$header .= "Host: ".HOST."\r\n";

				$header .= "Content-Length: " . strlen($req) . "\r\n\r\n";

				$fp = @fsockopen (HOST,PORT, $errno, $errstr,TIMEOUT);

				if (!$fp) {
					//No se pudo establecer la comunicacion.
					$retVal= -2;
				} else {
					fputs ($fp, $header . $req);
					$res = '';
					$headerdone = false;
					while (!feof($fp)) {
						$line = fgets ($fp, 1024);
						if (strcmp($line, "\r\n") == 0) {
							$headerdone = true;
						}else if ($headerdone){
							$res .= $line;
						}
					}

					$res=urldecode($res);
					if (strpos($res,'OK')===FALSE){
						//Ocurrio un error al procesarlo.
						$retVal= -3;
					}
					//Aqui el mensaje fue enviado.
				}
				fclose ($fp);
		}else{
			//Error de parametros.
			return -4;
		}
		return $retVal;
	}

	/**
	 * Metodo para enviar mensajes de texto a traves del gateway utilizando una cadena CSV.
	 *
	 * @param unknown_type $csv
	 * @param string $csv Registros separada por comas.
	 * @param string $msg Mensaje a enviar.
	 * @param string $fechaInicio Fecha y hora en la que iniciará el envío. Formato: "dia/mes/año(4 digitos)/hora(24hrs)/minuto"
	 * @return integer Devuelve el ticket en caso satisfactorio, y un númnero menor que cero en caso de error.
	 */
	public static function enviaMensajeCSV($csv,$msg,$fechaInicio=null){
		return self::_enviaMensajeCSV($csv,$msg,'SMS',$fechaInicio);
	}


	/**
	 * Metodo para enviar mensajes de texto a traves del gateway.
	 *
	 * @param string $dest Numeros de celular de los destinatarios, a 10 digitos y separados por comas.
	 * @param string $msg Mensaje a enviar.
	 * @param string $fechaInicio Fecha y hora en la que iniciará el envío. Formato: "dia/mes/año(4 digitos)/hora(24hrs)/minuto"
	 * @return integer Devuelve 0 (cero) en caso satisfactorio, y devuelve cualquier otra cosa en caso de error.
	 */
	public static function enviaMensaje($dest,$msg,$fechaInicio=null){
		return self::_enviaMensaje($dest,$msg,'SMS',$fechaInicio);
	}

	/**
	 * Metodo para enviar mensajes de voz a traves del gateway.
	 *
	 * @param string $dest Numeros telefonicos de los destinatarios, a 10 digitos y separados por comas.
	 * @param string $msg Mensaje a enviar.
	 * @param string $fechaInicio Fecha y hora en la que iniciará el envío. Formato: "dia/mes/año(4 digitos)/hora(24hrs)/minuto"
	 * @return integer Devuelve 0 (cero) en caso satisfactorio, y devuelve cualquier otra cosa en caso de error.
	 */
	public static function enviaMensajeVoz($dest,$msg,$fechaInicio=null){
		$msg='<texto voz="Carlos">'.$msg.'</texto>';
		return self::_enviaMensaje($dest,$msg,'VOZ',$fechaInicio);
	}

	/**
	 * Metodo para enviar mensajes de voz a traves del gateway. Construyendo el XML directamente.
	 *
	 * @param string $dest Numeros telefonicos de los destinatarios, a 10 digitos y separados por comas.
	 * @param string $msg XML del mensaje a enviar.
	 * @param string $fechaInicio Fecha y hora en la que iniciará el envío. Formato: "dia/mes/año(4 digitos)/hora(24hrs)/minuto"
	 * @return integer Devuelve 0 (cero) en caso satisfactorio, y devuelve cualquier otra cosa en caso de error.
	 */
	public static function enviaMensajeXmlVoz($dest,$msg,$fechaInicio=null){
		return self::_enviaMensaje($dest,$msg,'VOZ',$fechaInicio);
	}

}
?>