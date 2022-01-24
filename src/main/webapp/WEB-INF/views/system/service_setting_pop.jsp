<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="true" %>

<c:import url="/common/pageLink.do?link=inc/top_pop_layout" />
		<ul class="breadcrumb" style="width:93%">
            <li>
                <i class="fa-icon-home"></i> Home / 시스템 관리 / <strong>훈련 서비스 관리</strong>
            </li>
        </ul>    
        <ul class="nav nav-tabs2" >
				<li id="tabs1" <c:if test="${pageType eq 'insert'}"> class="active"  </c:if> onClick="tabs('1');"  >새로 생성</li>
				<li id="tabs2" <c:if test="${pageType eq 'update'}"> class="active"  </c:if>onClick="tabs('2');"  >기존 설정 수정</li>
		</ul>   
	<div id="content2">
			<div class="panel panel-default">
       		 	<div class="panel-heading">
       		 		
       		 	</div>
	       		 	 <form class="form-horizontal" role="form" name='frm' method='post'>
	       		 		<table class="table table-bordered">
	       		 		<colgroup>
	       		 			<col width="200px">
	       		 			<col width="*">
	       		 		</colgroup>
	       		 		 <tbody>
	       		 		 	<tr></tr>
  		 			<c:choose>
 		 				<c:when test="${ pageType eq 'update'}">
	       		 		 	<tr>
	       		 				<th>이전 항목</th>
	       		 				<td colspan="3">
		       		 				<select name='update_list' id='update_list' onchange="change_service(this.value);">		       		 		 			
		       		 		 			<option value="-1">선택하세요</option>
		       		 		 			<c:forEach var="serviceList" items="${serviceList}" varStatus="status">
												<option value="<c:out value="${serviceList.code}"/>"  <c:if test="${detail.code eq serviceList.code }"> selected </c:if>><c:out value="${serviceList.title}"/></option>
						       		 	</c:forEach>	
		       		 		 		</select>		       		 		 		
	       		 				</td>
	       		 			</tr>	
       		 			</c:when>
       		 		</c:choose>
					    	<tr>
	       		 				<th>아이디<img src="<c:url value='/'/>images/required.gif" width="15" height="15" />
	       		 				</th>
	       		 				<td colspan="3">
      		 						${memberInfo.userid }(${memberInfo.name })
	       		 				</td>
	       		 			</tr>	       		 	
	       		 			
	       		 	<c:choose>
 		 				<c:when test="${ pageType == 'update' &&( detail.code == '' || detail.code == null ) }">		
 		 				
 		 				</c:when>
 		 				<c:otherwise>
 		 				
	       		 			<tr>
	       		 				<th>서비스명<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input type='text' name='title' id='title' required='required' class="fl" maxlength="10">
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input type='text' name='title' id='title' required='required' class="fl" value="<c:out value="${detail.title }"/>" maxlength="10">
	       		 						</c:when>
	       		 					</c:choose>	
	       		 				</td>
	       		 			</tr>
	       		 			
	       		 			<tr>
	       		 				<th>전체 훈련 기간<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">
	       		 				
									  	<input style="width: 100px" readonly type='text' name='start_date' id='start_date' value="<c:if test="${pageType=='update'}"><c:out value="${detail.start_date }"/></c:if>">
										<input style="width: 100px" readonly type='text' name='end_date' id='end_date' value="<c:if test="${pageType=='update'}"><c:out value="${detail.end_date }"/></c:if>">
										<span id="date_display" name="date_display"  style="display:none; font_size=15px;">
										<strong>	(총 훈련 기간 :  <span id="date_num" name="date_num"></span>일)</strong>
										</span>
	       		 				</td>
	       		 			</tr>
	       		 			
	       		 			<tr>
	       		 				<th>테스트 훈련 발송인원 수<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">	       		 					
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input style="width: 70px" type='number' name='test_send_number' id='test_send_number' min='0' maxlength="40" class="fl" value="">&nbsp;명
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input style="width: 70px" type='number' name='test_send_number' id='test_send_number' min='0' maxlength="40" class="fl" value="<c:out value="${detail.test_send_number}"/>">&nbsp;명
	       		 						</c:when>
	       		 					</c:choose>	
	       		 				</td>
	       		 			</tr>
	       		 			
	       		 			<tr>
	       		 				<th>실제 훈련 발송인원 수<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">	       		 					
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input style="width: 70px" type='number' name='real_send_number' id='real_send_number' min='0' maxlength="40" class="fl" value="">&nbsp;명
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input style="width: 70px" type='number' name='real_send_number' id='real_send_number' min='0' maxlength="40" class="fl" value="<c:out value="${detail.real_send_number}"/>">&nbsp;명
	       		 						</c:when>
	       		 					</c:choose>	
	       		 				</td>
	       		 			</tr>
	       		 			
	       		 			<tr>
	       		 				<th>자동 삭제 사용 유무<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">
	       		 					
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<select name='auto_del_type' id='auto_del_type'>
			       		 						<option value='Y'>사용</option>
			       		 						<option value='N' selected >마사용</option>
			       		 					</select>			       		 							       		 					
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<select name='auto_del_type' id='auto_del_type'>
			       		 						<option value='Y'  	<c:if test="${detail.auto_del_type=='Y'}"> selected </c:if>>사용</option>
			       		 						<option value='N'   	<c:if test="${detail.auto_del_type=='N'}"> selected </c:if>>미사용</option>
			       		 					</select>	       		 					
	       		 						</c:when>
	       		 					</c:choose>
	       		 					
	       		 				</td>
	       		 			</tr>
	       		 			
       		 				<tr  name="auto_test_del_date_display" id="auto_test_del_date_display" <c:if test="${ pageType eq 'insert' or detail.auto_del_type=='N'}">style="display:none" </c:if>>
	       		 				<th>테스트  훈련 자동 삭제일<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">	       		 					
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input style="width: 70px" type='number' name='auto_test_del_date' id='auto_test_del_date' min="0" maxlength="40" class="fl" value='' >&nbsp;일 이후	
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input style="width: 70px" type='number' name='auto_test_del_date' id='auto_test_del_date' min="0" maxlength="40" class="fl" value="<c:out value="${detail.auto_test_del_date}"/>">&nbsp;일 이후	
	       		 						</c:when>
	       		 					</c:choose>	
	       		 				</td>
       		 				</tr>
       		 				
       		 				<tr  name="auto_real_del_date_display" id="auto_real_del_date_display" <c:if test="${ pageType eq 'insert' or detail.auto_del_type=='N'}">style="display:none" </c:if>>
	       		 				<th>실제 훈련 자동 삭제일<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">	       		 					
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input style="width: 70px" type='number' name='auto_real_del_date' id='auto_real_del_date' min="0" maxlength="40" class="fl" value='' >&nbsp;일 이후	
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input style="width: 70px" type='number' name='auto_real_del_date' id='auto_real_del_date' min="0" maxlength="40" class="fl" value="<c:out value="${detail.auto_real_del_date}"/>">&nbsp;일 이후	
	       		 						</c:when>
	       		 					</c:choose>	
	       		 				</td>
       		 				</tr>
	       		 				
	       		 				
	       		 			
	       		 			
	       		 			<tr>
	       		 				<th>수동 삭제 사용 유무<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">
	       		 					
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<select name='passive_del_type' id='passive_del_type'>
			       		 						<option value='Y'>사용</option>
			       		 						<option value='N' selected >마사용</option>
			       		 					</select>
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<select name='passive_del_type' id='passive_del_type'>
			       		 						<option value='Y'  	<c:if test="${detail.passive_del_type=='Y'}"> selected </c:if>>사용</option>
			       		 						<option value='N'   	<c:if test="${detail.passive_del_type=='N'}"> selected </c:if>>미사용</option>
			       		 					</select>
	       		 						</c:when>
	       		 					</c:choose>
	       		 					
	       		 				</td>
	       		 			</tr>
	       		 			
	       		 			<tr  name="passive_test_del_date_display" id="passive_test_del_date_display" <c:if test="${ pageType eq 'insert' or detail.auto_del_type=='N'}">style="display:none" </c:if>>
	       		 				<th>테스트  훈련  최대 보관일<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">	       		 					
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input style="width: 70px" type='number' name='passive_test_del_date' id='passive_test_del_date' min="0" maxlength="40" class="fl" value='' >&nbsp;일 이후	
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input style="width: 70px" type='number' name='passive_test_del_date' id='passive_test_del_date' min="0" maxlength="40" class="fl" value="<c:out value="${detail.passive_test_del_date}"/>">&nbsp;일 이후	
	       		 						</c:when>
	       		 					</c:choose>	
	       		 				</td>
       		 				</tr>
       		 				
       		 				<tr  name="passive_real_del_date_display" id="passive_real_del_date_display" <c:if test="${ pageType eq 'insert' or detail.auto_del_type=='N'}">style="display:none" </c:if>>
	       		 				<th>실제  훈련 최대 보관일<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
	       		 				<td colspan="3">	       		 					
	       		 					<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 							<input style="width: 70px" type='number' name='passive_real_del_date' id='passive_real_del_date' min="0" maxlength="40" class="fl" value='' >&nbsp;일
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<input style="width: 70px" type='number' name='passive_real_del_date' id='passive_real_del_date' min="0" maxlength="40" class="fl" value="<c:out value="${detail.passive_real_del_date}"/>">&nbsp;일
	       		 						</c:when>
	       		 					</c:choose>	
	       		 				</td>
       		 				</tr>
	       		 			
	       		 			<c:choose>
       		 						<c:when test="${ pageType eq 'insert'}">
       		 								<tr>
					       		 				<th>서비스 설정 상태<img src="<c:url value='/'/>images/required.gif" width="15" height="15" /></th>
					       		 				<td colspan="3">
			       		 							<select name='service_use' id='service_use'>
					       		 						<option value='Y'  selected >사용</option>
					       		 						<option value='N' >미사용</option>
					       		 					</select>
					       		 				</td>
					       		 			</tr>	       		 				
       		 						</c:when>
       		 						<c:when test="${ pageType eq 'update'}">
	       		 							<tr>
					       		 				<th>서비스 설정 상태</th>
					       		 				<td colspan="3">
			       		 							<select name='service_use' id='service_use'>
					       		 						<option value='Y'  	<c:if test="${detail.service_use=='Y'}"> selected </c:if>>사용</option>
					       		 						<option value='N'   	<c:if test="${detail.service_use=='N'}"> selected </c:if>>미사용</option>
					       		 					</select>
					       		 				</td>
					       		 			</tr>
       		 						</c:when>
	       		 			</c:choose>
	       		 			
       		 				<tr>
	       		 		 		<th>comment</th>
	       		 		 		<td colspan="3">
	       		 		 			<textarea id='comment' name='comment' rows="10" cols="10" style="width:100%"></textarea>
	       		 		 		</td>
	       		 		 	</tr>	
      		 	</c:otherwise>
     		</c:choose>
					    </tbody>
	       		 		</table>
	       				
	       				<input type='hidden' name='uc' value="${memberInfo.code}"/>
	       				<input type='hidden' name='code' value="${detail.code}"/>
	       				<input type='hidden' name='pageType' value="${pageType}"/>
	       				
	       		 	</form>
	       		 	<table width='100%' border='0'>
				    	<tr>
				    		<td width="50px" align="right">
				    			<c:choose>
	       		 						<c:when test="${ pageType eq 'insert'}">
	       		 								<button type="button" class="btn btn-default" onClick='insertServicePop();'>생성</button>
	       		 						</c:when>
	       		 						<c:when test="${ pageType eq 'update'}">
	       		 								<button type="button" class="btn btn-default" onClick='insertServicePop();'>수정</button>
	       		 						</c:when>
	       		 					</c:choose>
	       		 			&nbsp;<a href='#' class="btn fr" onClick='window.close();'>닫기</a>	
							</td>
				    	</tr>
					 </table>
       		 	</div>
    </div>
    <script>
    var pageType = "<c:out value="${pageType}"/>";

    function dateDiff2(_date1, _date2) {

        var diffDate_1 = _date1 instanceof Date ? _date1 : new Date(_date1);
        var diffDate_2 = _date2 instanceof Date ? _date2 : new Date(_date2);
        
        diffDate_1 = new Date(diffDate_1.getFullYear(), diffDate_1.getMonth()+1, diffDate_1.getDate());
        diffDate_2 = new Date(diffDate_2.getFullYear(), diffDate_2.getMonth()+1, diffDate_2.getDate());

     
        var diff = Math.abs(diffDate_2.getTime() - diffDate_1.getTime());
        diff = Math.ceil(diff / (1000 * 3600 * 24));

        return diff+1;

    }
    
$(function() {	
		
		$("#start_date")
				.datepicker(
						{
							showOn : "button",
							buttonImage : "<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif'/>",
							buttonImageOnly : true,
							dateFormat : "yy-mm-dd",
							 prevText: '이전 달',
					        nextText: '다음 달',
					        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
					        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
					        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
					        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
					        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
							buttonText : "calendar",
							onSelect: function(dateText) {  
								
								if($("#end_date").val() != null && $("#end_date").val() != ""){											
									
									 if(Number($("#start_date").val().replace(/\-/g,''))>Number($("#end_date").val().replace(/\-/g,'')))
									{
											alert('서비스 시작일이 서비스 종료일 이후의 날짜입니다. \n다시 설정해주세요');
											$("#date_display").hide();	
											$("#start_date").val("");
											
									}else{
										
										var diff=dateDiff2($("#start_date").val(),this.value);												
										$("#date_display").show();									
										$("#date_num").html(diff);
									
									}								
									
								}else{
									$("#date_display").hide();
								}
								
						}
						});

		$("#end_date")
				.datepicker(
						{
							showOn : "button",
							buttonImage : "<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif'/>",
							buttonImageOnly : true,
							dateFormat : "yy-mm-dd",
							 prevText: '이전 달',
					        nextText: '다음 달',
					        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
					        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
					        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
					        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
					        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
							buttonText : "calendar",
							onSelect: function(dateText) {  
									
									if($("#start_date").val() != null && $("#start_date").val() != ""){											
										
										 if(Number($("#start_date").val().replace(/\-/g,''))>Number($("#end_date").val().replace(/\-/g,'')))
										{
												alert('서비스 종료일이 서비스 시작일 이전날짜입니다. \n다시 설정해주세요');
												$("#date_display").hide();	
												$("#end_date").val("");
												
										}else{
											
											var diff=dateDiff2($("#start_date").val(),this.value);												
											$("#date_display").show();									
											$("#date_num").html(diff);
										
										}								
										
									}else{
										alert("훈련 시작일자를 먼저 선택해주세요");
										$("#date_display").hide();
										$("#end_date").val("");
									}
									
							}

						});
		
		$('#auto_del_type').focus(function() 
				{
			
				}).change(function() {
					
					if($("#auto_test_del_date_display").css("display") == "none"){   
				        $('#auto_test_del_date_display').show();  
				    } else {  
				        $('#auto_test_del_date_display').hide();  
				    }  
					
					if($("#auto_real_del_date_display").css("display") == "none"){   
				        $('#auto_real_del_date_display').show();  
				    } else {  
				        $('#auto_real_del_date_display').hide();  
				    }  
					
					
				});
		
		$('#passive_del_type').focus(function() 
				{
			
				}).change(function() {
					
					if($("#passive_test_del_date_display").css("display") == "none"){   
				        $('#passive_test_del_date_display').show();  
				    } else {  
				        $('#passive_test_del_date_display').hide();  
				    }  
					
					if($("#passive_real_del_date_display").css("display") == "none"){   
				        $('#passive_real_del_date_display').show();  
				    } else {  
				        $('#passive_real_del_date_display').hide();  
				    }  
				});
		
		
		if(pageType == "update"){
			var diff=dateDiff2($("#start_date").val(),$("#end_date").val());												
			$("#date_display").show();									
			$("#date_num").html(diff);
		}
		
	});
    
    /**
     서비스 항목 저장 및 수정
    **/
    function insertServicePop()
    {
    	var confirm_msg = "";
    	
    	if($("input[name='pageType']").val() == "update"){
    		confirm_msg="해당 훈련 서비스를 수정하시겠습니까?";
    		
    		if($("select[name='update_list']").val()== ""){
    			alert("변경할 서비스를 선태해주세요!");
    			return ;
    		}
    		
    	}else{
    		confirm_msg="해당 훈련 서비스를 생성하시겠습니까?";
    	}
    	
    	if($("select[name='service_use']").val()== "Y")
		{
    		confirm_msg=confirm_msg + "\n서비스 설정 상태가 사용일 경우 이전 서비스 설정에 대해서는 비활성화 됩니다.";
		}
    	
    	//훈련기간 체크
		if($("#title").val()=="")
		{
			alert('서비스명을 입력하여주세요!');
			return ;
		}
    	
    	//서비스명 체크
		if($("input[name='title']").val().length > 20)
		{
			alert('서비스명 길이는 20자 이상을 초과할 수 없습니다.');
			return ;
		}else{
			var err_char=["[","]","/","*","?"];
			for(i=0;i<err_char.length;i++)
			{
				if($("input[name='title']").val().indexOf(err_char[i]) != -1){
					alert('서비스명에 해당 문자열([,],/,*,?)을 사용할 수  없습니다.');
					return ;
				}
			}
		}
    	
		//훈련기간 체크
		if($("#start_date").val()=="" || $("#end_date").val()=="")
		{
			alert('훈련기간을 입력하여주세요!');
			return ;
		}
		
		else if(Number($("#start_date").val().replace(/\-/g,''))>Number($("#end_date").val().replace(/\-/g,'')))
		{
			alert('서비스 시작일이 서비스 종료일보다 작아야합니다.');
			return ;
		}
    	
		//사전 테스트 훈련 발송 인원 체크
		if($("#test_send_number").val()=="" || $("#test_send_number").val() < 0)
		{
			alert('사전 테스트 발송 인원 수는 0 이상의 값으로 입력하여주세요!');
			return ;
		}
		
		//실제 훈련 발송 인원  체크
		if($("#real_send_number").val()=="" || $("#real_send_number").val() < 0)
		{
			alert('실제 훈련 발송 인원 수는 0 이상의 값으로 입력하여주세요!');
			return ;
		}
    	
		
		if($("select[name='auto_del_type']").val()== "Y")
		{
			if($("#auto_test_del_date").val()=="" ) 
			{
				alert('테스트 훈련 삭제 일을 입력해주세요.');
				return ;
			}
			
			if($("#auto_test_del_date").val() <= 0){
				alert('테스트 훈련 삭제 일은 1 이상의 값을 입력하셔야 합니다..');
				return ;
			}
			
			if($("#auto_real_del_date").val()=="" ) 
			{
				alert('실제 훈련 삭제 일을 입력해주세요.');
				return ;
			}
			
			if($("#auto_real_del_date").val() <= 0){
				alert('실제 훈련 삭제 일은 1 이상의 값을 입력하셔야 합니다..');
				return ;
			}
			
		}		
		
		if(confirm(confirm_msg)){
			document.frm.action = "/system/servicemanage_proc.do";
	    	document.frm.submit();
		}
    	
    }    	
    
    
    function change_service(code){    	
    	$("input[name='code']").val(code);
		document.frm.action = "/system/service_setting_pop.do";
    	document.frm.submit();
    	
    }
    
    
    function tabs(id)
	{
		if(id== 1 ){			
			$("input[name='pageType']").val("insert");
			document.frm.action = "/system/service_setting_pop.do";
	    	document.frm.submit();
		}else if (id == 2){			
			$("input[name='pageType']").val("update");
			document.frm.action = "/system/service_setting_pop.do";
	    	document.frm.submit();
		}
	}
    
    
    
    </script>