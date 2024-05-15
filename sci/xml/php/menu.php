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

$RECURSO 	= param("RECURSO");
$SISTEMA 	="SCI";
$CODIGO 	=param("CODIGO");
$COD_MENU_PADRE=param("COD_MENU_PADRE");
$NOMBRE		=param("NOMBRE");
$LINK		=param("LINK");
$TARGET		=param("TARGET");
$ORDEN		=param("ORDEN");

switch ($RECURSO)
{	
	case "listMenu" : listMenu();
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

function listMenu (){
global $SISTEMA;
$Sql = "SELECT CODIGO, COD_MENU_PADRE, NOMBRE, LINK, TARGET, SISTEMA, USERNAME, USERDATE, ORDEN ";
$Sql = $Sql." FROM MENU WHERE SISTEMA='".$SISTEMA."' ORDER BY ORDEN";

$entries = mysql_query($Sql);

echo "<?xml version='1.0' encoding='ISO-8859-15'?>";
echo "<Xml>";
for($i = 0; $i < @mysql_num_rows($entries); $i++){
	 $entry = mysql_fetch_array($entries);
	 	echo "<ROW>";
		echo 	"<CODIGO>".$entry["CODIGO"]."</CODIGO>";
		echo	"<COD_MENU_PADRE>".$entry["COD_MENU_PADRE"]."</COD_MENU_PADRE>";
		echo	"<NOMBRE>".$entry["NOMBRE"]."</NOMBRE>";
		echo	"<LINK>".$entry["LINK"]."</LINK>";
		echo	"<ORDEN>".$entry["ORDEN"]."</ORDEN>";
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

	 	echo "<ROW>";
		echo 	"<CODIGO>Ok</CODIGO>";
		echo "</ROW>";

echo "</Xml>";
}

function newMenu (){
global $CODIGO;
global $SISTEMA;
global $COD_MENU_PADRE;
global $NOMBRE;
global $LINK;
global $TARGET;
global $ORDEN;

$Sql = "SELECT MAX(ORDEN) ORDEN FROM MENU WHERE COD_MENU_PADRE='".$COD_MENU_PADRE."'";
$entries = mysql_query($Sql);
$entry = mysql_fetch_array($entries);
$MaxOrden = $entry["ORDEN"] + 1;

$Sql = "INSERT INTO MENU (CODIGO, COD_MENU_PADRE, NOMBRE, LINK, TARGET, SISTEMA, ORDEN,  USERNAME, USERDATE) VALUES ('";
$Sql = $Sql.$CODIGO."','".$COD_MENU_PADRE." ','".$NOMBRE." ','".$LINK." ','".$TARGET." ','".$SISTEMA."',".$MaxOrden.",'".$USERNAME."', curdate())";

$entries = mysql_query($Sql);
//echo "Entries = ".$entries."</br>";
echo "<?xml version='1.0' encoding='ISO-8859-15'?>";
echo "<Xml>";echo $Sql;
	 	echo "<ROW>";
		echo 	"<CODIGO>Ok</CODIGO>";
		echo "</ROW>";
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
