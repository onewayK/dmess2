<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_layout" />
	<div id="PageHeight" class="container-fluid">
		
		<!-- navi -->
		<ul class="breadcrumb">
            <li>
                 <i class="fa-icon-home"></i> Home / 시스템 관리 / <strong>훈련 서비스 로그</strong>
            </li>
        </ul>
        
        <!-- 검색 -->
        <div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-money"></i><span class="break"></span>훈련 서비스 로그</h2>
					</div>
        			<div class="box-content">
        			
        	<form name='search' method="post">
        			<input type='hidden' name='pageNo' value='${searchVO.pageNo }'>
    				<div class="form-horizontal">
							<div class="control-group span9">
						  <label class="control-label" for="typeahead">검색인자</label>
						  <div class="controls">
							<select name="searchCondition">
			        				<option value='userid' <c:if test="${searchVO.searchCondition=='userid' }"> selected </c:if>>아이디</option>
			        				<option value='title' <c:if test="${searchVO.searchCondition=='title' }"> selected </c:if>>서비스명</option>
			        			</select>
			        			<input type='text' name='searchKeyword' value="${searchVO.searchKeyword }">
			        			
			        			&nbsp;&nbsp;등록일자 검색
			        			<input type='text' name='searchBgnDe'		id='searchBgnDe' value='${searchVO.searchBgnDe}' style="width:100px">
			        			<input type='text' name='searchEndDe'		id='searchEndDe' value='${searchVO.searchEndDe}' style="width:100px">
						        			
						  </div>
						</div>
						<div class="pull-right">
							<a href='#' onClick='fn_search()' class="btn">검색</a>
						</div>
					</div>
	        </form>
	        
	        
	       		 	<table class="table table-bordered table-striped ">
	       		 		 <thead>
					      <tr>
					        <th>아이디</th>
					        <th>이름</th>
					        <th>타입</th>
					        <th>서비스명</th>
					        <th>코멘트</th>
					        <th>생성자</th>
					        <th>등록일</th>
					        <th>비고</th>
					      </tr>
					    </thead>
					    <tbody>
					    	<c:choose>
						    		<c:when test="${fn:length(list)>0}">
						    			<c:forEach var="list" items="${list}" varStatus="status">
								    	<tr>
				       		 				<td><c:out value="${list.userid}"/></td>
				       		 				<td><c:out value="${list.name}"/></td>
				       		 				<td>
				       		 					<!--<c:out value="${list.type}"/>-->
				       		 					<c:choose>
				       		 						<c:when test="${list.type=='create' }">
				       		 							서비스 생성
				       		 						</c:when>
				       		 						<c:when test="${list.type=='updaet' }">
				       		 							서비스 수정
				       		 						</c:when>
				       		 						<c:when test="${list.type=='delete' }">
				       		 							서비스 삭제
				       		 						</c:when>
				       		 						<c:when test="${list.type=='execute' }">
				       		 							훈련 실행
				       		 						</c:when>
				       		 						<c:otherwise>
				       		 							기타
				       		 						</c:otherwise>
				       		 					</c:choose>
				       		 				</td>
				       		 				<td><c:out value="${list.title}"/></td>
				       		 				<td><c:out value="${list.comment}"/></td>
				       		 				<td><c:out value="${list.create_user}"/></td>
				       		 				<td><c:out value="${list.sdate}"/></td>
				       		 				<td></td>
				       		 			</tr>
				       		 			</c:forEach>
						    		</c:when>
						    		<c:otherwise>
						    			<tr>
				       		 				<td colspan="8" align="center">no list</td>
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
	       		 	<div class="clearFix"></div>
       		 	</div>
       		 	</div>
       		 	</div>
    </div>
    <script>
    
    $(function() {
		$("#searchBgnDe").datepicker({
			showOn: "button",
			buttonImage: "<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif'/>",
			buttonImageOnly: true,
			dateFormat: "yy-mm-dd",
			buttonText: "calendar"
		});
		
		$("#searchEndDe").datepicker({
			showOn: "button",
			buttonImage: "<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif'/>",
			buttonImageOnly: true,
			dateFormat: "yy-mm-dd",
			buttonText: "calendar"
		});
		
	});	
    
    
    /**
    검색
    **/
	function fn_search()
	{
		if($("#searchBgnDe").val()=="" || $("#searchEndDe").val()=="")
    	{
    		alert("발송일자의 검색일을 선택해주세요!");
    		return ;
    	}    	
		
    	document.search.pageNo.value = '1';
		document.search.action = "/system/serviceLog_List.do";
		document.search.submit();
	}
	
    /**
    페이지 이동
    **/
	function goPage(pageno)
	{
		document.search.pageNo.value = pageno;
		document.search.action = "/system/serviceLog_List.do";
		document.search.submit();
	}
    
    	
    
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />