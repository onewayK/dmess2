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
		<li><i class="fa-icon-home"></i> Home / <strong>훈련그룹생성</strong>
		</li>
	</ul>

	<div class="panel panel-default">
		
		
		
		<form name="frm" id="frm" method="post"  enctype="multipart/form-data">
		
		<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-user"></i><span class="break"></span>훈련그룹생성</h2>
					</div>
					<div class="box-content">
						<div class="form-horizontal "> 
						
							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />훈련생성 기관</label>
							  <div class="controls">
							  	<c:choose>
									<c:when test="${pageType eq 'insert' }">
									<select name='institution_code' required='required' class="fl">
										<option value="">선택하세요</option>
										<c:forEach var="institutionList" items="${institutionList}" varStatus="status">
											<option value="<c:out value="${institutionList.code}"/>"><c:out value="${institutionList.institution_name}"/></option>
					       		 		</c:forEach>	
					       		 	</select>
									</c:when>
									
									<c:when test="${pageType eq 'update'}">
											<input type="hidden" name='code' value='${detail.code }'>
											<input type="hidden"name='pageType' value='${pageType}'>
											
											<c:forEach var="institutionList" items="${institutionList}" varStatus="status" >
												<c:if test="${ institutionList.code == detail.institution_code}">
													<c:out value="${institutionList.institution_name}"/>
												</c:if>
											</c:forEach>
									</c:when>
								</c:choose>
							  </div>
							</div>
						
							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />그룹명</label>
							  <div class="controls">
							  		<input style="width: 200px" type='text' name='group_name' maxlength='20' required='required' class="fl" value="<c:if test="${pageType=='update'}"><c:out value="${detail.group_name }"/></c:if>">
							  </div>
							</div>
							
							<div class="pull-right">
							<c:choose>
								<c:when test="${pageType eq 'insert' }">
									<a href='#' onClick='group_send()' class="btn btn-primary">등록</a>
								</c:when>
								<c:when test="${pageType eq 'update'}">
									<a href='#' onClick='group_send()' class="btn">수정</a>
									
									<c:choose>
										<c:when test="${detail.lev == 'admin' }">
											<a href='#' onClick="deleteTraining_group();" class="btn">삭제</a>
										</c:when>
									</c:choose>
								</c:when>
							</c:choose>
							<a href="/training/GroupList.do" class="btn">리스트</a>
						</div>
						<div class="clearFix"></div>
		
						</div>
						
					</div>
				</div>
			</div>
		</form>
		</div>
	</div>
</div>
<script type="text/javascript" src="/js/HuskyEZCreator.js" charset="utf-8"></script>
<script>
	
	
	
	<!--체크박스(수집정보)-->
	$(function() {
		
		<c:choose>
		<c:when test="${pageType eq 'insert' }">
			$("#frm").validate({
			
			rule: {
				institution_code:{
					required:true
				}, group_name:{
					required:true
				}
			},
			messages: {
				institution_code:
				{
					required:"훈련생성기관을 선택하세요"
				}, 
				group_name:{
					required:"훈련명을 입력하세요"
				}
			}
		});
		</c:when>
		
		<c:when test="${pageType eq 'update'}">
			$("#frm").validate({
			rule: {
				group_name:{
					required:true
					,maxlength:20
				}
			},
			messages: {
				group_name:{
					required:"훈련명을 입력하세요"
					,maxlength: $.validator.format('{0}자 이내로 입력해주세요!')
				}
			}
		});	
		</c:when>
	</c:choose>
		
		
		
		
		
		
		
	});
	
	
	//저장
	function group_send()
	{
		if($("#frm").valid())
		{
			var frm = document.getElementById("frm");
			frm.action = "<c:url value='/training/groupSave.do'/>";
			<c:choose>
				<c:when test="${pageType eq 'insert' }">
					if(confirm("그룹을 생성하시겠습니까?")){
						frm.submit();
					}
				</c:when>
					
				<c:when test="${pageType eq 'update'}">
				if(confirm("그룹명을 수정하시겠습니까?")){
					frm.submit();
				}
				</c:when>
			</c:choose>
		}
		else
		{
			alert("입력값을 확인하세요");
		}
	}
	
	/**
	훈련 그룹 삭제
	**/
	function deleteTraining_group()
	{
		var frm = document.getElementById("frm");
		
		if (confirm("해당 훈련그룹을 정말 삭제하시겠습니까?\n삭제를 진행하면 그룹에 속한 모든 훈련들이 같이 삭제되며, \n복구는 불가능 합니다. 신중하게 신행해주시기 바랍니다.") == true)
		{  
			frm.action = "<c:url value='/training/training_group_del.do'/>";
			frm.submit();
		}
	}
</script>

<c:import url="/common/pageLink.do?link=inc/bottom_layout" />