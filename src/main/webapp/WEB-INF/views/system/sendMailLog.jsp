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
                 <i class="fa-icon-home"></i> Home / 시스템 관리 / <strong>발송로그</strong>
            </li>
        </ul>
        
  
        
        <!-- 검색 -->
        	
        	<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-user"></i><span class="break"></span>발송로그</h2>
					</div>
        			<div class="box-content">
			        	<form name='search' method="post">
				        			<div class="form-horizontal">
											<div class="control-group span9">
										  <label class="control-label" for="typeahead">검색인자</label>
										  <div class="controls">
											
											
											<select name="searchCondition">
						        				<option value='tname' <c:if test="${searchVO.searchCondition=='tname' }"> selected </c:if>>훈련명</option>
						        				<option value='send_name' <c:if test="${searchVO.searchCondition=='send_name' }"> selected </c:if>>발신자 이름</option>
						        				<option value='send_email' <c:if test="${searchVO.searchCondition=='send_email' }"> selected </c:if>>발신자 이메일</option>
						        				<option value='name' <c:if test="${searchVO.searchCondition=='name' }"> selected </c:if>>수신자 이름</option>
						        				<option value='email' <c:if test="${searchVO.searchCondition=='email' }"> selected </c:if>>수신자 이메일</option>
						        			</select>
						        			<input type='text' name='searchKeyword' value="${searchVO.searchKeyword }">
						        			
						        			
    										&nbsp;&nbsp;훈련실행일자 검색
						        			<input type='text' name='searchBgnDe'		id='searchBgnDe' value='${searchVO.searchBgnDe}' style="width:100px">
						        			<input type='text' name='searchEndDe'		id='searchEndDe' value='${searchVO.searchEndDe}' style="width:100px">
						        			
						        			
						        			
						        			<input type='hidden' name='pageNo' value='${searchVO.pageNo }'>
						        			
										  </div>
										</div>
										<div class="pull-right">
											<a href='#' onClick='fn_search()' class="btn">검색</a>
										</div>
									</div>
									
			        	
				        </form>
        	
	       		 	<table class="table table-bordered table-striped table_list">
	       		 		 <thead>
					      <tr>
					        <th>발송일</th>
					        <th>기관명</th>
					        <th>훈련명</th>
					        <th>발신자 이름</th>
					        <th>발신자 이메일</th>
					        <th>수신자 이름</th>
					        <th>수신자 이메일</th>
					        <th>수신자 부서</th>
					        <th>수신자 사번/고유값</th>
					        <th>상태</th>
					        <th>메일내용보기</th>
					      </tr>
					    </thead>
					    <tbody>
					    	<c:choose>
						    		<c:when test="${fn:length(list)>0}">
						    			<c:forEach var="list" items="${list}" varStatus="status">
								    	<tr>
								    	    <td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.send_date}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.institution_name}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.tname}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.send_name}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.send_email}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.name}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.email}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.department_name}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.unikey}"/></td>
				       		 				<td onclick="view('<c:out value="${list.code}"/>');"><c:out value="${list.status}"/></td>
				       		 				<td>
				       		 					<textarea name="send_content" id="send_content<c:out value="${list.code}"/>"  style="width:100%; height:412px; display:none;"><c:out value="${list.send_content }"/></textarea>
				       		 					<button type="button" class="btn btn-info" onClick='popContent("send_content<c:out value="${list.code}"/>");'>본문보기</button>
				       		 				</td>
				       		 				
				       		 			</tr>
				       		 			<tr>
				       		 				<td id="tr_<c:out value="${list.code}"/>" colspan="11" style="display:none" onclick="close_view('<c:out value="${list.code}"/>')">
				       		 					<pre>
<c:out value="${f:nl2br_html(list.log) }" escapeXml="false"/>
				       		 					</pre>
				       		 				</td>
				       		 			</tr>
				       		 			</c:forEach>
						    		</c:when>
						    		<c:otherwise>
						    			<tr>
				       		 				<td colspan="11" align="center">no list</td>
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
	    	if($("#searchBgnDe").val()=="" || $("#searchEndDe").val()=="")
	    	{
	    		alert("발송일자의 검색일을 선택해주세요!");
	    		return ;
	    	}
	    	
	    	document.search.pageNo.value = '1';
    		document.search.action = "/system/emailSendLogList.do";
    		document.search.submit();
    	}
    	
	    /**
	    페이지 이동
	    **/
    	function goPage(pageno)
    	{
    		document.search.pageNo.value = pageno;
    		document.search.action = "/system/emailSendLogList.do";
    		document.search.submit();
    	}
    	
    	/**
    	상세정보 보기
    	**/
    	function view(code)
    	{
    		$("#tr_"+code).fadeToggle( "fast", "linear" );	
    	}
    	
    	function close_view(code)
    	{
    		view(code);	
    	}
    	
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
    	
    	function popContent(id)
    	{
    		preViewHtml($("#"+id).text(),"본문 미리보기","");
    	}
    	
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />