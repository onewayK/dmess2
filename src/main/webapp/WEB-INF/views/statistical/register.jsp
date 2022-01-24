<%@page import="kr.nshare.common.util.EgovProperties"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>
<c:import url="/common/pageLink.do?link=inc/top_layout" />
<div id="PageHeight" class="container-fluid">
		<ul class="breadcrumb">
            <li>
                <i class="fa-icon-home"></i> Home / <strong>신고접수</strong>
            </li>
        </ul>		

<div id="PageHeight" class="container-fluid">
	
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
			
	<!-- navi -->
	<div class="panel panel-default">
		
		
		
		<form name="frm" id="frm" method="post"  enctype="multipart/form-data">
			<input type="hidden" name="t" value="<c:out value="${searchVO.t }"/>">		
		<div class="row-fluid">
				
				<div class="box span12">
					
					<div class="box-header">
						                     			
                       	<h2><i class="fa-icon-user"></i><span class="break"></span>신고접수(개별)</h2>
					</div>
					<div class="box-content">						
						
						<div class="form-horizontal "> 
							
							
									<div class="control-group">
										<label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />훈련명</label>
										<div class="controls">
												              			
			                       			<select name="searchInstitution" id="searchInstitution" onChange="chgInstitution(this.value)">
												<option value="">선택하세요</option>
												<c:forEach var="list" items="${list}" varStatus="status">																						
													<option value="${list.code }" <c:if test="${searchVO.searchInstitution eq list.code }"> selected </c:if>><c:out value="${list.institution_name}"/></option>												
												</c:forEach>										
											</select>		
											
											<!-- 기관코드에 맞게 그룹코드 출력 -->	
											<span id="div_group">
			        							<select name='group_code' id="group_code" onChange="chgGroup(this.value)">
													<option value="">선택하세요</option>
													<c:forEach var="groupList" items="${groupList}" varStatus="status">																						
														<option value="${groupList.code }" <c:if test="${searchVO.group_code eq groupList.code }"> selected </c:if>><c:out value="${groupList.group_name}"/></option>												
													</c:forEach>										
												</select>
					        				</span>
					        				
											<!-- 그룹코드에 맞게 훈련 값출력 -->
											<span id="div_training_code">
												<select name="training_code" id="training_code" onChange="chgTrainingUser(this.value)">
													<option value="">선택하세요</option>
													<c:forEach var="trainingList" items="${trainingList}" varStatus="status">																						
															<option value="${trainingList.code }" <c:if test="${searchVO.training_code eq trainingList.code }"> selected </c:if>><c:out value="${trainingList.tname}"/></option>																									
													</c:forEach>
												</select>
					        				</span>	
					        				
										</div>
									</div>
							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />신고제목</label>
							  <div class="controls">
							  		<input type="text" name="title" width="100%" style="width:100%">
							  </div>
							</div>
							
						</div>
						
						
						<div class="form-horizontal "> 				
							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />신고자</label>
							  <div class="controls">
							  		<span id="div_register_user">
										<select name="register_user" id="register_user">
											<option value="">선택하세요</option>
										</select>
			        				</span>
							  </div>
							</div>							
						</div>
							
												
						<div class="form-horizontal "> 				
							<div class="control-group">
							  <label class="control-label" for="typeahead">신고시간</label>
							 <div class="controls">
							  		<input style="width: 130px;" readonly type='text' name='sdate' id='sdate' value="">
							  		<input type="checkbox" id="sdate_use_chk" name="sdate_use_chk" onClick="check_sdate_setting();">설정									
							 		<input type='hidden' name='sdate_use' id='sdate_use' value="N"/>
							 </div>
							</div>							
						</div>
						
						
						<div class="form-horizontal "> 
						
							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />신고내용</label>
							  <div class="controls">
							  		<textarea rows="10" style="width:100%" name="content"></textarea>
							  </div>
							</div>
							
						</div>
						<div class="pull-right">
							<a href='#' onClick='send()' class="btn btn-primary">등록</a>
							<button type="button" class="btn btn-primary" onClick='movelist();'>리스트</button>
						</div>
						<div class="clearFix"></div>	
			
					</div>				
		</div>
		</form>
		</div>
	</div>
	</div>
</div>
<script>
	
	var msg = "<c:out value="${msg}"/>";
	$( document ).ready(function() {
		$('#overlay').hide();   
		$("#sdate")		
		.datetimepicker(
				{
					format: 'Y-m-d H:i',
					step : 1
		});
		
		$("#register_user").chosen(
	    		{
	    			no_results_text: "해당 대상자가 존재하지 않습니다.",
	    			width: 200		
	    		}
	    ); 
		
		check_sdate_setting();
	});
	
	function movelist()
	{
		location.href="/statistical/registerList.do";
	}
	
	//기관선택
	function chgInstitution(code)
	{
		var param = "code="+code+"&type=0";
		$.ajax({
			type:'POST',
			url : "<c:url value='/statistical/ajax_institutionList.do'/>",
			data:param,
			dataType : "json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
			beforeSend: function() {
	        	
	        },
			success : function(json){
				
				var html = "<select name='group_code' id='group_code' onChange='chgGroup(this.value);'><option value=''>선택하세요</option>";
				
				for(i=0;i<json.length;i++)
				{
					html = html + "<option value='"+json[i].code+"'>"+json[i].group_name+"</option>";	
				}
				html = html +"</select>";
				$("#div_group").html(html);
				
				//훈련명 초기화 처리
				chgGroup('0');
				
			},
			error:function(request,status,error){
				
			}
			
		}).complete(function() {
			
	    });
	}
	
	/**
	훈련리스트 그룹 추출
	**/
	function chgGroup(code)
	{
		if(code=="0" || code == '')
		{			
			var html = "<select name='training_code' id='training_code'><option value=''>선택하세요</option>";
			html = html +"</select>";
			
			$("#div_training_code").html(html);		
			chgTrainingUser('0');
		}
		else
		{
	   		var searchCondition = $('#searchCondition option:selected').val();
	   		
	   		
	   		var param = "code="+code+"&type=1";
	   		$.ajax({
				type:'POST',
				url : "<c:url value='/statistical/ajax_institutionList.do'/>",
				data:param,
				dataType : "json",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
				beforeSend: function() {
		        	
		        },
				success : function(json){
					
					var html = "<select name='training_code' id='training_code' onChange='chgTrainingUser(this.value)'><option value=''>선택하세요</option>";
					
					for(i=0;i<json.length;i++)
					{
						html = html + "<option value='"+json[i].code+"'>"+json[i].tname+"</option>";	
					}
					
					html = html +"</select>";
					$("#div_training_code").html(html);
				}
	   		});
		}
	}
	//사용자 선택
	function chgTrainingUser(code)
	{
	
		if(code=="0" || code == '')
		{			
			var html = "<select name='register_user' id='register_user'><option value=''>선택하세요</option>";
			html = html +"</select>";
			
			$("#div_register_user").html(html);
			
			$("#register_user").chosen(
		    		{
		    			no_results_text: "해당 대상자가 존재하지 않습니다.",
		    			width: 200		
		    		}
		    ); 
			
		}else {
			var param = "code="+code;
			$.ajax({
				type:'POST',
				url : "<c:url value='/statistical/ajax_userList.do'/>",
				data:param,
				dataType : "json",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
				beforeSend: function() {
		        	
		        },
				success : function(json){
					
					var html = "<select name='register_user' id='register_user'><option value=''>선택하세요</option>";
					
					for(i=0;i<json.length;i++)
					{
						html = html + "<option value='"+json[i].email + "," + json[i].name+"'>"+json[i].email+","+json[i].name+"</option>";			
					}
					html = html +"</select>";				
					$("#div_register_user").html(html);				
					
					
					$("#register_user").chosen(
				    		{
				    			no_results_text: "해당 대상자가 존재하지 않습니다.",
				    			width: 200		
				    		}
				    ); 
					
					
				},
				error:function(request,status,error){
					
				}
				
			}).complete(function() {
				
		    });
		}

	
	}
	
	function send()
	{
		if($("select[name='searchInstitution']").val()=="" )
    	{
    		alert('기관은 필수입력사항입니다.');
    		return ;
    	}
		
    	 if($("select[name='group_code']").val()=="")
    	{
    		alert('그룹명은 필수입력사항입니다.');
    		return ;
    	}
    	 
    	 if($("select[name='training_code']").val()=="")
    	{
    		alert('훈련명은 필수입력사항입니다.');
    		return ;
    	} 
    	 
		if($("input[name='title']").val()=="")
		{
			alert('신고제목은 필수입력사항입니다.');
			return ;
		}
		
		if($("select[name='register_user']").val()=="")
		{
			alert('신고자는 필수입력사항입니다.');
			return ;
		}
		
		if($("input[name='email']").val()=="")
		{
			alert('신고자 이메일은 필수입력사항입니다.');
			return ;
		}
		
		if($("input[name='name']").val()=="")
		{
			alert('신고자 이름은 필수입력사항입니다.');
			return ;
		}
		
		if($("input:checkbox[name='sdate_use_chk']").is(":checked")==true)
		{
			if($("input[name='sdate']").val()=="")
			{
				alert('신고 시간은 입력해야 합니다..');
				return ;
			}
		}		
		
		if($("textarea[name='content']").val()=="")
		{
			alert('신고 내용은 필수입력사항입니다.');
			return ;
		}
		
		document.frm.action = "/statistical/register_save.do";
		if(confirm("접수하시겠습니까?")){
			document.frm.submit();
		}
				
	}
	
	/**
	* 스팸 사용 체크에 따른 입력폼 비활성화
	**/
	function check_sdate_setting()
	{				
		if($("input:checkbox[name='sdate_use_chk']").is(":checked")==true)
		{
			$("input[name='sdate']").val('');	
			$("input[name='sdate_use']").val('Y');
			$('#sdate').css("cursor","pointer");
			$('#sdate').prop('disabled', false);
		}else{
			$("input[name='sdate']").val('');
			$("input[name='sdate_use']").val('N');
			$('#sdate').css("cursor","not-allowed");
			$('#sdate').prop('disabled', true);
		}				
	}
</script>


<c:import url="/common/pageLink.do?link=inc/bottom_layout" />