<?php

$data=$_GET['data'];
$file=$_GET['file'];

if(!function_exists('downloader'))
 {
  function downloader($data, $filename = true, $content = 'application/x-octet-stream')
   {
    // If headers have already been sent, there is no point for this function.
    if(headers_sent()) return false;
    // If $filename is set to true (or left as default), treat $data as a filepath.
    if($filename === true)
     {
      if(!file_exists($data)) return false;
      $data = file_get_contents($data);
     }
    if(strpos($_SERVER['HTTP_USER_AGENT'], "MSIE") !== false)
     {
      header('Content-Disposition: attachment; filename="'.$filename.'"');
      header('Expires: 0');
      header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
      header('Content-Transfer-Encoding: binary');
      header('Content-Type: '.$content);
      header('Pragma: public');
      header('Content-Length: '.strlen($data));
     }
    else
     {
      header('Content-Disposition: attachment; filename="'.$filename.'"');
      header('Content-Transfer-Encoding: binary');
      header('Content-Type: '.$content);
      header('Expires: 0');
      header('Pragma: no-cache');
      header('Content-Length: '.strlen($data));
     }
    // Send file to browser, and terminate script to prevent corruption of data.
    exit($data);
   }
 }

downloader($data, 'List_bitacoras.xml', 'application/xml');

//-------------------------------------------------------------------------------

//$url = 'http://www.ttminsight.cl/sgm/xml/sync_Bitacoras.asp?RECURSO=ListBitacora&RESPONSABLE=TOD&EQUIPO=TOD&EQUIPO_PRIN=TOD&IND_DANO=TOD&IND_SOLUCION=TOD&CRITICIDAD=TOD&FAENA=LOS PELAMBRES';
////$file = basename($url);
//$file = "List_bitacoras.xml";
// 
//$fp = fopen($file, 'w');
// 
//$ch = curl_init($url);
//curl_setopt($ch, CURLOPT_FILE, $fp);
// 
//$data = curl_exec($ch);
// 
//curl_close($ch);
//fclose($fp);
// 
//header('Content-Description: File Transfer');
//header('Content-Type: application/octet-stream');
//header('Content-Disposition: attachment; filename='.basename($file));
//header('Content-Transfer-Encoding: binary');
//header('Expires: 0');
//header('Cache-Control: must-revalidate');
//header('Pragma: public');
//header('Content-Length: ' . filesize($file));
//ob_clean();
//flush();
//readfile($file);
//exit;

//-----------------------------------------------

//// Create a URL handle.
//$ch = curlinit();
//
//// Tell curl what URL we want.
//curlsetopt($ch, CURLOPTURL, 'http://www.ttminsight.cl/sgm/xml/sync_Bitacoras.asp?RECURSO=ListBitacora&RESPONSABLE=TOD&EQUIPO=TOD&EQUIPO_PRIN=TOD&IND_DANO=TOD&IND_SOLUCION=TOD&CRITICIDAD=TOD&FAENA=LOS PELAMBRES');
//
//// We want to return the web page from curlexec, not 
//// print it.
//curlsetopt($ch,CURLOPTRETURNTRANSFER,1);
//
//// Set this if you don't want the content header.
//curlsetopt($ch, CURLOPTHEADER, 0);
//
//// Download the HTML from the URL.
//$content = curlexec($ch);
//
//// Check to see if there were errors.
//if(curlerrno($ch)) {
//   // We have an error. Show the error message.
//   echo curlerror($ch);
//}
//else {
// // No error. Save the page content.
//    $file = 'List_bitacoras.xml';
//    
//   // Open a file for writing.
//    $fh = fopen($file, 'w');
//   
//   if(!$fh) {
//     // Couldn't create the file.
//       echo "Unable to create $file";
// }
//  else {
//     // Write the retrieved
//     // html to the file.
//       fwrite($fh, $content);
//     
//       // Display a message to say
//        // we've saved the file OK.
//        echo "Saved $file";
//        
//       // Close the file.
//     fclose($fh);
//   }
//}
//
//// Close the curl handle.
//curlclose($ch);

?>
