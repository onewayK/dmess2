<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_pop_layout" />
<div class="pop_header">
	<h2><i class="fa-icon-sign-blank"></i><span class="break"></span> 신고 일괄 등록</h2>
</div>
	<div class="container-fluid">
			<div class="row-fluid">
					<div class="box-content span12">
	       		 	 <form class="form-horizontal" role="form" name='frm' method='post' enctype="multipart/form-data">
	       		 		<table class="table table-bordered table-striped">
	       		 		<colgroup>
	       		 			<col width="100px">
	       		 			<col width="300px">
	       		 			<col width="*">
	       		 		</colgroup>
	       		 		 <tbody>
	       		 		 	<tr>
	       		 		 		<td colspan="3">
		       		 		 		sample xls를 다운로드하신후 등록하시고자하는 사용자 리스트를 등록하신후
		       		 		 		파일 업로드를 해주시기 바랍니다.
	       		 		 		</td>
	       		 		 	</tr>
	       		 		 	<tr>
	       		 		 		<th>신고 등록</th>
	       		 		 		<td><input type='file' name="uploadfile" id="uploadfile"></td>
	       		 		 		<td><a href='#' class="btn" onClick="dwn_sample();">sample xls</a></td>
	       		 		 	</tr>
					    </tbody>
	       		 		</table>
	       		 		</form>
	       				<table class="table table-bordered table-striped" id="listpage">
	       				<c:choose>
	       					<c:when test="${fn:length(list)>0 && parseType eq 'success'}">
						    	<tr>
						    		<th width='20%'>신고제목</th>
						    		<th width='15%'>수신자 이메일</th>
						    		<th width='10%'>수신자 이름</th>
						    		<th width='40%'>신고 내용</th>
						    		<th width='15%'>신고시간</th>						    		
						    	</tr>
						    	<c:forEach var="list" items="${list}" varStatus="status">
	       						<tr>
	       							<td>
		       		 					<c:out value="${list.title}"/>
		       		 					<input type='hidden' name='title[]' value='<c:out value="${list.title}"/>'/>
		       		 				</td>
		       		 				<td>
		       		 					<c:out value="${list.email}"/>
		       		 					<input type='hidden' name='email[]' value='<c:out value="${list.email}"/>'/>
		       		 				</td>
		       		 				<td>
		       		 					<c:out value="${list.name}"/>
		       		 					<input type='hidden' name='name[]' value='<c:out value="${list.name}"/>'/>
		       		 				</td>
		       		 				<td>
		       		 					<c:out value="${list.content}"/>
		       		 					<input type='hidden' name='content[]' value='<c:out value="${list.content}"/>'/>
		       		 				</td>
		       		 				<td>
		       		 					<c:out value="${list.sdate}"/>
		       		 					<input type='hidden' name='sdate[]' value='<c:out value="${list.sdate}"/>'/>
		       		 				</td>
		       		 			</tr>
	       						</c:forEach>
	       					</c:when>
	       				</c:choose>	
	       				</table>
	       				
	       							 
	       		 	
	       		 	<table class="table table-bordered table-striped">
				    	<tr>
				    		<td width="50px">
				    			
				    			<c:choose>
				    				<c:when test="${pageType=='form' }">
				    					<button type="button" class="btn" onClick='xls_parse();'>신고내역 파싱</button>	
				    				</c:when>
				    				<c:otherwise>
				    					<button type="button" class="btn" onClick='xls_parse();'>신고내역 파싱</button>
				    					<button type="button" class="btn" onClick='register_add();'>적용</button>
				    				</c:otherwise>
				    			</c:choose>
							</td>
				    	</tr>
					 </table>
       		 	</div>
    </div>
    <form name="filedownload" target="iframe" hidden="hidden">
    </form>
    <iframe name="iframe" hidden="hidden">
    
    </iframe>
    <script>
    
    var paserType = "<c:out value="${parseType}"/>";
	var errList = "";
    <c:choose>
		<c:when test="${fn:length(errList)>0}">
	    	<c:forEach var="errList" items="${errList}" varStatus="status">
	    		errList = errList + "<c:out value="${errList.email}"/> | <c:out value="${errList.name}"/> | <c:out value="${errList.sdate}"/>\n";  
	    	</c:forEach>
    	</c:when>
    </c:choose>
    
    //최초 로드시 
    $(document).ready(function() {
      
    	if(paserType!='success')
    	{
    		alert("아래의 row가 등록에 문제가 있습니다. \n문제 되는 부분을 제거하고 다시 등록해주시기 바랍니다.\n"+errList);	
    	}
    });
    
    
    function dwn_sample()
    {
    	document.filedownload.action = "/download/register_file.do";
    	document.filedownload.submit();
    }
    
    
    function xls_parse()
    {
    	
    	var strFile = $("#uploadfile").val();    // 파일명
    	 var pathLen = strFile.lastIndexOf(".");  // 파일명의 확장자를 제외한 거리 까지의 길이
    	 var strExt  = strFile.substring(pathLen+1); // 파일 확장자 추출
    	
    	if($("#uploadfile").val()=="" ||  $('#uploadfile').val().split('.').pop().toLowerCase()!="xls" )
    	{
    		alert('신고 등록을 원하시면 정해진 xls파일 을 입력하여주시기 바랍니다.');
    		return ;
    	}
    	document.frm.action = "/statistical/register_add_pop.do";
    	document.frm.submit();
    }
    
    /**
    신고내역 적용
    **/
    function register_add()
    {
    	window.opener.addRegisterClear();
    	
    	for(var i=0;i<$("input[name='email[]']").length;i++)
    	{
    		window.opener.addRegisterList($("input[name='title[]']").eq(i).val(),$("input[name='email[]']").eq(i).val(), $("input[name='name[]']").eq(i).val(),$("input[name='content[]']").eq(i).val(),$("input[name='sdate[]']").eq(i).val(),"");
    	}
    	
    	window.opener.addRegisterFlush();
        	
    	window.close();
    }
    
	    
    
    </script>
    <c:out value="${jsonList}"/>
<c:import url="/common/pageLink.do?link=inc/bottom_pop_layout" />


       	</div>
</div>