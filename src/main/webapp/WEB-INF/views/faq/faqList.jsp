<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="f"           uri="http://nshare.kr/taglib" %>

<%@ page session="true" %>

<c:import url="/common/pageLink.do?link=inc/top_layout" />
	<div id="PageHeight" class="container-fluid">
		
		<!-- navi -->
        <ul class="breadcrumb">
            <li>
            	<c:choose>
            		<c:when test="${pageType == 'system'}">
            			<i class="fa-icon-home"></i> Home / Faq / <strong>FAQ관리</strong>
            		</c:when>
            		<c:otherwise>
            			<i class="fa-icon-home"></i> Home / Faq / <strong>FAQ</strong>
            		</c:otherwise>
            	</c:choose>
                 
            </li>
        </ul>
        
        <!-- 검색 -->
        	<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
					
					<c:choose>
            		<c:when test="${pageType == 'system'}">
            			<h2><i class="fa-icon-bar-chart"></i><span class="break"></span>FAQ관리</h2>
            		</c:when>
            		<c:otherwise>
            			<h2><i class="fa-icon-bar-chart"></i><span class="break"></span>FAQ</h2>
            		</c:otherwise>
            	</c:choose>
						
					
					</div>
        			<div class="box-content">
			        	<form name='search' method="post">
			        		<input type='hidden' name='pageNo' value='<c:out value="${searchVO.pageNo }"/>'>
				        			<div class="form-horizontal">
											<div class="control-group span9">
										  <label class="control-label" for="typeahead">검색인자</label>
										  <div class="controls">
											<select name="searchCondition">
						        				<option value='faq_q'>제목</option>
						        				<option value=faq_a>내용</option>
						        			</select>
						        			<input type='text' name='searchKeyword' value="${searchVO.searchKeyword }">
										  </div>
										</div>
										<div class="pull-right">
											<a href='#' onClick='fn_search()' class="btn">검색</a>
										</div>
									</div>
			        	
				        </form>
				        
	        
	        
	        <div class="faq_list span12 marginl0">
       		 		
       		 		     
	       		 	
					    	<% pageContext.setAttribute("lineChar", "\n"); %>
					    	<c:choose>
						    		<c:when test="${fn:length(list)>0}">
						    			<c:choose>
						    				<c:when test="${pageType == 'system'}">
						    					<table class="table table-bordered  table-striped table_list">
								       		 		 <thead>
												      <tr>
												      	<th>번호</th>
												        <th>질문</th>
												        <th>등록시간</th>
												        <th>타입</th>
												        <th>기관</th>
												        <th>사용유무</th>											        
												      </tr>
												    </thead>
												    <tbody>
												    <c:forEach var="list" items="${list}" varStatus="status">
										    	    	<c:set var="uni_id" value="${status.index }"/>
													    <tr onclick="view('<c:out value="${list.code}"/>');" style="cursor:hand">
													    	<td><c:out value="${list.code }"/></td>
													    	<td><c:out value="${list.faq_q }"/></td>
													    	<td><c:out value="${list.sdate }"/></td>
													    	<td>
													    		<c:choose>
													    			<c:when test="${list.type eq 'i' }">
													    				기관 특화
													    			</c:when>
													    			<c:otherwise>
													    				공통
													    			</c:otherwise>
													    		</c:choose>
													    	</td>
													    	<td><c:out value="${list.institution_name }"/></td>
													    	<td>
													    		<c:choose>
													    			<c:when test="${list.useyn=='0' }">
													    				사용
													    			</c:when>
													    			<c:otherwise>
													    				중지
													    			</c:otherwise>
													    		</c:choose>
													    			
													    	</td>
													    
													    </tr>
													 </c:forEach>
												    </tbody>
												    </table>
						    						
						    					
						    				</c:when>
						    				<c:otherwise>
							    				<c:forEach var="list" items="${list}" varStatus="status">
										    	    	<c:set var="uni_id" value="${status.index }"/>
												    	
												    	<div class="faq_group" >
															  <div class="faq_default">
															    <div class="faq_heading">
															      <h4 class="faq_title">
															        <i class="fa-icon-volume-up"></i> <a href='#' onClick="faqview('<c:out value="${uni_id}"/>');">
																		<c:out value="${list.faq_q }"/>
																	</a>
															      </h4>
															    </div>
																<div id="<c:out value="${uni_id}"/>" style='display:none;'>
															      <div class="faq_body">
															      	<c:out value="${f:nl2br(list.faq_a) }" escapeXml="false"/>
																  </div>
															    </div>
															</div>
														</div>
														
												 </c:forEach>
						    				</c:otherwise>
						    			</c:choose>			
						    			
						    			
						    			
						    		</c:when>
						    		<c:otherwise>
						    			<tr>
				       		 				<td colspan="7" align="center">no list</td>
				       		 			</tr>		
		       		 				 </c:otherwise>
					    	</c:choose>
	       		 			
					   
					   
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
						<c:choose>
							<c:when test="${pageType == 'system'}">
								<div class="pull-right">
		       		 				<a href='<c:url value="/faq/faqForm.do"/>' class="btn btn-primary">등록</a> 
		       		 			</div>
							</c:when>
						</c:choose>  
	       		 		
					</div>
       		 	<div class="clearFix"></div>
       		 	</div>
       		 	</div>
       		 	</div>
    </div>
    
   
    <script>
    	
    	/**
    	상세보기
    	**/
    	function view(code)
    	{
    		
    		location.href="/faq/faqForm.do?code="+code;
    	}
    	
    	function faqview(id)
    	{
    		$("#"+id).fadeToggle( "fast", "linear" );

    	}
    	
    	
    	 /**
	    검색
	    **/
    	function fn_search()
    	{
    		document.search.pageNo.value = 1;
    		
    		<c:choose>
    			<c:when test="${pageType=='faq'}">
    				document.search.action = "/faq/faqList.do";
    			</c:when>
    			<c:otherwise>
    				document.search.action = "/system/faqList.do";	
    			</c:otherwise>
    		</c:choose>
    		
    		
    		document.search.submit();
    	}
    	
	    /**
	    페이지 이동
	    **/
    	function goPage(pageno)
    	{
	    	document.search.pageNo.value = pageno;
	    	<c:choose>
			<c:when test="${pageType=='faq'}">
				document.search.action = "/faq/faqList.do";
			</c:when>
			<c:otherwise>
				document.search.action = "/system/faqList.do";	
			</c:otherwise>
		</c:choose>
    		document.search.submit();
    	}
    	
    	
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />