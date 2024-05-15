<?php
/**
* Multi file upload example
* @author Resalat Haque
* @link http://www.w3bees.com/2013/02/multiple-file-upload-with-php.html
**/

$valid_formats = array("jpg", "png", "gif", "xml");
$max_file_size = 1024*3000; //3000 kb
$path = "Files/"; // Upload directory
$count = 0;

//if(isset($_POST) and $_SERVER['REQUEST_METHOD'] == "POST"){
//	// Loop $_FILES to execute all files
//	foreach ($_FILES['files']['name'] as $f => $name) {     
//	    if ($_FILES['files']['error'][$f] == 4) {
//	        continue; // Skip file if any error found
//	    }	       
//	    if ($_FILES['files']['error'][$f] == 0) {	           
//	        if ($_FILES['files']['size'][$f] > $max_file_size) {
//	            $message[] = "$name is too large!.";
//	            continue; // Skip large files
//	        }
//			elseif( ! in_array(pathinfo($name, PATHINFO_EXTENSION), $valid_formats) ){
//				$message[] = "$name is not a valid format";
//				continue; // Skip invalid file formats
//			}
//	        else{ // No error found! Move uploaded files 
//	            if(move_uploaded_file($_FILES["files"]["tmp_name"][$f], $path.$name)) {
//	            	$count++; // Number of successfully uploaded files
//	            }
//	        }
//	    }
//	}
//}


function subirFichero($origen, $destinoDir) {   
    $origen = strtolower(basename($origen));

    $destinoFull = $destinoDir.$origen;
    $frand = $origen;
    $i = 1;
   
    while (file_exists( $destinoFull )) {
        $file_name         = substr($origen, 0, strlen($origen)-4);
        $file_extension  = substr($origen, strlen($origen)-4, strlen($origen));
        $frand = $file_name."[$i]".$file_extension;
        $destinoFull = $destinoDir.$frand;
        $i++;
    }
   
    if (move_uploaded_file($origen, $destinoFull))    return $frand;
    else                                                 return "0";
}

echo subirFichero("file:///mnt/sdcard/pws/www/sgm/xml/list_mediciones.xml",$path);


?>

