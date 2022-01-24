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
                 <i class="fa-icon-home"></i> Home / 시스템 관리 / <strong>공통코드관리</strong>
            </li>
        </ul>
        
        <!-- 검색 -->
        <div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-money"></i><span class="break"></span>공통코드관리</h2>
					</div>
        			<div class="box-content">
        			
        		<form name='search' method="post">
	        	</form>
	        
	        
	       		 	<table class="table table-bordered table-striped table_list">
	       		 	<colgroup>
	       		 			<col width="*">
	       		 			<col width="160px">
	       		 			<col width="130px">
	       		 			<col width="160px">
	       		 		</colgroup>
	       		 		 <thead>
					      <tr>
					        <th>카테고리명</th>
					        <th>등록단어수</th>
					        <th>등록카테고리수<br>(기관/공통)</th>
					        <th>등록시간</th>
					      </tr>
					    </thead>
					    <tbody>
					    	<c:choose>
						    		<c:when test="${fn:length(categoryList)>0}">
						    			<c:forEach var="list" items="${categoryList}" varStatus="status">
									    	<tr onClick="view('<c:out value="${list.code }"/>');">
									    		<td>
									    			<c:out value="${list.cate_name }"/>
									    		</td>
									    		<td align="center">
									    			<c:out value="${list.word_cnt }"/>
									    		</td>
									    		<td class="text-center">
									    			<c:out value="${list.cnt }"/>(<c:out value="${list.institution_cnt }"/>/<c:out value="${list.not_institution_cnt }"/>)
									    		</td>
									    		<td>
									    			<c:out value="${list.sdate }"/>
									    		</td>
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
	       		 	<div class="pull-right">
	       		 		<a href='/system/templateCategoryForm.do' class="btn btn-primary">등록</a>
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
    	
    	/*
    	function hitManagerPop(tc_code)
    	{
    		
    		url = "/system/templateHitManagerListPopForm.do?tc_code="+tc_code;
    		width="1224";
    		height ="600";
    		page_id = "templateHitManagerListPopForm";
    		var popup = fn_openwindow(url, width, height, page_id);
    	} 
    	*/
    	
    	
    	
    	/**
    	수정 및 상세보기
    	**/
    	function view(code)
    	{
    		document.frm.code.value = code ;
    		document.frm.action = "/system/templateCategoryForm.do";
    		document.frm.submit();
    	}
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />