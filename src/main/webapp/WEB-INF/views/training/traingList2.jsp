<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_layout" />
	<script src="<c:url value='/js/bootstrap/bootstrap-dialog.js'/>"></script>

	<!-- bootstrap dialog -->
	<link href="<c:url value='/css/bootstrap/bootstrap-dialog.css'/>" rel="stylesheet">
		
	<div id="PageHeight" class="container-fluid">
		
		<!-- navi 
		<ul class="breadcrumb">
            <li>
                  <i class="fa-icon-home"></i> Home / 훈련관리 /<strong>훈련리스트</strong>
            </li>
        </ul>
        -->
        <br>
        <ul class="nav nav-tabs">
		  <li><a href="<c:url value='/training/TrainingList.do'/>">훈련리스트</a></li>
		  <li class="active"><a href="<c:url value='/training/TrainingList2.do'/>">취향분석 훈련리스트</a></li>
		</ul>
  
        
       		<!-- 검색 -->
        	<form name='search' method="post">
        	<input type='hidden' name='pageNo' value='<c:out value="${searchVO.pageNo }"/>'>
        	
        	<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-user"></i><span class="break"></span>취향분석 훈련리스트</h2>
					</div>
					<div class="box-content">
        	
        					<div class="form-horizontal">
								<div class="control-group span9">
								  <label class="control-label" for="typeahead">검색인자</label>
								  <div class="controls">
									
									<select name='searchInstitution'>
										<option value="">선택하세요</option>
										<c:forEach var="list2" items="${list2}" varStatus="status">																						
											<option value="${list2.code }" <c:if test="${searchVO.searchInstitution eq list2.code }"> selected </c:if>><c:out value="${list2.institution_name}"/></option>												
										</c:forEach>										
									</select>									
									
									<select name="searchCondition">
				        				<option value='tname' <c:if test="${searchVO.searchCondition=='tname' }"> selected </c:if>>훈련명</option>
				        				<option value='send_name' <c:if test="${searchVO.searchCondition=='semd_name' }"> selected </c:if>>발신인</option>
				        			</select>
				        			<input type='text' name='searchKeyword' value="${searchVO.searchKeyword }">
				        			
								  </div>
								</div>
								<div class="pull-right">
									<a href='#' onClick='fn_search()' class="btn">검색</a>
								</div>
							</div>
        	
	        </form>
	        
	       		 	<table class="table table-bordered table-striped">
	       		 		<colgroup>
	       		 			<col width="60px">
	       		 			<col width="250px">
	       		 			<col width="*">
	       		 			<col width="100px">
	       		 			<col width="200px">
	       		 			<col width="60px">
	       		 			<col width="60px">
	       		 			<col width="100px">
	       		 			<col width="160px">
	       		 			<col width="150px">
	       		 		</colgroup>
	       		 		 <thead>
					      <tr>
					        <th rowspan='2'>번호</th>
					        <th rowspan='2'>기관/그룹</th>
					        <th rowspan='2'>훈련명</th>
					        <th rowspan='2'>발신인</th>
					        <th rowspan='2'>발신email</th>
					        <th colspan="3" align="center" width="250px" >훈련타입</th>
					        <th rowspan='2'>등록일</th>
					        <th rowspan='2'>진행상태</th>
					      </tr>
					      <tr>
					      		<th>메일열람</th>
					      		<th>링크(URL)실행</th>
					      		<th>첨부파일 실행</th>
					      </tr>
					      
					    </thead>
					    <tbody>
					    	<c:choose>
						    		<c:when test="${fn:length(list)>0}">
						    			<c:forEach var="list" items="${list}" varStatus="status">						    			
								    	<tr>
				       		 				<td><c:out value="${list.code}"/></td>
				       		 				
				       		 				<td>
				       		 					<c:out value="${list.institution_name}"/> / 
				       		 					<c:choose>
				       		 						<c:when test="${ list.group_name eq null || list.group_name eq ''}">
				       		 							[그룹미지정]
				       		 						</c:when>
				       		 						<c:otherwise>
				       		 							<c:out value="${list.group_name}"/>	
				       		 						</c:otherwise>
				       		 					</c:choose>
				       		 					
				       		 				</td>
				       		 				
				       		 				<td>
				       		 					<c:out value="${list.tname}"/>
				       		 					<c:choose>
					       		 					<c:when test="${list.del_flag == 'y' && list.del_type=='a'}">
					       		 						<br><p ><font color='red'>(자동 삭제 정책에 의해서 훈련대상자 정보가 삭제처리됨)</font></p>
					       		 					</c:when>
					       		 					<c:when test="${list.del_flag == 'y' && list.del_type=='a'}">
					       		 						<br><p ><font color='red'>(수동 삭제 정책에 의해서 훈련대상자 정보가 삭제처리됨)</font></p>
					       		 					</c:when>
				       		 					</c:choose>
				       		 				
				       		 				</td>
				       		 				<td><c:out value="${list.send_name}"/></td>
				       		 				<td><c:out value="${list.send_email}"/></td>
				       		 				<td><c:out value="${list.training_type1}"/></td>
				       		 				<td><c:out value="${list.training_type2}"/></td>
				       		 				<td><c:out value="${list.training_type3}"/></td>
				       		 				<td><c:out value="${list.sdate}"/></td>				       		 				
				       		 				<td>
				       		 				<c:choose>
				       		 					<c:when test="${list.del_flag == 'y' && list.del_type=='a'}">
				       		 						<a class="btn" onClick="view('${list.code}')">보기</a>
				       		 						
				       		 					</c:when>
				       		 					<c:when test="${list.del_flag == 'y' && list.del_type=='a'}">
				       		 						<a class="btn" onClick="view('${list.code}')">보기</a>
				       		 						
				       		 					</c:when>
				       		 					<c:otherwise>
				       		 							<c:choose>
				       		 								<c:when test="${list.status=='step1' }">
						       		 							<a class="btn" onClick="view('${list.code}')">준비(1)</a>
						       		 						</c:when>
				       		 								<c:when test="${list.status=='ready' }">
						       		 							
						       		 							<a class="btn" onClick="view('${list.code}')">준비(2)</a>
						       		 							
						       		 							<a class="btn" onClick='copy("${list.tname}","${list.code}");'>복사</a>
						       		 							
						       		 						</c:when>
						       		 						<c:when test="${list.status=='send' || list.status=='sending' || list.status=='receive'}">
						       		 							<a class="btn" onClick="view('${list.code}')">실행중</a>
						       		 						</c:when>				       		 						
						       		 						<c:when test="${list.status=='end' }">
						       		 							<a class="btn" onClick="view('${list.code}')">완료</a>
						       		 							
						       		 							<a class="btn" onClick='copy("${list.tname}","${list.code}");'>복사</a>
						       		 						</c:when>
						       		 						<c:when test="${list.status=='stop' }">
						       		 							<a class="btn" onClick="view('${list.code}')">강제종료</a>
						       		 						</c:when>
						       		 						<c:otherwise>
						       		 							null
						       		 						</c:otherwise>
						       		 						
						       		 					</c:choose>
						       		 				</c:otherwise>
				       		 				</c:choose>
				       		 				</td>
				       		 			</tr>				       		 			
				       		 			</c:forEach>
						    		</c:when>
						    		<c:otherwise>
						    			<tr>
				       		 				<td colspan="9" align="center">no list</td>
				       		 			</tr>		
		       		 				 </c:otherwise>
					    	</c:choose>
	       		 			
					    </tbody>
	       		 	</table>
	       		 	
	       		 	
	       		 	<div class="pagination pagination-centered">
						  <ul>
							<li><a href="javascript:goPage(${pageing.firstPageNo})" class="first">처음</a></li>
							<li><a href="javascript:goPage(${pageing.prevPageNo})" class="prev">이전</a></li>
							
							<c:forEach var="i" begin="${pageing.startPageNo}" end="${pageing.endPageNo}" step="1">
								<c:choose>
									<c:when test="${i eq pageing.pageNo}">
										<li class="active"><a href="javascript:goPage(${i})" class="selected">${i}</a></li>
									</c:when>
									<c:otherwise>
										<li><a href="javascript:goPage(${i})">${i}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<li><a href="javascript:goPage(${pageing.nextPageNo})" class="next">다음</a></li>
							<li><a href="javascript:goPage(${pageing.finalPageNo})" class="last">마지막</a></li>
						  </ul>
						</div>   
	       		 	<div class="pull-right">
	       		 		<a href='/training/trainingForm2_step1.do' class="btn btn-primary">등록</a>
	       		 	</div>
	       		 	<div class="clearFix"></div>
       		 	</div>
			</div>
			</div>
			
    </div>
    <form name='frm' method="post">
    	<input type='hidden1' name='code' value='' hidden="hidden">
    </form>
    <script>
    
    	
    	/**
    	수정 및 상세보기
    	**/
    	function view(code)
    	{
    		document.frm.code.value = code ;
    		document.frm.action = "/training/trainingForm2.do";
    		document.frm.submit();
    		
    	}
    
	    /**
	    검색
	    **/
    	function fn_search()
    	{
    		document.search.pageNo.value = 1;
    		document.search.action = "/training/TrainingList2.do";
    		document.search.submit();
    	}
	    
	    function fn_reload()
	    {
	    	document.search.action = "/training/TrainingList2.do";
    		document.search.submit();
	    }
    	
	    /**
	    페이지 이동
	    **/
    	function goPage(pageno)
    	{
	    	document.search.pageNo.value = pageno;
	    	document.search.action = "/training/TrainingList2.do";
    		document.search.submit();
    	}
	    
	    /**
	     훈련 복사
	    **/
	    function copy(ori_title, code)
	    {
	    	var ajax_status = false;
	    	var title = "'"+ori_title.replace("'","")+"' 훈련복사";
			var messages ="";
			
			messages = "훈련대상자들은 제외된 상태에서 기존훈련명에 _copy 가 붙은 형태로 생성됩니다.";
			//messages = messages + "<label class='control-label' for='date01'>"+title +"&nbsp;"+"</>";
			
			
			var dia  = BootstrapDialog.show({
				title:title ,
		           message: messages,
		           closable: true,
		           closeByBackdrop: false,
		           closeByKeyboard: false,
		           buttons: [
								{
								    label: '복사',
								    action: function(dialogRef)
								    {
								    	var inputbox = $("input[name='val']").val();
								    	
								    	param = "code="+code;
								    	if (confirm("정말 복사하시겠습니까?") == true){   
								    	    
									    	$.ajax({
												type:'POST',
												url : "<c:url value='/training/training_copy.do'/>",
												data:param,
												dataType : "json",
												contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
												beforeSend: function() {
										        
												},
												success : function(json){
													ajax_status = true;
													console.log(json);
													if(json.status=="ok")
													{
														alert("정상적으로 훈련이 복사 되었습니다.");
														fn_reload();
													}
												},
												error:function(request,status,error){
													alert("복사가 실패하였습니다:"+error);
												}
												
											}).complete(function() {
															
									        });
									    	dialogRef.close();
										}
								    	
								        
								        
								    }
								},
		                    	{
				                	label: '닫기',
				                	action: function(dialogRef){
				                    	dialogRef.close();
				             		}
		           				}
							]
			
		       });
			
	    }
	    
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />