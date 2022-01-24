<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_layout" />
	<div id="PageHeight" class="container-fluid">
		
		<!-- navi -->
		<ul class="breadcrumb">
            <li>
                 <i class="fa-icon-home"></i> Home / 시스템관리 / <strong>버전정보</strong>
            </li>
        </ul>
			
	       <div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-tasks"></i><span class="break"></span>버전정보</h2>
					</div>
					<div class="box-content">
						<!-- 
						<p>
							<b style="font-size: 1.5em;">D-MESS Version 1.0(MESS최최 버전 개발)</b><br>
							1. 훈련 그룹 등록 및 훈련 관리 기능 개발<BR>
							2. 훈련 실행 기능 개발<BR>
							3. 통계 기능(차트, 리포팅, 신고리스트, 그룹별훈련 통계)<BR>
							4. FAQ(사용자 메뉴얼, FAQ, 담당영업정보)<BR>
							5. 시스템관리(기관생성관리, 사용자 관리 및 권한 관리, 발송로그, 과금로그, FAQ관리)<BR>
							
						</p>	
						<BR>						
						<p>
							<b style="font-size: 1.5em;">D-MESS Version 1.1(템플릿 기능 보강 및 피싱기능)</b><br>
							1. 템플릿 등록 및 관리 기능<BR>
							2. 훈련 옵션추가(피싱 테스트를 위한 기능)<BR>
							3. 접속자 로그 관리<BR>
							4. 훈련실행 UI/UX개선<BR>
							
						</p>
						<BR>						
						<p>
							<b style="font-size: 1.5em;">D-MESS Version 1.2(취향 분석 개발)</b><br>
							1. 훈련 방식 추가(취향분석)<BR>
							2. 휘향 분석 통계 및 리포팅 추가<BR>
							3. 취향 분석 관련 기반 정보 관리 기능 추가<BR>
							4. 발송 로그 고도화<br>
						</p>
						<p>
							<b style="font-size: 1.5em;">D-MESS Version 1.2.1(라이선스 기능 추가)</b><br>
							1. ASP 라이선스 기능 추가<BR>
						</p>
						<p>
							<b style="font-size: 1.5em;">D-MESS Version 1.2.2(exe 첨부파일 기능 추가)</b><br>
							1. EXE 첨부파일 기능 추가<BR>
						</p>
						<p>
							<b style="font-size: 1.5em;">D-MESS Version 1.3</b><br>
								1. 취향분석 훈련 대상자 랜덤 등록 기능<BR>
								2. 훈련 일시정지/이어보내기/발송초기화 기능<BR>
								3.. 차트별 통계에서 메일 열람자에 따른 신고 수 항목 추가<BR>
								4. 관리자 승인 기능<BR>
								5. 신고 일괄 등록<BR>
								6. 정상 신고 접수에 따른 확인 메일 전송 기능<BR>
								7. 이메일 주소 및 이름 암호화 저장 기능<BR>
								8. 훈련 기간을 분단위로 수정<BR>
								9. 발송 간격 설정 기능<BR>
								10. 개별 신고 접수 기간 제한 기능<BR>
								11. 훈련 메일 발송 완료 메일 전송 기능<BR>
								12. 일부 발송 기능<BR>
								13. 예약 발송 기능<BR>
								14. 신고 시간 준수 기능<BR>
								15. 훈련 결과 보고서 출력 기능<BR>
								16. 셀렉트 박스 검색 기능<BR>
								17. 리포트 및 신고내역 정렬 기능<BR>
								18. 완료된 훈련, 사용자 계정, 템플릿, 기관, 그룹, FAQ 삭제 기능<BR>
								19. 훈련 기간 변경 기능<BR>
								20. 훈련 실행 리스트 항목 추가<BR>
								21. 실제 발송 시간 표시 기능<BR>
								22. 신고 URL 즉시 출력 기능<BR>
								23. 신고 내역 중복 제거 기능<BR>
								24. 신고리스트 EXCEL 다운로드 기능<BR>
						</p>
						 -->
						 					
						<table cellpadding=0 cellspacing=0 >
						 <colgroup>
		       		 			<col width="130px">
		       		 			<col width="20px">
		       		 			<col width="600px">
	       		 		</colgroup>
							<tr >
								<td style="font-size: 15px;"><b>Release Version</b></td><td><b>:</b></td><td style="font-size: 15px;">D-MESS Version 1.3.1</td>
							</tr>
							<tr>
								<td style="font-size: 15px;"><b>Release Date</b></td><td><b>:</b></td><td style="font-size: 15px;">2018-04-05</td>
							</tr>
							
							<tr>
								<td style="font-size: 15px;"><b>License</b></td><td><b>:</b></td>
								<td style="font-size: 15px;">							
									<c:choose>
										<c:when test="${license_detail.license_file_type eq 'success' }">
											<c:choose>
												<c:when test="${license_detail.license_key_type eq  'fail'  or license_detail.host_type eq  'fail' or license_detail.mac_type eq  'fail'  or license_detail.date_type eq  'fail' }">
													<span style="color: red; font-size: 15px;"><c:out value="${license_detail.license_key }"/>(<c:out value="${license_detail.sdate }"/>)</span><br>
														</td>
													</tr>
													<tr>
														<td></td><td></td>
														<td>	
															<span style="color: red; font-size: 15px;">라이선스 정책이 만료되었습니다. 제품 키를 얻으려면 시스템 관리자에게 문의하세요</span>
														</td>
													</tr>
												</c:when>		
												<c:otherwise>
															<span><c:out value="${license_detail.license_key}"/>(<c:out value="${license_detail.sdate }"/>)</span>
														</td>
													</tr>
												</c:otherwise>
											</c:choose>						
										</c:when>
										<c:otherwise>
												<span style="color: red;"> 라이선스 파일이 잘못되었거나 파일을 찾을 수 없습니다. 라이선스 파일을 확인하십시오.</span>
												</td>
											</tr>
										</c:otherwise>
									</c:choose>					
								
						
						</table>						
							<br>
						<c:choose>
                        	<c:when test="${userInfo.lev=='admin'}">
                        		<a href="#LINK" class="btn" onclick="license_info();">라이선스 등록</a>	
	                        </c:when>	
	                        <c:otherwise>		                   
	                        </c:otherwise>
	                     </c:choose>  
								
					</div>
    			</div>
    		</div>
    </div>
      
    <script>
    
    function license_info(){
    	
    	url = "/common/license_valid_pop.do";
    	fn_openwindow(url,  '800px', '400px', 'license_info');	
    
    }
    
    
    </script>
   
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />