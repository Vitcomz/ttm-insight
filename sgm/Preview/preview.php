<?

$filename= 'tmp.dat';

$percent = $_POST['listEscala'];

move_uploaded_file($_FILES['file1']['tmp_name'], $filename);

//echo $filename;

// Content-type para el navegador
header('Content-type: image/jpeg');

// Se obtienen las nuevas dimensiones
list($width, $height) = getimagesize($filename);

$newwidth = $width * $percent;
$newheight = $height * $percent;

// Cargar la imagen
$thumb = imagecreatetruecolor($newwidth, $newheight);

$source = imagecreatefromjpeg($filename);

// Redimensionar
imagecopyresized($thumb, $source, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
//imagecopyresampled($thumb, $source, 0, 0, 0, 0, $newwidth, $newheight, $width, $height).;
// Mostrar la nueva imagen
imagejpeg($thumb);

echo $source;

function param($Name)
         {
         global $HTTP_GET_VARS;
         global $HTTP_POST_VARS;         

         if(isset($HTTP_GET_VARS[$Name]))
            return($HTTP_GET_VARS[$Name]);

         if(isset($HTTP_POST_VARS[$Name]))
            return($HTTP_POST_VARS[$Name]);
            
         return("");         
         }
		 
?>

