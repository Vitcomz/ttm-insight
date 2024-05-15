<?
// FTP access parameters
$host = 'ftp.ttminsight.cl';
$usr = 'ttminsi1';
$pwd = 'SyNaPtIc6532';
 
 
if(!empty($_GET['FILE'])) {
	echo 'Subiendo archivos! ....';
	// file to move:
	$file = $_GET['FILE'];
	$local_file = 'sgm/Files/'.$file;
	if(!empty($_GET['FILE2'])) {
		$file2 = $_GET['FILE2'];
		$ftp_path = '/ttminsi1/ttminsight.cl/wwwroot/sgm/Files/'.$file2;
	}else{
		$ftp_path = '/ttminsi1/ttminsight.cl/wwwroot/sgm/Files/'.$file;
	}
	// connect to FTP server (port 21)
	$conn_id = ftp_connect($host, 21) or die ("Cannot connect to host");
	 
	// send access parameters
	ftp_login($conn_id, $usr, $pwd) or die("No pudo accesar ftp");
	 
	// turn on passive mode transfers (some servers need this)
	ftp_pasv ($conn_id, true);
	 
	// perform file upload
	$upload = ftp_put($conn_id, $ftp_path, $local_file, FTP_ASCII);
	 
	// check upload status:
	print (!$upload) ? 'Error al subir archivos' : 'Subida exitosa';
	print "\n";
	 
	/*
	** Chmod the file (just as example)
	*/
	 
	// If you are using PHP4 then you need to use this code:
	// (because the "ftp_chmod" command is just available in PHP5+)
	if (!function_exists('ftp_chmod')) {
	   function ftp_chmod($ftp_stream, $mode, $filename){
			return ftp_site($ftp_stream, sprintf('CHMOD %o %s', $mode, $filename));
	   }
	}
	 
	// try to chmod the new file to 666 (writeable)
//	if (ftp_chmod($conn_id, 0666, $ftp_path) !== false) {
//		print $ftp_path . " chmoded successfully to 666\n";
//	} else {
//		print "could not chmod $file\n";
//	}
	 
	// close the FTP stream
	ftp_close($conn_id);
	

}

echo "<html><body><script>setTimeout(function(){ window.close(); }, 2000);</script></body></html>";
?>