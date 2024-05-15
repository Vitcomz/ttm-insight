// JavaScript Document



//**************************
function logeo(){
	window.addEvent('domready', function(){
	   $('Ingresar').addEvent('click', function(evento){   
			var nuevoRequest = new Request({
				method: 'get', 
				url: '/sci/xml/usuarios.asp?RECURSO=ValidaPass&id=' + document.getElementById('TxtID').value+'&PASSWORD=' + document.getElementById('TxtPassWord').value+"&TIPO=CONFIABILIDAD",
				onSuccess: function(texto, xmlrespuesta){login(texto);},
				onFailure: function(){alert('Error!');}
		  }).send();
		  
	   });
	   
	   $('TxtPassWord').addEvent('keyup', function(evento){   
			var esIE=(document.all);
			var esNS=(document.layers);
			tecla=(esIE) ? event.keyCode : evento.which;
			if(tecla==13){
				var nuevoRequest = new Request({
				method: 'get', 
				url: '/sci/xml/usuarios.asp?RECURSO=ValidaPass&id=' + document.getElementById('TxtID').value+'&PASSWORD=' + document.getElementById('TxtPassWord').value+"&TIPO=CONFIABILIDAD",
				onSuccess: function(texto, xmlrespuesta){
						login(texto);
					},
				 onFailure: function(){alert('Error!');}
				 }).send();
			};
		  
	   });
	});
}
//**************************
function login(res2){
	DelSession(document.getElementById('TxtID').value);
	var rol = res2.substring(res2.indexOf('ROL')+4, res2.indexOf('ROL')+9);
	//alert(rol );
	if (res2){
		if (res2.indexOf('True')>0){
			CrearSession(document.getElementById('TxtID').value);
			crearRol(rol);
			this.location.href="intranet.html";
		}
		else{
			alert("Usuario o Password Invalidos!");
			formulario.TxtID.focus();
		}
	  }
}

function log_empresa(){
	switch (getEmpresa()) { 
		case 'EL ABRA - ESCORPION':
			url="Chart/layout.html";
			this.location.href=url;
  			break;
		case 'CODELCO NORTE':
			url='Chart/layout2.html';
			this.location.href=url;
			break;
		case 'ESCONDIDA':
		case 'COLLAHUASI':
		case 'QUEBRADA BLANCA':
		   url='Chart/newindexV2.html';
			this.location.href=url;
		   break; 
		case 'ANDINA': 
		case 'SPENCE': 
		case 'VALE BAYOVAR MINA': 
		case 'VALE BAYOVAR PUERTO': 
		   url='Chart/newindex.html';
			this.location.href=url;
		   break 
		default: 
		   url="Chart/newindexV2.html"; 
	} 

}

