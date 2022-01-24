<%@page import="kr.nshare.common.util.EgovProperties"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_pop_layout" />
<div class="pop_header">
<h2>
	<span class="break"></span>
	<span style="font-size: 18px;">&nbsp;&nbsp;훈련명 : <c:out value="${trainingDetail.tname }"/>
	</span>
</h2>
</div>
	<div class="container-fluid">
			<div class="row-fluid">
					<div class="box-content span12">
	       		 	 <form class="form-horizontal" role="form" name='search' method='post' enctype="multipart/form-data">	       		 	
	       		 		<input type='hidden' name='pageNo' value='<c:out value="${searchVO.pageNo}"/>'>
        				<input type='hidden' name='sortcolumn' value='<c:out value="${searchVO.sortcolumn}"/>'>
        				<input type='hidden' name='orderBy' value='<c:out value="${searchVO.orderBy }"/>'>
        				<input type='hidden' name='training_code' value='<c:out value="${trainingDetail.code}"/>'>
	       		 		<table id="report_table" name="report_table" class="table table-bordered table-striped tablesorter">
			       		 		<colgroup>
			       		 			<col width="60px">
			       		 			<col width="100px">
			       		 			<col width="100px">
			       		 			<col width="100px">
			       		 			<col width="90px">
			       		 			<col width="140px">
			       		 			<col width="140px">
			       		 			<col width="140px">
			       		 			<col width="140px">
			       		 			<col width="140px">
			       		 			<col width="140px">
			       		 			<col width="140px">
			       		 		</colgroup>
			       		 		 <thead>
							      <tr>
							        <th class="text-center" rowspan='2'  id="header_code" onclick="goSort('code','<c:out value="${pageing.pageNo}"/>');">번호</th>
							        <th class="text-center"rowspan='2' id="header_name" onclick="goSort('name','<c:out value="${pageing.pageNo}"/>');">수신자 이름</th>
							        <th class="text-center" rowspan='2' id="header_email" onclick="goSort('email','<c:out value="${pageing.pageNo}"/>');">수신자 이메일</th>
							        <th class="text-center" rowspan='2'id="header_department_name" onclick="goSort('department_name','<c:out value="${pageing.pageNo}"/>');">수신자 부서</th>
							        <th class="text-center"rowspan='2' id="header_unikey" onclick="goSort('unikey','<c:out value="${pageing.pageNo}"/>');">고유코드</th>
							        <th class="text-center"colspan="4" align="center" >훈련타입 </th>
							        <th class="text-center"colspan="2">신고</th>
							        <th class="text-center" rowspan='2'  id="header_send_date" onclick="goSort('send_date','<c:out value="${pageing.pageNo}"/>');">발송일</th>
							      </tr>
							      <tr>
							      		<th class="text-center"  id="header_type1_use" onclick="goSort('type1_use','<c:out value="${pageing.pageNo}"/>');">메일열람</th>
							      		<th class="text-center"  id="header_type2_use" onclick="goSort('type2_use','<c:out value="${pageing.pageNo}"/>');">링크(URL)실행</th>
							      		<th class="text-center"  id="header_phishing_cnt" onclick="goSort('type3_use','<c:out value="${pageing.pageNo}"/>');">링크(URL)피싱</th>
							      		<th class="text-center"  id="header_type3_use" onclick="goSort('phishing_cnt','<c:out value="${pageing.pageNo}"/>');">첨부파일실행</th>
							      		<th class="text-center"  id="header_register_use" onclick="goSort('register_use','<c:out value="${pageing.pageNo}"/>');">신고여부</th>
							      		<th class="text-center"  id="header_registertime_use" onclick="goSort('registertime_use','<c:out value="${pageing.pageNo}"/>');">신고시간준수</th>
							      </tr>
							      
							    </thead>
							    <tbody>
							   <c:choose>
								    <c:when test="${fn:length(list)>0}">
									<c:forEach var="list" items="${list}" varStatus="status">
												<!-- <tr id="tr_<c:out value="${list.code }"/>">   -->													
   													<tr id="tr_<c:out value="${list.code}"/>">
													<td class="text-center"><c:out value="${list.code}" /></td>
													<td class="text-center"><c:out value="${list.name}" /></td>
													<td class="text-center"><c:out value="${list.email}" /></td>
													<td class="text-center"><c:out value="${list.department_name}" /></td>
													<td class="text-center"><c:out value="${list.unikey}" /></td>

													<c:choose>
														<c:when test="${list.training_type1 eq 'Y'}">
															<td class="text-center"><c:out value="${list.type1_use}" />
															<c:choose>
																<c:when test="${list.type1_use eq 'O'}">
																	<div class="text-center">(<c:out value="${list.type1_date}" />)</div>
																</c:when>
															</c:choose>
															</td>
														</c:when>
														<c:otherwise>
															<td style="background: gray;">&nbsp;</td>
														</c:otherwise>
													</c:choose>

													<c:choose>

														<c:when test="${list.training_type2 eq 'Y'}">

															<c:choose>
																<c:when test="${list.phishing_use eq 'Y' }">
																	<td class="text-center"><c:out value="${list.type2_use}" />
																		<c:choose>
																			<c:when test="${list.type2_use eq 'O'}">
																				<div class="text-center">(<c:out value="${list.type2_date}" />)</div>
																			</c:when>
																		</c:choose>
																	</td>
																	<td align="center">
																	<font size='1.5'>
																	 
																	<c:choose>
																			<c:when test="${list.phishing_cnt>0 }">
																				입력횟수 : <a href='#' onClick="phishing_view('<c:out value="${list.training_code}"/>','<c:out value="${list.training_user_code}"/>')"><c:out value="${list.phishing_cnt}" /></a>
																				<br> 아 이 디: <c:out value="${list.t_userId}" />
																				<br> 비밀번호: <c:out value="${list.t_passwd}" />자리 입력
																			</c:when>
																			<c:otherwise>
																				입력횟수 : <c:out value="${list.phishing_cnt}" />
																				<br> 아 이 디: - 
																				<br> 비밀번호: -
																			</c:otherwise>
																	</c:choose> 
																		
																		
																	</font>
																	</td>
																</c:when>
																<c:otherwise>
																	<td class="text-center"><c:out value="${list.type2_use}" />
																		<c:choose>
																			<c:when test="${list.type2_use eq 'O'}">
																				<div class="text-center">(<c:out value="${list.type2_date}" />)</div>
																			</c:when>
																		</c:choose>
																	</td>
																	<td align="center" style="background: gray;"></td>
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:otherwise>
															<td style="background: gray;">&nbsp;</td>
															<td style="background: gray;">&nbsp;</td>
														</c:otherwise>
													</c:choose>

													<c:choose>
														<c:when test="${list.training_type3 eq 'Y'}">
															<td class="text-center">
																<c:out	value="${list.type3_use}" />
																<c:choose>
																	<c:when test="${list.type3_use eq 'O'}">
																		<div class="text-center">(<c:out value="${list.type3_date}" />)</div>
																	</c:when>
																</c:choose>
															</td>
														</c:when>
														<c:otherwise>
															<td style="background: gray;">&nbsp;</td>
														</c:otherwise>
													</c:choose>
													
													<c:choose>
														<c:when test="${list.register_type eq 'y'}">
															<td class="text-center">
																<c:out	value="${list.register_use}" />
																<c:choose>
																	<c:when test="${list.register_use eq 'O'}">
																		<div class="text-center">(<c:out value="${list.register_sdate}" />)</div>
																	</c:when>
																</c:choose>
															</td>
														</c:when>
														<c:otherwise>
															<td style="background: gray;">&nbsp;</td>
														</c:otherwise>
													</c:choose>			
																												
													<c:choose>
														<c:when test="${list.register_time_type eq 'Y'}">
															<td class="text-center">
																<c:out	value="${list.registertime_use}" />
																<c:choose>
																	<c:when test="${list.registertime_use eq 'X'}">
																		<div class="text-center"><span tooltipmessage="신고준수 시간 : <c:out value='${list.register_time}' />뷴 이내" >(초과&nbsp;<c:out value="${list.register_excess_time}" />)</span></div>
																	</c:when>
																</c:choose>
															</td>
														</c:when>
														<c:otherwise>
															<td style="background: gray;">&nbsp;</td>
														</c:otherwise>
													</c:choose>
													
													<td class="text-center"><c:out value="${list.send_date}" /></td>
												</tr>									
									</c:forEach>
								</c:when>
								    		<c:otherwise>
								    			<tr>
						       		 				<td colspan="10" align="center">no list</td>
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
       		 		
    </div>   >
	    	
    <script>
  
    /**
    닫기 
    **/
    function window_close()
    {      	        
    	window.opener.location.reload();     
    	window.close();
    }
	 
	  /**
    정렬
    **/
	function goSort(column,pageno)
	{
		var orderBy=$("input[name='orderBy']").val()
		
		if(column != $("input[name='sortcolumn']").val()){
			orderBy='asc';			
		}else if(orderBy == 'asc'){
			orderBy='desc';		
		}else{
			orderBy='asc';
		}

    	document.search.pageNo.value = pageno;
    	
		document.search.sortcolumn.value = column; 
    	document.search.orderBy.value = orderBy;
		
    	document.search.action = "/statistical/register_report_pop.do";
		document.search.submit();
	} 
    
	 /**
 	 해더 정렬 이미지 변경
   **/
	function change_header()
	{
		var sort="&nbsp;&nbsp;<i class='fa fa-sort'></i>";
		var sort_desc_asc;
		
		var sortcolumn=$("input[name='sortcolumn']").val();
		var orderBy=$("input[name='orderBy']").val();
		
		if(orderBy == 'desc'){
			sort_desc_asc="&nbsp;&nbsp;<i class='fa fa-sort-desc'></i>";
		}else{
			sort_desc_asc="&nbsp;&nbsp;<i class='fa fa-sort-asc'></i>";
		}
		
		$("#header_code").html("번호"+sort);	
		$("#header_name").html("수신자 이름"+sort);	
		$("#header_email").html("수신자 이메일"+sort);	
		$("#header_department_name").html("수신자 부서"+sort);	
		$("#header_unikey").html("고유코드"+sort);	
		
		$("#header_type1_use").html("메일열람"+sort);	
		$("#header_type2_use").html("링크(URL)실행"+sort);
		$("#header_phishing_cnt").html("링크(URL)피싱"+sort);
		$("#header_type3_use").html("첨부파일실행"+sort);
		
		$("#header_register_use").html("신고여부"+sort);		
		$("#header_registertime_use").html("신고시간준수"+sort);		
		
		$("#header_send_date").html("발송일"+sort);		
		
		if(sortcolumn == 'code'){
			$("#header_code").html("번호"+sort);	
		}else if(sortcolumn == 'name'){
			$("#header_name").html("수신자 이름"+sort);	
		}else if(sortcolumn == 'email'){	
			$("#header_email").html("수신자 이메일"+sort);	
		}else if(sortcolumn == 'department_name'){		
			$("#header_department_name").html("수신자 부서"+sort);	
		}else if(sortcolumn == 'unikey'){
			$("#header_unikey").html("고유코드"+sort);	
		}else if(sortcolumn == 'type1_use'){	
			$("#header_type1_use").html("메일열람"+sort);	
		}else if(sortcolumn == 'type2_use'){		
			$("#header_type2_use").html("링크(URL)실행"+sort);
		}else if(sortcolumn == 'phishing_cnt'){
			$("#header_phishing_cnt").html("링크(URL)피싱"+sort);
		}else if(sortcolumn == 'type3_use'){
			$("#header_type3_use").html("첨부파일실행"+sort);
		}else if(sortcolumn == 'register_use'){
			$("#header_register_use").html("신고여부"+sort);		
		}else if(sortcolumn == 'registertime_use'){
			$("#header_registertime_use").html("신고시간준수"+sort);
		}else if(sortcolumn == 'send_date'){
			$("#header_send_date").html("발송일"+sort);		
		}else{
			$("#header_code").html("번호"+sort_desc_asc);	
		}
	} 
	 /**
    페이지 이동
    **/
	function goPage(pageno)
	{		
    	document.search.pageNo.value = pageno;
    	document.search.action = "/statistical/register_report_pop.do";
		document.search.submit();
	}
	
	<c:choose>
		<c:when test="${fn:length(list)>0}">
				change_header();
		</c:when>
	</c:choose>	
	
    </script>   
</div>
