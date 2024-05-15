<?
$Host 		=     "localhost";
$User 		=     "vitcomz_bb"; 
$PassWord 	=     "julius"; 
$DataBaseName =   "vitcomz_bb"; 
mysql_connect($Host, $User, $PassWord);
mysql_select_db($DataBaseName);

$RECURSO 	=param("RECURSO");
$ID		 	=strtoupper(param("ID"));
$RUT	 	=param("RUT");
$DV		 	=param("DV");
$PASSWORD 	=param("PASSWORD");
$NOMBRES	=param("NOMBRES");
$APELLIDOS	=param("APELLIDOS");
$ESTADO		=param("ESTADO");
$AREA		=param("AREA");
$FECHA		=param("FECHA");
$ROL		=param("ROL");
$EMAIL		=param("EMAIL");
$CARGO		=param("CARGO");
$FONO		=param("FONO");
$CELULAR	=param("CELULAR");


switch ($RECURSO)
{	
	case "validaPass" : validaPassword();
	break;
	case "listUsuarios" : listUsuarios();
	break;
	case "getUsuario" : getUsuario();
	break;
	case "newUsuario" : newUsuario();
	break;
	case "updateUsuario" : updateUsuario();
	break;
	case "existeUsuario" : existeUsuario();
	break;
}

function validaPassword(){
global $ID;
global $PASSWORD;

$Sql ="SELECT PASSWORD FROM USUARIOS WHERE ID ='".$ID."'";
$entries = mysql_query($Sql);
echo "<?xml version='1.0' encoding='ISO-8859-15'?>";
echo "<Xml>";
if (@mysql_num_rows($entries)>0){
		$entry = mysql_fetch_array($entries);
		if ($entry["PASSWORD"] == $PASSWORD)
				echo 	"<ROW>True</ROW>";
		else
				echo 	"<ROW>False</ROW>";
}
echo "</Xml>";
}

function listUsuarios(){

$Sql = "SELECT ID, RUT, NOMBRES, APELLIDOS, ESTADO, CARGO, ROL, E_MAIL, IP, FONO, CELULAR, AREA, USERDATE FROM USUARIOS" ;

$entries = mysql_query($Sql);
//echo "Entries = ".$entries."</br>";
echo "<?xml version='1.0' encoding='ISO-8859-15'?>";
echo "<Xml>";
for($i = 0; $i <= @mysql_num_rows($entries); $i++){
	 $entry = mysql_fetch_array($entries);
	 	echo "<ROW>";
		echo 	"<ID>".$entry["ID"]."</ID>";
		echo	"<RUT>".$entry["RUT"]."</RUT>";
		echo	"<NOMBRE>".$entry["NOMBRES"]."</NOMBRE>";
		echo	"<APELLIDOS>".$entry["APELLIDOS"]."</APELLIDOS>";
		echo	"<ESTADO>".$entry["ESTADO"]."</ESTADO>";
		echo	"<AREA>".$entry["AREA"]."</AREA>";
		echo	"<CARGO>".$entry["CARGO"]."</CARGO>";
		echo	"<ROL>".$entry["ROL"]."</ROL>";
		echo	"<E_MAIL>".$entry["E_MAIL"]."</E_MAIL>";
		echo	"<PASSWORD>".$entry["PASSWORD"]."</PASSWORD>";
		echo	"<IP>".$entry["IP"]."</IP>";
		echo	"<FONO>".$entry["FONO"]."</FONO>";
		echo	"<CELULAR>".$entry["CELULAR"]."</CELULAR>";
		echo	"<FECHA>".$entry["USERDATE"]."</FECHA>";
		echo "</ROW>";
	 }
echo "</Xml>";
}

function existeUsuario(){
global $ID;

$Sql = "SELECT COUNT(ID) N FROM USUARIOS" ;
$Sql = $Sql." WHERE ID ='".$ID."' GROUP BY ID";

$entries = mysql_query($Sql);
//echo "Entries = ".$entries."</br>";
echo "<?xml version='1.0' encoding='ISO-8859-15'?>";
echo "<Xml>";
 $entry = @mysql_fetch_array($entries);
	 	echo "<ROW>";
		echo 	"<N>".$entry["N"]."</N>";
		echo "</ROW>";
echo "</Xml>";

}

function getUsuario(){
global $ID;

$Sql = "SELECT ID, RUT, NOMBRES, APELLIDOS, ESTADO, CARGO, ROL, E_MAIL, IP, FONO, CELULAR, AREA, USERDATE FROM USUARIOS" ;
$Sql = $Sql." WHERE ID ='".$ID."'";

$entries = mysql_query($Sql);
//echo "Entries = ".$entries."</br>";
echo "<?xml version='1.0' encoding='ISO-8859-15'?>";
echo "<Xml>";
 $entry = @mysql_fetch_array($entries);
	 	echo "<ROW>";
		echo 	"<ID>".$entry["ID"]."</ID>";
		echo	"<RUT>".$entry["RUT"]."</RUT>";
		echo	"<NOMBRES>".$entry["NOMBRES"]."</NOMBRES>";
		echo	"<APELLIDOS>".$entry["APELLIDOS"]."</APELLIDOS>";
		echo	"<ESTADO>".$entry["ESTADO"]."</ESTADO>";
		echo	"<AREA>".$entry["AREA"]."</AREA>";
		echo	"<CARGO>".$entry["CARGO"]."</CARGO>";
		echo	"<ROL>".$entry["ROL"]."</ROL>";
		echo	"<E_MAIL>".$entry["E_MAIL"]."</E_MAIL>";
		echo	"<PASSWORD>".$entry["PASSWORD"]."</PASSWORD>";
		echo	"<IP>".$entry["IP"]."</IP>";
		echo	"<FONO>".$entry["FONO"]."</FONO>";
		echo	"<CELULAR>".$entry["CELULAR"]."</CELULAR>";
		echo	"<ROL>".$entry["ROL"]."</ROL>";
		echo	"<FECHA>".$entry["USERDATE"]."</FECHA>";
		echo "</ROW>";
echo "</Xml>";
}

function newUsuario (){
global $ID;
global $RUT;
global $DV;
global $PASSWORD;
global $NOMBRES;
global $APELLIDOS;
global $ESTADO;
global $AREA;
global $FECHA;
global $ROL;
global $EMAIL;
global $CARGO;
global $FONO;
global $CELULAR;

$Sql = "INSERT INTO USUARIOS (ID, NOMBRES, APELLIDOS, RUT, DV, PASSWORD, ESTADO,  AREA, CARGO, ROL, E_MAIL, FONO, CELULAR, USERDATE) VALUES (";
$Sql = $Sql."'".$ID."','".$NOMBRES."','".$APELLIDOS."',".$RUT.",'".$DV."','".$PASSWORD."','".$ESTADO."',";
$Sql = $Sql."'".$AREA."','".$CARGO."','".$ROL."','".$EMAIL."','".$FONO."','".$CELULAR."', curdate())";

$entries = mysql_query($Sql);
//echo "Entries = ".$entries."</br>";
echo "<?xml version='1.0' encoding='ISO-8859-15'?>";
echo "<Xml>";//echo $Sql;
	 $entry = mysql_fetch_array($entries);
	 	echo "<ROW>";
		echo 	"<CODIGO>Ok</CODIGO>";
		echo "</ROW>";
echo "</Xml>";
}

function updateUsuario (){
global $ID;
global $RUT;
global $DV;
global $PASSWORD;
global $NOMBRES;
global $APELLIDOS;
global $ESTADO;
global $AREA;
global $FECHA;
global $ROL;
global $EMAIL;
global $CARGO;
global $FONO;
global $CELULAR;

	$Sql = "UPDATE USUARIOS SET ";
	$Sql = $Sql."NOMBRES='".$NOMBRES."',";
	$Sql = $Sql."APELLIDOS='".$APELLIDOS."',";
	$Sql = $Sql."RUT=".$RUT.",";
	$Sql = $Sql."DV='".$DV."',";
	$Sql = $Sql."ESTADO='".$ESTADO."',";
	$Sql = $Sql."E_MAIL='".$EMAIL."',";
	$Sql = $Sql."ROL='".$ROL."',";
	$Sql = $Sql."CARGO='".$CARGO."',";
	$Sql = $Sql."AREA='".$AREA."',";
	$Sql = $Sql."FONO='".$FONO."',";
	$Sql = $Sql."CECULAR='".$CELULAR."',";
	$Sql = $Sql."USERNAME='DESARROLLO',";
	$Sql = $Sql."USERDATE=CURDATE()";
	$Sql = $Sql."WHERE ID='".$ID."'";
	
$entries = mysql_query($Sql);
//echo "Entries = ".$entries."</br>";
echo "<?xml version='1.0' encoding='ISO-8859-15'?>";
echo "<Xml>"; //.$Sql;
	 	echo "<ROW>";
		echo 	"<CODIGO>Ok</CODIGO>";
		echo "</ROW>";
echo "</Xml>";
}



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
