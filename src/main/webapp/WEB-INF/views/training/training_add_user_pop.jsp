<%@page import="kr.nshare.common.util.EgovProperties"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_pop_layout" />
<div class="pop_header">
	<h2><i class="fa-icon-sign-blank"></i><span class="break"></span> 훈련 인원 등록</h2>
</div>
	<div class="container-fluid">
	
		<div id="overlay" >
			<ul>
				<li class="li1"></li>
				<li class="li2"></li>
				<li class="li3"></li>
				<li class="li4"></li>
				<li class="li5"></li>
				<li class="li6"></li>
			</ul>
		</div>
		
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
	       		 		 		<th>대상등록</th>
	       		 		 		<td><input type='file' name="uploadfile" id="uploadfile"></td>
	       		 		 		<td><a href='#' class="btn" onClick="dwn_sample();">sample xls</a></td>
	       		 		 	</tr>
					    </tbody>
	       		 		</table>
	       		 		</form>
	       				<div class="form-horizontal "> 
							<div id='userlist' class="userlist" style="height: 250px">
							</div>
						</div>
	       				
	       							 
	       		 	
	       		 	<table class="table table-bordered table-striped">
				    	<tr>
				    		<td width="50px">
				    			
				    			<c:choose>
				    				<c:when test="${pageType=='form' }">
				    					<button type="button" class="btn" onClick='xls_parse();'>수신자 파싱</button>	
				    				</c:when>
				    				<c:otherwise>
				    					<button type="button" class="btn" onClick='xls_parse();'>수신자 파싱</button>
				    					<button type="button" class="btn" onClick='user_add();'>적용</button>
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
	var rDate_val = []; 
	
    <c:choose>
		<c:when test="${parseType == 'success' and pageType ==  'proc'}">
			createUserFields();
	    	<c:forEach var="errList" items="${list}" varStatus="status">
	    		rDate_val[${status.index}] ={email: '${errList.email}',name: '${errList.name}', department_name: '${errList.department_name}', unikey: '${errList.unikey}'};
				//errList = errList + "<c:out value="${errList.email}"/> | <c:out value="${errList.name}"/> | <c:out value="${errList.department_name}"/>  | <c:out value="${errList.unikey}"/>";  
	    	</c:forEach>
		    addUserfush(rDate_val);				
    	</c:when>
    </c:choose>
  
    //slick grid 필드 생성
	function createUserFields(){
		
		var fields=[];
		
		fields.push({name : "이메일주소",id: "email"});
		fields.push({name : "이름",id: "name"});
		fields.push({name : "부서",id: "department_name"});
		fields.push({name : "사번/아이디",id: "unikey"});
	
		setSlickHeader(fields);	
	}
  
	//slick grid 생성 및 유저 리스트 추가
	function addUserfush(rdata){
		//데이터 삽입
		setSlickData_first(rdata);
		
		//slick grid 생성
		create_slick_grid("#userlist");
	}	
    
    //최초 로드시 
    $(document).ready(function() {
    	if(paserType=='user_false')
    	{
    		var user_cnt= <%=EgovProperties.getProperty("Globals.training.max.user.count") %>
    		alert("총 훈련 대상자 수 "+user_cnt +"명을 초과할 수 없습니다. \n다시 등록해주시기 바랍니다.");	
    		
        }else if(paserType=='false')
    	{
    		alert("아래의 row가 등록에 문제가 있습니다. \n문제 되는 부분을 제거하고 다시 등록해주시기 바랍니다.\n"+errList);	
    	}
    });
    
    
    function dwn_sample()
    {
    	document.filedownload.action = "/download/file.do";
    	document.filedownload.submit();
    }
    
    
    function xls_parse()
    {
    	
    	var strFile = $("#uploadfile").val();    // 파일명
    	 var pathLen = strFile.lastIndexOf(".");  // 파일명의 확장자를 제외한 거리 까지의 길이
    	 var strExt  = strFile.substring(pathLen+1); // 파일 확장자 추출
    	
    	if($("#uploadfile").val()=="" ||  $('#uploadfile').val().split('.').pop().toLowerCase()!="xls" )
    	{
    		alert('사용자 등록을 원하시면 정해진 xls파일 을 입력하여주시기 바랍니다.');
    		return ;
    	}
    	$('#overlay').show();   
    	document.frm.action = "/training/training_add_user_pop.do";
    	document.frm.submit();
    }
        
    /**
    사용자 적용
    **/
    function user_add()
    {   
    	window.opener.rDate_val=rDate_val;
   		window.opener.addUserfush(rDate_val);
    	
  	 	window.opener.send_num_init();
  	 	window.close();
    }
    
	    
    
    </script>
    <c:out value="${jsonList}"/>
<c:import url="/common/pageLink.do?link=inc/bottom_pop_layout" />


       	</div>
</div>