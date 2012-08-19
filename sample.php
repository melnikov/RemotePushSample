<?php


$serverId = 1;
$name = "StexGroup.com";

$payload['aps'] = array('alert' => array(), 'badge' => 1, 'sound' => 'default');
$payload['aps']['alert']['body'] = 'Приглашение в iMafia';
$payload['aps']['alert']['gameid'] = '444';
$payload['aps']['alert']['user'] = 'Debiloid';




$payload['server'] = array('serverId' => $serverId, 'name' => $name);
$output = json_encode($payload);

$apnsHost = 'gateway.sandbox.push.apple.com';
$apnsPort = 2195;
$apnsCert = '/var/www/own2.demo.stexgroup.com/apns-dev.pem';

$streamContext = stream_context_create();

stream_context_set_option($streamContext, 'ssl', 'local_cert', $apnsCert);


$apns = stream_socket_client('ssl://' . $apnsHost . ':' . $apnsPort, $error, $errorString, 20, STREAM_CLIENT_CONNECT, $streamContext);

//print("Error: ".$errorString."Code: ".$error);


//now we need device token :)

$deviceToken = "03488939 5ee025b7 54d6965e 918b23a7 84057f56 07342d59 d9f8e436 2576f7e0";

$packed = pack('H*', str_replace(' ', '', $deviceToken));


echo $packed;



$apnsMessage = chr(0) . chr(0) . chr(32) . $packed . chr(0) . chr(strlen($output)) . $output;


$numWritten = fwrite($apns, $apnsMessage);

echo "\n".$numWritten." bytes written"; 

socket_close($apns);
fclose($apns);


?>
