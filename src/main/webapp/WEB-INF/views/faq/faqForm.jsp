<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_layout" />
	<div id="PageHeight" class="container-fluid">
		
		<!-- navi -->
        <ul class="breadcrumb">
            <li>
            	<c:choose>
   		 			<c:when test="${pageType eq 'insert'}"><i class="fa-icon-home"></i> Home / Faq / <strong>FAQ 등록</strong></c:when>
   		 			<c:when test="${pageType eq 'update'}"><i class="fa-icon-home"></i> Home / Faq / <strong>FAQ 수정</strong></c:when>
       		 	</c:choose>                 
            </li>
        </ul>
			
	        <div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<c:choose>
	       		 			<c:when test="${pageType eq 'insert'}"><h2><i class="fa-icon-bar-chart"></i><span class="break"></span>FAQ 등록</h2></c:when>
	       		 			<c:when test="${pageType eq 'update'}"><h2><i class="fa-icon-bar-chart"></i><span class="break"></span>FAQ 수정</h2></c:when>
       		 			</c:choose>
					</div>
        			<div class="box-content">
        			
        			
	       		 	 <form class="form-horizontal" role="form" name='frm' id='frm' method='post'>
	       		 		<table class="table table-bordered">
	       		 		<colgroup>
	       		 			<col width="200px">
	       		 			<col width="*">
	       		 		</colgroup>
	       		 		 <tbody>
					    	<tr>
	       		 				<th>질문<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td>
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='text' name='faq_q' required='required' maxlength="50" class="fl" autocomplete="off" value="" style="width:100%">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type='text' name = 'faq_q' required='required'  maxlength="50" class="fl" value='<c:out value="${detail.faq_q}"/>' style="width:100%">
	       		 						</c:when>
	       		 					</c:choose>
	       		 				</td>
	       		 			</tr>
	       		 			
	       		 			<tr>
	       		 				<th>답변<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td>
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<textarea rows="10" name="faq_a" required='required' class="fl" style="width:100%"></textarea>
	       		 							
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<textarea rows="10" name="faq_a" required='required' class="fl" style="width:100%"><c:out value="${detail.faq_a}" /></textarea>
	       		 						</c:when>
	       		 					</c:choose>	
	       		 					
	       		 				
	       		 				</td>
	       		 			</tr>
	       		 			<tr>
	       		 				<th>faq유형</th>
	       		 				<td>
	       		 				<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<select name='type' onchange="selectType(this.value);">
			       		 						<option value='c'>공통</option>
			       		 						<option value='i'>기관특화</option>
			       		 					</select>
			       		 					
			       		 					<select name='institution_code' id='institution_code' disabled=true>
			       		 						<c:forEach var="list" items="${institutionList}" varStatus="status">
			       		 							<option value="<c:out value="${list.code }"/>"><c:out value="${list.institution_name }"/></option>
			       		 						</c:forEach>
			       		 					</select>
			       		 					
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<select name='type'  onchange="selectType(this.value);">
			       		 						<option value='c' 		<c:if test="${detail.type=='c'}"> selected </c:if>>공통</option>
			       		 						<option value='i'		<c:if test="${detail.type=='i'}"> selected </c:if>>기관특화</option>
			       		 					</select>
			       		 					
			       		 					<select name='institution_code' id='institution_code' disabled=true>
			       		 						<c:forEach var="list" items="${institutionList}" varStatus="status">
			       		 							<option value="<c:out value="${list.code }"/>" <c:if test="${detail.institution_code==list.code}"> selected </c:if>><c:out value="${list.institution_name }"/></option>
			       		 						</c:forEach>
			       		 					</select>
			       		 					
	       		 						</c:when>
	       		 					</c:choose>
	       		 					
	       		 				</td>
	       		 			</tr>
	       		 			<c:choose>
	       		 				<c:when test="${ pageType eq 'update'}">
	       		 						<tr>
				       		 				<th>사용유무</th>
				       		 				<td>
				       		 					<select name='useyn'>
				       		 						<option value='0' <c:if test="${detail.useyn=='0' }"> selected </c:if>>사용</option>
				       		 						<option value='1' <c:if test="${detail.useyn=='1' }"> selected </c:if>>중지</option>
				       		 					</select>
				       		 				</td>
				       		 			</tr>
	       		 				</c:when>
	       		 			</c:choose>
	       		 			
					    </tbody>
	       		 		</table>
	       		 		<input type='hidden' name='pageType' value="<c:out value="${pageType }"/>">
	       		 		<c:choose>
	       		 			<c:when test="${ pageType eq 'update'}">
	       		 				<input type='hidden' name='code'  value='<c:out value="${detail.code }"/>'>
	       		 			</c:when>
	       		 		</c:choose>
	       		 	</form>
	       		 	
	       		 	<div class="pull-right">
      		 				<c:choose>
      		 						<c:when test="${ pageType eq 'insert'}">
      		 							<button type="button" class="btn btn-primary" onClick='insertFaq();'>등록</button>
      		 						</c:when>
      		 						<c:when test="${ pageType eq 'update'}">
      		 							<button type="button" class="btn btn-default" onClick='updateFaq();'>수정</button>
      		 						
	      		 						<c:choose>
											<c:when test="${detail.lev == 'admin' }">
												<a href='#' onClick="deleteFAQ();" class="btn">삭제</a>
											</c:when>
										</c:choose>
      		 						</c:when>
      		 					</c:choose>	
      		 					<button type="button" class="btn btn-default" onClick='movelist();'>리스트</button>
	       		 		</div>
	       		 	<div class="clearFix"></div>
       		 	</div>
       		 	</div>
       		 	</div>
       		 	</div>
    </div>
      <style type="text/css">
        select[disabled] { background-color: #d3d3d3; }
    </style>
    <script>
    
    	$(function() {
    		<c:choose>
    			<c:when test="${ pageType eq 'update'}">
    				selectType('<c:out value="${detail.type}"/>');
    			</c:when>
    			<c:otherwise>
    				selectType('c');
    			</c:otherwise>
    			
    		</c:choose>
    		
    		$("#frm").validate({
    			rule:{
    				faq_q:{
    					required:true
    				}
    				, faq_a:{
    					required:true
    				}
    			},
    			messages:{
					faq_q:{
						required:"질문을 입력하세요"
						,maxlength: $.validator.format('{0}자 이내로 입력해주세요!')
    				}, faq_a:{
    					required:"답변을 입력하세요"
    				}
    			}
    		});
    	});
    
    	function selectType(type)
    	{
    		if(type=="c")
    		{
    			$("select[name='institution_code']").attr("disabled","disabled");
    			$("select[name='institution_code']").hide();
    		}
    		else
    		{
    			$("select[name='institution_code']").removeAttr("disabled");
    			$("select[name='institution_code']").show();
    		}
    	}
    
    	function movelist()
    	{
    		location.href="/system/faqList.do";
    	}
    	
    	/**
    	수정
    	**/
    	function updateFaq()
    	{
    			if($("#frm").valid()){
    				var frm = document.getElementById("frm");
    				frm.action = "<c:url value='/faq/faqProc.do'/>";
    				if(confirm("수정하시겠습니까?")){
    					frm.submit();
    				}
    			}else{
    				alert("입력값을 확인하세요");
    			}    		
    	}
    	/**
    	등록
    	**/
    	function insertFaq(){
    		
    		if($("#frm").valid()){
    			var frm = document.getElementById("frm");
    			frm.action = "<c:url value='/faq/faqProc.do'/>";
    			if(confirm("등록하시겠습니까?")){
    				frm.submit();
    			}
    		}else{
    			alert("입력값을 확인하세요");
    		}   
    	}
    	
    	
    	function  institution_pop()
    	{
    		
    		url = '<c:url value="/system/institution_list_pop.do"/>';
    		url = url +"?institution_code="+$("input[name='institution_code']").val();
    		fn_openwindow(url,  '400px', '600px', 'pop_institution_list');
    	}
    	
    	/**
    	기관설정
    	**/
    	function setInstitution(val)
    	{
    		var list = val;
    		var institution_name = "";
    		var institution_code = "";
    		$.each(list, function (k,v){
    			
    			console.log(v.code+"/"+v.institution_name);
    			
    			if(institution_name=="")
    			{
    				institution_code =  v.code;
    				institution_name = v.institution_name;
        				
    			}
    			else
    			{
    				institution_code = institution_code +","+ v.code;
    				institution_name = institution_name +","+v.institution_name;
    			}
    		});
    		$("#institution_list").html(institution_name);
    		$("input[name=institution_code]").val(institution_code);
    		$("input[name=institution_name]").val(institution_name);
    	}
    	
    	/**
    	해당 Feq 삭제
    	**/
    	function deleteFAQ()
    	{
    		var frm = document.getElementById("frm");
    		
    		if (confirm("해당 FAQ을 정말 삭제하시겠습니까?\n삭제된 FAQ는 복구는 불가능 합니다. 신중하게 신행해주시기 바랍니다.") == true)
    		{  
    			frm.action = "<c:url value='/faq/faq_del.do'/>";
    			frm.submit();
    		}
    	}
    	
    </script>
   
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />