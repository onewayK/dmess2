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
                 <i class="fa-icon-home"></i> Home / 시스템 관리 / <strong>과금로그</strong>
            </li>
        </ul>
        
        <!-- 검색 -->
        <div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-money"></i><span class="break"></span>과금로그</h2>
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
			        				<option value='name' <c:if test="${searchVO.searchCondition=='name' }"> selected </c:if>>이름</option>
			        			</select>
			        			<input type='text' name='searchKeyword' value="${searchVO.searchKeyword }">
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
					        <th>과금카운터</th>
					        <th>코멘트</th>
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
				       		 						<c:when test="${list.type=='plus' }">
				       		 							과금추가
				       		 						</c:when>
				       		 						<c:when test="${list.type=='minus' }">
				       		 							과금사용
				       		 						</c:when>
				       		 						<c:otherwise>
				       		 							기타
				       		 						</c:otherwise>
				       		 					</c:choose>
				       		 				</td>
				       		 				<td><c:out value="${list.now_count}"/></td>
				       		 				<td><c:out value="${list.comment}"/></td>
				       		 				<td><c:out value="${list.sdate}"/></td>
				       		 				<td><c:out value="${list.training_name}"/></td>
				       		 			</tr>
				       		 			</c:forEach>
						    		</c:when>
						    		<c:otherwise>
						    			<tr>
				       		 				<td colspan="7" align="center">no list</td>
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
    	
    /**
    검색
    **/
	function fn_search()
	{
    	document.search.pageNo.value = '1';
		document.search.action = "/system/paymentLogList.do";
		document.search.submit();
	}
	
    /**
    페이지 이동
    **/
	function goPage(pageno)
	{
		document.search.pageNo.value = pageno;
		document.search.action = "/system/paymentLogList.do";
		document.search.submit();
	}
    
    	
    
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />