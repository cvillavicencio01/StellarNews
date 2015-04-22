<?php
    
require_once "apns.php";
    
consultarSitio();

function extractTableString($responseString){

$begin = '</thead>';
$end = '</table>';
$pos = strpos($responseString,$begin);


if ($pos === false){ 
	print "$pos error";
	return;
}

		$responseString = substr($responseString,$pos+strlen($begin));
		$pos = strpos($responseString,$end);
		$value = substr ($responseString,0,$pos);
		
		return $value;
}

function extractRow($responseString){

$begin = '<tr';
$end = '</tr>';

$pos = strpos($responseString,$begin);
if ($pos === false){ 
	return array("status" => "error" , "message" => "No se pudo conseguir la fila");
}
		$responseString = substr($responseString,$pos+strlen($begin));
		$pos = strpos($responseString,$end);
		$value = substr ($responseString,0,$pos);
		
return array("status" => "success" , "row" => $value , "string" => $responseString);			
}

function getDataWithParams($string,$begin,$end,$campo){
	$pos = strpos($string,$begin);
	
	if ($pos === false) {
		return array("status" => "error" , "message" => "No se pudo conseguir el $campo de su cuenta");
	} 
	else {

		$string = substr ($string,$pos+strlen($begin));
		$pos = strpos($string,$end);
		
		$value = substr ($string,0,$pos);
		
		return array("status" => "success" , $campo => $value , "string" => $string);	
	}
}

function processRow($fila){
	$result = getDataWithParams($fila,'<td><a href="','"',"url");



		if ($result['status']=="error") {
			echo "error en url";
			return $result;
		}
		
		else{
		
		$url = $result['url'];
		$responseString = $result['string'];
		$result = getDataWithParams($responseString,'>',"</a></td>","name");
		
			if ($result['status']=="error") {
			echo "error en name";
				return $result;
			}
			else{
			
			
				$name = $result['name'];
				$responseString = $result['string'];
				$result = getDataWithParams($responseString,'<td>',"</td>","ra");
					if ($result['status']=="error") {
					echo "error en ra";
							return $result;
					}
					else{
					
							$ra = $result['ra'];
							$responseString = $result['string'];
							$result = getDataWithParams($responseString,'<td>',"</td>","dec");
					
							if ($result['status']=="error") {
							echo "error en dec";
									return $result;
							}else{
							
								$dec = $result['dec'];
								$responseString = $result['string'];				
								$result = getDataWithParams($responseString,'<td>',"</td>","alt");
									
									if ($result['status']=="error") {
									echo "error en alt";
										return $result;
									}else{
							
										$alt = $result['alt'];
										$responseString = $result['string'];
							
										$result = getDataWithParams($responseString,'<td>',"</td>","class");
													if ($result['status']=="error") {
													echo "error en class";
														return $result;
													}else{
															$class = $result['class'];
															
															//echo "direccion: $url nombre: $name Ra: $ra Dec: $dec class: $class";
															
															return array('url'=> $url, 'name'=> $name,'ra'=> $ra, 'dec'=> $dec, 'alt' =>$alt ,'class'=> $class);
													}
							
							
									}		
												
												/*
													*/
													
													
													
											}
									
									
									}
							
							
							}
					
					}
		
			}
		
		
	








function consultarSitio(){
        
        $url = "http://swift.gsfc.nasa.gov/results/transients/";
        $ch = curl_init($url);
        curl_setopt ($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt ($ch, CURLOPT_TIMEOUT, 60);
        $responseString = curl_exec($ch);
        curl_close($ch);
               
               
               
        $tabla = extractTableString($responseString);
        
        $finalJson = [];
        
        
        for ($i = 0; $i <= 3; $i++){
        	$rowResult = extractRow($tabla);
        	
        	
        	if ($rowResult['status']=="error"){
        		break;
        	}
        	else{
        		$row = $rowResult['row'];
				$tabla = $rowResult['string'];
				$datas = processRow($row);
				array_push($finalJson, $datas);
        	}
        }
        		
 
        
        $fp = fopen('data/swift/results.json', 'w');
		fwrite($fp, json_encode($finalJson));
		fclose($fp);
        
        
		if(equalsJson()){
			//echo "iguales";
		}else{
			//echo "diferentes";
			$file = "data/swift/swift.json";
			if (!unlink($file))
  				{
  					echo ("Error deleting $file");
  				}
			else
  				{
  				echo ("Deleted $file");
  				
  				
  				//rename("data/swift/results.json", "data/swift/swift.json");
  				
  				if(rename("data/swift/results.json", "data/swift/swift.json"))
					send_push_notification();
			
			
  				}
  
			
		}
		
		

  
  
		
}
    
function equalsJson(){

$array = [];
$array2= [];

$data = file_get_contents ('data/swift/results.json');
$array = json_decode($data, TRUE);
  
$data2 = file_get_contents ('data/swift/swift.json');
$array2 = json_decode($data2, TRUE);  


if (strcmp($array[0]["name"], $array2[0]["name"]) !== 0) 
    return false;

else

	return true;

}    
?>