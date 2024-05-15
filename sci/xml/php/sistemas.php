<?
$Host 		=     "localhost";
$User 		=     "vitcomz_bb"; 
$PassWord 	=     "julius"; 
$DataBaseName =   "vitcomz_bb"; 
//SET PASSWORD FOR 'root'@'localhost' = OLD_PASSWORD('julius');
//show tables 

/*
LOAD DATA LOCAL INFILE '/menu.txt' 
INTO TABLE MENU
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
(CODIGO, COD_MENU_PADRE, NOMBRE, LINK, TARGET, ORDEN, SISTEMA, USERNAME, USERDATE); 
*/
mysql_connect($Host, $User, $PassWord);
mysql_select_db($DataBaseName);

$RECURSO 	=param("RECURSO");
$ID		 	=param("ID");
$AUTOR	 	=param("AUTOR");
$NOMBRE		=param("NOMBRE");
$VERSION	=param("VERSION");
$DESCRIPCION=param("DESCRIPCION");
$FECHA		=param("FECHA");
$BD			=param("BD");
$UBICACION	=param("UBICACION");
$ESTADO		=param("ESTADO");

switch ($RECURSO)
{	
	case "listSistemas" : listSistemas();
	break;
	case "delMenu" : delMenu();
	break;
	case "getMenu" : getMenu();
	break;
	case "newMenu" : newMenu();
	break;
	case "updateMenu" : updateMenu();
	break;
}

function listSistemas (){
global $SISTEMA;
$Sql = "SELECT ID, NOMBRE, DESCRIPCION, VERSION, ESTADO, AUTOR, FECHA, DB, UBICACION FROM SISTEMAS ";
$entries = mysql_query($Sql);
echo "<?xml version='1.0' encoding='ISO-8859-15'?>";
echo "<Xml>";
for($i = 0; $i < @mysql_num_rows($entries); $i++){
	 $entry = mysql_fetch_array($entries);
	 	echo "<ROW>";
		echo 	"<ID>".$entry["ID"]."</ID>";
		echo	"<NOMBRE>".$entry["NOMBRE"]."</NOMBRE>";
		echo	"<DESCRIPCION>".$entry["DESCRIPCION"]."</DESCRIPCION>";
		echo	"<VERSION>".$entry["VERSION"]."</VERSION>";
		echo	"<ESTADO>".$entry["ESTADO"]."</ESTADO>";
		echo	"<AUTOR>".$entry["AUTOR"]."</AUTOR>";
		echo	"<FECHA>".$entry["FECHA"]."</FECHA>";
		echo	"<DB>".$entry["DB"]."</DB>";
		echo	"<UBICACION>".$entry["UBICACION"]."</UBICACION>";
		echo "</ROW>";
	 }
echo "</Xml>";
}

function getMenu ($Codigo){

$Sql = "SELECT CODIGO, COD_MENU_PADRE, NOMBRE, LINK, TARGET, SISTEMA, USERNAME, USERDATE, ORDEN " ;
$Sql = $Sql."FROM MENU WHERE CODIGO='".$Codigo."'";

$entries = mysql_query($Sql);
//echo "Entries = ".$entries."</br>";
echo "<?xml version='1.0' encoding='ISO-8859-15'?>";
echo "<Xml>";
for($i = 0; $i <= @mysql_num_rows($entries); $i++){
	 $entry = mysql_fetch_array($entries);
	 	echo "<ROW>";
		echo 	"<CODIGO>".$entry["CODIGO"]."</CODIGO>";
		echo	"<COD_MENU_PADRE>".$entry["COD_MENU_PADRE"]."</COD_MENU_PADRE>";
		echo	"<NOMBRE>".$entry["NOMBRE"]."</NOMBRE>";
		echo	"<LINK>".$entry["LINK"]."</LINK>";
		echo	"<TARGET>".$entry["TARGET"]."</TARGET>";
		echo	"<SISTEMA>".$entry["SISTEMA"]."</SISTEMA>";
		echo	"<USERNAME>".$entry["USERNAME"]."</USERNAME>";
		echo	"<USERDATE>".$entry["USERDATE"]."</USERDATE>";
		echo	"<ORDEN>".$entry["ORDEN"]."</ORDEN>";
		echo "</ROW>";
	 }
echo "</Xml>";
}

function delMenu ($Codigo){
global $CODIGO;
$Sql = "DELETE FROM MENU WHERE CODIGO = '".$CODIGO."'";
$entries = mysql_query($Sql);
//echo "Entries = ".$entries."</br>";
echo "<?xml version='1.0' encoding='ISO-8859-15'?>";
echo "<Xml>";
for($i = 0; $i <= $entries; $i++){
	 $entry = mysql_fetch_array($entries);
	 	echo "<ROW>";
		echo 	"<CODIGO>Ok</CODIGO>";
		echo "</ROW>";
	 }
echo "</Xml>";
}

function newMenu (){
global $CODIGO;
global $COD_MENU_PADRE;
global $NOMBRE;
global $LINK;
global $TARGET;
global $ORDEN;

$Sql = "INSERT INTO MENU (CODIGO, COD_MENU_PADRE, NOMBRE, LINK, TARGET, SISTEMA, USERNAME, USERDATE) VALUES ('";
$Sql = $Sql.$CODIGO."','".$COD_MENU_PADRE." ','".$NOMBRE." ','".$LINK." ','".$TARGET." ','".$SISTEMA."','".$USERNAME." ', curdate())";

$entries = mysql_query($Sql);
//echo "Entries = ".$entries."</br>";
echo "<?xml version='1.0' encoding='ISO-8859-15'?>";
echo "<Xml>";
for($i = 0; $i <= $entries; $i++){
	 $entry = mysql_fetch_array($entries);
	 	echo "<ROW>";
		echo 	"<CODIGO>Ok</CODIGO>";
		echo "</ROW>";
	 }
echo "</Xml>";
}

function updateMenu (){
global $CODIGO;
global $COD_MENU_PADRE;
global $NOMBRE;
global $LINK;
global $TARGET;
global $ORDEN;

	$Sql = "UPDATE MENU SET ";
	$Sql = $Sql."COD_MENU_PADRE='".$COD_MENU_PADRE."',";
	$Sql = $Sql."NOMBRE='".$NOMBRE."',";
	$Sql = $Sql."LINK='".$LINK."',";
	$Sql = $Sql."TARGET='".$TARGET."',";
	$Sql = $Sql."USERNAME='DESARROLLO',";
	$Sql = $Sql."USERDATE=CURDATE()";
	if (strlen($ORDEN)>0)
			$Sql=$Sql.",ORDEN = ".$ORDEN." ";
	$Sql = $Sql."WHERE CODIGO='".$CODIGO."'";
	
$entries = mysql_query($Sql);
//echo "Entries = ".$entries."</br>";
echo "<?xml version='1.0' encoding='ISO-8859-15'?>";
echo "<Xml>".$Sql;
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
