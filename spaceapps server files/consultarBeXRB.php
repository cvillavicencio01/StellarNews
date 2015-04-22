<?php
    
    
//apns service
//require_once "apns.php";

    
consultarSitio();

function extractTableString($responseString){

$begin = '<tbody>';
$end = '</tbody>';
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

     


	$result = getDataWithParams($fila,"<td><a href='","'><div id='name_cell'","simurl");
		if ($result['status']=="error") {
			return $result;
		}
		else{
		
			$simurl = $result['simurl'];
			$responseString = $result['string'];
			$result = getDataWithParams($responseString,"class='formated_cell'>" ,"</div></a>","name");
			
			if ($result['status']=="error") {
				return $result;
			}
			else{
				$name = $result['name'];
				$responseString = $result['string'];
				$result = getDataWithParams($responseString,"class='formated_cell'>" ,"</div></td>","ra");
				
				if ($result['status']=="error") {
					return $result;
				}
				else{
					$ra = $result['ra'];
					$responseString = $result['string'];
					$result = getDataWithParams($responseString,"class='formated_cell'>" ,"</div></td>","dec");
					
					if ($result['status']=="error") {
						return $result;
					}
					else{
						$dec = $result['dec'];
						$responseString = $result['string'];
						$result = getDataWithParams($responseString,"class='formated_cell'>" ,"</div></td>","orper");
						
						if ($result['status']=="error") {
							return $result;
						}
						else{
							$orper = $result['orper'];
							$responseString = $result['string'];
							
							//$result = getDataWithParams($responseString,"class='formated_cell'>" ,"</div></td>","orper");
							
							//eliminar inutiles se procesa 2 veces para elimnar  maxiflux y maxiaver
							$pos = strpos($responseString,"class='formated_cell'>");
							$responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
							$pos = strpos($responseString,"class='formated_cell'>");
							$responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));							
							
							
							$maxiurl='';
							$maxidate='';
							
							if (strcmp("</div></td><td><div class='formated_cell'>", substr($responseString,0,42)) !== 0) {
							    //no son iguales ejecutamos el de la url
								$result = getDataWithParams($responseString,"<td><a href='" ,"'><div","maxiurl");
								$maxiurl = $result['maxiurl'];
								$responseString = $result['string'];
								$result = getDataWithParams($responseString,"class='formated_cell'>" ,"</div></a></td>","maxidate");
								$maxidate = $result['maxidate'];
								$responseString = $result['string'];
							}else{
								$pos = strpos($responseString,"class='formated_cell'>");
							    $responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
								$maxidate= 'NO DATA';
							}


							//eliminar inutiles se procesa 2 veces para elimnar  maxiflux y maxiaver
							$pos = strpos($responseString,"class='formated_cell'>");
							$responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
							$pos = strpos($responseString,"class='formated_cell'>");
							$responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
							
							
							
							
							
							
							$swifturl='';
							$swiftdate='';
							
							if (strcmp("</div></td><td><div class='formated_cell'>", substr($responseString,0,42)) !== 0) {
							    //no son iguales ejecutamos el de la url
								$result = getDataWithParams($responseString,"<td><a href='" ,"'><div","swifturl");
								$swifturl = $result['swifturl'];
								$responseString = $result['string'];
								$result = getDataWithParams($responseString,"class='formated_cell'>" ,"</div></a></td>","swiftdate");
								$swiftdate = $result['swiftdate'];
								$responseString = $result['string'];
							}else{
								$pos = strpos($responseString,"class='formated_cell'>");
							    $responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
								$swiftdate= 'NO DATA';
							}
							
							
							
							
							
							
							
							//eliminar inutiles se procesa 2 veces para elimnar  maxiflux y maxiaver
							$pos = strpos($responseString,"class='formated_cell'>");
							$responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
							$pos = strpos($responseString,"class='formated_cell'>");
							$responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
							
							
							
							
							
							$fermiurl='';
							$fermidate='';
							
							if (strcmp("</div></td><td><div class='formated_cell'>", substr($responseString,0,42)) !== 0) {
							    //no son iguales ejecutamos el de la url
								$result = getDataWithParams($responseString,"<td><a href='" ,"'><div","fermiurl");
								$fermiurl = $result['fermiurl'];
								$responseString = $result['string'];
								$result = getDataWithParams($responseString,"class='formated_cell'>" ,"</div></a></td>","fermidate");
								$fermidate = $result['fermidate'];
								$responseString = $result['string'];
							}else{
								$pos = strpos($responseString,"class='formated_cell'>");
							    $responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
								$fermidate= 'NO DATA';
							}
							
							
						return array('simurl'=>$simurl, 'name'=>$name, 'ra'=>$ra, 'dec'=>$dec,'orper'=>$orper,'maxiurl'=>$maxiurl,'maxidate'=>$maxidate,'swifturl'=>$swifturl,'swiftdate'=>$swiftdate,'fermiurl'=>$fermiurl,'fermidate'=>$fermidate);

							//substr($responseString,$pos+strlen("class='formated_cell'>"));
							
							//Aqui esta el problema, si es No data se la va a saltar al siguiente href y me va a trucar
						/*	$result = getDataWithParams($responseString,"<td><a href='" ,"'><div","maxiurl");
							
							
							
							$maxiurl= '';//vacias
							$maxidate= '';//vacias
							//$bandera = false;
							
							if ($result['status']=="error") {
								$pos = strpos($responseString,"class='formated_cell'>");
							    $responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
								$maxidate= 'NO DATA';
								//$bandera = true;
							}
							else{
								$maxiurl = $result['maxiurl'];
								$responseString = $result['string'];
								//maxidate  "class='formated_cell'>"        "</div></a></td>"
								//no deberia haber error
								$result = getDataWithParams($responseString,"class='formated_cell'>" ,"</div></a></td>","maxidate");
								$maxidate = $result['maxidate'];
								$responseString = $result['string'];
							}
							

							
							
							//eliminar inutiles se procesa 2 veces para elimnar  swiftflux y swiftaver
							$pos = strpos($responseString,"class='formated_cell'>");
							$responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
							$pos = strpos($responseString,"class='formated_cell'>");
							$responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
							
							
							///swift
							
							
							$result = getDataWithParams($responseString,"<td><a href='" ,"'><div","swifturl");
							
							$swifturl= '';//vacias
							$swiftdate= '';//vacias
							//$bandera = false;
							
							if ($result['status']=="error") {
								$pos = strpos($responseString,"class='formated_cell'>");
							    $responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
								$swiftdate= 'NO DATA';
								//$bandera = true;
							}
							else{
								$swifturl = $result['swifturl'];
								$responseString = $result['string'];
								//maxidate  "class='formated_cell'>"        "</div></a></td>"
								//no deberia haber error
								$result = getDataWithParams($responseString,"class='formated_cell'>" ,"</div></a></td>","swiftdate");
								$swiftdate = $result['swiftdate'];
								$responseString = $result['string'];
							}
							
							
							
							//eliminar inutiles se procesa 2 veces para elimnar  swiftflux y swiftaver
							$pos = strpos($responseString,"class='formated_cell'>");
							$responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
							$pos = strpos($responseString,"class='formated_cell'>");
							$responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
							
							
							
							
							
							///fermi
							
							
							$result = getDataWithParams($responseString,"<td><a href='" ,"'><div","fermiurl");
							
							$fermiurl= '';//vacias
							$fermidate= '';//vacias
							//$bandera = false;
							
							if ($result['status']=="error") {
								$pos = strpos($responseString,"class='formated_cell'>");
							    $responseString = substr($responseString,$pos+strlen("class='formated_cell'>"));
								$fermidate= 'NO DATA';
								//$bandera = true;
							}
							else{
								$fermiurl = $result['fermiurl'];
								$responseString = $result['string'];
								//maxidate  "class='formated_cell'>"        "</div></a></td>"
								//no deberia haber error
								$result = getDataWithParams($responseString,"class='formated_cell'>" ,"</div></a></td>","fermidate");
								$fermidate = $result['fermidate'];
								$responseString = $result['string'];
							}
							
							
							
							return array('simurl'=>$simurl, 'name'=>$name, 'ra'=>$ra, 'dec'=>$dec,'orper'=>$orper,'maxiurl'=>$maxiurl,'maxidate'=>$maxidate,'swifturl'=>$swifturl,'swiftdate'=>$swiftdate,'fermiurl'=>$fermiurl,'fermidate'=>$fermidate);
							
							*/
							
						}
						
					}
					
				}

			
			}
					
					
		}
		
}
		
		
	


function consultarSitio(){
        
        $url = "http://integral.esac.esa.int/bexrbmonitor/webpage_oneplot.php";
        $ch = curl_init($url);
        curl_setopt ($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt ($ch, CURLOPT_TIMEOUT, 60);
        $responseString = curl_exec($ch);
        curl_close($ch);
               
               
               
        $tabla = extractTableString($responseString);
        
        $finalJson = [];
        
        
        for ($i = 0; $i <= 26; $i++){
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
        		
 
        
        $fp = fopen('data/bexrb/results.json', 'w');
		fwrite($fp, json_encode($finalJson));
		fclose($fp);
        
        
		if(equalsJson()){
			//echo "iguales";
		}else{
			//echo "diferentes";
			$file = "data/bexrb/bexrb.json";
			if (!unlink($file))
  				{
  					echo ("Error deleting $file");
  				}
			else
  				{
  				echo ("Deleted $file");
  				
  				
  				rename("data/bexrb/results.json", "data/bexrb/bexrb.json");
  				
  				//if(rename("data/bexrb/results.json", "data/bexrb/bexrb.json"))
					//send_push_notification();
			
			
  				}
  
			
		}
		
		

  
  
		
}
    
function equalsJson(){

$array = [];
$array2= [];

$data = file_get_contents ('data/bexrb/results.json');
$array = json_decode($data, TRUE);
  
$data2 = file_get_contents ('data/bexrb/bexrb.json');
$array2 = json_decode($data2, TRUE);  


if (strcmp($array[0]["name"], $array2[0]["name"]) !== 0) 
    return false;

else

	return true;

}    
?>