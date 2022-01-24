<%@page import="kr.nshare.common.util.EgovProperties"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_pop_layout" />
<div class="pop_header">
	<h2><span class="break"></span><span style="font-size: 18px;">&nbsp;&nbsp;훈련 삭제 리스트</span></h2>
</div>
	<div class="container-fluid">
			<div class="row-fluid">
					<div class="box-content span12">
	       		 	 <form class="form-horizontal" role="form" name='frm' method='post' enctype="multipart/form-data">	       		 	
	       		 		<table class="table table-bordered table-striped">
	       		 		<colgroup>
	       		 			<col width="60px">
	       		 			 <%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
			       		 		  <col width="100px">
	       		 			<%}%>
	       		 			<col width="100px">
	       		 			<col width="*">
	       		 			<col width="100px">
	       		 			<col width="120px">
	       		 			<col width="120px">
	       		 			<col width="130px">
	       		 			<col width="80px">
	       		 		</colgroup>
	       		 		 <thead>
					      <tr>
					        <th>번호</th>
					        <%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
			       		 		  <th>서비스타입</th>
			       		 	<%}%>
					        <th>기관/그룹</th>
					        <th >훈련명</th>
					        <th>생성자</th>
					        <th>생성자이름</th>
					        <th>생성자전화번호</th>
					        <th>등록일</th>
					        <th>삭제</th>
					      </tr>					      
					    </thead>
					    <tbody>
					    	<c:choose>
						    		<c:when test="${fn:length(list)>0}">
						    			<c:forEach var="list" items="${list}" varStatus="status">						    			
								    	<tr>
				       		 				<td><c:out value="${list.code}"/></td>
				       		 			
				       		 				<%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
							       		 		<td>
							       		 		<c:choose>
				       		 						<c:when test="${list.service_type eq 'test' }">
				       		 								테스트
				       		 						</c:when>
				       		 						<c:when test="${list.service_type eq 'real' }">
				       		 								실전
				       		 						</c:when>
				       		 						<c:otherwise>
				       		 								기타
				       		 						</c:otherwise>
				       		 					</c:choose>
					       		 				</td>
					       		 			<%}%>
				       		 									       		 			
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
				       		 				
				       		 				<td><c:out value="${list.tname}"/></td>				       		 				
				       		 				<td><c:out value="${list.create_id}"/></td>
				       		 				<td><c:out value="${list.create_name}"/></td>
				       		 				<td><c:out value="${list.create_phone}"/></td>				
				       		 				<td><c:out value="${list.sdate}"/></td>				       		 				
				       		 				<td><a class="btn" onClick="deleteTraining('${list.code}')">삭제</a></td>	
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
	       		 	
	       		 		</form>
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
				 
       		 	</div>
       		 	
       		 	<c:import url="/common/pageLink.do?link=inc/bottom_pop_layout" />
       		 		
    </div>
   <form name="del_frm" method="post">
	<input type="hidden" name="code" value=""/>
	</form>
	<form name='search' method="post">
        	<input type='hidden' name='pageNo' value='<c:out value="${searchVO.pageNo }"/>'>
    </form>
	    	
    <script>
  
    /**
    사용자 적용
    **/
    function window_close()
    {      	        
    	window.opener.location.reload();     
    	window.close();
    }
	
    /**
    페이지 이동
    **/
	function goPage(pageno)
	{
    	document.search.pageNo.value = pageno;
    	document.search.action = "/training/training_del_valid_pop.do";
		document.search.submit();
	}
    
    /**
	훈련삭제
	**/
	function deleteTraining(code)
	{
		
		if (confirm("정말 삭제하시겠습니까?\n삭제를 진행하면 복구는 불가능 합니다. \n신중하게 신행해주시기 바랍니다.") == true)
		{  
			document.del_frm.code.value= code;
			document.del_frm.action = "/training/training_pop_del.do";
	    		
			document.del_frm.submit();
		}
		else
		{
		
		}
	}
    </script>
   

       	</div>
</div>