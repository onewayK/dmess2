<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_pop_layout" />
<div class="pop_header">
	<h2><span class="break"></span><span style="font-size: 20px;">&nbsp;&nbsp;D-MESS LICENSE</span></h2>
</div>
	<div class="container-fluid">
			<div class="row-fluid">
					<div class="box-content span12">
	       		 	 <form class="form-horizontal" role="form" name='frm' method='post' enctype="multipart/form-data">	       		 	
	       		 		<table class="table table-bordered table-striped">
							<colgroup>
		       		 			<col width="100px">
		       		 			<col width="300px">       		 			
		       		 		</colgroup>
		       		 		<tbody>		       		 		
								<tr>
									<td style="font-size: 15px;"><strong>VERSION</strong></td>
									<td style="font-size: 15px;">v1.3.1</td>
								</tr>
					<c:choose>
							<c:when  test="${license_detail.license_file_type eq 'success'}">
								<tr>
									<td style="font-size: 15px;"><strong>발급일자</strong></td>
									<td style="font-size: 15px;"><c:out value="${license_detail.sdate }"/></td>
								</tr>												
								<tr>
									<td style="font-size: 15px; <c:if test="${license_detail.license_key_type eq 'fail'}">color:red;</c:if>" ><strong>제품키</strong></td>
									<td style="font-size: 15px; <c:if test="${license_detail.license_key_type eq 'fail'}">color:red;</c:if>"><c:out value="${license_detail.license_key }"/></td>
								</tr>
								
								<c:if test="${license_detail.host_use ne 'N'}">	
									<tr>
										<td style="font-size: 15px; <c:if test="${license_detail.host_type eq 'fail'}">color:red;</c:if>"><strong>호스트명</strong></td>
										<td style="font-size: 15px; <c:if test="${license_detail.host_type eq 'fail'}">color:red;</c:if>"><c:out value="${license_detail.hostname }"/></td>
									</tr>
								</c:if>
								
								<c:if test="${license_detail.mac_use ne 'N'}">	
									<tr>
										<td style="font-size: 15px; <c:if test="${license_detail.mac_type eq 'fail'}">color:red;</c:if>"><strong>MAC 주소</strong></td>
										<td style="font-size: 15px; <c:if test="${license_detail.mac_type eq 'fail'}">color:red;</c:if>"><c:out value="${license_detail.mac }"/></td>
									</tr>
								</c:if>
								
								<c:if test="${license_detail.date_use ne 'N'}">	
									<tr >
										<td style="font-size: 15px; <c:if test="${license_detail.date_type eq 'fail'}">color:red;</c:if>"><strong>시작일자</strong></td>
										<td style="font-size: 15px; <c:if test="${license_detail.date_type eq 'fail'}">color:red;</c:if>"><c:out value="${license_detail.startDt }"/>
										</td>
									</tr>
									
									<tr>
										<td style="font-size: 15px; <c:if test="${license_detail.date_type eq 'fail'}">color:red;</c:if>"><strong>종료일자</strong></td>
										<td style="font-size: 15px; <c:if test="${license_detail.date_type eq 'fail'}">color:red;</c:if>"><c:out value="${license_detail.endDt }"/>
										
										</td>
									</tr>
								</c:if>
								
							<c:choose>	
								<c:when test="${license_detail.date_use eq 'Y' and license_detail.date_type eq 'success' and (license_detail.diffDay > 0 && license_detail.diffDay < 30)}">											
									<tr>
										<td colspan="2" style="font-size: 15px; color:red;">라이선스 기간이 ${license_detail.diffDay}일 남았습니다. 서비스를 연장하시려면 시스템 관리자에게 문의하세요  </td>
									</tr>
								</c:when>								
								<c:otherwise>	
									<c:if test="${license_detail.host_use ne 'N' and license_detail.host_type eq 'fail'}">											
										<tr>
											<td colspan="2" style="font-size: 15px; color:red;">호스트명이 정보가 일치하지 않습습니다. 시스템 관리자에게 문의하세요  </td>
										</tr>
									</c:if>
									<c:if test="${license_detail.mac_use ne 'N' and license_detail.mac_type eq 'fail'}">												
										<tr>
											<td colspan="2" style="font-size: 15px; color:red;">MAC 정보가 일치하지 않습습니다. 시스템 관리자에게 문의하세요</td>
										</tr>
									</c:if>
									<c:if test="${license_detail.date_use ne 'N' and license_detail.date_type eq 'fail'}">										
										<tr>
											<td colspan="2" style="font-size: 15px; color:red;">라이선스 기간이 만료되었습니다. 서비스를 연장하시려면 시스템 관리자에게 문의하세요. </td>
										</tr>
									</c:if>								
								</c:otherwise>	
							</c:choose>		
								
						</c:when>
						<c:otherwise>	
							<tr>
								<td colspan="2"  style="font-size: 15px; color:red;">라이선스 파일이 잘못되었거나 찾을 수 없습니다. 라이선스 파일을 확인하십시오</td>
							</tr>
						</c:otherwise>
					</c:choose>
							</tbody>
						</table>
	       		 		</form>
	       				
				   <a href="#LINK" class="btn" onclick="pop_License_upload()"> 라이선스 등록 </a>
       		 	</div>
       		 	
       		 	<c:import url="/common/pageLink.do?link=inc/bottom_pop_layout" />
       		 		
    </div>
    <form name="filedownload" target="iframe" hidden="hidden">
    </form>
    <iframe name="iframe" hidden="hidden">
    
    </iframe>
    <script>
    window.onunload = function() { 
    	window.opener.location.reload();        
 	 } 
    
    /**
    사용자 적용
    **/
    function window_close()
    {      	        
    	window.close();
    }
    
	//License  파일 등록
	function pop_License_upload()
	{
		url = '<c:url value="/common/license_upload_pop.do"/>';
   		fn_openwindow(url,  '600px', '200px', 'pop_institution_list');
	}
    </script>
   

       	</div>
</div>