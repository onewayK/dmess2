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
                 <i class="fa-icon-home"></i> Home / 시스템 관리 / <strong>훈련 템플릿 관리</strong>
            </li>
        </ul>
        
        <!-- 검색 -->
        <div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-money"></i><span class="break"></span>훈련 템플릿 관리</h2>
					</div>
        			<div class="box-content">
        			
        	<form name='search' method="post">
    				<input type='hidden' name='pageNo' value='<c:out value="${searchVO.pageNo }"/>'>
    				<div class="form-horizontal">
							<div class="control-group span9">
						  <label class="control-label" for="typeahead">검색인자</label>
						  <div class="controls">
							<select name="searchCondition">
			        				<option value='template_name' <c:if test="${searchVO.searchCondition=='template_name' }"> selected </c:if>>템플릿명</option>
			        				<option value='cate_name' <c:if test="${searchVO.searchCondition=='cate_name' }"> selected </c:if>>카테고리명</option>
			        			</select>
			        			<input type='text' name='searchKeyword' value="${searchVO.searchKeyword }">
						  </div>
						</div>
						<div class="pull-right">
							<a href='#' onClick='fn_search()' class="btn">검색</a>
						</div>
					</div>
	        </form>
	        
	        
	       		 	<table class="table table-bordered table-striped table_list">
	       		 	<colgroup>
	       		 			<col width="160px">
	       		 			<col width="160px">
	       		 			<col width="*">
	       		 			<col width="160px">
	       		 			<col width="160px">
	       		 			<col width="160px">
	       		 			<col width="160px">
	       		 		</colgroup>
	       		 		 <thead>
					      <tr>
					        <th>카테고리명</th>
					        <th>서비스기관</th>
					        <th>템플릿명</th>
					        <th>메일열람</th>
					        <th>링크(URL)실행</th>
					        <th>파일실행실행</th>
					        <th>등록시간</th>
					        
					      </tr>
					    </thead>
					    <tbody>
					    	<c:choose>
						    		<c:when test="${fn:length(list)>0}">
						    			<c:forEach var="list" items="${list}" varStatus="status">
								    	<tr onclick="view('<c:out value="${list.code}"/>');">
				       		 				<td><c:out value="${list.cate_name}"/></td>
				       		 				<td><c:out value="${list.institution_name}"/></td>
				       		 				<td><c:out value="${list.template_name}"/></td>
				       		 				<td><c:out value="${list.training_type1}"/></td>
				       		 				<td><c:out value="${list.training_type2}"/></td>
				       		 				<td><c:out value="${list.training_type3}"/></td>
				       		 				<td><c:out value="${list.sdate}"/></td>
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
					<div class="pull-right">
	       		 		<a href='<c:url value="/system/templateForm.do"/>' class="btn btn-primary">등록</a>
	       		 	</div>
	       		 	<div class="clearFix"></div>
	       		 	
						
	       		 	
       		 	</div>
       		 	</div>
       		 	</div>
    </div>
    <script>
    
    	function view(code)
    	{
    		location.href="/system/templateForm.do?code="+code;
    	}
    
	    /**
	    검색
	    **/
    	function fn_search()
    	{
    		document.search.pageNo.value = 1;
    		document.search.action = "/system/templateList.do";
    		document.search.submit();
    	}
    	
	    
	    /**
	    페이지 이동
	    **/
    	function goPage(pageno)
    	{
    		location.href="/system/templateList.do?pageNo="+pageno;
    	}
    	
    
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />