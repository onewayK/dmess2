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
                <i class="fa-icon-home"></i> Home / 훈련관리 /<strong>훈련그룹관리</strong>
            </li>
        </ul>
        
        <!-- 검색 -->
        	<form name='search' method="post">
        	<input type='hidden' name='pageNo' value='<c:out value="${searchVO.pageNo }"/>'>
        	
        	<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-user"></i><span class="break"></span>훈련그룹관리</h2>
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
				        				<option value='gname' <c:if test="${searchVO.searchCondition=='gname' }"> selected </c:if>>그룹명</option>
				        				<option value='institution_name' <c:if test="${searchVO.searchCondition=='institution_name' }"> selected </c:if>>기관명</option>
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
	       		 			<col width="60px">
	       		 			<col width="*">
	       		 			<col width="100px">
	       		 			<col width="200px">
	       		 			<col width="150px">
	       		 			
	       		 		</colgroup>
	       		 		 <thead>
					      <tr>
					        <th rowspan='1'>번호</th>
					        <th rowspan='1'>그룹명</th>
					        <th rowspan='1'>기관명</th>
					        <th rowspan='1'>등록훈련수</th>
					        <th rowspan='1'>등록일</th>
					        
					      </tr>
					      					      
					    </thead>
					    <tbody>
					    	<c:choose>
						    		<c:when test="${fn:length(list)>0}">
						    			<c:forEach var="list" items="${list}" varStatus="status">						    			
								    	<tr  onClick="view('${list.code}')">
				       		 				<td><c:out value="${list.code}"/></td>
				       		 				<td><c:out value="${list.group_name}"/></td>
				       		 				<td><c:out value="${list.institution_name}"/></td>
				       		 				<td><span title='<c:out value="${list.training_list}"/>'><c:out value="${list.training_cnt}"/></span></td>
				       		 				<td><c:out value="${list.sdate}"/></td>
				       		 				
				       		 			</tr>				       		 			
				       		 			</c:forEach>
						    		</c:when>
						    		<c:otherwise>
						    			<tr>
				       		 				<td colspan="5" align="center">no list</td>
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
	       		 		<a href='/training/GroupForm.do' class="btn btn-primary">등록</a>
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
    		document.frm.action = "/training/GroupForm.do";
    		document.frm.submit();
    		
    	}
    
	    /**
	    검색
	    **/
    	function fn_search()
    	{
    		document.search.pageNo.value = 1;
    		document.search.action = "/training/GroupList.do";
    		document.search.submit();
    	}
    	
	    /**
	    페이지 이동
	    **/
    	function goPage(pageno)
    	{
	    	document.search.pageNo.value = pageno;
	    	document.search.action = "/training/GroupList.do";
    		document.search.submit();
    	}
    	
    
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />