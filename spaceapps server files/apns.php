<?php

// Set APNS parameters as constants
define('APNS_HOST', 'gateway.push.apple.com');
define('APNS_DEVEL_HOST', 'gateway.sandbox.push.apple.com');
define('APNS_PORT', 2195);

function send_push_notification(){
//DEVELOPMENT
	$USE_APNS_DEVEL_HOST = true;

//PAYLOAD
	$body = array();
	$body['aps'] = array('alert' =>  'A NEW TRANSIENT DISCOVERED', 'badge' => 1, "sound" => "default");
	$payload = json_encode($body);

//MESSAGE
	$pushTokens = array(''); //ADD YOUR DEVICE PUSH TOKEN HERE
	for ($x=0;$x<count($pushTokens);$x++){
		$token = $pushTokens[$x];
		$tokensProcesados[] = array('token' => $token, 'payload' => $$payload);
		$apns_message .= chr(0) . chr(0) . chr(32) . pack('H*', str_replace(' ', '', $token)) . chr(0) . chr(mb_strlen($payload)) . $payload;
	}

//CERTIFICATE .PEM
	$cert_file = $USE_APNS_DEVEL_HOST?'apns/dev/apns-dev.pem':'apns/prod/apns-prod.pem'; //It is obligatory generate your own .pem
	$cert_password = ''; //ADD YOUR CERT PASSWORD HERE

//CREATE CONNECTION
	$apns_connection = apns_connect($cert_file, $cert_password,$USE_APNS_DEVEL_HOST);
	if (is_array($apns_connection)){
		die(json_encode($apns_connection));
	}
	
//SENDING MESSAGE
	if (apns_send_notification($apns_message, $apns_connection)) {
		$result['message'] = "Message Sent $enviroment";
	}
	else {
		$result['message'] = "Message Failed";
	}
	
//
	apns_close_connection($apns_connection);

	echo json_encode($result);
}

/**
*     Establish a connection to Apple APNS Server
*     Returns the APNS connection or Errors if cannot connect
*/
function apns_connect($cert, $password = null, $devel = false) {
          
     $stream_context = stream_context_create();
     stream_context_set_option($stream_context, 'ssl', 'local_cert', $cert);
     if ($password)
          stream_context_set_option($stream_context, 'ssl', 'passphrase', $password);
          
     $apns_host = ($devel ? APNS_DEVEL_HOST : APNS_HOST);

     $apns_connection = stream_socket_client('ssl://'. $apns_host.':'. APNS_PORT, $error_code, $error_message, 5, STREAM_CLIENT_CONNECT, $stream_context);
     
     if($apns_connection === false) {
          apns_close_connection($apns_connection);
          return (array($error_code, $error_message));
     }
     
     return $apns_connection;
}

/**
*     Sends a notification to an open apns_connection, returns TRUE if sent successfully and FALSE if not
*/          
function apns_send_notification($apns_message, $apns_connection) {
     
     $success = fwrite($apns_connection, $apns_message);
          
     return $success !== false;
}

/**
*     Close a connection to Apple APNS Server
*/     
function apns_close_connection($apns_connection) {

     fclose($apns_connection);     
}



send_push_notification();
?>