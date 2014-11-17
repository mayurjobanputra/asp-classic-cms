<%
Private Function IsGoLive
	Dim objResults, objResultsRS, golive
	Set objResults = Server.CreateObject("ADODB.Command")
	Set objResults.ActiveConnection = m_objDBConnection
	objResults.CommandText = "golive_get"
	objResults.CommandType = adCmdStoredProc
	Set objResultsRS=objResults.Execute
	golive=objResultsRS("decision")
	If golive=1 Then
		IsGoLive=True
	Else
		If session("PreLive") <> "" Then
			IsGoLive=True
		Else
			response.clear
			response.redirect "comingsoon.htm"
		End if
	End If
End Function

Private Function GetHeaderImage
	Select Case mylocation
	Case "default.asp"
		GetHeaderImage="<img src='/images/header.jpg' alt=''>"
	Case Else
		GetHeaderImage="<img src='/images/header.jpg' alt=''>"
	End Select
End Function




Private Function ConvertCamelCase (value)
	Dim i
	For i = 1 To Len(Trim(Value))
        ' If the character is uppercase, then insert a space before
        If Asc(Mid(Value, i, 1)) = Asc(UCase(Mid(Value, i, 1))) And i <> 1 Then
            ConvertCamelCase = ConvertCamelCase & " " & Mid(Value, i, 1)
        Else
            ConvertCamelCase = ConvertCamelCase & Mid(Value, i, 1)
        End If
    Next
	ConvertCamelCase=Replace(ConvertCamelCase, "And", "and")
	ConvertCamelCase=Replace(ConvertCamelCase, ".asp", "")
	ConvertCamelCase=Replace(ConvertCamelCase, "To", "to")
	ConvertCamelCase=Replace(ConvertCamelCase, "Not", "NOT")
	ConvertCamelCase=Replace(ConvertCamelCase, "F A Q", "FAQ")
End Function





Private Function stripHTML(strtext)
 dim arysplit,i,j, strOutput
 arysplit=split(strtext,"<span")
 
  if len(arysplit(0))>0 then j=1 else j=0

  for i=j to ubound(arysplit)
     if instr(arysplit(i),">") then
       arysplit(i)=mid(arysplit(i),instr(arysplit(i),">")+1)
     else
       arysplit(i)="<span" & arysplit(i)
     end if
  next

  strOutput = join(arysplit, "")
  strOutput = mid(strOutput, 2-j)
  strOutput = replace(strOutput,">",">")
  strOutput = replace(strOutput,"<","<")

  stripHTML = strOutput
End Function

Private Function ErrorCheckScript
	If Err.Number <> 0 Then
		dim errorbody
		errorbody="<p align='center'>An error occurred in the execution of this ASP page.<br><br><div align='center'><table cellpadding='5' cellspacing='0' border='1' bordercolordark='white' bordercolorlight='black'><tr><td colspan='2' bgcolor='#CCCCCC' align='center'><B>Page Error</B></td></tr><tr><td>Page</td><td>" & mylocation & "</td></tr><tr><td>Error Number</td><td>" & err.number & "</td></tr><tr><td>Error Description</td><td>" & err.description & "</td></tr><tr><td>Source</td><td>" & err.source & "</td></tr></table></div>"
		cdontsmail "you@you.com", "Page Error", errorbody
		response.clear
		response.write("An error occurred in the execution of this ASP page. The webmaster has been notified. Please continue to our <a href='/'>home page</a>")
	end if
End Function

Sub Shuffle (ByRef arrInput)
	'declare local variables:
	Dim arrIndices, iSize, x
	Dim arrOriginal
	
	'calculate size of given array:
	iSize = UBound(arrInput)+1
	
	'build array of random indices:
	arrIndices = RandomNoDuplicates(0, iSize-1, iSize)
	
	'copy:
	arrOriginal = CopyArray(arrInput)
	
	'shuffle:
	For x=0 To UBound(arrIndices)
		arrInput(x) = arrOriginal(arrIndices(x))
	Next
End Sub

Function CopyArray (arr)
	Dim result(), x
	ReDim result(UBound(arr))
	For x=0 To UBound(arr)
		If IsObject(arr(x)) Then
			Set result(x) = arr(x)
		Else  
			result(x) = arr(x)
		End If
	Next
	CopyArray = result
End Function

Function RandomNoDuplicates (iMin, iMax, iElements)
	'this function will return array with "iElements" elements, each of them is random
	'integer in the range "iMin"-"iMax", no duplicates.
	
	'make sure we won't have infinite loop:
	If (iMax-iMin+1)>iElements Then
		Exit Function
	End If
	
	'declare local variables:
	Dim RndArr(), x, curRand
	Dim iCount, arrValues()
	
	'build array of values:
	Redim arrValues(iMax-iMin)
	For x=iMin To iMax
		arrValues(x-iMin) = x
	Next
	
	'initialize array to return:
	Redim RndArr(iElements-1)
	
	'reset:
	For x=0 To UBound(RndArr)
		RndArr(x) = iMin-1
	Next
	
	'initialize random numbers generator engine:
	Randomize
	iCount=0
	
	'loop until the array is full:
	Do Until iCount>=iElements
		'create new random number:
		curRand = arrValues(CLng((Rnd*(iElements-1))+1)-1)
		
		'check if already has duplicate, put it in array if not
 		If Not(InArray(RndArr, curRand)) Then
			RndArr(iCount)=curRand
			iCount=iCount+1
		End If
		
		'maybe user gave up by now...
		If Not(Response.IsClientConnected) Then
			Exit Function
		End If
	Loop
	
	'assign the array as return value of the function:
	RandomNoDuplicates = RndArr
End Function
  
Function InArray(arr, val)
	Dim x
	InArray=True
	For x=0 To UBound(arr)
		If arr(x)=val Then
			Exit Function
		End If
 	Next
	InArray=False
End Function
%>