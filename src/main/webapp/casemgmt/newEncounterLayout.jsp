<!-- 
/*
* 
* Copyright (c) 2001-2002. Centre for Research on Inner City Health, St. Michael's Hospital, Toronto. All Rights Reserved. *
* This software is published under the GPL GNU General Public License. 
* This program is free software; you can redistribute it and/or 
* modify it under the terms of the GNU General Public License 
* as published by the Free Software Foundation; either version 2 
* of the License, or (at your option) any later version. * 
* This program is distributed in the hope that it will be useful, 
* but WITHOUT ANY WARRANTY; without even the implied warranty of 
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
* GNU General Public License for more details. * * You should have received a copy of the GNU General Public License 
* along with this program; if not, write to the Free Software 
* Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. * 
* 
* <OSCAR TEAM>
* 
* This software was written for 
* Centre for Research on Inner City Health, St. Michael's Hospital, 
* Toronto, Ontario, Canada 
*/
 -->

<%@ include file="/casemgmt/taglibs.jsp" %>
<%@ page errorPage="/casemgmt/error.jsp" %>
<% if(session.getAttribute("userrole") == null )  response.sendRedirect("../logout.jsp"); %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%
    oscar.oscarEncounter.pageUtil.EctSessionBean bean = null;
    String beanName = "casemgmt_oscar_bean" + (String) request.getAttribute("demographicNo");
    bean=(oscar.oscarEncounter.pageUtil.EctSessionBean)request.getSession().getAttribute(beanName);
    
    pageContext.setAttribute("providerNo",bean.providerNo, pageContext.PAGE_SCOPE);
    org.oscarehr.casemgmt.model.CaseManagementNoteExt cme = new org.oscarehr.casemgmt.model.CaseManagementNoteExt();
%>

<%--<nested:define id="rowOneSize" name="caseManagementViewForm" property="ectWin.rowOneSize"/>
<nested:define id="rowTwoSize" name="caseManagementViewForm" property="ectWin.rowTwoSize"/>
--%>
<html:html locale="true">
  <head>  	<c:set var="ctx" value="${pageContext.request.contextPath}" scope="request"/>	
	<link rel="stylesheet" href="<c:out value="${ctx}"/>/css/casemgmt.css" type="text/css">
    <link rel="stylesheet" href="<c:out value="${ctx}"/>/oscarEncounter/encounterStyles.css" type="text/css">         
    <link rel="stylesheet" type="text/css" href="<c:out value="${ctx}"/>/css/print.css" media="print">
    <script src="<c:out value="${ctx}"/>/share/javascript/prototype.js" type="text/javascript"></script>
    <script src="<c:out value="${ctx}"/>/share/javascript/scriptaculous.js" type="text/javascript"></script>    

    <%-- for popup menu of forms --%>
    <script src="<c:out value="${ctx}"/>/share/javascript/popupmenu.js" type="text/javascript"></script>
    <script src="<c:out value="${ctx}"/>/share/javascript/menutility.js" type="text/javascript"></script>

    <!-- library for rounded elements -->
    <link rel="stylesheet" type="text/css" href="<c:out value="${ctx}/share/css/niftyCorners.css" />">
    <script type="text/javascript" src="<c:out value="${ctx}/share/javascript/nifty.js"/>"></script>
    
      <!-- calendar stylesheet -->
  <link rel="stylesheet" type="text/css" media="all" href="<c:out value="${ctx}"/>/share/calendar/calendar.css" title="win2k-cold-1">

  <!-- main calendar program -->
  <script type="text/javascript" src="<c:out value="${ctx}"/>/share/calendar/calendar.js"></script>

  <!-- language for the calendar -->
  <script type="text/javascript" src="<c:out value="${ctx}"/>/share/calendar/lang/<bean:message key="global.javascript.calendar"/>"></script>

  <!-- the following script defines the Calendar.setup helper function, which makes
       adding a calendar a matter of 1 or 2 lines of code. -->
  <script type="text/javascript" src="<c:out value="${ctx}"/>/share/calendar/calendar-setup.js"></script>
  
  <%--<!-- js implementation of markdown -->
  <script type="text/javascript" src="<c:out value="${ctx}/share/javascript/showdown.js"/>"></script>--%>
  
  <!-- js window size utility funcs since prototype's funcs are buggy in ie6 -->
  <script type="text/javascript" src="<c:out value="${ctx}/share/javascript/screen.js"/>"></script>

  <!-- scriptaculous based select box -->
  <script type="text/javascript" src="<c:out value="${ctx}/share/javascript/select.js"/>"></script>

  <!-- phr popups -->
  <script type="text/javascript" src="<c:out value="${ctx}/phr/phr.js"/>"></script>

  <!--js code for newCaseManagementView.jsp -->
  <script type="text/javascript" src="<c:out value="${ctx}/js/newCaseManagementView.js.jsp"/>"></script>
  
   <script src="<c:out value="${ctx}/js/jquery.js"/>"></script>
   <script>
     jQuery.noConflict();
   </script>
   
   <script>

   function makeElement(type, attributes) {
	   var element = document.createElement(type);
	   if (attributes != null) {
	     for (var i in attributes) {
	       element.setAttribute(i, attributes[i]);
	     }
	   }	   
	   return element;
	 }

   function insertAfter( referenceNode, newNode )
   {
       referenceNode.parentNode.insertBefore( newNode, referenceNode.nextSibling );
   }
   
   
   function addCppRow(rowNumber) {	   	
		if(!document.getElementById("divR" + rowNumber)) {
			var newDiv = makeElement('div',{'style':'width: 100%; height: 75px; margin-top: 0px; background-color: #FFFFFF;','id':'divR'+rowNumber});

			var i1 = makeElement('div',{'id':'divR' + rowNumber + 'I1','class':'topBox','style':'clear: left; float: left; width: 49%; margin-left: 3px;'});
			var i2 = makeElement('div',{'id':'divR' + rowNumber + 'I2','class':'topBox','style':'clear: right; float: right; width: 49%; margin-right: 3px;'});
			newDiv.appendChild(i1);
			newDiv.appendChild(i2);
			var prevRow = document.getElementById("divR"+(rowNumber-1));
			insertAfter(prevRow,newDiv);
		}	
   }

   function popColumn(url,div,params, navBar, navBarObj) {
	   params = "reloadURL=" + url + "&numToDisplay=6&cmd=" + params;

       var objAjax = new Ajax.Request (
                           url,
                           {
                               method: 'post',
                               postBody: params,
                               evalScripts: true,
                               /*onLoading: function() {
                                               $(div).update("<p>Loading ...<\/p>");
                                           }, */
                               onSuccess: function(request) {
                                             //  alert(request.responseText);
                                               //while( $(div).firstChild )
                                               //    $(div).removeChild($(div).firstChild);
                                               //alert("success " + div);
                                               $(div).update(request.responseText);

                                               if( $("leftColLoader") != null )
                                                   Element.remove("leftColLoader");

                                               if( $("rightColLoader") != null )
                                                   Element.remove("rightColLoader");


                                               //track ajax completions and display divs when last ajax call completes
                                               //navBarObj.display(navBar,div);
                                          },
                               onFailure: function(request) {
                                               $(div).innerHTML = "<h3>" + div + "</h3>Error: " + request.status;
                                           }
                           }

                     );
       };
   

       function addLeftNavDiv(name) {
    	   var div = document.createElement("div");
           div.className = "leftBox";
           div.style.display = "block";
           div.style.visiblity = "hidden";
           div.id = name;                
           $("leftNavBar").appendChild(div);
           
       }

       function addRightNavDiv(name) {
    	   var div = document.createElement("div");
           div.className = "leftBox";
           div.style.display = "block";
           div.style.visiblity = "hidden";
           div.id = name;                
           $("rightNavBar").appendChild(div);
           
       }

       function removeNavDiv(name) {
    	   var tmpEl = document.getElementById(name);          
           tmpEl.parentNode.removeChild(tmpEl);
       }
       

       function addPrintOption(name,bean) {
    	   var test1Str = "<img style=\"cursor: pointer;\" title=\"Print "+name+"\" id=\"img"+name+"\" alt=\"Print "+name+"\" onclick=\"return printInfo(this, 'extPrint"+name+"');\" src=\"" + ctx + "/oscarEncounter/graphics/printer.png\">&nbsp;"+name;
           jQuery("#printDateRow").before("<tr><td></td><td>" + test1Str + "</tr></tr>");           
           jQuery("form[name='caseManagementEntryForm']").append("<input name=\"extPrint"+name+"\" id=\"extPrint"+name+"\" value=\"false\" type=\"hidden\"/>");
           jQuery.ajax({ url: ctx+"/casemgmt/ExtPrintRegistry.do?method=register&name="+name+"&bean="+bean, async:false, success: function(data){               
           }});      
       }
       
       var appointmentNo = <%=request.getParameter("appointmentNo")%>;
      
   </script>
 
 	<oscar:customInterface section="cme"/>
  
    <style type="text/css">
        
        /*CPP Format */
        li.cpp {
            color: #000000;         
            font-family:arial,sans-serif;
        }
        
        /*Note format */
        div.newNote {
            color: #000000;         
            font-family:arial,sans-serif;
            font-size:0.8em;
            margin: 5px 0px 5px 5px;
            float:left;  
            width:98%;            
        }
        
        div.newNote pre {
            color: #000000;      
            font-family:arial,sans-serif;
            margin: 0px 3px 0px 3px;          
            width:100%; 
            clear:left;            
        }
        
        div.note {
            color: #000000;         
            font-family:arial,sans-serif;
            margin: 3px 0px 3px 5px;
            float:left;  
            width:98%;
        }
        
        div.note pre {
            color: #000000;      
            font-family:arial,sans-serif;
            margin: 0px 3px 0px 3px;          
            width:100%; 
            clear:left;
        }
       .sig {
            background-color:#CCCCFF;
            color: #000000;  
            width:100%;
            font-size:9px;
        }                
        
        .txtArea {
            font-family:arial,sans-serif; 
            font-size:1.0em;             
            width:99%; 
            rows:10; 
            overflow:hidden; 
            border:none; 
            font-family:arial,sans-serif;             
            margin: 0px 3px 0px 3px;
        }
      
        p.passwd {
            margin: 0px 3px 0px 3px;
        }
        
        /* span formatting for measurements div found in ajax call */
        span.measureCol1 {            
            float: left;
            width: 50px;            
        }
        
        span.measureCol2 {
            float: left;
            width: 55px;
        }
        
        span.measureCol3 {
            float: left;                        
        }
        
        .topLinks  {
            color: black;
            text-decoration:none;
            font-size:9px;                
        }
        
        .topLinkhover { 
            color: blue;
            text-decoration: underline;
        }
        
        /* formatting for navbar */               
        .links {
            color: blue;
            text-decoration:none;
            font-size:9px;
        }
        
        .linkhover { 
            color: black;
            text-decoration: underline;
        }
        
    /* template styles*/
          
          .enTemplate_name_auto_complete {
            width: 350px;
            background: #fff;
            font-size: 9px;
            text-align:left;
          }
          .enTemplate_name_auto_complete ul {
            border:1px solid #888;
            margin:0;
            padding:0;
            width:100%;
            list-style-type:square;
            list-style-position:inside;
          }
          .enTemplate_name_auto_complete ul li {
            margin:0;
            padding:3px;            
          }
          .enTemplate_name_auto_complete ul li.selected { 
            background-color: #ffb; 
            text-decoration: underline;
          }
          .enTemplate_name_auto_complete ul strong.highlight { 
            color: #800; 
            margin:0;
            padding:0;
          }


        /* CPP textareas */
        .rowOne {
            height: <%--<nested:write name="rowOneSize"/>--%>10px;
            width: 97%;
            overflow:auto;
        }
        
        .rowTwo {
            height: <%--<nested:write name="rowTwoSize"/>--%>10px;
            width:97%;
            margin-left:4px;            
            overflow:auto;
        }
        
        /* Encounter type select box */
        div.autocomplete {
          position:absolute;
          width:400px;
          background-color:white;
          border:1px solid #ccc;
          margin:0px;
          padding:0px;
          font-size:9px;
          text-align:left;
          max-height:200px;
          overflow:auto;
        }
        div.autocomplete ul {
          list-style-type:none;
          margin:0px;
          padding:0px;
        }
        div.autocomplete ul li.selected { 
          background-color: #EAF2FB;
        }
        div.autocomplete ul li {
          list-style-type:none;
          display:block;
          margin:0;
          padding:2px;
          cursor:pointer;
        }
        
        .encTypeCombo /* look&feel of scriptaculous select box*/
        {
          margin: 0px;/* 5px 10px 0px;*/
          font-family:Verdana, Geneva, Arial, Helvetica, sans-serif;
          font-size:9px;
          width: 200px;          
          text-align:left; 
          vertical-align: middle;
          background: #FFFFFF url('<c:out value="${ctx}"/>/images/downarrow_inv.gif') no-repeat right;
          height:18px;
          cursor: pointer;
          border:1px solid #ccc;
          color: #000000;
          
        }
        
        .printOps {                        
            background-color:#CCCCFF;
            font-size:9px;
                        
            position: absolute;
            display:none;
            z-index:1;
            width:200px;
            right:100px;
            bottom:200px;
        }
        
        .showEdContainer {        
            position: absolute;
            display:none;
            z-index:100;
            right:100px;
            bottom:200px;            
            background-color:transparent;
            font-size:8px;
            /*border: thin ridge black;*/
            text-align: center;
        }
        
        .showEdPosition { 
            display: table-cell;        
            vertical-align: middle;            
        }
        
        .showEdContent {            
            /*border: thin ridge black;*/
            background-color:#CCCCFF;
            font-size:9px;
                        
            position: absolute;
            display:none;
            z-index:200;
            right:100px;
            bottom:200px;                                    
            text-align: center;
        }
        
    </style>
<!--[if IE]>
    <style type=text/css>
    
        .showEdContent { 
            width:450px;
        }
     </style>
 <![endif]-->
    <html:base />
    <title><bean:message key="oscarEncounter.Index.title"/> - <oscar:nameage demographicNo="<%=(String) request.getAttribute(\"demographicNo\")%>"/></title>
    <script type="text/javascript">
            
        socHistoryLabel = "oscarEncounter.socHistory.title";
        medHistoryLabel = "oscarEncounter.medHistory.title";
        onGoingLabel = "oscarEncounter.onGoing.title";;
        remindersLabel = "oscarEncounter.reminders.title";
        oMedsLabel = "oscarEncounter.oMeds.title";
        famHistoryLabel = "oscarEncounter.famHistory.title";
        riskFactorsLabel = "oscarEncounter.riskFactors.title";  

        diagnosticNotesLabel = "oscarEncounter.eyeform.diagnosticNotes.title";
        pastOcularHistoryLabel = "oscarEncounter.eyeform.pastOcularHistory.title";
        patientLogLabel = "oscarEncounter.eyeform.patientLog.title";
        ocularMedicationsLabel = "oscarEncounter.eyeform.ocularMedications.title";          
		currentHistoryLabel = "oscarEncounter.eyeform.currentHistory.title";
         
        insertTemplateError = "<bean:message key="oscarEncounter.templateError.msg"/>";
        unsavedNoteWarning = "<bean:message key="oscarEncounter.unsavedNoteWarning.msg"/>";
        sessionExpiredError = "<bean:message key="oscarEncounter.sessionExpiredError.msg"/>";
        unlockNoteError = "<bean:message key="oscarEncounter.unlockNoteError.msg"/>";
        filterError = "<bean:message key="oscarEncounter.filterError.msg"/>";
        pastObservationDateError = "<bean:message key="oscarEncounter.pastObservationDateError.msg"/>";
        assignIssueError = "<bean:message key="oscarEncounter.assignIssueError.msg"/>";
        assignObservationDateError = "<bean:message key="oscarEncounter.assignObservationDateError.msg"/>";
        assignEncTypeError = "<bean:message key="oscarEncounter.assignEncTypeError.msg"/>";
        savingNoteError = "<bean:message key="oscarEncounter.savingNoteError.msg"/>";
        changeIssueMsg = "<bean:message key="oscarEncounter.change.title"/>";
        closeWithoutSaveMsg = "<bean:message key="oscarEncounter.closeWithoutSave.msg"/>";
        pickIssueMsg = "<bean:message key="oscarEncounter.pickIssue.msg"/>";
        assignIssueMsg = "<bean:message key="oscarEncounter.assign.title"/>";
        updateIssueError = "<bean:message key="oscarEncounter.updateIssueError.msg"/>";
        unsavedNoteMsg = "<bean:message key="oscarEncounter.unsavedNote.msg"/>";
        printDateMsg = "<bean:message key="oscarEncounter.printDate.msg"/>";
        printDateOrderMsg = "<bean:message key="oscarEncounter.printDateOrder.msg"/>";
        nothing2PrintMsg = "<bean:message key="oscarEncounter.nothingToPrint.msg"/>";
        editUnsignedMsg = "<bean:message key="oscarEncounter.printDateOrder.msg"/>";
        msgDraftSaved = "<bean:message key="oscarEncounter.draftSaved.msg"/>";
        msgPasswd = "<bean:message key="Logon.passWord"/>";
        btnMsgUnlock = "<bean:message key="oscarEncounter.Index.btnUnLock"/>";
        editLabel = "<bean:message key="oscarEncounter.edit.msgEdit"/>";
        month[0] = "<bean:message key="share.CalendarPopUp.msgJan"/>";
        month[1] = "<bean:message key="share.CalendarPopUp.msgFeb"/>";
        month[2] = "<bean:message key="share.CalendarPopUp.msgMar"/>";
        month[3] = "<bean:message key="share.CalendarPopUp.msgApr"/>";
        month[4] = "<bean:message key="share.CalendarPopUp.msgMay"/>";
        month[5] = "<bean:message key="share.CalendarPopUp.msgJun"/>";
        month[6] = "<bean:message key="share.CalendarPopUp.msgJul"/>";
        month[7] = "<bean:message key="share.CalendarPopUp.msgAug"/>";
        month[8] = "<bean:message key="share.CalendarPopUp.msgSep"/>";
        month[9] = "<bean:message key="share.CalendarPopUp.msgOct"/>";
        month[10] = "<bean:message key="share.CalendarPopUp.msgNov"/>";
        month[11] = "<bean:message key="share.CalendarPopUp.msgDec"/>";

function init() {       

    showIssueNotes();
    
    var navBars = new navBarLoader();
    navBars.load();  
    
    monitorNavBars(null);
    
    Element.observe(window, "resize", monitorNavBars);    
    
    if(!NiftyCheck())
        return;

    Rounded("div.showEdContent","all","transparent","#CCCCCC","big border #000000"); 
    Rounded("div.printOps","all","transparent","#CCCCCC","big border #000000");
    Calendar.setup({ inputField : "printStartDate", ifFormat : "%d-%b-%Y", showsTime :false, button : "printStartDate_cal", singleClick : true, step : 1 });    
    Calendar.setup({ inputField : "printEndDate", ifFormat : "%d-%b-%Y", showsTime :false, button : "printEndDate_cal", singleClick : true, step : 1 });    
    
    <c:url value="/CaseManagementEntry.do" var="issueURLCPP">
        <c:param name="method" value="issueList"/>
        <c:param name="demographicNo" value="${demographicNo}" />
        <c:param name="providerNo" value="${providerNo}" />
        <c:param name="all" value="true" />
    </c:url>
    var issueAutoCompleterCPP = new Ajax.Autocompleter("issueAutocompleteCPP", "issueAutocompleteListCPP", "<c:out value="${issueURLCPP}" />", {minChars: 3, indicator: 'busy2', afterUpdateElement: addIssue2CPP, onShow: autoCompleteShowMenuCPP, onHide: autoCompleteHideMenuCPP});
    
    strToday = $F("serverDate");        
    
    <nested:notEmpty name="DateError">
        alert("<nested:write name="DateError"/>");
    </nested:notEmpty>

    doscroll();

    //if we're on a new note
    setTimeout(scrollDownInnerBar,1500);
    
}

function scrollDownInnerBar() {
	$("encMainDiv").scrollTop= $("encMainDiv").scrollHeight;
}

function doscroll(){
	x=document.body.scrollHeight;
	x=x+99999
	window.scrollTo(0,x);
	}

</script>
  </head> 
  <body id="body" style="margin:0px;" onunload="onClosing()">
    
          <div id="header">
              <tiles:insert attribute="header" />
          </div>
                    
          <div id="leftNavBar" style="display:inline; float:left; width:20%;">
              <tiles:insert attribute="leftNavigation" />
          </div>  
          
          <div id="content" style="display:inline; float:left; width:60%; background-color:#CCCCFF;">
              <tiles:insert attribute="body" />
          </div>                   

          <div id="rightNavBar" style="display:inline; float:right; width:20%; margin-left:-3px;">
              <tiles:insert attribute="rightNavigation" />
          </div>            
                
          <!-- hovering divs -->
          <div id="showEditNote" class="showEdContent">
              <form id="frmIssueNotes" action="" method="post" onsubmit="return updateCPPNote();">
                  <input type="hidden" id="reloadUrl" name="reloadUrl" value="">
                  <input type="hidden" id="containerDiv" name="containerDiv" value="">
                  <input type="hidden" id="issueChange" name="issueChange" value="">
                  <input type="hidden" id="archived" name="archived" value="false">
		  <input type="hidden" id="annotation_attrib" name="annotation_attrib">
                  <div id="winTitle"></div>
                  <textarea style="margin:10px;" cols="50" rows="15" id="noteEditTxt" name="value" ></textarea><br>
		  <table>
		      <tr id="Itemstartdate"><td><bean:message key="oscarEncounter.startdate.title"/>: </td>
			<td><input type="text" id="startdate" name="startdate" value="" size="12"> (YYYY-MM-DD)</td></tr>
		      <tr id="Itemresolutiondate"><td><bean:message key="oscarEncounter.resolutionDate.title"/>: </td>
			<td><input type="text" id="resolutiondate" name="resolutiondate" value="" size="12"> (YYYY-MM-DD)</td></tr>
		      <tr id="Itemageatonset"><td><bean:message key="oscarEncounter.ageAtOnset.title"/>: </td>
			<td><input type="text" id="ageatonset" name="ageatonset" value="" size="2"></td></tr>
		      <tr id="Itemtreatment"><td><bean:message key="oscarEncounter.treatment.title"/>: </td>
			<td><input type="text" id="treatment" name="treatment" value=""></td></tr>
		      <tr id="Itemproceduredate"><td><bean:message key="oscarEncounter.procedureDate.title"/>: </td>
			<td><input type="text" id="proceduredate" name="proceduredate" value="" size="12"> (YYYY-MM-DD)</td></tr>
		      <tr id="Itemproblemstatus"><td><bean:message key="oscarEncounter.problemStatus.title"/>: </td>
			<td><input type="text" id="problemstatus" name="problemstatus" value="" size="8"> <bean:message key="oscarEncounter.problemStatusExample.msg"/></td></tr>
		      <tr id="Itemexposuredetail"><td><bean:message key="oscarEncounter.exposureDetail.title"/>: </td>
			<td><input type="text" id="exposuredetail" name="exposuredetail" value=""></td></tr>
		      <tr id="Itemrelationship"><td><bean:message key="oscarEncounter.relationship.title"/>: </td>
			<td><input type="text" id="relationship" name="relationship" value=""></td></tr>
		  </table><br>
                  <span style="float:right; margin-right:10px;">      
		      <input type="image" src="<c:out value="${ctx}/oscarEncounter/graphics/annotation.png"/>" title='<bean:message key="oscarEncounter.Index.btnAnotation"/>' id="anno"> &nbsp; &nbsp;
                      <input type="image" src="<c:out value="${ctx}/oscarEncounter/graphics/edit-cut.png"/>" title='<bean:message key="oscarEncounter.Index.btnArchive"/>' onclick="$('archived').value='true';" style="padding-right:10px;">
                      <input type="image" src="<c:out value="${ctx}/oscarEncounter/graphics/note-save.png"/>" title='<bean:message key="oscarEncounter.Index.btnSignSave"/>' onclick="$('archived').value='false';" style="padding-right:10px;">
                      <input type="image" src="<c:out value="${ctx}/oscarEncounter/graphics/system-log-out.png"/>" title='<bean:message key="global.btnExit"/>' onclick="this.focus();$('channel').style.visibility ='visible';$('showEditNote').style.display='none';return false;">
                  </span>
                  <bean:message key="oscarEncounter.Index.btnPosition"/><select id="position" name="position"><option id="popt0" value="0">1</option>
                  </select> 
                  <div id="issueNoteInfo" style="clear:both; text-align:left;"></div>
                  <div id="issueListCPP" style="background-color:#FFFFFF; height:200px; width:350px; position:absolute; z-index:1; display:none; overflow:auto;">
                      <div class="enTemplate_name_auto_complete" id="issueAutocompleteListCPP" style="position:relative; left:0px; display:none;"></div>
                  </div>
                  <bean:message key="oscarEncounter.Index.assnIssue"/>&nbsp;<input  tabindex="100" type="text" id="issueAutocompleteCPP" name="issueSearch" style="z-index: 2;" size="25">&nbsp;
                 
                  <span id="busy2" style="display: none"><img style="position:absolute;" src="<c:out value="${ctx}/oscarEncounter/graphics/busy.gif"/>" alt="<bean:message key="oscarEncounter.Index.btnWorking"/>" ></span>
                  
              </form>
          </div>
          <div id="printOps" class="printOps">
              <h3 style="margin-bottom:5px; text-align:center;"><bean:message key="oscarEncounter.Index.PrintDialog"/></h3>
              <form id="frmPrintOps" action="" onsubmit="return false;">
              		<table id="printElementsTable">
              			<tr>
              				<td><input type="radio" id="printopSelected" name="printop" value="selected"><bean:message key="oscarEncounter.Index.PrintSelect"/></td>
              				<td>
              					<%
	              					String roleName = (String)session.getAttribute("userrole") + "," + (String) session.getAttribute("user");
              					%>
								<security:oscarSec roleName="<%=roleName%>" objectName="_newCasemgmt.cpp" rights="r" reverse="false">
									<img style="cursor: pointer;" title="<bean:message key="oscarEncounter.print.title"/>" id='imgPrintCPP' alt="<bean:message key="oscarEncounter.togglePrintCPP.title"/>" onclick="return printInfo(this,'printCPP');" src='<c:out value="${ctx}"/>/oscarEncounter/graphics/printer.png'>&nbsp;<bean:message key="oscarEncounter.cpp.title" /> 
								</security:oscarSec>
              				</td>
              			</tr>
              			<tr>
              				<td><input type="radio" id="printopAll" name="printop" value="all"><bean:message key="oscarEncounter.Index.PrintAll"/></td>
              				<td>
								<img style="cursor: pointer;" title="<bean:message key="oscarEncounter.print.title"/>" id='imgPrintRx' alt="<bean:message key="oscarEncounter.togglePrintRx.title"/>" onclick="return printInfo(this, 'printRx');" src='<c:out value="${ctx}"/>/oscarEncounter/graphics/printer.png'>&nbsp;<bean:message key="oscarEncounter.Rx.title" />
              				</td>
              			</tr>
              			<!--  extension point -->              			
              			<tr id="printDateRow">
              				<td><input type="radio" id="printopDates" name="printop" value="dates"><bean:message key="oscarEncounter.Index.PrintDates"/>&nbsp;<a style="font-variant:small-caps;" href="#" onclick="return printToday(event);"><bean:message key="oscarEncounter.Index.PrintToday"/></a></td>
              				<td></td>
              			</tr>
              		</table>

                   <div style="float:left; margin-left:5px; width:30px;"><bean:message key="oscarEncounter.Index.PrintFrom"/>:</div> <img src="<c:out value="${ctx}/images/cal.gif" />" id="printStartDate_cal" alt="calendar">&nbsp;<input type="text" id="printStartDate" name="printStartDate" ondblclick="this.value='';" style="font-style:italic; border: 1px solid #7682b1; width:125px; background-color:#FFFFFF;" readonly value=""><br>
                   <div style="float:left; margin-left:5px; width:30px;"><bean:message key="oscarEncounter.Index.PrintTo"/>:</div> <img src="<c:out value="${ctx}/images/cal.gif" />" id="printEndDate_cal" alt="calendar">&nbsp;<input type="text" id="printEndDate" name="printEndDate" ondblclick="this.value='';" style="font-style:italic; border: 1px solid #7682b1; width:125px; background-color:#FFFFFF;" readonly value=""><br>                   
                   <div style="margin-top:5px; text-align:center">
                       <input type="submit" id="printOp" style="border: 1px solid #7682b1;" value="Print" onclick="return printNotes();">
                       <oscarProperties:oscarPropertiesCheck property="MY_OSCAR" value="yes">
                       	<indivo:indivoRegistered demographic="<%=(String) request.getAttribute(\"demographicNo\")%>" provider="<%=(String) request.getSession().getAttribute(\"user\")%>">
                       		<input type="submit" id="sendToPhr" style="border: 1px solid #7682b1;" value="Send To Phr" onclick="return sendToPhrr();">
                       	</indivo:indivoRegistered>
                       </oscarProperties:oscarPropertiesCheck>
                       <input type="submit" id="cancelprintOp" style="border: 1px solid #7682b1;" value="Cancel" onclick="$('printOps').style.display='none';">
                       <input type="submit" id="clearprintOp" style="border: 1px solid #7682b1;" value="Clear" onclick="$('printOps').style.display='none'; return clearAll(event);">
                   </div>
              </form>              
          </div>
          
  </body>
</html:html>