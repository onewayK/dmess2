<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="kr.nshare.common.util.EgovProperties"%>
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
                 <i class="fa-icon-home"></i> Home / 시스템 관리 / <strong>사용자 관리 및 권한 관리</strong>
            </li>
        </ul>
        
  
        
        <!-- 검색 -->
        <div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-user"></i><span class="break"></span>사용자 관리 및 권한 관리</h2>
					</div>
        			<div class="box-content">
			        	<form name='search' method="post">
			        				<input type='hidden' name='pageNo' value='<c:out value="${searchVO.pageNo }"/>'>
				        			<div class="form-horizontal">
											<div class="control-group span9">
										  <label class="control-label" for="typeahead">검색인자</label>
										  <div class="controls">
											<select name="searchCondition">
						        				<option value='name'>이름</option>
						        				<option value='userid'>아이디</option>
						        				<option value='email'>이메일</option>
						        			</select>
						        			<input type='text' name='searchKeyword' value="${searchVO.searchKeyword }">
										  </div>
										</div>
										<div class="pull-right">
											<a href='#' onClick='fn_search()' class="btn">검색</a>
										</div>
									</div>
			        	
				        </form>
        
        
        
        
        	
	        
	       	<table class="table table-bordered table-striped table_list" >
	       		 		 <thead>
					      <tr>
					        <th>아이디</th>
					        <th>이름</th>
					        <th>이메일</th>
					        <th>전화번호</th>
					        <th>회사명</th>
					        <th>등록일자</th>
					        <th>업데이트일자</th>
					        <th>생성사용자</th>
					        <th>권한</th>
					        <%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
					     	<th>훈련서비스상태</th>
					     	<th>훈련서비스설정</th>
					     	<!-- 	기존 과금 정책에 대한 표시	
					        <th>잔여과금</th>
					        -->
					        <%}%>	
					      </tr>
					    </thead>
					    <tbody>
					    	<c:choose>
						    		<c:when test="${fn:length(list)>0}">
						    			<c:forEach var="list" items="${list}" varStatus="status">
								    	<tr  >
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.userid}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.name}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.email}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.phone}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.comp_name}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.sdate}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.udate}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.cuser}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');">
				       		 					<c:choose>
				       		 						<c:when test="${list.lev=='admin' }">
				       		 							관리자
				       		 						</c:when>
				       		 						
				       		 						<c:when test="${list.lev=='institution_admin' }">
				       		 							기관관리자
				       		 						</c:when>
				       		 						
				       		 						<c:when test="${list.lev=='institution_user' }">
				       		 							기관사용자
				       		 						</c:when>
				       		 						
				       		 						
				       		 					</c:choose>
				       		 					
				       		 				</td>
				       		 				 <%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
				       		 					 <c:choose>
				       		 						<c:when test="${list.lev=='institution_admin' }">
				       		 						<td>
			       		 								<c:choose>
				       		 								<c:when test="${list.service_status_cnt > 0 }">
				       		 										서비스 진행중
				       		 								</c:when>
				       		 								<c:otherwise>
				       		 										서비스 종료 
				       		 								</c:otherwise>
			       		 								</c:choose>
				       		 						</td>
				       		 						<td>
				       		 							<a class="btn" onclick="servicepayManager('<c:out value="${list.code}"/>')">서비스&nbsp;설정</a>
				       		 						</td>
				       		 						</c:when>
				       		 						
				       		 						<c:otherwise>
				       		 							<td>&nbsp;</td>
				       		 							<td>&nbsp;</td>
				       		 						</c:otherwise>
				       		 					</c:choose>
				       		 					
				       		 			<!-- 	기존 과금 정책에 대한 표시	
				       		 					<c:choose>
				       		 						<c:when test="${list.lev=='institution_admin' }">
				       		 							<td  onCLick="payManager('<c:out value="${list.code}"/>');">
				       		 								<c:out value="${list.paycnt}"/>
				       		 							</td>
				       		 						</c:when>
				       		 						<c:otherwise>
				       		 							<td>&nbsp;</td>
				       		 						</c:otherwise>
				       		 					</c:choose>
				       		 			 -->
				       		 				 <%}%>	
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
	       		 	<div class="pull-right">
	       		 		<a href='<c:url value="/system/memberForm.do"/>' class="btn btn-primary">등록</a>
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
    		document.search.pageNo.value = 1;
    		document.search.action = "/system/memberList.do";
    		document.search.submit();
    	}
    	
	    /**
	    페이지 이동
	    **/
    	function goPage(pageno)
    	{
	    	document.search.pageNo.value = pageno;
	    	document.search.action = "/system/memberList.do";
    		document.search.submit();
    	}
    	
    	
    	function view(code)
    	{
    		location.href="/system/memberForm.do?code="+code;	
    	}    	    
    	
    	function servicepayManager(code)
    	{
    		url = '<c:url value="/system/service_setting_pop.do"/>';
    		url = url +"?uc="+code;
    		fn_openwindow(url,  '600px', '600px', 'service_setting_pop');
    	}
    	
    	/* 과정 정책에 의한 소스
    	function payManager(code)
    	{
    		url = '<c:url value="/system/paymanage_pop.do"/>';
    		url = url +"?code="+code;
    		fn_openwindow(url,  '600px', '600px', 'paymanage_pop');
    	}*/
    	
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />