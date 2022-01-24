<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_layout" />
	<div id="PageHeight" class="container-fluid">
		
		<!-- navi -->
		<ul class="breadcrumb">
            <li>
            	<c:choose>
  		 			<c:when test="${pageType eq 'insert'}"><i class="fa-icon-home"></i> Home / 시스템 관리 / <strong>기관 등록</strong></c:when>
  		 			<c:when test="${pageType eq 'update'}"><i class="fa-icon-home"></i> Home / 시스템 관리 / <strong>기관 수정</strong></c:when>
       		 	</c:choose>
            </li>
        </ul>
			
	        <div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<c:choose>
	       		 			<c:when test="${pageType eq 'insert'}"><h2><i class="fa-icon-group"></i><span class="break"></span>기관 등록</h2></c:when>
	       		 			<c:when test="${pageType eq 'update'}"><h2><i class="fa-icon-group"></i><span class="break"></span>기관 수정</h2></c:when>
       		 		</c:choose>
					</div>
        			<div class="box-content">
	       		 	 <form class="form-horizontal" role="form" name='frm' id='frm' method='post'>
	       		 		<table class="table table-bordered table-striped">
	       		 		<colgroup>
	       		 			<col width="200px">
	       		 			<col width="*">
	       		 		</colgroup>
	       		 		 <tbody>
	       		 		 	<c:choose>
    		 					<c:when test="${ pageType eq 'update'}">
    		 					<tr>
		       		 				<th>기관코드</th>
		       		 				<td>
		       		 					<c:out value="${detail.code }"/>
		       		 				</td>
		       		 			</tr>
    		 					</c:when>
    		 				</c:choose>
	       		 		 	<tr>
	       		 				<th>기관명<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td>
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='text' name='institution_name' required='required' class="fl" autocomplete="off" value="" maxlength="16">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type="text" name="institution_name" required='required' class="fl" value="<c:out value="${detail.institution_name }"/>"  maxlength="16"/>
	       		 						</c:when>
	       		 					</c:choose>
	       		 					
	       		 				</td>
	       		 			</tr>
	       		 			<tr>
	       		 				<th>관리자 이름<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td>
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='text' name='institution_owner_name' required='required' class="fl"  maxlength="10" >
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type='text' name='institution_owner_name' required='required' class="fl" value="<c:out value="${detail.institution_owner_name }"/>"  maxlength="10">
	       		 							
	       		 						</c:when>
	       		 					</c:choose>	
	       		 					
	       		 					
	       		 				</td>
	       		 			</tr>
	       		 			<tr>
	       		 				<th>관리자 이메일<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td>
	       		 				
	       		 				<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='email' name='institution_owner_email' required='required' class="fl"  maxlength="50">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type='email' name='institution_owner_email' required='required' class="fl" value="<c:out value="${detail.institution_owner_email }"/>"  maxlength="50">
	       		 							
	       		 						</c:when>
	       		 					</c:choose>	
	       		 				</td>
	       		 			</tr>
	       		 			<tr>
	       		 				<th>관리자 연락처<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td>
	       		 					
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='text' name='institution_owner_phone'  placeholder="ex)053-111-1111" required='required' phone="phone" class="fl"  maxlength="20">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type='text' name='institution_owner_phone'  placeholder="ex)053-111-1111" required='required' phone="phone" class="fl" value="<c:out value="${detail.institution_owner_phone }"/>" maxlength="20">
	       		 							
	       		 						</c:when>
	       		 					</c:choose>	
	       		 				</td>
	       		 			</tr>
	       		 			<tr>
	       		 				<th>기관위치</th>
	       		 				<td>
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='text' name='institution_owner_location' maxlength="50">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type='text' name='institution_owner_location' value="<c:out value="${detail.institution_owner_location }"/>" maxlength="50">
	       		 							
	       		 						</c:when>
	       		 					</c:choose>	
	       		 				</td>
	       		 			</tr>
	       		 			<tr>
	       		 				<th>생성자</th>
	       		 				<td>
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type="text" name="create_userid" required='required' class="fl" value="<c:out value="${userInfo.name }"/>" readonly="readonly">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<c:out value="${detail.create_userid }"/>
	       		 							<input type="hidden" name="create_userid" required='required' class="fl" value="<c:out value="${userInfo.name }"/>" readonly="readonly">
	       		 						</c:when>	
	       		 					</c:choose>
	       		 					
	       		 				</td>
	       		 			</tr>
	       		 			
					    </tbody>
	       		 		</table>
	       		 		<input type='hidden' name='pageType' value="<c:out value="${pageType }"/>">
	       		 		<c:choose>
	 						<c:when test="${ pageType eq 'update'}">
	 							<input type='hidden' name='code' value="<c:out value="${detail.code }"/>">
	 							
	 						</c:when>
	 					</c:choose>	
	       		 	</form>
	       		 	
	       		 	<div class="pull-right">
	       		 				<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<button type="button" class="btn btn-default" onClick='insertInstitutionProc();'>등록</button>
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<button type="button" class="btn btn-default" onClick='updateInstitution();'>수정</button>
	       		 							<c:choose>
												<c:when test="${userInfo.lev == 'admin'}">
		       		 								<button type="button" class="btn btn-default" onClick='deleteInstitution();'>삭제</button>
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
    <script>
    	function movelist()
    	{
    		location.href="/system/institutionList.do";
    	}
    	
    	/**
    	수정
    	**/
    	function updateInstitution()
    	{
    			if($("#frm").valid()){
    				var frm = document.getElementById("frm");
    				frm.action = "<c:url value='/system/institutionProc.do'/>";
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
    	function insertInstitutionProc(){
    		
    		if($("#frm").valid()){
    			var frm = document.getElementById("frm");
    			frm.action = "<c:url value='/system/institutionProc.do'/>";
    			if(confirm("등록하시겠습니까?")){
    				frm.submit();
    			}
    		}else{
    			alert("입력값을 확인하세요");
    		}    		
    	}
    	
    	$(function(){
    		
    		$("#frm").validate({
    			rule: {
    				institution_name:{
    					required:true
    				}, institution_owner_name:{
    					required:true
    				}, institution_owner_email:{
    					required:true
    					,email:true
    				}, institution_owner_phone:{
    					required:true
    					,phone:true
    				}, create_userid:{
    					required:true
    				}
    			},
    			messages: {
					institution_name:{
						required:"기관명을 입력하세요"
    				}, institution_owner_name:{
    					required:"관리자명을 입력하세요"
    				}, institution_owner_email:{
    					required:"이메일을 입력하세요"
    					,email:"정상적인 이메일을 입력하여주세요"
    				}, institution_owner_phone:{
    					required:"연락처를 입력하세요"
    					, phone: "정확한 연락처를 입력해 주세요(053-111-1111)"
    				}, create_userid:{
    					required: "생성자를 입력하세요"
    				}
    			}
    		});
    	});
    	
    	/**
      	 기관 삭제
      	**/
      	function deleteInstitution()
      	{
      		var frm = document.getElementById("frm");
      		
      		if (confirm("해당 기관을 정말 삭제하시겠습니까?\n해당 기관에 포함된 모든 정보도 함께 삭제되며, 복구 불가능 합니다. \n신중하게 신행해주시기 바랍니다.") == true)
      		{  
      			frm.action = "<c:url value='/system/institution_del.do'/>";
      			frm.submit();
      		}
      	}
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />