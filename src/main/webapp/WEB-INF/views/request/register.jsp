<%@page import="kr.nshare.common.util.EgovProperties"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>
<c:import url="/common/pageLink.do?link=inc/top_none_menu_layout" />

<div id="PageHeight" class="container-fluid">

	<!-- navi -->
	<div class="panel panel-default">
		
		
		
		<form name="frm" id="frm" method="post"  enctype="multipart/form-data">
			<input type="hidden" name="t" value="<c:out value="${searchVO.t }"/>">		
		<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
								<h2><i class="fa-icon-user"></i><span class="break"></span>신고접수</h2>
				       	
					</div>
					<div class="box-content">						
						
						<div class="form-horizontal "> 
							
							
							
							<div class="control-group">
							  <label class="control-label" for="typeahead">신고제목</label>
							  <div class="controls">
							  		<input type="text" name="title" width="100%" style="width:100%" <c:if test="${validation!='success'}"> disabled='true'</c:if>>
							  </div>
							</div>
							
						</div>
						
						
								<div class="form-horizontal "> 
						
									<div class="control-group">
									  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />신고자이메일</label>
									  <div class="controls">
									  		<input type='text' name='email' <c:if test="${validation!='success'}"> disabled='true'</c:if>>
									  </div>
									</div>
									
								</div>
								
								<div class="form-horizontal "> 
								
									<div class="control-group">
									  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />신고자이름</label>
									  <div class="controls">
									  		<input type='text' name='name' <c:if test="${validation!='success'}"> disabled='true'</c:if>>
									  </div>
									</div>
									
								</div>
						<div class="form-horizontal "> 
						
							<div class="control-group">
							  <label class="control-label" for="typeahead">신고내용</label>
							  <div class="controls">
							  		<textarea rows="10" style="width:100%" name="content" <c:if test="${validation!='success'}"> disabled='true'</c:if>></textarea>
							  </div>
							</div>
							
						</div>
						<div class="pull-right">
						<c:if test="${validation=='success'}">
							<a href='#' onClick='send()' class="btn btn-primary" >등록</a>
						</c:if>
							<button type="button" class="btn btn-primary" onClick='close_window();'>닫기</button>
						</div>
						<div class="clearFix"></div>	
			
					</div>				
		</div>
		</form>
		</div>
	</div>
</div>
<script>
	var validation = "<c:out value="${validation}"/>";
	function close_window()
	{
		window.close();
	}
	
	
	
	function send()
	{
		
		if($("input[name='title']").val()=="")
		{
			$("input[name='title']").val("-");
		}
		
		if($("select[name='register_user']").val()=="")
		{
			alert('신고자는 필수입력사항입니다.');
			return ;
		}
		
		var regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";
    	var email = $("input[name='email']").val();
    	
		if (!email.match(regex))
    	{
			alert('잘못된 이메일 형식입니다.');
			return ;
    	}
    	
		if($("input[name='email']").val()=="")
		{
			alert('이메일은 필수입력사항입니다.');
			return ;
		}
		
		if($("input[name='name']").val()=="")
		{
			alert('이름은 필수입력사항입니다.');
			return ;
		}
		
		if($("textarea[name='content']").val()=="")
		{
			$("textarea[name='content']").val("-")
		}
		
		document.frm.action = "/request/register_save.do";
		if(confirm("접수하시겠습니까?")){
			document.frm.submit();
		}
				
	}
	$(function() {
	 if("success" ==validation ){
		}else{
			alert("훈련 집계기간이 종료되었습니다.\n신고하지 않으셔도 됩니다.");
		}
	});
</script>


<c:import url="/common/pageLink.do?link=inc/bottom_none_menu_layout" />