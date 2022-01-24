<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page session="true" %>
<html>
<head>
<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/font-awesome2.css" rel="stylesheet">
<link href="/css/style.css" rel="stylesheet">
<script src="/js/jquery-1.11.2.min.js"></script> 
<script src="/js/common.js"></script>
    <script src="/js/custom.js"></script>
    
<style type="text/css">
			body { background: url(/images/login_bg2.jpg) !important; }
		</style>
	<title>D-MESSv1.3</title>
</head>
<body>
<c:out value="${msg}"/>
<div class="container-fluid">
		<div class="row-fluid">
					
			<div class="row-fluid">
				<div class="login-box">
					<h2><img src="../images/logo2.png"></h2>
					<form action="<c:url value='/member/loginForm.do' />" method="post" onsubmit="return sendit();"> 
						<div class="form-horizontal">
							
							<table class="table table-bordered table-striped ">
							<colgroup>
		       		 			<col width="100px">
		       		 			<col width="300px">       		 			
		       		 		</colgroup>
		       		 		<tbody>		   		 		
							
					<c:choose>
							<c:when  test="${license_detail.license_file_type eq 'success'}">																		
								<tr >
									<td  style="font-size: 11px; <c:if test="${license_detail.license_key_type eq 'fail'}">color:red;</c:if>" ><strong>제품키</strong></td>
									<td style="font-size: 11px; <c:if test="${license_detail.license_key_type eq 'fail'}">color:red;</c:if>"><c:out value="${license_detail.license_key }"/></td>
								</tr>
								
								<c:if test="${license_detail.host_use ne 'N'}">	
									<tr class="table-light">
										<td style="font-size: 11px; <c:if test="${license_detail.host_type eq 'fail'}">color:red;</c:if>"><strong>호스트명</strong></td>
										<td style="font-size: 11px; <c:if test="${license_detail.host_type eq 'fail'}">color:red;</c:if>"><c:out value="${license_detail.hostname }"/></td>
									</tr>
								</c:if>
								
								<c:if test="${license_detail.mac_use ne 'N'}">	
									<tr>
										<td style="font-size: 11px; <c:if test="${license_detail.mac_type eq 'fail'}">color:red;</c:if>"><strong>MAC 주소</strong></td>
										<td style="font-size: 11px; <c:if test="${license_detail.mac_type eq 'fail'}">color:red;</c:if>"><c:out value="${license_detail.mac }"/></td>
									</tr>
								</c:if>
								
								<c:if test="${license_detail.date_use ne 'N'}">	
									<tr >
										<td style="font-size: 11px; <c:if test="${license_detail.date_type eq 'fail'}">color:red;</c:if>"><strong>시작일자</strong></td>
										<td style="font-size: 11px; <c:if test="${license_detail.date_type eq 'fail'}">color:red;</c:if>"><c:out value="${license_detail.startDt }"/>
										</td>
									</tr>
									
									<tr>
										<td style="font-size: 11px; <c:if test="${license_detail.date_type eq 'fail'}">color:red;</c:if>"><strong>종료일자</strong></td>
										<td style="font-size: 11px; <c:if test="${license_detail.date_type eq 'fail'}">color:red;</c:if>"><c:out value="${license_detail.endDt }"/>
										
										</td>
									</tr>
								</c:if>
								<tr>
									<td style="font-size: 11px;"><strong>발급일자</strong></td>
									<td style="font-size: 11px;"><c:out value="${license_detail.sdate }"/></td>
								</tr>		
								
							<c:choose>	
								<c:when test="${license_detail.date_use eq 'Y' and license_detail.date_type eq 'success' and (license_detail.diffDay > 0 && license_detail.diffDay < 30)}">											
									<tr>
										<td colspan="2" style="font-size: 11px; color:red;">라이선스 기간이 ${license_detail.diffDay}일 남았습니다.  </td>
									</tr>
								</c:when>								
								<c:otherwise>	
									<c:if test="${license_detail.host_use ne 'N' and license_detail.host_type eq 'fail'}">											
										<tr>
											<td colspan="2" style="font-size: 11px; color:red;">호스트명이 정보가 일치하지 않습습니다. </td>
										</tr>
									</c:if>
									<c:if test="${license_detail.mac_use ne 'N' and license_detail.mac_type eq 'fail'}">												
										<tr>
											<td colspan="2" style="font-size: 11px; color:red;">MAC 정보가 일치하지 않습습니다.</td>
										</tr>
									</c:if>
									<c:if test="${license_detail.date_use ne 'N' and license_detail.date_type eq 'fail'}">										
										<tr>
											<td colspan="2" style="font-size: 11px; color:red;">라이선스 기간이 만료되었습니다. </td>
										</tr>
									</c:if>								
								</c:otherwise>	
							</c:choose>		
								
						</c:when>
						<c:otherwise>	
							<tr>
								<td colspan="2"  style="font-size: 11px; color:red;">라이선스 파일이 잘못되었거나 찾을 수 없습니다. 라이선스 파일을 확인하십시오</td>
							</tr>
						</c:otherwise>
					</c:choose>
							</tbody>
						</table>
														
										  
							</div>
							<div class="clearfix"></div>
							<div class="button-login">	
								<button type="button" class="btn btn-primary" onClick='pop_License_upload();'>라이선스 등록</button>
								<button type="submit" class="btn btn-primary">확인</button>
							</div>
							<div class="clearfix"></div>
						</div>
					</form>
	
				</div><!--/span-->
			</div><!--/row-->
			
		</div><!--/fluid-row-->		
	</div><!--/.fluid-container-->
	<script>
		function sendit()
		{
				return true;
		}
		
		//License  파일 등록
		function pop_License_upload()
		{
			url = '<c:url value="/common/license_upload_pop.do"/>';
	   		fn_openwindow(url,  '600px', '400px', 'pop_institution_list');
		}
			
	</script>

</body>
</html>
