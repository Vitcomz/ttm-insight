<%@ Page Language="C#" ContentType="text/javascript" %>


// top search

function doSearch(sender, args)
{
	window.location.href = args.get_item().get_value();
}

function clearSearch()
{
	var searchBox = document.getElementById("searchBox");
	if (searchBox.value == "Search examples")
	{
		searchBox.value = "";
	}
}


// expand, collapse examples

function toggleDisplay(blockId, titleId)
{
	var block = document.getElementById(blockId);
	var title = document.getElementById(titleId);
	if (block.className.indexOf("qsfNone") == -1)
	{
		block.className = block.className + " qsfNone";
		title.className = "qsfSubtitleCollapsed";
	}
	else
	{
		block.className = block.className.replace(/qsfNone/, "");
		title.className = "qsfSubtitle";
	}
	return false;
}

// Customer Skins thumb container width adjuster

function setThumbTableWidth()
{
	var skinChooserTable = $get(SkinChooserTableID);
	if (skinChooserTable.clientWidth != qsfClientSkinsWidth)
	{
		qsfClientSkinsWidth = skinChooserTable.clientWidth;
		var qsfClientSkinsTable = $get("qsfClientSkins");
		qsfClientSkinsTable.style.width = qsfClientSkinsWidth + "px";
		$get(CustomerSkinsThumbID).style.zoom = 1;
		qsfClientSkinsTable.style.zoom = 1;
		window.setTimeout("setThumbTableWidth()", 2000);
	}
}

// demo thumbnails slider

function InitDemoSlider(sender, eventArgs)
{
	var sliderId = sender.get_id();
	eval("initialValue_" + sliderId + " = sender.get_minimumValue() + 10;");
	
	HandleClientValueChange(sender, null);
}

function HandleClientValueChange(sender, eventArgs)
{
	var sliderId = sender.get_id();
	
	var wrapper = document.getElementById(sliderId + "_wrapper");
	var content = document.getElementById(sliderId + "_content");

	var oldValue = (eventArgs) ? eventArgs.get_oldValue() : (sender.get_minimumValue() + 10);
	var change = sender.get_value() - oldValue;

	var contentWidth = content.scrollWidth - wrapper.offsetWidth;
	var calculatedChangeStep = contentWidth / (((sender.get_maximumValue() - 10) - (sender.get_minimumValue() + 10)) / sender.get_slideStep());

	eval("initialValue_" + sliderId + " = initialValue_" + sliderId + " - change * calculatedChangeStep;");

	eval("content.style.left = initialValue_" + sliderId + " + 'px';");
	
	if (sender.get_value() == (sender.get_minimumValue() + 10))
	{
		eval("content.style.left = 0;");
	}
}

function OnClientBeforeValueChange(sender, args)
{
    // In order for the dragHandle of the slider to never leave the track, 
    // the values from -1 to -10 and from 101 and 110 are not valid values.
    var newValue = args.get_newValue();
    if(newValue < 0)
    {
        args.set_cancel(true);
        sender.set_value(0);
    }
    else if(newValue > 100)
    {
        args.set_cancel(true);
        sender.set_value(100);
    }
}

function slideConfig(uniqudId,dir)
{
	if (!uniqudId) { return; }
	
    var opposite = (dir == 'Down' ? 'Up' : 'Down');
    
    $telerik.$(".bigModuleContent")["slide" + dir](300);
    $telerik.$(".bigModuleCollapsible span.configButton")
		.removeClass("toggleUp")
		.removeClass("toggleDown")
		.addClass("toggle" + opposite);
		
    $telerik.$(".bigModuleCollapsible")[0].href = "javascript:slideConfig('" + uniqudId + "','" + opposite + "');";
    $telerik.$("input[name='" + uniqudId + "']").val(dir == "Down" ? "true" : "false");
}

function openInNewWindow(a)
{
	window.open(a.href, "_blank");	
	return false;
}

window.onload =  (function () {
	var resetNotice = $get('qsfDbResetNotice');
	
	if (resetNotice) {
		var timeout = resetNotice.getElementsByTagName("strong")[0];


		
		var remainingTime = {
			h: /(\d+) hour/gi,
			m: /(\d+) minute/gi,
			s: /(\d+) second/gi
		};
		
		var initialValue = timeout.firstChild.nodeValue;


		
		remainingTime.h = remainingTime.h.exec(initialValue);
		remainingTime.m = remainingTime.m.exec(initialValue);
		remainingTime.s = remainingTime.s.exec(initialValue);
		
		for (var i in remainingTime) { remainingTime[i] = remainingTime[i] ? remainingTime[i][1] : 0 }

		
		var tickInterval = null;

		
		var tick = function () {
		
			var timeFormatter = [];
			
			--remainingTime.s;
			
			if (remainingTime.s < 0) {
				--remainingTime.m;
				
				if (remainingTime.m < 0) {
					--remainingTime.h;
					
					if (remainingTime.h < 0) {
						clearInterval (tickInterval);
						window.location.href = window.location.href;
						return;
					}
					
					remainingTime.m = 59;
				}
					
				remainingTime.s = 59;








			}
			
			if (remainingTime.h > 0) {
				timeFormatter[timeFormatter.length] = remainingTime.h;
				timeFormatter[timeFormatter.length] = remainingTime.h > 1 ? " hours, " : " hour, ";
			}
			
			if (remainingTime.m > 0) {
				timeFormatter[timeFormatter.length] = remainingTime.m;
				timeFormatter[timeFormatter.length] = remainingTime.m > 1 ? " minutes, " : " minute, ";
			}
					
			timeFormatter[timeFormatter.length] = remainingTime.s;
			timeFormatter[timeFormatter.length] = remainingTime.s > 1 ? " seconds" : " second";
			
			timeout.innerHTML = timeFormatter.join("");
		};
		
		tickInterval = setInterval (tick, 1000);


	}
});


