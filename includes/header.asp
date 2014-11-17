<!--#include virtual="/includes/libgeneral.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="js/prototype.js"></script>
<script type="text/javascript" src="js/scriptaculous.js?load=effects,builder"></script>
<script type="text/javascript" src="js/lightbox.js"></script>


<link rel="stylesheet" href="css/lightbox.css" type="text/css" media="screen" />
<title><%=page_title%> - <%=default_page_title%></title>
<link rel="stylesheet" href="css/Site.css" type="text/css" />
<meta name="keywords" content="<%=page_keywords%>">
<meta name="description" content="<%=page_description%>">
<META http-equiv="expires" content="<%=now()-1%>">

<% if InStr(mylocation,"admin") then %>
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "../htmlarea/";           // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>
<% end if %>
<script type="text/javascript" SRC="/includes/javascript.js"></SCRIPT>

</head>
<%
If session("verified")="true" Then
	Response.Buffer = False
End if

If current_server="development" Then
	response.write("<p align='center'><font color='white'>THIS IS A TESTING ONLY SERVER</font></p>")
	Response.Buffer = False
End If

if session("verified") = "true" and InStr(mylocation, "admin")=false Then
	response.write("<table bgcolor='white' align='center' cellpadding='5' cellspacing='0' border='1'><tr><td><p align='center'>You are logged in as " & session("username") & "<br><br><font style='font-size:120%'><a href='/admin_changecontent.asp?action=showpage&page_id=" & page_id & "&pagename=" & mylocation & "'>EDIT THIS PAGE</a> | <a href='/admin_changecontent.asp?action=logout'>LOGOUT</a></p></td></tr></table><br>")		
end if 
%>
<body>
<%=GetHeaderImage%>
<% If instr(mylocation,"admin") = 1 Then %>
<% else %>
<%
response.write("<h1>" & page_heading & "</h1>")
%><% End if %><!--end of header-->