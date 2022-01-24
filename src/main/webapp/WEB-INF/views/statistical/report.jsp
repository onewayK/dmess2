<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_layout" />
	
	<div id="PageHeight" class="container-fluid">
		
		<div id="overlay" >
			<ul>
				<li class="li1"></li>
				<li class="li2"></li>
				<li class="li3"></li>
				<li class="li4"></li>
				<li class="li5"></li>
				<li class="li6"></li>
			</ul>
		</div>
		
		<!-- navi -->
		<ul class="breadcrumb">
            <li>
                <i class="fa-icon-home"></i> Home / 통계 /<strong>리포트</strong>
            </li>
        </ul>
        
        	<!-- 검색 -->
        	<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-bar-chart"></i><span class="break"></span>리포트</h2>
					</div>
					<div class="box-content">
			        	<form name='search' id='search' method="post">
				        			<div class="form-horizontal">
											<div class="control-group span10">
										  <label class="control-label" for="typeahead">검색인자</label>
										  <div class="controls">
											
											<select name="searchCondition" id='searchCondition'>
					        					<option value='type1' <c:if test="${searchVO.searchCondition=='type1' }"> selected </c:if>>사용자별</option>
					        					<option value='type2' <c:if test="${searchVO.searchCondition=='type2' }"> selected </c:if>>부서별</option>
					        				</select>
					        				
					        				<!-- 기관코드  -->
					        				<select name='searchInstitution' id="searchInstitution" onChange="chgInstitution(this.value)">
												<option value="">선택하세요</option>
												<c:forEach var="list2" items="${list2}" varStatus="status">																						
													<option value="${list2.code }" <c:if test="${searchVO.searchInstitution eq list2.code }"> selected </c:if>><c:out value="${list2.institution_name}"/></option>												
												</c:forEach>										
											</select>	
											
											<!-- 기관코드에 맞게 그룹코드 출력 -->	
											<span id="div_group">
					        							<select name='group_code' id="group_code" onChange="chgGroup(this.value)">
															<option value="">선택하세요</option>
															<c:forEach var="groupList" items="${groupList}" varStatus="status">																						
																<option value="${groupList.code }" <c:if test="${searchVO.group_code eq groupList.code }"> selected </c:if>><c:out value="${groupList.group_name}"/></option>												
															</c:forEach>										
														</select>
					        				</span>
											
											<!-- 그룹코드에 맞게 훈련 값출력 -->
											<span id="div_training_code">
												<select name="training_code" id="training_code" multiple="multiple" style="width: 370px;">
													<c:forEach var="trainingList" items="${trainingList}" varStatus="status">																						
															<option value="${trainingList.code }" <c:out value="${trainingList.selected}"/>><c:out value="${trainingList.tname}"/></option>												
													</c:forEach>
												</select>
					        				</span>
						        		
										  </div>
										</div>
									
										<div class="pull-right">
											<a href='#' onClick='fn_search()' class="btn">검색</a>
										</div>
										
										<div class="pull-right">
											<a href='#' onClick="choseSearchForm('통합 검색');" class="btn">통합 검색</a>	&nbsp;&nbsp;
										</div>
									</div>
			        	
				        </form>
				        <div class="clearFix"></div>
	        		</div>
	        	</div>
	        </div>
	        
	        <div class="row-fluid">
		        <div class="box span12">
						<div class="box-header">
							<h2>
								<i class="fa-icon-bar-chart"></i><span class="break"></span>
									결과						
							</h2>
							
							<h2 style="float:right"><span class="break"></span>								
								<c:choose>
									<c:when test="${trainingDetail ne null }">
										<a href="#" onclick="template_report_download(); return false;"><i class="fa-icon-print"></i>보고서</a>
										<span class="break"></span>	
									</c:when>
								</c:choose>	
								<c:choose>
									<c:when test="${trainingDetail ne null }">
										<a href="#" onclick="report_download(); return false;"><i class="fa-icon-print"></i>리포트(전체)<!-- 리포트--></a>
									</c:when>
								</c:choose>	
							</h2>
						</div>
						<div class="box-content">
						
						<!-- tab메뉴 시작 -->
						<c:choose>
				    		<c:when test="${fn:length(trainingTnameList)>0}">
				    			<ul class="nav nav-tabs">
				    			<c:forEach var="trainingTnameList" items="${trainingTnameList}" varStatus="status">
				    				
				    				<c:choose>
				    					<c:when test="${status.index eq '0' }">
				    						<li id="tabMenu_<c:out value="${trainingTnameList.code}"/>" class="active"><a href="#" onClick="tabView('<c:out value="${trainingTnameList.code}"/>');"><c:out value="${trainingTnameList.tname}"/></a></li>
				    					</c:when>
				    					<c:otherwise>
				    						<li id="tabMenu_<c:out value="${trainingTnameList.code}"/>" ><a href="#" onClick="tabView('<c:out value="${trainingTnameList.code}"/>');"><c:out value="${trainingTnameList.tname}"/></a></li>			
				    					</c:otherwise>
				    				</c:choose>
				    			</c:forEach>
				    			</ul>
				    		</c:when>
						</c:choose>
						
						
						<!-- dataList 출력 시작-->
						<c:choose>
				    		<c:when test="${fn:length(trainingTnameList)>0}">
				    			<c:forEach var="trainingTnameList" items="${trainingTnameList}" varStatus="status">
				    				<c:set var="user_num" value="0"/>
				    				<c:choose>
				    					<c:when test="${status.index eq '0' }">
				    						<c:set var="display" value=""/>
				    						<c:set var="dataListId" value="dataList_${trainingTnameList.code}"/>
				    					</c:when>
				    					<c:otherwise>
				    						<c:set var="display" value="display:none"/>
				    						<c:set var="dataListId" value="dataList_${trainingTnameList.code}"/>			
				    					</c:otherwise>
				    				</c:choose>
				    				
				    				<!-- Summery 출력부 시작-->		
				    			<div id="sum_<c:out value="${dataListId}"/>" style="<c:out value="${display}"/>">		    				
								<table id="table_sum_<c:out value="${dataListId}"/>" name="table_sum_<c:out value="${dataListId}"/>" class="table table-bordered table-striped tablesorter">
						       		 <colgroup>
						       		 	<col width="100px">
						       		 	<col width="100px">						       		 			
				       		 			<col width="100px">
				       		 			<col width="100px">
				       		 			<col width="100px">
				       		 			<col width="100px">
				       		 			<col width="150px">
				       		 			<col width="150px">
				       		 			<col width="150px">
				       		 			<col width="150px">
				       		 			<col width="150px">
				       		 			<col width="150px">
				       		 		</colgroup>
				       		 		 <thead>
								      <tr>
								       <th class="text-center"rowspan='2'>기관명</th>
								        <th class="text-center"rowspan='2'>그룹명</th>
								        <th class="text-center"rowspan='2'>훈련명</th>
								        <th class="text-center"rowspan='2'>훈련상태</th>
								        <th class="text-center" rowspan='2'>전체 인원</th>
								        <th class="text-center" rowspan='2'>발송 인원</th>
								        <th class="text-center"colspan="3" align="center" >훈련타입 </th>
								        <th class="text-center"colspan="3">신고</th>
								      </tr>
								      <tr>
								      		<th class="text-center">메일열람</th>
								      		<th class="text-center">링크(URL)실행</th>
								      		<th class="text-center">첨부파일실행</th>
								      		<th class="text-center">신고율(전체)</th>
								      		<th class="text-center">신고율(메일열람)</th>
								      		<th class="text-center">신고준수율</th>
								      </tr>
								      
								    </thead>
								    <tbody>
								    <c:forEach var="sumList" items="${training_sum_list}" varStatus="status">
								   		<c:choose>
											<c:when	 test="${sumList.training_code eq trainingTnameList.code }">
  												<tr id="tr_sum_<c:out value="${sumList.training_code}"/>">
	  												<td class="text-center"><c:out value="${sumList.institution_name}" /></td>
	  												<td class="text-center"><c:out value="${sumList.group_name}" /></td>
													<td class="text-center"><c:out value="${sumList.tname}" /></td>
													<td class="text-center">
													<c:choose>				       		 						
					       		 						<c:when test="${sumList.status=='ready' }">
					       		 							준비
					       		 						</c:when>
					       		 						<c:when test="${sumList.status=='sending' || sumList.status=='send' || sumList.status=='receive' }">
					       		 							발송중
					       		 						</c:when>
					       		 						<c:when test="${sumList.status=='step1' }">
					       		 							step1
					       		 						</c:when>
					       		 						<c:when test="${sumList.status=='end' }">
					       		 							발송완료
					       		 						</c:when>
					       		 						<c:when test="${sumList.status=='stopping' }">
					       		 							발송중지중
					       		 						</c:when>
					       		 						<c:when test="${sumList.status=='stop' }">
					       		 							발송중지
					       		 						</c:when>
					       		 						<c:when test="${sumList.status=='resend' }">
					       		 							재준비중
					       		 						</c:when>
					       		 						<c:when test="${sumList.status=='init' }">
					       		 							초기화중
					       		 						</c:when>
					       		 						<c:when test="${sumList.status=='approval' }">
					       		 							승인요청중
					       		 						</c:when>
					       		 						<c:when test="${sumList.status=='reservation' }">
					       		 							진행대기중
					       		 						</c:when>
					       		 						<c:otherwise>
					       		 							-
					       		 						</c:otherwise>
					       		 					</c:choose>
													</td>
													<td class="text-center"><c:out value="${sumList.all_total}" /></td>
													<td class="text-center"><c:out value="${sumList.total}" /></td>
													
													<td class="text-center"><c:out value="${sumList.type1_use}" /></td>
													<td class="text-center"><c:out value="${sumList.type2_use}" /></td>
													<td class="text-center"><c:out value="${sumList.type3_use}" /></td>
													
													<td class="text-center"><c:out value="${sumList.register_cnt}" /></td>																
													<td class="text-center"><c:out value="${sumList.type1_register}" /></td>
													<td class="text-center"><c:out value="${sumList.type1_registertime}" /></td>		
							    				</tr>
						    				</c:when>
					    				</c:choose>
				    				</c:forEach>
									</tbody>
							    </table>
							</div>
				    		<!-- Summery 출력부 종료-->
				    				
				    				<!-- 실데이터 출력부 시작-->
				    				<div id="<c:out value="${dataListId}"/>" style="<c:out value="${display}"/>">
					    				<c:choose>
											<c:when test="${searchVO.searchCondition=='type1'}">
												<table id="table_<c:out value="${dataListId}"/>" name="table_<c:out value="${dataListId}"/>" class="table table-bordered table-striped tablesorter">
								       		 		<colgroup>
								       		 			<col width="60px">
								       		 			<col width="100px">
								       		 			<col width="100px">
								       		 			<col width="100px">
								       		 			<col width="100px">
								       		 			<col width="150px">
								       		 			<col width="150px">
								       		 			<col width="150px">
								       		 			<col width="150px">
								       		 			<col width="150px">
								       		 			<col width="150px">
								       		 			<col width="150px">
								       		 			
								       		 		</colgroup>
								       		 		 <thead>
												      <tr>
												        <th class="text-center" rowspan='2'>번호</th>
												        <th class="text-center"rowspan='2'>수신자 이름</th>
												        <th class="text-center" rowspan='2'>수신자 이메일</th>
												        <th class="text-center" rowspan='2'>수신자 부서</th>
												        <th class="text-center"rowspan='2'>고유코드</th>
												        <th class="text-center"colspan="4" align="center" >훈련타입 </th>
												        <th class="text-center"colspan="2">신고</th>
												        <th class="text-center" rowspan='2'>발송일</th>
												      </tr>
												      <tr>
												      		<th class="text-center">메일열람</th>
												      		<th class="text-center">링크(URL)실행</th>
												      		<th class="text-center">링크(URL)피싱</th>
												      		<th class="text-center">첨부파일실행</th>
												      		<th class="text-center">신고여부</th>
												      		<th class="text-center">신고시간준수</th>
												      </tr>
												      
												    </thead>
												    <tbody>
												   <c:choose>
													    <c:when test="${fn:length(list)>0}">
														<c:forEach var="list" items="${list}" varStatus="status">
															<c:choose>
																<c:when	 test="${list.training_code eq trainingTnameList.code }">
																	<!-- <tr id="tr_<c:out value="${list.code }"/>">   -->
																		<c:set var="user_num" value="${user_num + 1}"/>
				    													<tr id="tr_<c:out value="${list.code}"/>">
																		<td class="text-center"><c:out value="${user_num}" /></td>
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
																</c:when>
															</c:choose>
														</c:forEach>
													<c:choose>
														<c:when test="${user_num == 0}">
											    			<tr>
									       		 				<td colspan="12" align="center">no list</td>
									       		 			</tr>		
						       		 				 	</c:when>
											    	</c:choose>
													</c:when>
										    		<c:otherwise>
										    			<tr>
								       		 				<td colspan="12" align="center">no list</td>
								       		 			</tr>		
						       		 				 </c:otherwise>
											    	</c:choose>
												    </tbody>
								       		 	</table>								       		 		       		 	
											</c:when>
											<c:when test="${searchVO.searchCondition=='type2'}">
											<table id="table_<c:out value="${dataListId}"/>" name="table_<c:out value="${dataListId}"/>" class="table table-bordered table-striped tablesorter">
								       		 		<colgroup>
								       		 			<col width="200px">
								       		 			<col width="100px">
								       		 			<col width="200px">
								       		 			<col width="200px">
								       		 			<col width="200px">
								       		 			<col width="200px">
								       		 			<col width="200px">
								       		 		</colgroup>
								       		 		 <thead>
												      <tr>
												        <th rowspan='2'>수신자 부서</th>
												        <th rowspan='2'>메일발송수</th>
												        <th colspan="3" align="center" ><span tooltipmessage='전체/열람(퍼센트)'>훈련타입</span></th>
												        <th rowspan='2'>신고건수(전체)</th>
												     	<th rowspan='2'>신고건수(메일열람)</th>
												      </tr>
												      <tr>
												      		<th><span tooltipmessage='전체/메일열람(%)'>메일열람</span></th>
												      		<th><span tooltipmessage='전체/링크(URL)실행(%)'>링크(URL)실행</span></th>
												      		<th><span tooltipmessage='전체/첨부파일실행(%)'>첨부파일실행</span></th>
												      </tr>
												       
												    </thead>
												    <tbody>
												    	<c:choose>
													    		<c:when test="${fn:length(list)>0}">
													    			<c:forEach var="list" items="${list}" varStatus="status">
													    			<c:choose>
															    			<c:when test="${list.training_code eq trainingTnameList.code }">
															    			
													    				    	<tr id="tr_<c:out value="${list.code }"/>">
														       		 			<c:set var="user_num" value="${user_num + 1}"/>	
														       		 				<td><c:out value="${list.department_name}"/></td>
														       		 				<td class="text-center"><c:out value="${list.total}"/></td>
														       		 				
														       		 					<c:choose>
																			        		<c:when test="${list.training_type1=='Y'}">
																			        			<td class="text-center">
																			        			
																			        					<c:out value="${list.training_type1_cnt}"/>/<c:out value="${list.type1_use}"/>(<c:out value="${list.training_type1_percent}"/>%)
																			        					
																			        			</td>
																			        		</c:when>
																			        		<c:otherwise>
																			        			<td style="background:gray;">&nbsp;</td>
																			        		</c:otherwise>
																			        	</c:choose>
														       		 					
														       		 					<c:choose>
																			        		<c:when test="${list.training_type2=='Y'}">
																			        			<td class="text-center">
																			        				<c:out value="${list.training_type2_cnt}"/>/<c:out value="${list.type2_use}"/>(<c:out value="${list.training_type2_percent}"/>%)
																			        			</td>
																			        		</c:when>
																			        		<c:otherwise>
																			        			<td style="background: gray;">&nbsp;</td>
																			        		</c:otherwise>
																			        	</c:choose>
																			        	<c:choose>
																			        		<c:when test="${list.training_type3=='Y'}">
																			        			<td class="text-center">
																			        				<c:out value="${list.training_type3_cnt}"/>/<c:out value="${list.type3_use}"/>(<c:out value="${list.training_type3_percent}"/>%)
																			        			</td>
																			        		</c:when>
																			        		<c:otherwise>
																			        			<td style="background: gray;">&nbsp;</td>
																			        		</c:otherwise>
																			        	</c:choose>
														       		 				<td class="text-center"><c:out value="${list.register_cnt}"/></td>
														       		 				<td class="text-center"><c:out value="${list.type1_register_cnt}"/></td>
														       		 			</tr>
													       		 			</c:when>
													       		 		</c:choose>
											       		 			</c:forEach>			
											       		 			<c:choose>
																		<c:when test="${user_num == 0}">
															    			<tr>
													       		 				<td colspan="7" align="center">no list</td>
													       		 			</tr>		
										       		 				 	</c:when>
															    	</c:choose>								       		 		
													    		</c:when>													    		
													    		<c:otherwise>
													    			<tr>
											       		 				<td colspan="7" align="center">no list</td>
											       		 			</tr>		
									       		 				 </c:otherwise>
												    	</c:choose>
								       		 			
												    </tbody>
								       		 	</table>
											</c:when>
											<c:otherwise>
												no list
											</c:otherwise>
											
										</c:choose>
				    				</div>
				    				<!-- 실데이터 출력부 종료 -->	
				    			</c:forEach>
				    		</c:when>
						</c:choose>
						<!-- dataList 출력 종료-->
						
												
						
				        	<div class="clearFix"></div>
		        		</div>
		        </div>
	        </div>
    </div>
    
    <!-- 통합 검색 창 -->
    <div id="dialog-search" title="통합 검색 창" style="display:none">		 
	    <table style="width:100%" class="table table-bordered ">
	   <colgroup>						       		 			
			 <col width="50%">
			<col width="50%">
		</colgroup>
	    <thead>
			  <tr>
			      <th class="text-center">훈련 목록</th>	
			      <th class="text-center">검색할 훈련 목록</th>		
			</tr>		      
	    </thead>
	    <tbody>	  
	   <tr>
	   
		<td>
   		  <div class="controls">
			<select name="searchCondition_dialog" id='searchCondition_dialog'>
				<option value='type1' <c:if test="${searchVO.searchCondition=='type1' }"> selected </c:if>>사용자별</option>
				<option value='type2' <c:if test="${searchVO.searchCondition=='type2' }"> selected </c:if>>부서별</option>
  			</select>
  			
     		<!-- 기관코드  -->
     		<select name='searchInstitution_dialog' id="searchInstitution_dialog" onChange="chgInstitution_dialog(this.value)">
				<option value="">선택하세요</option>
				<c:forEach var="list2" items="${list2}" varStatus="status">																						
					<option value="${list2.code }" <c:if test="${searchVO.searchInstitution eq list2.code }"> selected </c:if>><c:out value="${list2.institution_name}"/></option>												
				</c:forEach>										
			</select>	
			
			<!-- 기관코드에 맞게 그룹코드 출력 -->	
			<span id="div_group_dialog">
     				<select name='group_code_dialog' id="group_code_dialog" onChange="chgGroup_dialog(this.value)">
							<option value="">선택하세요</option>
					</select>
     		</span>      		
		  </div>			
		  <div>
		   		<select name="pickData"  id="pickData" class='form-control'   multiple="multiple" style="width: 100%; height: 300px;">
		   		</select>
			</div>
			<div>
			    <button  onClick="pAdd()" class='btn btn-primary btn-sm'>추가</button>
			    <button  onClick="pAddAll()" class='btn btn-primary btn-sm'>전체추가</button>
			</div>
		</td>
	<td>
		<div>
	   		<select name="pickListResult"  id="pickListResult" class='form-control'  multiple="multiple" style="width: 100%; height: 335px">
	   		</select>
		</div>
		<div>
		    <button  onClick="pRemove()"  class=' btn btn-primary btn-sm'>삭제</button>
		    <button  onClick="pRemoveAll()"  class='pAddAll btn btn-primary btn-sm'>전체삭제</button>
		</div>
	</td>
		</tr>
	</tbody>
		 </table>
	</div>
			  
	 <form name='excel_all'  id='excel_all'  method="post">
    	<input type='hidden' name='searchCondition'  id='searchCondition'  value="<c:out value="${searchVO.searchCondition}"/>">
       	<select id="training_code"  name="training_code"  multiple="multiple"  style="display:none">
			<c:forEach var="training_code" items="${searchVO.training_code}" varStatus="status">																						
				<option value="${training_code}"  selected></option>												
			</c:forEach>										
		</select>	
    </form>
    
    <form name='frm'  id='frm'  method="post">
    	<input type='hidden' name='code' value=''>
    </form>
  
    <script>       

    	function phishing_view(training_code, training_user_code)
    	{
    		url = '<c:url value="/statistical/phishing_view.do"/>?training_code='+training_code+"&training_user_code="+training_user_code;
       		fn_openwindow(url,  '600px', '400px', 'pop_phishing_list');
    	}
    	/**
    	트레이팅 코드 
    	**/
    	var cur_training_code = "<c:out value="${searchVO.training_code}"/>";
    	$( document ).ready(function() {
    		
    	
    		
    	var cur_searchCondition = "<c:out value="${searchVO.searchCondition}"/>";
   
    	/**
    	타입 설정 체크
    	**/
	    $('#searchCondition').change(function(){
	        //alert( $('#searchCondition option:selected').val() );
	        
	        /**
	        if(searchCondition!=$('#searchCondition option:selected').val())
	        {
	        	if($('#searchCondition option:selected').val()=='type2')
	        	{
	        		if(confirm('부서별의 경우 일반 훈련에 대한 리포트 내용을 확인하실수있습니다.\n변경시 이전 선택한 내용들은 초기화 한후 진행됩니다. \n계속 진행하시겠습니까?'))
		        	{
	        			$("#searchCondition").val("type2").prop("selected", true);
	        			chgInstitution($("#searchInstitution option:selected").val());
		        	}
		        	else
		        	{
		        		$("#searchCondition").val("type1").prop("selected", true);
		        	}	
	        	}
	        	else
	        	{
	        		searchCondition=$('#searchCondition option:selected').val();
	        		chgInstitution($("#searchInstitution option:selected").val());
	        	}
	      
	        }  **/
	    });

    	   /**멀티 선택**/
    	  $("#training_code").multiselect(
    		{
    			noneSelectedText:'선택해주세요'
    			,checkAllText:'전체선택'
    			,uncheckAllText:'선택해제'
    		}	  
    	  ).multiselectfilter(
    			  {
		    			label:'훈련검색',
		    			placeholder: '훈련명 입력',
		    			width : 100
		    		}	  
  	 	  );
    		
    	  if($("#searchInstitution option:selected").val()!="")
    	  {
    		  //chgInstitution($("#searchInstitution option:selected").val());
    	  }
    	});
    	
    	//기관선택
    	function chgInstitution(code)
    	{
    		var param = "code="+code+"&type=0";
    		$.ajax({
				type:'POST',
				url : "<c:url value='/statistical/ajax_institutionList.do'/>",
				data:param,
				dataType : "json",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
				beforeSend: function() {
		        	
		        },
				success : function(json){
					
					var html = "<select name='group_code' id='group_code' onChange='chgGroup(this.value);'><option value=''>선택하세요</option>";
					for(i=0;i<json.length;i++)
					{
						if(cur_training_code==json[i].code)
						{
							html = html + "<option value='"+json[i].code+"' selected >"+json[i].group_name+"</option>";
						}
						else
						{
							html = html + "<option value='"+json[i].code+"'>"+json[i].group_name+"</option>";	
						}
						
					}
					html = html +"</select>";
					$("#div_group").html(html);
					
					//훈련명 초기화 처리
					chgGroup('0');
					
					
				},
				error:function(request,status,error){
					
				}
				
			}).complete(function() {
				
	        });
    	}
    	
    	
    	/**
    	훈련리스트 그룹 추출
    	**/
    	function chgGroup(code)
    	{
    		
    		if(code=="0" || code == '')
    		{
    			
    			var html = "<select name='training_code' id='training_code' multiple='multiple' style='width: 370px;'>";
				html = html +"</select>";
				
				$("#div_training_code").html(html);
    			$("#training_code").multiselect({
	    			noneSelectedText:'선택해주세요'
	    			,checkAllText:'전체선택'
	    			,uncheckAllText:'선택해제'
	    		}).multiselectfilter(
		    		{
			    			label:'훈련검색',
			    			placeholder: '훈련명 입력',
			    			width : 100
				    }	  
		    	 );
    		}
    		else
    		{
	    		var searchCondition = $('#searchCondition option:selected').val();
	    		
	    		
	    		var param = "code="+code+"&type=1";
	    		$.ajax({
					type:'POST',
					url : "<c:url value='/statistical/ajax_institutionList.do'/>",
					data:param,
					dataType : "json",
					contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
					beforeSend: function() {
			        	
			        },
					success : function(json){
						
						var html = "<select name='training_code' id='training_code' multiple='multiple'  style='width: 370px;''>";
						for(i=0;i<json.length;i++)
						{
							html = html + "<option value='"+json[i].code+"' selected>"+json[i].tname+"</option>";
						}
						html = html +"</select>";
						$("#div_training_code").html(html);
						
						/**멀티 선택**/
			    	  $("#training_code").multiselect(
			    		{
			    			noneSelectedText:'선택해주세요'
			    			,checkAllText:'전체선택'
			    			,uncheckAllText:'선택해제'
			    		}	  
			    	  ).multiselectfilter(
			    			  {
					    			label:'훈련검색',
					    			placeholder: '훈련명 입력',
					    			width : 100
					    		}	  
			    	 );
					}
			      
	    		});
    		}
    	}
    	
    	/**
    	수정 및 상세보기
    	**/
    	function view(code)
    	{
    		
    	}
    	
   		var cur_tab;
   		
    	var tabList = new Array();
    	<!-- tab메뉴 시작 -->
		<c:choose>
    		<c:when test="${fn:length(trainingTnameList)>0}">
    			<c:forEach var="trainingTnameList" items="${trainingTnameList}" varStatus="status">
    			tabList[<c:out value="${status.index}"/>] = "<c:out value="${trainingTnameList.code}"/>";
    			</c:forEach>
    		</c:when>
		</c:choose>
		
		<c:choose>
			<c:when test="${fn:length(trainingTnameList)>0}">
				cur_tab=tabList[0];
				$("#table_dataList_"+tabList[0]).tablesorter();
			</c:when>
		</c:choose>
		
		
		
    	function tabView(code)
    	{    		
    		for(i=0;i<tabList.length;i++)
    		{
    			if(tabList[i]==code)
    			{
    				$("#tabMenu_"+tabList[i]).addClass("active");
    				$("#sum_dataList_"+tabList[i]).show();
    				$("#dataList_"+tabList[i]).show();
    				cur_tab=tabList[i];
    				$("#table_dataList_"+tabList[i]).tablesorter();
    			}
    			else
    			{
    				$("#tabMenu_"+tabList[i]).removeClass("active");
    				$("#dataList_"+tabList[i]).hide();
    				$("#sum_dataList_"+tabList[i]).hide();
    			}
    		}
    
    	}
    	
	    /**
	    검색
	    **/
    	function fn_search()
    	{	    	
    		$('#overlay').show();   
	    	document.search.action = "/statistical/report.do";
			document.search.submit();
    	}
	    
	    
    	
	    /**
	    페이지 이동
	    **/
    	function goPage(pageno)
    	{
    		location.href="/statistical/report.do?pageNo="+pageno;
    	}
	    /**
	    	report donwload
	    **/
	    function report_download()
	    {	
	    	var frm = document.getElementById("excel_all");
	    		    	
	    	frm.action = "<c:url value='/statistical/excel.do'/>";
	    	frm.submit();
	    }
    	
	    /**
    	template report donwload
	    **/
	    function template_report_download()
	    {	
	    	if(cur_tab != null){
	    		var frm = document.getElementById("frm");
	    		
	    		$("input[name='code']").val(cur_tab);	    		
	    		
		    	frm.action = "<c:url value='/statistical/templateExcel.do'/>";
		    	frm.submit();
		    	
	    	}else{
	    		alert("보고서 출력을 원하시는 훈련을 선택 또는 검색해주세요");
	    	}
	    }
    	       		    
	    function choseSearchForm(title)
    	{	    	 
	    	choseSearchForm_init();
	    	
    		$("#dialog-search").dialog({
    				title:title,
    		      resizable: false,
    		      position:'center',
    		      height: "auto",
    		      width: 1000,
    		      modal: true,
    		      buttons: {
    		     	"검색": function() {
    		     		$('#overlay').show();   
    		     		
    		     		var search_Condition = $('#searchCondition_dialog').val();
    		     		
    		     		$('#searchCondition').children("[value='"+search_Condition+"']").prop("selected", true);
    		     		
    		     		var html = "<select name='training_code' id='training_code' multiple='multiple'  style='width: 370px;''>";						
    		     		var count = $("select[name='pickListResult'] option").length;
    					
    					for(i=0;i<count; i++){
    										
    						var option_val= $("select[name='pickListResult'] option")[i].value;
    						var option_name= $("select[name='pickListResult'] option")[i].text;
    						
    						html = html + "<option value='"+option_val+"' selected>"+option_name+"</option>";
    					}    	
    					
						html = html +"</select>";
						$("#div_training_code").html(html);
						
    		        	document.search.action = "/statistical/report_dialog.do";
    		        	document.search.submit();
    		        } 		      
    		      }
    		    });
    	}
	    
	    function choseSearchForm_init()
    	{	    	 
	    	  $("select[name='pickData'] option").remove();
	    	  $("select[name='pickListResult'] option").remove();
	    	  
	    	  $("select[name='group_code_dialog'] option").remove();
	    	  $("#group_code_dialog").append("<option value='''>선택하세요</option>");
	    		
	    	  $("#searchInstitution_dialog option:eq(0)").prop("selected", true);
	    	  $("#searchCondition_dialog option:eq(0)").prop("selected", true);
    	}
	    
	    function choseSearchForm_pickData_init()
    	{
	    	$("select[name='pickData'] option").remove();;
    	}
	    
		//기관선택
    	function chgInstitution_dialog(code)
    	{
    		choseSearchForm_pickData_init();
			
    		var param = "code="+code+"&type=0";
    		$.ajax({
				type:'POST',
				url : "<c:url value='/statistical/ajax_institutionList.do'/>",
				data:param,
				dataType : "json",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
				beforeSend: function() {
		        	
		        },
				success : function(json){
					
					var html = "<select name='group_code_dialog' id='group_code_dialog' onChange='chgGroup_dialog(this.value);'><option value=''>선택하세요</option>";
					for(i=0;i<json.length;i++)
					{
						if(cur_training_code==json[i].code)
						{
							html = html + "<option value='"+json[i].code+"' selected >"+json[i].group_name+"</option>";
						}
						else
						{
							html = html + "<option value='"+json[i].code+"'>"+json[i].group_name+"</option>";	
						}
						
					}
					html = html +"</select>";
					$("#div_group_dialog").html(html);
					
					//훈련명 초기화 처리
					chgGroup_dialog('0');
					
					
				},
				error:function(request,status,error){
					
				}
				
			}).complete(function() {
				
	        });
    	}    	
    	
    	/**
    	훈련리스트 그룹 추출
    	**/
    	function chgGroup_dialog(code)
    	{
    		
    		if(code ==null  || code == "" || code=="0")
    		{
    			  $("select[name='pickData'] option").remove();    			
    		}
    		else
    		{
    			choseSearchForm_pickData_init();
	    		var searchCondition = $('#searchCondition_dialog option:selected').val();
	    		
	    		
	    		var param = "code="+code+"&type=1";
	    		
	    		$.ajax({
					type:'POST',
					url : "<c:url value='/statistical/ajax_institutionList.do'/>",
					data:param,
					dataType : "json",
					contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
					beforeSend: function() {
			        	
			        },
					success : function(json){
						
						for(i=0;i<json.length;i++)
						{		
							 $("#pickData").append("<option value='"+json[i].code+"'>"+json[i].tname+"</option>");
						}
					} 
	    		});
    		}
    	}

    	 function pAdd(){    	
			var count = $("select[name='pickData'] option:selected").length;
			
			var institution_name= $("select[name='searchInstitution_dialog'] option:selected").text();
			
			var group_name= $("select[name='group_code_dialog'] option:selected").text();
			
			for(i=0;i<count; i++){
								
				var option_val= $("select[name='pickData'] option:selected")[i].value;
				var option_name= $("select[name='pickData'] option:selected")[i].text;
				
				$('#pickListResult').children("[value='"+option_val+"']").remove();				
				
				$("#pickListResult").append("<option value='"+option_val+"'>"+institution_name+"/"+group_name+"/"+option_name+"</option>");
			}
          }

          function pAddAll() {
        	var count = $("select[name='pickData'] option").length;
  			
        	var institution_name= $("select[name='searchInstitution_dialog'] option:selected").text();
			var group_name= $("select[name='group_code_dialog'] option:selected").text();
			
        	
  			for(i=0;i<count; i++){
  				var option_val= $("select[name='pickData'] option")[i].value;
  				var option_name= $("select[name='pickData'] option")[i].text;
  				
  				$('#pickListResult').children("[value='"+option_val+"']").remove();				
  				
  				$("#pickListResult").append("<option value='"+option_val+"'>"+institution_name+"/"+group_name+"/"+option_name+"</option>");
  			}
          }

      	 function pRemove() {
      		$("select[name='pickListResult'] option:selected").remove();
          }
      	 
          function pRemoveAll() {
        	  $("select[name='pickListResult'] option").remove();
          }
    	
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />