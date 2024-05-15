<?

	$RECURSO=$_GET['RECURSO'];
	if ($RECURSO == 'NewBitacora'){
		$CAUSA=$_GET['CAUSA'];
		$ESTATUS=$_GET['ESTATUS'];
		$CRITICIDAD=strtoupper($_GET['CRITICIDAD']);
		$CONDICION=$_GET['CONDICION'];
		$COLOR=$_GET['COLOR'];
		$FECHA=$_GET['FECHA'];
		$ULT_INSPECCION=$_GET['ULT_INSPECCION'];
		$FAENA=strtoupper($_GET['FAENA']);
		$REPORT=$_GET['REPORT'];
		$RECOMENDACION=$_GET['RECOMENDACION'];
		$OT=$_GET['OT'];
		$EQUIPO=$_GET['EQUIPO'];
		$FECHA_PROGRAMADA=$_GET['FECHA_PROGRAMADA'];
		$USERNAME=strtoupper($_GET['USERNAME']);
		$DESCRIPCION=$_GET['DESCRIPCION'];
		$IND_INCIDENTE=strtoupper($_GET['IND_INCIDENTE']);
		$IND_SOLUCION=strtoupper($_GET['IND_SOLUCION']);
		
		
		
		$file = "list_Bitacoras.xml";
		$fp = fopen($file, "rb") or die("cannot open file");
		$str = fread($fp, filesize($file));
	
		$xml = new DOMDocument();
		$xml->formatOutput = true;
		$xml->preserveWhiteSpace = false;
		$xml->load($file);
		
		// original
		//echo "<xmp>OLD:\n".  ."</xmp>";
		$xml->saveXML();
		// get document element
		$root   = $xml->documentElement;
		//$fnode  = $root->lastChild;
	
		//add a node
		//$ori    = $fnode->childNodes->nodeValue;
		$xpath = new DOMXpath($xml);
		foreach ($xpath->evaluate('//ROW[last()]') as $listing) {
			//echo $xpath->evaluate('string(N)', $listing);
			$N = $xpath->evaluate('string(N)', $listing);
			$Ni = $N + 1;
		}
		$highest_key = 0;
		foreach ($xpath->evaluate('//ROW') as $listing2) {
			$ori = $xpath->evaluate('string(ID)', $listing2);
			if (intval($ori) > $highest_key) {
				$highest_key = intval($ori);
			} 
		}
		$orit = $highest_key + 1;
		//echo $Ni. '<->' .$orit;
	
	
		$Qr     = $xml->createElement("N");
		$QrText = $xml->createTextNode($Ni);
		$Qr->appendChild($QrText);
		$Wr     = $xml->createElement("ID");
		$WrText = $xml->createTextNode($orit);
		$Wr->appendChild($WrText);
		$Er     = $xml->createElement("FECHA");
		$ErText = $xml->createTextNode($FECHA);
		$Er->appendChild($ErText);
		$Rr     = $xml->createElement("TURNO");
	//	$RrText = $xml->createTextNode($TURNO);
	//	$Rr->appendChild($RrText);
		$Tr     = $xml->createElement("RESPONSABLE");
		$TrText = $xml->createTextNode($USERNAME);
		$Tr->appendChild($TrText);
		$Yr     = $xml->createElement("DESCRIPCION");
		$YrText = $xml->createTextNode($DESCRIPCION);
		$Yr->appendChild($YrText);
		$Ur     = $xml->createElement("ESTADO");
		$UrText = $xml->createTextNode('ING');
		$Ur->appendChild($UrText);
		$Ir     = $xml->createElement("IND_INCIDENTE");
		$IrText = $xml->createTextNode($IND_INCIDENTE);
		$Ir->appendChild($IrText);
		$Or     = $xml->createElement("TIPO_TURNO");
	//	$OrText = $xml->createTextNode($TIPO_TURNO);
	//	$Or->appendChild($OrText);
		$Pr     = $xml->createElement("EQUIPO");
		$PrText = $xml->createTextNode($EQUIPO);
		$Pr->appendChild($PrText);
		$Ar     = $xml->createElement("DESC_EQUIPO");
	//	$ArText = $xml->createTextNode($Ni);
	//	$Ar->appendChild($ArText);
		$Sr     = $xml->createElement("IND_DANO");
	//	$SrText = $xml->createTextNode($IND_DANO);
	//	$Sr->appendChild($SrText);
		$Dr     = $xml->createElement("COLOR");
		$DrText = $xml->createTextNode($COLOR);
		$Dr->appendChild($DrText);
		$Fr     = $xml->createElement("CAUSA");
		$FrText = $xml->createTextNode($CAUSA);
		$Fr->appendChild($FrText);
		$Gr     = $xml->createElement("IND_SOLUCION");
		$GrText = $xml->createTextNode($IND_SOLUCION);
		$Gr->appendChild($GrText);
		$Hr     = $xml->createElement("DIAS");
	//	$HrText = $xml->createTextNode($Ni);
	//	$Hr->appendChild($HrText);
		$Jr     = $xml->createElement("EQUIPO_PRIN");
		$JrText = $xml->createTextNode($Ni);
		$Jr->appendChild($JrText);
		$Kr     = $xml->createElement("RECOMENDACION");
		$KrText = $xml->createTextNode($RECOMENDACION);
		$Kr->appendChild($KrText);
		$Lr     = $xml->createElement("CRITICIDAD");
		$LrText = $xml->createTextNode($CRITICIDAD);
		$Lr->appendChild($LrText);
		$Zr     = $xml->createElement("GCODE");
	//	$ZrText = $xml->createTextNode($Ni);
	//	$Zr->appendChild($ZrText);
		$Xr     = $xml->createElement("X");
	//	$XrText = $xml->createTextNode($Ni);
	//	$Xr->appendChild($XrText);
		$Cr     = $xml->createElement("Y");
	//	$CrText = $xml->createTextNode($Ni);
	//	$Cr->appendChild($CrText);
		$Lxr     = $xml->createElement("CONDICION");
		$LxrText = $xml->createTextNode($CONDICION);
		$Lxr->appendChild($LxrText);
		$Lrx     = $xml->createElement("STATUS");
		$LrxText = $xml->createTextNode($ESTATUS);
		$Lrx->appendChild($LrxText);			
		$Vr     = $xml->createElement("EJECUTOR");
	//	$VrText = $xml->createTextNode($EJECUTOR);
	//	$Vr->appendChild($VrText);
		$Br     = $xml->createElement("REPORT");
		$BrText = $xml->createTextNode($REPORT);
		$Br->appendChild($BrText);
		$Nr     = $xml->createElement("FAENA");
		$NrText = $xml->createTextNode($FAENA);
		$Nr->appendChild($NrText);
		$Mr     = $xml->createElement("DANO");
	//	$MrText = $xml->createTextNode($DANO);
	//	$Mr->appendChild($MrText);
		$QWr     = $xml->createElement("PRIORIDAD");
	//	$QWrText = $xml->createTextNode($PRIORIDAD);
	//	$QWr->appendChild($QWrText);
		$WEr     = $xml->createElement("COMBUSTIBLE");
	//	$WErText = $xml->createTextNode($COMBUSTIBLE);
	//	$WEr->appendChild($WErText);
		$ERr     = $xml->createElement("VALOR_COMBUSTIBLE");
	//	$ERrText = $xml->createTextNode($VALOR_COMBUSTIBLE);
	//	$ERr->appendChild($ERrText);
		$RTr     = $xml->createElement("DOC_COMBUSTIBLE");
	//	$RTrText = $xml->createTextNode($DOC_COMBUSTIBLE);
	//	$RTr->appendChild($RTrText);
		$TxYr     = $xml->createElement("FECHA_PROGRAMADA");
		$TxYrText = $xml->createTextNode($FECHA_PROGRAMADA);
		$TxYr->appendChild($TxYrText);
		$TYr     = $xml->createElement("ULT_INSPECCION");
		$TYrText = $xml->createTextNode($ULT_INSPECCION);
		$TYr->appendChild($TYrText);
		$YUr     = $xml->createElement("OT");
		$YUrText = $xml->createTextNode($OT);
		$YUr->appendChild($YUrText);
		$UIr     = $xml->createElement("ULT_MOD_OBS");
	//	$UIrText = $xml->createTextNode($ULT_MOD_OBS);
	//	$UIr->appendChild($UIrText);
		$IOr     = $xml->createElement("FILE");
	//	$IOrText = $xml->createTextNode($IMG);
	//	$IOr->appendChild($IOrText);
		$OPr     = $xml->createElement("OP");
		$OPrText = $xml->createTextNode("ING");
		$OPr->appendChild($OPrText);
		
		$book   = $xml->createElement("ROW");
		$book->appendChild($Qr);
		$book->appendChild($Wr);
		$book->appendChild($Er);
		$book->appendChild($Rr);
		$book->appendChild($Tr);
		$book->appendChild($Yr);
		$book->appendChild($Ur);
		$book->appendChild($Ir);
		$book->appendChild($Or);
		$book->appendChild($Pr);
		$book->appendChild($Ar);
		$book->appendChild($Sr);
		$book->appendChild($Dr);
		$book->appendChild($Fr);
		$book->appendChild($Gr);
		$book->appendChild($Hr);
		$book->appendChild($Jr);
		$book->appendChild($Kr);
		$book->appendChild($Lr);
		$book->appendChild($Zr);
		$book->appendChild($Xr);
		$book->appendChild($Cr);
		$book->appendChild($Lxr);
		$book->appendChild($Lrx);
		$book->appendChild($Vr);
		$book->appendChild($Br);
		$book->appendChild($Nr);
		$book->appendChild($Mr);
		$book->appendChild($QWr); 
		$book->appendChild($WEr);
		$book->appendChild($ERr);
		$book->appendChild($RTr);
		$book->appendChild($TxYr);
		$book->appendChild($TYr);
		$book->appendChild($YUr);
		$book->appendChild($UIr);
		$book->appendChild($IOr);
		$book->appendChild($OPr);
		
	//	$ori->parentNode->insertBefore($book,$ori);
		$root->appendChild($book);
	
		$xml->formatOutput = true;
		$xml->save("list_Bitacoras.xml") or die("Error");
		$xml->saveXML();
	
		//echo "<xmp>NEW:\n". $xml->saveXML() ."</xmp>";
		//$xmlx = new SimpleXMLElement($SRT);
		//echo $xmlx->asXML();
		
		$SRT = "<REGISTROS><ID>".$orit."</ID></REGISTROS>";
		Header('Content-type: text/xml');
		print($SRT);
	}
	
	if ($RECURSO == 'DelBitacora'){
		
		$FOLIO=$_GET['FOLIO'];
	
		
		$file = "list_Bitacoras.xml";
		$fp = fopen($file, "rb") or die("cannot open file");
		$str = fread($fp, filesize($file));
			
		$xml = new DOMDocument();
		$xml->load($file);
		
		//$xml->saveXML();
		$root   = $xml->documentElement;
		$xpath = new DOMXpath($xml);
		//$nodeList = $xpath->query('//ROW[ID="'.$ID.'"]'); [IDENTIFICADOR=".$IDentx."]
		$nodelist = $xpath->query("//ROW[ID=".$FOLIO."]");
		$domElemsToRemove = array(); 
		foreach ( $nodelist as $domElement ) {
		  // ...do stuff with $domElement...
		  $domElemsToRemove[] = $domElement;
		}
		foreach( $domElemsToRemove as $node ){
		  $node->parentNode->removeChild($node);
		} 
//			if ($nodelist->length) {
//				$node = $nodelist->item(0);
//				$node->parentNode->removeChild($node);
//			}
		//    $xml->save($myXML);
			$xml->save("list_Bitacoras.xml");
			$xml->saveXML();	

	}


	if ($RECURSO == 'DelCheckBitacora'){
		
		$FOLIO=$_GET['FOLIO'];
	
		
		$file = "list_check_bitacora.xml";
		$fp = fopen($file, "rb") or die("cannot open file");
		$str = fread($fp, filesize($file));
			
		$xml = new DOMDocument();
		$xml->load($file);
		
		//$xml->saveXML();
		$root   = $xml->documentElement;
		$xpath = new DOMXpath($xml);
		//$nodeList = $xpath->query('//ROW[ID="'.$ID.'"]'); [IDENTIFICADOR=".$IDentx."]
		$nodelist = $xpath->query("//ROW[BITACORA=".$FOLIO."]");
		$domElemsToRemove = array(); 
		foreach ( $nodelist as $domElement ) {
		  // ...do stuff with $domElement...
		  $domElemsToRemove[] = $domElement;
		}
		foreach( $domElemsToRemove as $node ){
		  $node->parentNode->removeChild($node);
		} 
//			if ($nodelist->length) {
//				$node = $nodelist->item(0);
//				$node->parentNode->removeChild($node);
//			}
		//    $xml->save($myXML);
			$xml->save("list_check_bitacora.xml");
			$xml->saveXML();	

	}
	
	if ($RECURSO == 'NewCheckBitacora'){
		$ID = $_GET['ID'];
		$FOLIO = $_GET['FOLIO'];
		$VALOR = $_GET['VALOR'];

		$file = "list_check_bitacora.xml";
		$fp = fopen($file, "rb") or die("cannot open file");
		$str = fread($fp, filesize($file));
	
		$xml = new DOMDocument();
		$xml->formatOutput = true;
		$xml->preserveWhiteSpace = false;
		$xml->load($file);
		
		$xml->saveXML();
		$root   = $xml->documentElement;
//		$xpath = new DOMXpath($xml);
//		foreach ($xpath->evaluate('//ROWS[last()]') as $listing) {
//			$ori = $xpath->evaluate('string(NRO)', $listing);
//			$orit = $ori + 1;
//		}
	
		$nro     = $xml->createElement("BITACORA");
		$nroText = $xml->createTextNode($FOLIO);
		$nro->appendChild($nroText);
		
		$id     = $xml->createElement("CHECKLIST");
		$idText = $xml->createTextNode($ID);
		$id->appendChild($idText);
	
		$insp     = $xml->createElement("VALOR");
		$inspText = $xml->createTextNode($VALOR);
		$insp->appendChild($inspText);

		$op     = $xml->createElement("OP");
		$opText = $xml->createTextNode("ING");
		$op->appendChild($opText);
	
		$book   = $xml->createElement("ROW");
		$book->appendChild($nro);
		$book->appendChild($id);
		$book->appendChild($insp);
		$book->appendChild($op);
		
	
	//	$fnode->insertBefore($book,$ori);
		$root->appendChild($book);
	
		$xml->save("list_check_bitacora.xml");
		$xml->saveXML();
		
		$SRTx = "<REGISTROS><ROW>OK</ROW></REGISTROS>";
		Header('Content-type: text/xml');
		print($SRTx);
	}
	if ($RECURSO == 'UpdCheckBitacora'){
		$ID = $_GET['ID'];
		$FOLIO = $_GET['FOLIO'];
		$VALOR = $_GET['VALOR'];

		$file = "list_check_bitacora.xml";
		$fp = fopen($file, "rb") or die("cannot open file");
		$str = fread($fp, filesize($file));
	
		$xml = new DOMDocument();
		$xml->formatOutput = true;
		$xml->preserveWhiteSpace = false;
		$xml->load($file);
		
		$xml->saveXML();
		$root   = $xml->documentElement;
		$xpath = new DOMXpath($xml);
		$nodelist = $xpath->query("//ROW[BITACORA='".$FOLIO."']");
			if ($nodeList->length > 0) {
				$nx = 1;
			}else{
				$nx = 0;
			}
		if ($nx == 0){
			$nro     = $xml->createElement("BITACORA");
			$nroText = $xml->createTextNode($FOLIO);
			$nro->appendChild($nroText);
			
			$id     = $xml->createElement("CHECKLIST");
			$idText = $xml->createTextNode($ID);
			$id->appendChild($idText);
		
			$insp     = $xml->createElement("VALOR");
			$inspText = $xml->createTextNode($VALOR);
			$insp->appendChild($inspText);
	
			$op     = $xml->createElement("OP");
			$opText = $xml->createTextNode("ING");
			$op->appendChild($opText);
		
			$book   = $xml->createElement("ROW");
			$book->appendChild($nro);
			$book->appendChild($id);
			$book->appendChild($insp);
			$book->appendChild($op);
			
		
		//	$fnode->insertBefore($book,$ori);
			$root->appendChild($book);
		
			$xml->save("list_check_bitacora.xml");
		}else{
			$newNode1 = $xml->createElement('CHECKLIST', $ID);
			$newNode2 = $xml->createElement('VALOR', $VALOR);
			$newNode3 = $xml->createElement("OP", "UPD");
			//$node = $nodeList->item(0)->$node;
			//$data->item(0)->nodeValue = $ULT_MOD_OBS;
			$x = $nodeList->item(0);
			$x->childNodes->item(1)->parentNode->replaceChild($newNode1, $x->childNodes->item(1));
			$x->childNodes->item(2)->parentNode->replaceChild($newNode2, $x->childNodes->item(2));
			$x->childNodes->item(3)->parentNode->replaceChild($newNode3, $x->childNodes->item(3));

		}
		$xml->save("list_check_bitacora.xml");
		$xml->saveXML();
		
		$SRTx = "<REGISTROS><ROW>OK</ROW></REGISTROS>";
		Header('Content-type: text/xml');
		print($SRTx);
	}
	
		if ($RECURSO == 'delPlanData'){
		
		$FOLIO=$_GET['FOLIO'];
		$FAENA=strtoupper($_GET['FAENA']);
		
		$file = "List_plandata.xml";
		$fp = fopen($file, "rb") or die("cannot open file");
		$str = fread($fp, filesize($file));
			
		$xml = new DOMDocument();
		$xml->load($file);
		
		//$xml->saveXML();
		$root   = $xml->documentElement;
		$xpath = new DOMXpath($xml);
		//$nodeList = $xpath->query('//ROW[ID="'.$ID.'"]'); [IDENTIFICADOR=".$IDentx."]
		$nodelist = $xpath->query("//ROWS[ID=".$FOLIO." and  FAENA='".$FAENA."']");
		$domElemsToRemove = array(); 
		foreach ( $nodelist as $domElement ) {
		  // ...do stuff with $domElement...
		  $domElemsToRemove[] = $domElement;
		}
		foreach( $domElemsToRemove as $node ){
		  $node->parentNode->removeChild($node);
		} 
//			if ($nodelist->length) {
//				$node = $nodelist->item(0);
//				$node->parentNode->removeChild($node);
//			}
		//    $xml->save($myXML);
			$xml->save("List_plandata.xml");
			$xml->saveXML();	

	}
	
	if ($RECURSO == 'insertPlanData'){
		$ID = $_GET['ID'];
		$REPORT = $_GET['REPORT'];
		$OT = $_GET['OT'];
		$FECHA_PROGRAMADA = $_GET['FECHA_PROGRAMADA'];
		$RECOMENDACION = $_GET['RECOMENDACION'];
		$ACCION = $_GET['ACCION'];
		$CONDICION = $_GET['CONDICION'];
		$STATUS = $_GET['ESTATUS'];
		$FAENA=strtoupper($_GET['FAENA']);
		
		$file = "List_plandata.xml";
		$fp = fopen($file, "rb") or die("cannot open file");
		$str = fread($fp, filesize($file));
	
		$xml = new DOMDocument();
		$xml->formatOutput = true;
		$xml->preserveWhiteSpace = false;
		$xml->load($file);
		
		$xml->saveXML();
		$root   = $xml->documentElement;
//		$xpath = new DOMXpath($xml);
//		foreach ($xpath->evaluate('//ROWS[last()]') as $listing) {
//			$ori = $xpath->evaluate('string(NRO)', $listing);
//			$orit = $ori + 1;
//		}
	
		$insp1    = $xml->createElement("REPORT");
		$inspText1 = $xml->createTextNode($REPORT);
		$insp1->appendChild($inspText1);
		
		$insp2     = $xml->createElement("OT");
		$inspText2 = $xml->createTextNode($OT);
		$insp2->appendChild($inspText2);
	
		$insp3     = $xml->createElement("FECHA_PROGRAMADA");
		$inspText3 = $xml->createTextNode($FECHA_PROGRAMADA);
		$insp3->appendChild($inspText3);

		$insp4     = $xml->createElement("RECOMENDACION");
		$inspText4 = $xml->createTextNode($RECOMENDACION);
		$insp4->appendChild($inspText4);
		
		$insp5     = $xml->createElement("ACCION");
		$inspText5 = $xml->createTextNode($ACCION);
		$insp5->appendChild($inspText5);

		$insp6     = $xml->createElement("CONDICION");
		$inspText6 = $xml->createTextNode($CONDICION);
		$insp6->appendChild($inspText6);

		$insp7     = $xml->createElement("STATUS");
		$inspText7 = $xml->createTextNode($STATUS);
		$insp7->appendChild($inspText7);

		$insp8     = $xml->createElement("ID");
		$inspText8 = $xml->createTextNode($ID);
		$insp8->appendChild($inspText8);
		
		$insp9     = $xml->createElement("FAENA");
		$inspText9 = $xml->createTextNode($FAENA);
		$insp9->appendChild($inspText9);
										
		$op     = $xml->createElement("OP");
		$opText = $xml->createTextNode("UPD");
		$op->appendChild($opText);
	
		$book   = $xml->createElement("ROWS");
		$book->appendChild($insp1);
		$book->appendChild($insp2);
		$book->appendChild($insp3);
		$book->appendChild($insp4);
		$book->appendChild($insp5);
		$book->appendChild($insp6);
		$book->appendChild($insp7);
		$book->appendChild($insp8);
		$book->appendChild($insp9);
		$book->appendChild($op);				
	
	//	$fnode->insertBefore($book,$ori);
		$root->appendChild($book);
	
		$xml->save("List_plandata.xml");
		$xml->saveXML();
		
		$SRTx = "<REGISTROS><ROW>OK</ROW></REGISTROS>";
		Header('Content-type: text/xml');
		print($SRTx);
	}


	if ($RECURSO == 'updatePlanData'){
		$ID = $_GET['ID'];
		$REPORT = $_GET['REPORT'];
		$OT = $_GET['OT'];
		$FECHA_PROGRAMADA = $_GET['FECHA_PROGRAMADA'];
		$RECOMENDACION = $_GET['RECOMENDACION'];
		$ACCION = $_GET['ACCION'];
		$CONDICION = $_GET['CONDICION'];
		$STATUS = $_GET['ESTATUS'];
		
		$file = "List_plandata.xml";
		$fp = fopen($file, "rb") or die("cannot open file");
		$str = fread($fp, filesize($file));
	
		$xml = new DOMDocument();
		$xml->formatOutput = true;
		$xml->preserveWhiteSpace = false;
		$xml->load($file);
		
		//$xml->saveXML();
		$root   = $xml->documentElement;
		$xpath = new DOMXpath($xml);
		$nodeList = $xpath->query('//ROWS[ID="'.$ID.'"]');
		
		$newNode1 = $xml->createElement('REPORT', $REPORT);
		$newNode2 = $xml->createElement('OT', $OT);
		$newNode7 = $xml->createElement('FECHA_PROGRAMADA', $FECHA_PROGRAMADA);
		$newNode3 = $xml->createElement('RECOMENDACION', utf8_encode($RECOMENDACION));
		$newNode4 = $xml->createElement('ACCION', $ACCION);
		$newNode5 = $xml->createElement('CONDICION', $CONDICION);
		$newNode6 = $xml->createElement('STATUS', $STATUS);
		
		$x = $nodeList->item(0);
		$x->childNodes->item(0)->parentNode->replaceChild($newNode1, $x->childNodes->item(0));
		$x->childNodes->item(1)->parentNode->replaceChild($newNode2, $x->childNodes->item(1));
		$x->childNodes->item(2)->parentNode->replaceChild($newNode7, $x->childNodes->item(2));
		$x->childNodes->item(3)->parentNode->replaceChild($newNode3, $x->childNodes->item(3));
		$x->childNodes->item(4)->parentNode->replaceChild($newNode4, $x->childNodes->item(4));
		$x->childNodes->item(5)->parentNode->replaceChild($newNode5, $x->childNodes->item(5));
		$x->childNodes->item(6)->parentNode->replaceChild($newNode6, $x->childNodes->item(6));
		$xml->save("List_plandata.xml");
		
		$xml->saveXML();
		$SRTx = "<REGISTROS><ROWS><LAYOUT>OK</LAYOUT></ROWS></REGISTROS>";
		Header('Content-type: text/xml');
		print($SRTx);

	}
	if ($RECURSO == 'updateMod_Obs'){
		$ID = $_GET['ID'];
		$ULT_MOD_OBS = $_GET['ULT_MOD_OBS'];

		$file = "list_Bitacoras.xml";
		$fp = fopen($file, "rb") or die("cannot open file");
		$str = fread($fp, filesize($file));
	
		$xml = new DOMDocument();
		$xml->formatOutput = true;
		$xml->preserveWhiteSpace = false;
		$xml->load($file);
		
		//$xml->saveXML();
		$root   = $xml->documentElement;
		$xpath = new DOMXpath($xml);
		$nodeList = $xpath->query('//ROW[ID="'.$ID.'"]');
		
		$newNode1 = $xml->createElement('ULT_MOD_OBS', $ULT_MOD_OBS);
		
		$x = $nodeList->item(0);
		$x->childNodes->item(0)->parentNode->replaceChild($newNode1, $x->childNodes->item(0));
		$xml->save("list_Bitacoras.xml");
		
		$xml->saveXML();



//		$nodeList = $xpath->query('//ROW[ID="'.$ID.'"]');
//		$x = $nodeList->item(0);
//		foreach ($x->childNodes as $p){
//			echo $p->nodeName.' = '.$p->nodeValue.'<br>';
//		}
//		
//		$SRTx = "<REGISTROS><ROW>OK</ROW></REGISTROS>";
//		Header('Content-type: text/xml');
//		print($SRTx);
	}
	if ($RECURSO == 'UpdateBitacora'){
		$ID=$_GET['ID'];
		$FECHA=$_GET['FECHA'];
		$ULT_INSPECCION=$_GET['ULT_INSPECCION'];
		$EQUIPO=$_GET['EQUIPO'];
		$DESCRIPCION=$_GET['DESCRIPCION'];
		$RECOMENDACION=$_GET['RECOMENDACION'];
		$CAUSA=$_GET['CAUSA'];
		$COLOR=$_GET['COLOR'];
		$CRITICIDAD=strtoupper($_GET['CRITICIDAD']);
		$OLDCRITICIDAD=$_GET['OLDCRITICIDAD'];
		$IND_INCIDENTE=strtoupper($_GET['IND_INCIDENTE']);
		$IND_SOLUCION=strtoupper($_GET['IND_SOLUCION']);
		$REPORT=$_GET['REPORT'];
		$SW=$_GET['SW'];
		$USERNAME=strtoupper($_GET['USERNAME']);
		$FAENA=strtoupper($_GET['FAENA']);
		
		if ($OLDCRITICIDAD < $CRITICIDAD){
			$sts = 3;
		}else if($OLDCRITICIDAD = $CRITICIDAD){
			$sts = 2;
		}else{
			$sts = 1;
		}
		
		//echo $CRITICIDAD . ' <-> '  . $OLDCRITICIDAD . ' <-> ' . $sts;
		
		$file = "list_Bitacoras.xml";
		$fp = fopen($file, "rb") or die("cannot open file");
		$str = fread($fp, filesize($file));
	
		$xml = new DOMDocument();
		$xml->formatOutput = true;
		$xml->preserveWhiteSpace = false;
		$xml->load($file);
		
		// original
		//echo "<xmp>OLD:\n".  ."</xmp>";
		$xml->saveXML();

		$root   = $xml->documentElement;
		$xpath = new DOMXpath($xml);
		$nodeList = $xpath->query('//ROW[ID="'.$ID.'"]');
		
		$Nr     = $xml->createElement("FECHA", str_replace('/', '-',$FECHA));
		$Yr     = $xml->createElement("DESCRIPCION", utf8_encode($DESCRIPCION));
		$Ir     = $xml->createElement("IND_INCIDENTE", $IND_INCIDENTE);
		$Pr     = $xml->createElement("EQUIPO", $EQUIPO);
		$Br     = $xml->createElement("REPORT", $REPORT);
		$Dr     = $xml->createElement("COLOR", $COLOR);
		$TYr     = $xml->createElement("ULT_INSPECCION", $ULT_INSPECCION);
		$Lr     = $xml->createElement("CRITICIDAD", $CRITICIDAD);
		$Fr     = $xml->createElement("CAUSA", utf8_encode($CAUSA));
		$Kr     = $xml->createElement("RECOMENDACION", utf8_encode($RECOMENDACION));
		$Gr     = $xml->createElement("IND_SOLUCION", $IND_SOLUCION);
		$OPr     = $xml->createElement("OP", "UPD");
		
		$x = $nodeList->item(0);
		$x->childNodes->item(2)->parentNode->replaceChild($Nr, $x->childNodes->item(2));
		$x->childNodes->item(5)->parentNode->replaceChild($Yr, $x->childNodes->item(5));
		$x->childNodes->item(7)->parentNode->replaceChild($Ir, $x->childNodes->item(7));
		$x->childNodes->item(9)->parentNode->replaceChild($Pr, $x->childNodes->item(9));
		$x->childNodes->item(12)->parentNode->replaceChild($Dr, $x->childNodes->item(12));
		$x->childNodes->item(13)->parentNode->replaceChild($Fr, $x->childNodes->item(13));
		$x->childNodes->item(14)->parentNode->replaceChild($Gr, $x->childNodes->item(14));
		$x->childNodes->item(17)->parentNode->replaceChild($Kr, $x->childNodes->item(17));
		$x->childNodes->item(18)->parentNode->replaceChild($Lr, $x->childNodes->item(18));
		$x->childNodes->item(26)->parentNode->replaceChild($Br, $x->childNodes->item(25));
		$x->childNodes->item(33)->parentNode->replaceChild($TYr, $x->childNodes->item(33));
		$x->childNodes->item(37)->parentNode->replaceChild($OPr, $x->childNodes->item(37));

		$xml->save("list_Bitacoras.xml");
		$xml->saveXML();
		
		if ($sts == 2 || $sts == 3 || $IND_SOLUCION == 'TRUE'){
			$file = "list_historial.xml";
			$fp = fopen($file, "rb") or die("cannot open file");
			$str = fread($fp, filesize($file));
		
			$xml = new DOMDocument();
			$xml->formatOutput = true;
			$xml->preserveWhiteSpace = false;
			$xml->load($file);
			
			switch ($sts) {
				case 1:
					$textsts = "DISMINUYE CRITICIDAD";
					break;
				case 2:
					$textsts =  "SE MANTIENE CONDICION";
					break;
				case 3:
					$textsts =  "AUMENTA CRITICIDAD";
					break;
				case 4:
					$textsts =  "NO SE REALIZA INSPECCION";
					break;					
			}
			$ULT_INSPECCIONx = str_replace('/', '-',$ULT_INSPECCION);

			//$xml->saveXML();
			$root   = $xml->documentElement;
			$xpath = new DOMXpath($xml);
			$nodeList = $xpath->query("//ROWS[ID=".$ID." and STATUS='".$textsts."'  and  FECHA='".$ULT_INSPECCIONx."']");
			//$nodeList = $xpath->query("//ROWS[FECHA='".$ULT_INSPECCIONx."']");
						
			//$node = $nodeList->item(0)->$node;
			//$data->item(0)->nodeValue = $ULT_MOD_OBS;
			
			if ($IND_SOLUCION == 'TRUE'){
				$sts == 1;
			}

			//echo "//ROWS[ID=".$ID." and STATUS='".$textsts."'  and  FECHA='".$ULT_INSPECCIONx."']";
			if ($nodeList->length == 0) {
				$root   = $xml->documentElement;
				$xpathx = new DOMXpath($xml);
				foreach ($xpathx->evaluate('//ROWS[last()]') as $listingx) {
					$orix = $xpathx->evaluate('string(NRO)', $listingx);
					$orit = $orix + 1;
				}
				
			
				$nro     = $xml->createElement("NRO");
				$nroText = $xml->createTextNode($orit);
				$nro->appendChild($nroText);
				
				$id     = $xml->createElement("ID");
				$idText = $xml->createTextNode($ID);
				$id->appendChild($idText);
			
				$insp     = $xml->createElement("INSPECTOR");
				$inspText = $xml->createTextNode($USERNAME);
				$insp->appendChild($inspText);
				
				if ($ULT_INSPECCIONx == ''){
					$ULT_INSPECCIONx = date("d-m-Y");
				}
				$fech     = $xml->createElement("FECHA");
				$fechText = $xml->createTextNode($ULT_INSPECCIONx);
				$fech->appendChild($fechText);
				
				switch ($sts) {
					case 1:
						$textsts = "DISMINUYE CRITICIDAD";
						break;
					case 2:
						$textsts =  "SE MANTIENE CONDICION";
						break;
					case 3:
						$textsts =  "AUMENTA CRITICIDAD";
						break;
					case 4:
						$textsts =  "NO SE REALIZA INSPECCION";
						break;					
				}
	
		  
				$stat     = $xml->createElement("STATUS");
				$statText = $xml->createTextNode($textsts);
				$stat->appendChild($statText);
			
				$op     = $xml->createElement("OP");
				$opText = $xml->createTextNode("ING");
				$op->appendChild($opText);
			
				$book   = $xml->createElement("ROWS");
				$book->appendChild($nro);
				$book->appendChild($id);
				$book->appendChild($insp);
				$book->appendChild($fech);
				$book->appendChild($stat);
				$book->appendChild($op);			
				
				$root->appendChild($book);
			
				$xml->save("list_historial.xml");
				$xml->saveXML();
			}

		}
		
				
		$SRT = "<REGISTROS><ID>OK</ID></REGISTROS>";
		Header('Content-type: text/xml');
		print($SRT);
	}
?>