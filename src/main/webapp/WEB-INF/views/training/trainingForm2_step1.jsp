<%@page import="kr.nshare.common.util.EgovProperties"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>

<c:import url="/common/pageLink.do?link=inc/top_layout" />

<!-- bootstrap dialog -->
<script src="<c:url value='/js/bootstrap/bootstrap-dialog.js'/>"></script>

<!-- bootstrap dialog -->
<link href="<c:url value='/css/bootstrap/bootstrap-dialog.css'/>" rel="stylesheet">



<div id="PageHeight" class="container-fluid">

	<!-- navi -->
	<ul class="breadcrumb">
		<li><i class="fa-icon-home"></i> Home / <strong>취향분석 훈련 생성</strong>
		</li>
	</ul>

	<div class="panel panel-default">
		
		
		
		<form name="frm" id="frm" method="post">
		<input type='hidden' name='pageType' value="step1">
		<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2>
							<%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
								<c:choose>
									<c:when test="${service_type eq 'test' }">
											<i class="fa-icon-user"></i><span class="break"></span>취향분석 훈련 생성(테스트)
									</c:when>
									<c:when test="${service_type eq 'real' }">
											<i class="fa-icon-user"></i><span class="break"></span>취향분석 훈련 생성(실전)
									</c:when>
									<c:otherwise>
										<i class="fa-icon-user"></i><span class="break"></spaan> 취향분석훈련생성
									</c:otherwise>
								</c:choose>
								<input type='hidden' name='service_setting_code' id='service_setting_code' value="<c:out value="${serviceSetting.code}"/>"/>
								<input type='hidden' name='service_type' id='service_type' value="<c:out value="${service_type}"/>"/>
							
							<%}else {%>
								<i class="fa-icon-user"></i><span class="break"></span> 취향분석 훈련생성
							<%}%>
						</h2>
					</div>
					<div class="box-content">
						
						<div class="form-horizontal span6"> 
						
								<div class="control-group">
								  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />기관/그룹</label>
								  <div class="controls">
								  		
										
											<select name='institution_code' required='required' class="fl" onchange="ig_load(this.value);">
												<option value="">선택하세요</option>
												<c:forEach var="institutionList" items="${institutionList}" varStatus="status">
													<option value="<c:out value="${institutionList.code}"/>"><c:out value="${institutionList.institution_name}"/></option>
							       		 		</c:forEach>	
							       		 	</select>
							       		 	
							       		 	<div id="ig_code_div">
								       		 	<select name='ig_code' id="required" required="required" class="fl">
								       		 		<option value=''>그룹선택</option>	
								       		 	</select>
							       		 	</div>
						       		 	
								  </div>
								</div>
							</div>
							<div class="form-horizontal span6"> 
								<div class="control-group">
								  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />훈련명</label>
								  <div class="controls">
								  		
								  		<p>
								  			<input type='text' name='tname' required='required' maxlength="40" class="fl" onkeypress="enter_event(event)">
								  		</p>		
								  		<br><br>
								  		<p>
											<b>취향분석 훈련은 훈련 step1 훈련명 생성 -> step2 훈련 내용 작성순으로 훈련생성이 진행됩니다.</b>
										</p>
								  </div>
							</div>
							
						</div>
						<div class="clearFix"></div>
						</div>
						
						<div class="box-content">
							<div class="pull-right">
									<a href='#' onClick='send()' class="btn btn-primary">훈련생성</a>
									<a href='/training/TrainingList.do' class="btn">리스트</a>
							</div>
							<div class="clearFix"></div>
						</div>
		
		
		</div>
		</form>
		</div>
	</div>
</div>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />
<script>
	
	
	function send()
	{
		var frm = document.getElementById("frm");
		
		//훈련명 체크
		if($("input[name='tname']").val().length > 30)
		{
			alert('훈련명 길이는 30자 이상을 초과할 수 없습니다.');
			return ;
		}else{
			var err_char=["[","]","/","*","?"];
			for(i=0;i<err_char.length;i++)
			{
				if($("input[name='tname']").val().indexOf(err_char[i]) != -1){
					alert('훈련명에 해당 문자열([,],/,*,?)을 사용할 수  없습니다.');
					return ;
				}
			}
		}
		
		if($("#frm").valid())
		{
			if(confirm("훈련을 생성하시겠습니까?")){
				frm.action = "<c:url value='/training/trainingSave2.do'/>";
				frm.submit();
			}
		}
	}
	
	function ig_load(code)
	{
		
			var html="";
			var select_html="";
			param = "code="+code;
			$.ajax({
				type:'POST',
				url : "<c:url value='/training/ajax_group_list.do'/>",
				data:param,
				dataType : "json",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
				beforeSend: function() {
		        },
				success : function(json){
					for(i=0;i<json.length;i++)
					{
						select_html = select_html +"<option value='"+json[i].code+"'>"+json[i].group_name+"</option>";
					}
					
					html = "<select name='ig_code' id='ig_code' required='required' class='fl'>";
					html = html + "<option value=''>그룹선택</option>";
					html = html + select_html;
					html = html + "</select>";
					
					$("#ig_code_div").html(html);
					
				},
				error:function(request,status,error){
				}
				
			}).complete(function() {
							
	        });
		
	}
	
	<!--체크박스(수집정보) -->
	$(function() {
		
		$("#frm").validate({
			
			rule: {
				institution_code:{
					required:true
				}
				, ig_code:{
					required:true
				}
				, tname:{
					required:true
				}
			},
			messages: {
				institution_code:
				{
					required:"훈련생성기관을 선택하세요"
				}, 
				ig_code:
				{
					required:"그룹을 선택하세요."
				}, 
				tname:{
					required:"훈련명을 입력하세요"
					,maxlength: $.validator.format('{0}자 이내로 입력해주세요!')
				}
			}
		});
	
	});
	
	
	function enter_event(e)
	{
		  if(e.keyCode == 13){  
			  send();
		   }		
	}
</script>