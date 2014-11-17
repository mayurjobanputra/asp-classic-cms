//*****************************************
// Blending Image Slide Show Script
//* www.dynamicdrive.com
//***********************************************

//specify interval between slide (in mili seconds)
var slidespeed=3000

//specify images
var slideimages=new Array("/images/picture1.jpg", "/images/picture2.jpg", "/images/picture3.jpg", "/images/picture4.jpg", "/images/picture5.jpg")

//specify corresponding links
var slidelinks=new Array("http://www.kneetai.com","http://www.kneetai.com","http://www.kneetai.com", "http://www.kneetai.com")

var newwindow=1 //open links in new window? 1=yes, 0=no

var imageholder=new Array()
var ie=document.all
for (i=0;i<slideimages.length;i++){
imageholder[i]=new Image()
imageholder[i].src=slideimages[i]
}

function gotoshow(){
if (newwindow)
window.open(slidelinks[whichlink])
else
window.location=slidelinks[whichlink]
}

//***********************************************
//* AnyLink Drop Down Menu
//* www.dynamicdrive.com
//***********************************************

//Contents for menu 1
var menu1=new Array()
menu1[0]='<a href="DI_WhyChooseHardwood.asp">Why Choose Hardwood</a>'
menu1[1]='<a href="DI_ProductRecommendations.asp">Getting Started</a>'
menu1[2]='<a href="DI_QualifyYourHome.asp">Solid & Engineered Hardwood</a>'


//Contents for menu 2
var menu2=new Array()
menu2[0]='<a href="DFC_AztecCollection.asp">Aztec Collection</a>'
menu2[1]='<a href="DFC_MayanSolidCollection.asp">Mayan Solid Collection</a>'
menu2[2]='<a href="DFC_MayanEngineeredCollection.asp">Mayan Engineered Collection</a>'
menu2[3]='<a href="DFC_VikingCollection.asp">Chester Collection</a>'
menu2[4]='<a href="DFC_NatureCollection.asp">UNO Mondo Collection</a>'
menu2[5]='<a href="DFC_MoldingsAndAccessories.asp">Jamaica, Scottsdale & Grand Prairie Collection</a>'
menu2[6]='<a href="IC_HardnessScale.asp">Solid Surface Collections</a>'


//Contents for menu 3
var menu3=new Array()
menu3[1]='<a href="IC_InstallationTipsforBambooClic.asp">Bamboo Fusion Clic/EcoClic (Float)</a>'
menu3[2]='<a href="IC_InstallationTipsforBambooT&G.asp">Bamboo Fusion T&G (Cleat/Glue)</a>'
menu3[3]='<a href="IC_InstallationTipsforHardwoodEngineered.asp">Hardwood Engineered (Nail/Cleat/Glue)</a>'
menu3[4]='<a href="IC_InstallationTipsforHardwoodFloat.asp">Hardwood Engineered (Float)</a>'
menu3[5]='<a href="IC_InstallationTipsforHardwoodSolid.asp">Hardwood Solid (Nail/Cleat)</a>'
menu3[6]='<a href="IC_MaintenanceTips.asp">Maintenance & Care</a>'
menu3[7]='<a href="IC_WhatToExpect.asp">Hardwood Expectations</a>'
menu3[11]='<a href="IC_Warranty.asp">Warranty</a>'


var menu4=new Array()
menu4[0]='<a href="ContactUs.asp">Enquiries & Distributor Locations</a>'
menu4[1]='<a href="FAQ.asp">FAQ</a>'

	

var menuwidth='200px' //default menu width
var menubgcolor='white'  //menu bgcolor
var disappeardelay=20  //menu disappear speed onMouseout (in miliseconds)
var hidemenu_onclick="yes" //hide menu when user clicks within menu?


//***********************************************
/////No further editting needed
//***********************************************

var ie4=document.all
var ns6=document.getElementById&&!document.all

if (ie4||ns6)
document.write('<div id="dropmenudiv" style="visibility:hidden;width:600px;background-color:'+menubgcolor+'" onMouseover="clearhidemenu()" onMouseout="dynamichide(event)"></div>')
//document.write('<div id="dropmenudiv" style="visibility:hidden;width:600'+menuwidth+';background-color:'+menubgcolor+'" onMouseover="clearhidemenu()" onMouseout="dynamichide(event)"></div>')

function getposOffset(what, offsettype){
var totaloffset=(offsettype=="left")? what.offsetLeft : what.offsetTop;
var parentEl=what.offsetParent;
while (parentEl!=null){
totaloffset=(offsettype=="left")? totaloffset+parentEl.offsetLeft : totaloffset+parentEl.offsetTop;
parentEl=parentEl.offsetParent;
}
return totaloffset;
}


function showhide(obj, e, visible, hidden, menuwidth){
if (ie4||ns6)
dropmenuobj.style.left=dropmenuobj.style.top="-500px"
if (menuwidth!=""){
dropmenuobj.widthobj=dropmenuobj.style
dropmenuobj.widthobj.width=menuwidth
}
if (e.type=="click" && obj.visibility==hidden || e.type=="mouseover")
obj.visibility=visible
else if (e.type=="click")
obj.visibility=hidden
}

function iecompattest(){
return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
}

function clearbrowseredge(obj, whichedge){
	var edgeoffset=0
	if (whichedge=="rightedge"){
		var windowedge=ie4 && !window.opera? iecompattest().scrollLeft+iecompattest().clientWidth-15 : window.pageXOffset+window.innerWidth-15
		dropmenuobj.contentmeasure=dropmenuobj.offsetWidth
		if (windowedge-dropmenuobj.x < dropmenuobj.contentmeasure)
			edgeoffset=dropmenuobj.contentmeasure-obj.offsetWidth
	}
	else{
		var topedge=ie4 && !window.opera? iecompattest().scrollTop : window.pageYOffset
		var windowedge=ie4 && !window.opera? iecompattest().scrollTop+iecompattest().clientHeight-15 : window.pageYOffset+window.innerHeight-18
		dropmenuobj.contentmeasure=dropmenuobj.offsetHeight
		if (windowedge-dropmenuobj.y < dropmenuobj.contentmeasure){ //move up?
			edgeoffset=dropmenuobj.contentmeasure+obj.offsetHeight
				if ((dropmenuobj.y-topedge)<dropmenuobj.contentmeasure) //up no good either?
					edgeoffset=dropmenuobj.y+obj.offsetHeight-topedge
		}
	}
	return edgeoffset
}

function populatemenu(what){
	if (ie4||ns6)
		dropmenuobj.innerHTML=what.join("")
	}


function dropdownmenu(obj, e, menucontents, menuwidth){
	if (window.event) event.cancelBubble=true
	else if (e.stopPropagation) e.stopPropagation()
	clearhidemenu()
	dropmenuobj=document.getElementById? document.getElementById("dropmenudiv") : dropmenudiv
	populatemenu(menucontents)

	if (ie4||ns6){
		showhide(dropmenuobj.style, e, "visible", "hidden", menuwidth)
		dropmenuobj.x=getposOffset(obj, "left")
		dropmenuobj.wrap="on"
		dropmenuobj.y=getposOffset(obj, "top")
		dropmenuobj.style.left=dropmenuobj.x-clearbrowseredge(obj, "rightedge")+"px"
		dropmenuobj.style.top=dropmenuobj.y-clearbrowseredge(obj, "bottomedge")+obj.offsetHeight+"px"
	}
	return clickreturnvalue()
}

function clickreturnvalue(){
if (ie4||ns6) return false
else return true
}

function contains_ns6(a, b) {
while (b.parentNode)
if ((b = b.parentNode) == a)
return true;
return false;
}

function dynamichide(e){
if (ie4&&!dropmenuobj.contains(e.toElement))
delayhidemenu()
else if (ns6&&e.currentTarget!= e.relatedTarget&& !contains_ns6(e.currentTarget, e.relatedTarget))
delayhidemenu()
}

function hidemenu(e){
if (typeof dropmenuobj!="undefined"){
if (ie4||ns6)
dropmenuobj.style.visibility="hidden"
}
}

function delayhidemenu(){
if (ie4||ns6)
delayhide=setTimeout("hidemenu()",disappeardelay)
}

function clearhidemenu(){
if (typeof delayhide!="undefined")
clearTimeout(delayhide)
}

if (hidemenu_onclick=="yes")
document.onclick=hidemenu


/***********************************************
* Namo Image Swapper for mouseovers
***********************************************/

function na_preload_img()
{ 
  var img_list = na_preload_img.arguments;
  if (document.preloadlist == null) 
    document.preloadlist = new Array();
  var top = document.preloadlist.length;
  for (var i=0; i < img_list.length-1; i++) {
    document.preloadlist[top+i] = new Image;
    document.preloadlist[top+i].src = img_list[i+1];
  } 
}

function na_change_img_src(name, nsdoc, rpath, preload)
{ 
  var img = eval((navigator.appName.indexOf('Netscape', 0) != -1) ? nsdoc+'.'+name : 'document.all.'+name);
  if (name == '')
    return;
  if (img) {
    img.altsrc = img.src;
    img.src    = rpath;
  } 
}

function na_restore_img_src(name, nsdoc)
{
  var img = eval((navigator.appName.indexOf('Netscape', 0) != -1) ? nsdoc+'.'+name : 'document.all.'+name);
  if (name == '')
    return;
  if (img && img.altsrc) {
    img.src    = img.altsrc;
    img.altsrc = null;
  } 
}


/***********************************************
* Custom JS for merging Namo and Dynamic Drive menu
***********************************************/

function dropdownmenucustommouseover(obj, e, menucontents, menuwidth, na_buttonname, na_documentname, na_image_on, na_returnvalue) {
	dropdownmenu(obj, e, menucontents, menuwidth)
	na_change_img_src(na_buttonname, na_documentname, na_image_on, na_returnvalue)
}

function dropdownmenucustommouseout(name, nsdoc){
	delayhidemenu()
	na_restore_img_src(name, nsdoc)
}
