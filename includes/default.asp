<!--#include virtual="includes/header.asp"-->

<script type="text/javascript" src="js/swfobject.js"></script>
		
		<script type="text/javascript">
			
			// JAVASCRIPT VARS
			// cache buster
			var cacheBuster = "?t=" + Date.parse(new Date());
			// stage dimensions		
			var stageW = "500";//"100%";
			var stageH = "250";//"100%";
			
			
			// ATTRIBUTES
			var attributes = {};
			attributes.id = 'FlabellComponent';
			attributes.name = 'FlabellComponent';

			// PARAMS
			var params = {};
			params.bgcolor = "#ffffff";
		    params.menu = "false";
		    params.scale = 'noScale';
		    params.wmode = "opaque";
		    params.allowfullscreen = "true";
		    params.allowScriptAccess = "always";			
			
			
			/* FLASH VARS */
			var flashvars = {};
			
			/// if commented / delete these lines, the component will take the stage dimensions defined 
			/// above in "JAVASCRIPT SECTIONS" section or those defined in the settings xml
		    flashvars.componentWidth = stageW;
			flashvars.componentHeight = stageH;
			
			/// path to the content folder(where the xml files, images or video are nested)
			/// if you want to use absolute paths(like "http://domain.com/images/....") then leave it empty("")			
			flashvars.pathToFiles = "banner/";
			
			// path to content XML
			flashvars.xmlPath = "xml/banner.xml";
			
			
			/** EMBED THE SWF**/
			swfobject.embedSWF("preview.swf"+cacheBuster, attributes.id, stageW, stageH, "9.0.124", "js/expressInstall.swf", flashvars, params, attributes);
			
		</script>
<div id="FlabellComponent">
					<p>In order to view this object you need Flash Player 9+ support!</p>
					<a href="http://www.adobe.com/go/getflashplayer">
						<img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player"/>
					</a>
				</div>


<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
var pageTracker = _gat._getTracker("UA-8571411-1");
pageTracker._trackPageview();
</script>
<%
response.write page_content
%><!--#include virtual="includes/footer.asp"-->