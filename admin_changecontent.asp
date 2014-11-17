<!--#include virtual="includes/header.asp"-->
<%
response.write page_content
%>
<h1>Administration Tools</h1>
<a href="admin_default.asp">Admin Home</a>
<%

if session("verified") <> "true" then
	response.clear
	response.redirect "admin_default.asp"
end if

select case request.querystring("action")
case "default"
	response.write(" > Content Manager<br><br>")
	ShowDefaultSummary
case "showpage"
	response.write(" > <a href='?action=default'>Content Manager</a> > " & request.querystring("pagename") & "<br><br>")
	ShowPageEditor
case "savepage"
	SavePage
case "logout"
	Logout
case "showusers"
	response.write(" > User Manager<br><br>")
	ShowUsers
case "saveusers"
	SaveUsers
case "adduser"
	AddUser
case "deletepage"
	DeletePage
case "addpage"
	AddPage
case "tips_show"
	response.write(" > Dental Tips<br><br>")
	ShowDentalTips
case "tips_edit"
	response.write(" > Edit a Dental Tip<br><br>")
	EditTip
case "tips_save"
	SaveTip
case "tips_delete"
	Tips_delete
case "tips_add"
	Tips_Add
case "testimonials_show"
	response.write(" > Testimonials<br><br>")
	Testimonials_Show
case "testimonials_edit"
	response.write(" > Edit a Testimonial<br><br>")
	Testimonials_Edit
case "testimonials_save"
	Testimonials_Save
case "testimonials_delete"
	Testimonials_Delete
case "testimonials_add"
	Testimonials_add
case "addpics_form"
	response.write(" > <a href='?action=addpics_viewall'>Picture Manager</a> > Add New Picture<br><br>")
	Addpics_form
case "addpics_invalid"
	response.write(" > Picture Manager<br><br>")
	AddPics_invalid
case "addpics_viewall"
	response.write(" > Picture Manager<br><br>")
	AddPics_view
case "addpics_edit"
	response.write(" > <a href='?action=addpics_viewall'>Picture Manager</a> > Edit<br><br>")
	AddPics_Edit
case "addpics_delete"
	AddPics_Delete
case "addpics_update"
	AddPics_Update
case else
	response.clear
	response.redirect "admin_default.asp"
end select

Private Function ShowUsers
	if session("username") <> "webmaster" then
		response.clear
		response.redirect "admin_Changecontent.asp"
	end if
	Dim objResults, objResultsRS
	Set objResults = Server.CreateObject("ADODB.Command")
	Set objResults.ActiveConnection = m_objDBConnection
	objResults.CommandText = "admin_users_get"
	objResults.CommandType = adCmdStoredProc
	Set objResultsRS=objResults.Execute
	if not objResultsRS.eof then
		response.write("<br><table border='1' cellpadding='5' cellspacing='0' bordercolorlight='black' bordercolordark='white'>")
		do while not objResultsRS.eof
			response.write("<form method='post' action='admin_Changecontent.asp?action=saveusers'><tr>")
			response.write("<td><input type='text' value='" & objResultsRS.fields("username") & "' name='username'></td>")
			response.write("<td><input type='text' value='" & objResultsRS("password") & "' name='password'></td>")
			response.write("<td><input type='hidden' value='" & objResultsRS("id") & "' name='id'><input type='submit' value='save'></td>")
			response.write("</tr></form>")
			objResultsRS.movenext
		loop
		response.write("<form method='post' action='admin_Changecontent.asp?action=adduser'><tr>")
		response.write("<td><input type='text' name='username'></td>")
		response.write("<td><input type='text' name='password'></td>")
		response.write("<td><input type='submit' value='add'></td>")
		response.write("</tr></form>")
		response.write("</table>")
	end if
End Function

Private Function AddUser
	if session("username") <> "webmaster" then
		response.clear
		response.redirect "admin_Changecontent.asp"
	end if
	if trim(request.form("username")) <> "" and trim(request.form("password")) <> "" then
		Dim objResults, objResultsRS, id
		Set objResults = Server.CreateObject("ADODB.Command")
		Set objResults.ActiveConnection = m_objDBConnection
		objResults.CommandText = "admin_users_add"
		objResults.CommandType = adCmdStoredProc
		objResults.Parameters.Append objResults.CreateParameter("username", adVarChar, adParamInput, 50, request.form("username"))
		objResults.Parameters.Append objResults.CreateParameter("password", adVarChar, adParamInput, 50, request.form("password"))
		objResults.Execute
	end if
	response.clear
	response.redirect("admin_Changecontent.asp?action=showusers")
End Function

Private Function SaveUsers
	if session("username") <> "webmaster" then
		response.clear
		response.redirect "admin_Changecontent.asp"
	end if
	Dim objResults, objResultsRS, id
	Set objResults = Server.CreateObject("ADODB.Command")
	Set objResults.ActiveConnection = m_objDBConnection
	objResults.CommandText = "admin_users_save"
	objResults.CommandType = adCmdStoredProc
	objResults.Parameters.Append objResults.CreateParameter("id", adInteger, adParamInput, ,request.form("id"))
	objResults.Parameters.Append objResults.CreateParameter("username", adVarChar, adParamInput, 50, request.form("username"))
	objResults.Parameters.Append objResults.CreateParameter("password", adVarChar, adParamInput, 50, request.form("password"))
	objResults.Execute
	response.clear
	response.redirect("admin_Changecontent.asp?action=showusers")
End Function

Private Function DeletePage
	if session("username") <> "webmaster" then
		response.clear
		response.redirect "admin_Changecontent.asp"
	end if
	Dim objResults, objResultsRS, id
	Set objResults = Server.CreateObject("ADODB.Command")
	Set objResults.ActiveConnection = m_objDBConnection
	objResults.CommandText = "admin_page_delete"
	objResults.CommandType = adCmdStoredProc
	objResults.Parameters.Append objResults.CreateParameter("page_id", adInteger, adParamInput, ,request.querystring("page_id"))
	objResults.Execute
	response.clear
	response.redirect "admin_Changecontent.asp?action=default"
End Function

Private Function Logout
	session("verified")=""
	response.clear
	response.redirect "default.asp"
End Function

Private Function ShowDefaultSummary
	'id, filename(50), title(50), keywords(100), description(200), header(50), content(2000)
	Dim objResults, objResultsRS
	Dim daysago, fontsize, fontcolor
	Set objResults = Server.CreateObject("ADODB.Command")
	Set objResults.ActiveConnection = m_objDBConnection
	objResults.CommandText = "admin_cmgr_summary"
	objResults.CommandType = adCmdStoredProc
	Set objResultsRS=objResults.Execute
	if not objResultsRS.eof then
		%><p>Select a page to change below:</p>
		<table cellpadding="5" cellspacing="0" bordercolordark="white" bordercolorlight="black" border="1" width="100%">
		<tr>
		<td bgcolor="silver">title</td><td bgcolor=silver>last updated</td><td bgcolor=silver>action</td>
		</tr>
		<%
		do while not objResultsRS.eof
			response.write("<tr>")
			response.write("<td width='100%'><font style='font-size:100%'>" & objResultsRS("page_title") & " <font style='font-size:80%;'> - (" & objResultsRS("page_filename") & ")</font></td>")
			%>
			<td nowrap>
			<%
			fontsize="100"
			daysago=Trim(DateDiff("d", objResultsRS("last_updated"), now()))
			If isnumeric(daysago) And daysago > 1  Then
				fontcolor="black"
				response.write("<font style='color:" & fontcolor & ";font-size:" & fontsize & "%'>" & daysago & " days ago</font>")
			Else
				response.write("<font color='green'>today")
			End if
			%>
			</td>
			<td nowrap><font style="font-size:100%"><a href='admin_Changecontent.asp?action=showpage&page_id=<%=objResultsRS("page_id")%>&pagename=<%=objResultsRS("page_filename")%>'>edit</a> | <a href='/<%=objResultsRS("page_filename")%>'>view</a>
			<%
			if session("username")="webmaster" then
				%>
				| <a href="?action=deletepage&page_id=<%=objResultsRS("page_id")%>" onclick="return confirm( 'Are you sure you want to delete this page?  This process CANNOT be reversed! \n\n\t\tYou will LOSE this page content!')">delete</a>
				<%
			end if
			response.write("</tr>")
			objResultsRS.MoveNext
		loop
		if session("username")="webmaster" then
			%>
			<form method="post" action="admin_Changecontent.asp?action=addpage">
			<tr>
				<td colspan='3'><input type="text" name="page_filename"><input type="submit" value="add"></td>
			</tr>
			<%
		end if
		response.write("</table>")
	Else
		response.clear
		response.redirect "?action=default"
	End if
End Function

Private Function AddPage
	if session("username") <> "webmaster" then
		response.clear
		response.redirect "admin_Changecontent.asp"
	end if
	Dim objResults, objResultsRS, id, content, heading
	content="We apologize while we rebuild this page.  Please come back again soon."
	heading="Coming Soon"
	Set objResults = Server.CreateObject("ADODB.Command")
	Set objResults.ActiveConnection = m_objDBConnection
	objResults.CommandText = "admin_page_add"
	objResults.CommandType = adCmdStoredProc
	objResults.Parameters.Append objResults.CreateParameter("page_filename", adVarChar, adParamInput, 50,request.form("page_filename"))
	objResults.Parameters.Append objResults.CreateParameter("page_content", adVarChar, adParamInput, 500,content)
	objResults.Parameters.Append objResults.CreateParameter("page_heading", adVarChar, adParamInput, 50,heading)
	
	objResults.Execute
	response.clear
	response.redirect "admin_Changecontent.asp?action=default"
End Function



Private Function ShowPageEditor
	'dim useragent
	'UserAgent = Request.ServerVariables("HTTP_USER_AGENT")
	'if instr(1,UserAgent,"MSIE") > 0 then
		'id, filename(50), title(50), keywords(100), description(200), header(50), content(2000)
		Dim objResults, objResultsRS
		Set objResults = Server.CreateObject("ADODB.Command")
		Set objResults.ActiveConnection = m_objDBConnection
		objResults.CommandText = "admin_cmgr_getpage"
		objResults.CommandType = adCmdStoredProc
		objResults.Parameters.Append objResults.CreateParameter("page_id", adinteger, adParamInput, , request.querystring("page_id"))
		Set objResultsRS=objResults.Execute
		if not objResultsRS.eof then
			'columns:
			'page_id, page_filename, page_title, page_keywords, page_description, page_heading, page_content, last_updated
			%>
			<form method=post action="admin_Changecontent.asp?action=savepage&id=<%=request.querystring("page_id")%>">
			<table width="100%" bordercolorlight="silver" bordercolordark="white" border="1" cellpadding="4" cellspacing="0">
				<tr>
					<td colspan="3"><b><%=objResultsRS("page_filename")%></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="save"> &nbsp;<input type="button" value="cancel" onclick="javascript:window.location='admin_Changecontent.asp'"> &nbsp;<input type="button" value="preview" onclick="window.open('/<%=objResultsRS("page_filename")%>')"></td>
				</tr>
				<tr>
					<td nowrap valign="top">
						page title:
					</td>
					<td width="50%" valign="top">
						<input type="text" name="page_title" value="<%=objResultsRS("page_title")%>" size="50" maxlength="50">
					</td>
					<td width="50%" valign="top" align='left'>
						<font color="blue" size="1"><b>Tip:</b> The page title is what appears in your taskbar on the "Internet Explorer" window.  Its important for search engines and for classifying your site correctly.
					</td>
				</tr>
				<tr>
					<td nowrap valign="top">
						page keywords:
					</td>
					<td width="50%" valign="top">
						<input type="text" name="page_keywords" value="<%=objResultsRS("page_keywords")%>" size="50" maxlength="100">
					</td>
					<td width="50%" valign="top" align='left'>
						<font color="blue" size="1"><b>Tip:</b> Page keywords are extremely important for proper search engine results.  Enter keywords that correctly represent this specific page and its contents.  Seperate keywords with commas.  Try to use keywords extracted from the content of this page.
					</td>
				</tr>
				<tr>
					<td nowrap valign="top">
						page description:
					</td>
					<td width="50%" valign="top">
						<input type="text" name="page_description" value="<%=objResultsRS("page_description")%>" size="50" maxlength="200">
					</td>
					<td width="50%" valign="top" align='left'>
						<font color="blue" size="1"><b>Tip:</b> The page description is just like the page keywords and are extremely important for proper search engine results.  Enter a short description that specifically represents this page and what its about.
					</td>
				</tr>
				<tr>
					<td nowrap valign="top">
						page heading:
					</td>
					<td width="50%" valign="top">
						<input type="text" name="page_heading" value="<%=objResultsRS("page_heading")%>" size="50" maxlength="50">
					</td>
					<td width="50%" valign="top" align='left'>
						<font color="blue" size="1"><b>Tip:</b> This will show up as the heading of the page below the main toolbar and above the page content.  Be careful about changing this from its current value
					</td>
				</tr>
				<tr>
					<td nowrap valign="top">
						page content:
					</td>
					<td width="50%" valign="top" colspan="2" bgcolor='silver'>
						<textarea name="page_content" rows="20" cols="65"><%=objResultsRS("page_content")%></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						This page was last updated <%=objResultsRS("last_updated")%>.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="save"> &nbsp;<input type="button" value="cancel" onclick="javascript:window.location='admin_Changecontent.asp'"> &nbsp;<input type="button" value="preview" onclick="window.open('/<%=objResultsRS("page_filename")%>')">
						<br>
					</td>
				</tr>
			</table>

			<script language="javascript1.2">
				var config = new Object();    // create new config object

				config.width = "100%";
				config.height = "500px";
				config.debug = 0;

				// NOTE:  You can remove any of these blocks and use the default config!

				config.toolbar = [
					['fontsize', 'justifyleft','justifycenter','justifyright','separator'],
					['OrderedList','UnOrderedList','Outdent','Indent','separator'],
					['HorizontalRule','Createlink','separator', 'InsertImage','Bold', 'InsertTable', 'htmlmode'],
				];

				config.fontsizes = {
					"Normal font size": "2",
					"Medium font size":"3",
					"Large font size": "4"
				  };

				editor_generate('page_content',config);
			</script>
			<input type="hidden" value="<%=Trim(objResultsRS("page_filename"))%>" name="page_filename">
			</form>
			<%
		End if
	'Else
	'	response.write("<p align='center'><font style='font-size:170%' color='red'><b>PLEASE USE INTERNET EXPLORER FOR EDITING THIS PAGE</b></font>")
	'end If
End Function

Private Function SavePage
	'page_id, page_filename, page_title, page_keywords, page_description, page_heading, page_content, last_updated
	Dim objResults, objResultsRS, page_content
	page_content=request.form("page_content")
	Set objResults = Server.CreateObject("ADODB.Command")
	Set objResults.ActiveConnection = m_objDBConnection
	objResults.CommandText = "admin_cmgr_savepage"
	objResults.CommandType = adCmdStoredProc
	objResults.Parameters.Append objResults.CreateParameter("page_id", adInteger, adParamInput, , request.querystring("id"))
	objResults.Parameters.Append objResults.CreateParameter("page_title", adVarChar, adParamInput, 50, request.form("page_title"))
	objResults.Parameters.Append objResults.CreateParameter("page_keywords", adVarChar, adParamInput, 100, request.form("page_keywords"))
	objResults.Parameters.Append objResults.CreateParameter("page_description", adVarChar, adParamInput, 200, request.form("page_description"))
	objResults.Parameters.Append objResults.CreateParameter("page_heading", adVarChar, adParamInput, 50, request.form("page_heading"))
	objResults.Parameters.Append objResults.CreateParameter("page_content", adLongVarChar, adParamInput, 300000, page_content)
	objResults.Execute
	response.clear
	response.redirect (request.Form("page_filename"))
End Function

%>
<br><br>
<!--#include virtual="includes/footer.asp"-->