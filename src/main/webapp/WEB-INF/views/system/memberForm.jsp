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
   		 			<c:when test="${pageType eq 'insert'}"><i class="fa-icon-home"></i> Home / 시스템 관리 / <strong>사용자 등록</strong></c:when>
   		 			<c:when test="${pageType eq 'update'}"><i class="fa-icon-home"></i> Home / 시스템 관리 / <strong>사용자 수정</strong></c:when>
       		 	</c:choose>                 
            </li>
        </ul>
			 <div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<c:choose>
	       		 			<c:when test="${pageType eq 'insert'}"><h2><i class="fa-icon-group"></i><span class="break"></span>사용자 등록</h2></c:when>
	       		 			<c:when test="${pageType eq 'update'}"><h2><i class="fa-icon-group"></i><span class="break"></span>사용자 수정</h2></c:when>
       		 			</c:choose>
					</div>
        			<div class="box-content">
        			
	        
	       		 	  	 <form class="form-horizontal" role="form" id='frm' name='frm' method='post' autocomplete="off">
	       		 	  	 <!--자동완성방지용 더미폼-->
						<div style="position:absolute;left: -10000000000000000000000000000000">
						<input style="display:none">
						<input type="password" style="display:block;width: 0px;height: 0px" >
						</div>
						<!--더미폼 끝-->
	       		 	  	 
	       		 		<table class="table table-bordered table-striped">
	       		 		<colgroup>
	       		 			<col width="200px">
	       		 			<col width="*">
	       		 		</colgroup>
	       		 		 <tbody>
					    	<tr>
	       		 				<th>아이디<img src="<c:url value='/'/>images/required.gif" width="15" height="15" />
	       		 				
	       		 				</th>
	       		 				<td colspan="3">
	       		 				
	       		 				<input style="display:none">
								<input type="password" style="display:none">
	       		 				
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='text' name='userid' required='required' class="fl" maxlength="20" autocomplete="off" value="">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<c:out value="${detail.userid }"/>
	       		 							<input type='hidden' name = 'code' required='required' class="fl" maxlength="20" autocomplete="off"  value='<c:out value="${detail.code }"/>'>
	       		 						</c:when>
	       		 					</c:choose>
	       		 					
	       		 				</td>
	       		 			</tr>
	       		 			
	       		 			<tr>
	       		 				<th>비밀번호<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='password' name='userpw' class="fl" autocomplete="off" value="" maxlength="20">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							변경<input type="checkbox" name="isChgPaswd" id="isChgPaswd" value='0'>
	       		 							<input type='password' name='userpw' class="fl" autocomplete="off" value="" maxlength="20">
	       		 							
	       		 						</c:when>
	       		 					</c:choose>	
	       		 					
	       		 				
	       		 				</td>
	       		 			</tr>
	       		 			<tr>
	       		 				<th>이름<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='text' name='name' required='required' class="fl" maxlength="10">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type='text' name='name' required='required' class="fl" value="<c:out value="${detail.name }"/>" maxlength="10">
	       		 							
	       		 						</c:when>
	       		 					</c:choose>	
	       		 					
	       		 					
	       		 				</td>
	       		 			</tr>
	       		 			<tr>
	       		 				<th>회사명<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">
	       		 				
	       		 				<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='text' name='comp_name' required='required' class="fl"  maxlength="10">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type='text' name='comp_name' required='required' class="fl" value="<c:out value="${detail.comp_name }"/>" maxlength="10">
	       		 							
	       		 						</c:when>
	       		 					</c:choose>	
	       		 				</td>
	       		 			</tr>
	       		 			<tr>
	       		 				<th>이메일주소<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">	       		 					
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='email' name='email'  maxlength="40"  required='required' class="fl">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type='email' name='email'  maxlength="40"  required='required' class="fl" value="<c:out value="${detail.email}"/>">
	       		 						</c:when>
	       		 					</c:choose>	
	       		 				</td>
	       		 			</tr>
	       		 			<tr>
	       		 				<th>팩스</th>
	       		 				<td colspan="3">
	       		 					
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='text' name='fax'  phone="phone" placeholder="ex)053-111-1111"  class="fl">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type='text' name='fax' phone="phone" placeholder="ex)053-111-1111"  class="fl" value="<c:out value="${detail.fax }"/>">
	       		 						</c:when>
	       		 					</c:choose>	
	       		 				</td>
	       		 			</tr>
	       		 			<tr>
	       		 				<th>전화번호<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='text' name='phone'  phone="phone" placeholder="ex)053-111-1111"  required='required' class="fl">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type='text' name='phone' phone="phone" placeholder="ex)053-111-1111"  required='required' class="fl" value="<c:out value="${detail.phone }"/>">
	       		 							
	       		 						</c:when>
	       		 					</c:choose>	
	       		 				</td>
	       		 			</tr>
	       		 			<tr>
	       		 				<th>우편번호</th>
	       		 				<td colspan="3">
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='text' name='zcode' maxlength="7">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type='text' name='zcode' maxlength="7" value="<c:out value="${detail.zcode }"/>">
	       		 							
	       		 						</c:when>
	       		 					</c:choose>
	       		 				</td>
	       		 			</tr>
	       		 			<tr>
	       		 				<th>주소1</th>
	       		 				<td colspan="3">
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='text' name='comp_addr1' maxlength="20">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type='text' name='comp_addr1' maxlength="50" value="<c:out value="${detail.comp_addr1 }"/>">
	       		 						</c:when>
	       		 					</c:choose>
	       		 				</td>
	       		 			</tr>
	       		 			<tr>
	       		 				<th>주소2</th>
	       		 				<td colspan="3">
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='text' name='comp_addr2'>
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type='text' name='comp_addr2' value="<c:out value="${detail.comp_addr2 }"/>">
	       		 						</c:when>
	       		 					</c:choose>
	       		 				</td>
	       		 			</tr>
	       		 			
	       		 			<tr>
	       		 				<th>권한</th>
	       		 				<td colspan="3">
	       		 				<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<select name='lev'>
			       		 						<option value='admin'>관리자</option>
			       		 						<option value='institution_admin'>기관 관리자</option>
			       		 						<option value='institution_user'>기관 사용자</option>
			       		 					</select>
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<select name='lev'>
			       		 						<option value='admin'  					<c:if test="${detail.lev=='admin'}"> selected </c:if>>관리자</option>
			       		 						<option value='institution_admin'   	<c:if test="${detail.lev=='institution_admin'}"> selected </c:if>>기관 관리자</option>
			       		 						<option value='institution_user'   	<c:if test="${detail.lev=='institution_user'}"> selected </c:if>>기관 사용자</option>
			       		 					</select>
	       		 						</c:when>
	       		 					</c:choose>
	       		 					
	       		 				</td>
	       		 			</tr>
	       		 			
	       		 			<tr>
	       		 				<th>소속기관</th>
	       		 				<td colspan="2">
	       		 					
	       		 								<!-- 추가기관 리스트 -->
	       		 								<div id='institution_list'>
	       		 									<c:forEach var="authList" items="${authList}" varStatus="status">
	       		 										<c:choose>
	       		 											<c:when test="${status.count>1 }">
	       		 												, <c:out value="${authList.institution_name}"/>
	       		 												
	       		 												<c:set var="institution_code" value="${institution_code},${authList.institution_code}"/>
	       		 											</c:when>
	       		 											<c:otherwise>
	       		 												<c:out value="${authList.institution_name}"/>
	       		 												
	       		 												<c:set var="institution_code" value="${authList.institution_code}"/>	
	       		 											</c:otherwise>
	       		 										</c:choose>
	       		 										
	       		 									</c:forEach>
	       		 								</div>
	       		 								
	       		 								<input type='hidden' name='institution_code' class="fl" value='<c:out value="${institution_code}"/>'>
	       		 								<input type='hidden' name='institution_name' required='required' class="fl" value=''>
	       		 							</td>
	       		 							
	       		 							<td width="200px">
	       		 								<a href='#' onClick="institution_pop();">소속기관 수정</a>
	       		 							</td>
	       		 						</tr>
	       		 						<tr>
				       		 	 			<th>생성자</th>
				       		 				<td colspan="3">
				       		 					<c:choose>
				       		 						<c:when test="${ pageType eq 'insert'}">
				       		 							<input type="text" name="cuser" required='required' class="fl" value="<c:out value="${userInfo.name }"/>" readonly="readonly">
				       		 						</c:when>
				       		 						<c:when test="${ pageType eq 'update'}">
				       		 							<c:out value="${detail.cuser }"/>
				       		 						</c:when>	
				       		 					</c:choose>
				       		 					
				       		 				</td>
				       		 			</tr>
	       		 					</table>
	       		 				</td>
	       		 			</tr>
	       		 			
					    </tbody>
	       		 		</table>
	       		 		<input type='hidden' name='pageType' value="<c:out value="${pageType }"/>">
	       		 	</form>
	       		 	
	       		 	<div class="pull-right">
	       		 				<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<button type="button" class="btn btn-default" onClick='insertMmeber();'>등록</button>
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<button type="button" class="btn btn-default" onClick='updateMmeber();'>수정</button>
	       		 							<c:choose>
												<c:when test="${userInfo.lev == 'admin'}">
		       		 								<button type="button" class="btn btn-default" onClick='deleteMmeber();'>삭제</button>
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
    		location.href="/system/memberList.do";
    	}
    	
    	/**
    	수정
    	**/
    	function updateMmeber()
    	{
    		if($("#frm").valid()){
    			var frm = document.getElementById("frm");
    			frm.action = "<c:url value='/system/memberProc.do'/>";
    			if(confirm("수정하시겠습니까?")){
    				if(($("input[name='isChgPaswd']:checked").length) > 0)
    				{
    					if(($("input[name='userpw']").val().length) < 4)
    					{
    						alert("비밀번호를 입력하세요.");
    						
    					}else{
    						frm.submit();
    					}    					
    				}
    				frm.submit();    				
    			}
    		}else{
				alert("입력값을 확인하세요");				
			}
    	}
    	/**
    	등록
    	**/
    	function insertMmeber(){
    		if($("#frm").valid()){
    			var frm = document.getElementById("frm");
    			frm.action = "<c:url value='/system/memberProc.do'/>";
    			if(confirm("저장하시겠습니까?")){
    				if($("input[name='userpw']").val().length < 4)
					{
						alert("비밀번호를 입력하세요.");
						
					}else{
						frm.submit();
					} 

    			}
    		}else{
				alert("입력값을 확인하세요");
				
			}
    	}
    	
    	$(function() {    		
    		
    		$("#frm").validate({
    			rule: {
    				userid:{
    					required:true
    				}, name:{
    					required:true
    				}, comp_name:{
    					required:true
    				}, phone:{
    					required:true
    					,phone:true
    				}, institution_name:{
    					required:true
    				}, cuser:{
    					required:true
    				}, fax:{
    					phone:true
    				}
    			},
    			messages: {
    				userid:{
    					required: "사용자 ID를 입력하세요"
    				}, name:{
    					required: "사용자 이름을 입력하세요"
    				}, comp_name:{
    					required: "회사명을 입력하세요"
    				}, email:{
    					required: "이메일 주소를 입력하세요"
    				}, phone:{
    					required: "전화번호를 입력하세요"
    					,phone:"정확한 전화번호를 입력해 주세요(053-111-1111)"
    				}, institution_name:{
    					required: "소속기관을 선택하세요"
    				}, cuser:{
    					required: "생성자를 입력하세요"
    				},fax:{
    					phone:"정확한 FAX 번호를 입력해 주세요(053-111-1111)"
    				}
    				
    			}
    		});
    	});    	
    	
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
   	 카테고리 삭제
   	**/
   	function deleteMmeber()
   	{
   		var frm = document.getElementById("frm");
   		
   		if (confirm("해당 계정을 정말 삭제하시겠습니까?\n해당 계정에 대한 접속로그도 함께 삭제되며, 복구 불가능 합니다. \n신중하게 신행해주시기 바랍니다.") == true)
   		{  
   			frm.action = "<c:url value='/system/member_del.do'/>";
   			frm.submit();
   		}
   	}
    </script>
   
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />