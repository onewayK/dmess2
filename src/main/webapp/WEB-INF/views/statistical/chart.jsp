<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_layout" />
	
	<link href="/css/c3.min.css" rel="stylesheet">
	<script src="/js/d3.min.js"></script>
    <script src="/js/c3.min.js"></script>
	<script src="/js/chart.js"></script>
	
	
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
                <i class="fa-icon-home"></i> Home / 통계 /<strong>차트별통계</strong>
            </li>
        </ul>
        
        	<!-- 검색 -->
        	<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-bar-chart"></i><span class="break"></span>차트별통계</h2>
					</div>
					<div class="box-content">
			        	<form name='search' id='search' method="post">
				        			<div class="form-horizontal">
											<div class="control-group span10">
										  <label class="control-label" for="typeahead">검색인자</label>
										  <div class="controls">
											
											
					        				
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
		        
		        
		        <c:set var="tname_temp" value=""/>
		        <c:set var="cur_training_list_array" value="${fn:split(searchVO.training_code,',') }"/>																						
				
				<div class="box span12">
						<div class="box-header" style="height: auto;min-height:20px">
							<h2 style="position: relative;padding-left: 52px;">
								<i class="fa-icon-bar-chart" style="position: absolute;left: 0;">
									<span class="break" style="display: inline-block; height: 20px; margin-top: -16px;"></span>
								</i>
									결과
														
							</h2>
						</div>
						
						<!--  차트 시작  -->
						<div class="box-content">
							
							<table width='100%'>
								<colgroup>
									<col width='50%'>
									<col width='50%'>
								</colgroup>
								<tr>
									<td>
										<c:choose>
											<c:when test="${detail ne null }">
												
												<div class="bar_area">
													<label class="bar_neme span2" style="cursor:default">전체</label>
										        	<div class="bar_graph span10" style="white-space:nowrap">	
											        	<div class="graph_sum">		
												        	<div id="usage_cpu">			
												        		<div class="type_orang" style="width:100%"></div>
												        	</div>
												        	<p>${detail.total }건(100%)</p>		
											        	</div>	
										        	</div>
									        	</div>
									        	
									        	<c:choose>
									        		<c:when test="${detail.training_type1 =='Y'}">
									        		<div class="bar_area">
														<label class="bar_neme span2" style="cursor:default">메일열람</label>
											        	<div class="bar_graph span10" style="white-space:nowrap">	
												        	<div class="graph_sum">		
													        	<div id="usage_cpu">			
													        		<div class="type_orang" style="width:${detail.type1_use_percent }%"></div>
													        	</div>
													        	<p>${detail.type1_use }건(${detail.type1_use_percent }%)</p>		
												        	</div>	
											        	</div>
										        	</div>
									        	</c:when>
									        	</c:choose>
									        	
									        	<c:choose>
									        		<c:when test="${detail.training_type2 =='Y'}">
									        	    	<div class="bar_area">
															<label class="bar_neme span2" style="cursor:default">링크(URL)실행</label>
												        	<div class="bar_graph span10" style="white-space:nowrap">	
													        	<div class="graph_sum">		
														        	<div id="usage_cpu">			
														        		<div class="type_blue" style="width:${detail.type2_use_percent }%"></div>
														        	</div>
														        	<p>${detail.type2_use }건(${detail.type2_use_percent }%)</p>		
													        	</div>	
												        	</div>
											        	</div>
									        		</c:when>
									        	</c:choose>
									        	
									        	
									        	<c:choose>
									        		<c:when test="${detail.training_type3 =='Y'}">
									        			<div class="bar_area">
															<label class="bar_neme span2" style="cursor:default">실행</label>
												        	<div class="bar_graph span10" style="white-space:nowrap">	
													        	<div class="graph_sum">		
														        	<div id="usage_cpu">			
														        		<div class="type_green" style="width:${detail.type3_use_percent }%"></div>
														        	</div>
														        	<p>${detail.type3_use }건(${detail.type3_use_percent }%)</p>		
													        	</div>	
												        	</div>
											        	</div>
									        		</c:when>
									        	</c:choose>
									        	
									        	
								        			
									        			<div class="bar_area">
															<label class="bar_neme span2" style="cursor:default">신고건수(전체)</label>
												        	<div class="bar_graph span10" style="white-space:nowrap">	
													        	<div class="graph_sum">		
														        	<c:choose>
								        							<c:when test="${detail.register_cnt_percent ne '' }">		
																        <div id="usage_cpu">			
															        		<div class="type_red" style="width:${detail.register_cnt_percent }%"></div>
															        	</div>
															        	<p>${detail.register_cnt }건(${detail.register_cnt_percent }%)</p>		
															        </c:when>
												        			<c:otherwise>
												        				<div id="usage_cpu">			
															        		<div class="type_red" style="width:0.00%"></div>
															        	</div>
													        			<p>0건(0.00%)</p>	
												        			</c:otherwise>
								        						</c:choose>
								        						
														        	
													        	</div>	
												        	</div>
											        	</div>
											        	
								        			<c:choose>
								        			<c:when test="${detail.training_type1 =='Y'}">
									        			<div class="bar_area">
															<label class="bar_neme span2" style="cursor:default">신고건수(메일열람)</label>
												        	<div class="bar_graph span10" style="white-space:nowrap">	
													        	<div class="graph_sum">
													        	<c:choose>
								        							<c:when test="${detail.type1_register_cnt_percent ne '' }">		
															        	<div id="usage_cpu">			
															        		<div class="type_red" style="width:${detail.type1_register_cnt_percent }%"></div>
															        	</div>
												        				<p>${detail.type1_register_cnt }건(${detail.type1_register_cnt_percent }%)</p>		
												        			</c:when>
												        			<c:otherwise>
												        				<div id="usage_cpu">			
															        		<div class="type_red" style="width:0.00%"></div>
															        	</div>
													        			<p>0건(0.00%)</p>	
												        			</c:otherwise>
								        						</c:choose>
													        	</div>	
												        	</div>
											        	</div>											        	
											      </c:when>
									        	</c:choose>
									        
									        	
							        		</c:when>
							        	</c:choose>
							
									
									</td>
									<td align="right">
										<c:choose>
											<c:when test="${detail ne null }">
												<table width='95%'  border="1">
													<tr>
															<c:choose>
												        		<c:when test="${detail.training_type1 =='Y'}">
												        			<td width='33%' height="200px" align="center">
												        				<div id='type1_chart'></div>
												        			</td>
												        			<script>
												        				
												        					
											 	        					//data = ['읽음',100],['data2',200];
												        					var data = new Array();
												        					
												        					data[0] = new Array();
												        					data[0]['k'] = '메일열람O';
												        					data[0]['v'] = "<c:out value="${detail.type1_use}"/>";
												        					data[0]['c'] = "#feaa26";
												        					data[1] = new Array();
												        					data[1]['k'] = '메일열람X';
												        					data[1]['v'] = <c:out value="${detail.training_type1_cal-detail.type1_use}"/>;
												        					data[1]['c'] = "gray";
												        					pieChart('type1_chart', data, "", "",200,150);
												        				
												        			</script>
												        		</c:when>
												        		<c:otherwise>
												        			<td width='33%' height="200px" align="center">
												        				-
												        			</td>
												        		</c:otherwise>
											        		</c:choose>
															
														<c:choose>
												        		<c:when test="${detail.training_type2 =='Y'}">
												        			<td width='33%' height="200px" align="center">
												        				<div id='type2_chart'></div>
												        			</td>
												        			<script>
												        				
												        					
												        					//data = ['읽음',100],['data2',200];
												        					var data = new Array();
												        					
												        					data[0] = new Array();
												        					data[0]['k'] = '링크(URL)실행 O';
												        					data[0]['v'] = "<c:out value="${detail.type2_use}"/>";
												        					data[0]['c'] = "#3c61c9";
												        					data[1] = new Array();
												        					data[1]['k'] = '링크(URL)실행X';
												        					data[1]['v'] = <c:out value="${detail.training_type2_cal-detail.type2_use}"/>;
												        					data[1]['c'] = "gray";
												        					pieChart('type2_chart', data, "", "",200,150);
												        				
												        			</script>
												        		</c:when>
												        		<c:otherwise>
												        			<td width='33%' height="200px" align="center">
												        				-
												        			</td>
												        		</c:otherwise>
											        		</c:choose>
														<c:choose>
												        		<c:when test="${detail.training_type3 =='Y'}">
												        			<td width='33%' height="200px" align="center" style="text-align: center">
												        				<div id='type3_chart'></div>
												        			</td>
												        			<script>
												        				
												        					
												        					//data = ['읽음',100],['data2',200];
												        					var data = new Array();
												        					
												        					data[0] = new Array();
												        					data[0]['k'] = '파일실행O';
												        					data[0]['v'] = "<c:out value="${detail.type3_use}"/>";
												        					data[0]['c'] = "#437a1c";
												        					
												        					data[1] = new Array();
												        					data[1]['k'] = '파일실행X';
												        					data[1]['v'] = <c:out value="${detail.training_type3_cal-detail.type3_use}"/>;
												        					data[1]['c'] = "gray";
												        					pieChart('type3_chart', data, "", "",200,150);
												        				
												        			</script>
												        		</c:when>
												        		<c:otherwise>
												        			<td width='33%' height="200px" align="center">
												        				-
												        			</td>
												        		</c:otherwise>
											        		</c:choose>
													</tr>
													<tr>
														<td align="center">메일열람</td>
														<td align="center">링크(URL)실행</td>
														<td align="center">첨부파일 실행</td>
													</tr>
													
												</table>
											</c:when>
										</c:choose>
									</td>
								</tr>
								
								<tr>
								<c:choose>
								 <c:when test="${detail ne null }">
									<table width='100%' border="1">
										<tr>
											<c:choose>
									        		<c:when test="${detail.training_type1_2 =='Y'}">
														<td align="center">메일열람/링크(URL)실행</td>
													</c:when>
													<c:otherwise>
														<td align="center">-</td>
													</c:otherwise>
											</c:choose>
											<c:choose>
									        		<c:when test="${detail.training_type1_3 =='Y'}">
														<td align="center">메일열람/첨부파일 실행</td>
													</c:when>
													<c:otherwise>
														<td align="center">-</td>
													</c:otherwise>
											</c:choose>
											<c:choose>
									        		<c:when test="${detail.training_type2_3 =='Y'}">
														<td align="center">링크(URL)실행/첨부파일 실행</td>
													</c:when>
													<c:otherwise>
														<td align="center">-</td>
													</c:otherwise>
											</c:choose>
											<c:choose>
									        		<c:when test="${detail.training_type1_2_3 =='Y'}">
														<td align="center">메일열람/링크(URL)실행/첨부파일 실행</td>
													</c:when>
													<c:otherwise>
														<td align="center">-</td>
													</c:otherwise>
											</c:choose>
										</tr>
										<tr>
											<c:choose>
								        		<c:when test="${detail.training_type1_2 =='Y'}">
								        			<td width='25%' height="170px" align="center">
								        				<div id='type1_2_chart'></div>
								        			</td>
								        			<script>
								        					var data = new Array();
								        					
								        					data[0] = new Array();
								        					data[0]['k'] = '메일열람/링크(URL)실행O';
								        					data[0]['v'] = "<c:out value="${detail.type1_2_use}"/>";
								        					data[0]['c'] = "#33CCFF";
								        					data[1] = new Array();
								        					data[1]['k'] = '메일열람/링크(URL)실행 X';
								        					data[1]['v'] = <c:out value="${detail.training_type1_2_cal-detail.type1_2_use}"/>;
								        					data[1]['c'] = "gray";
								        					pieChart('type1_2_chart', data, "", "",300,200);
								        				
								        			</script>							        			
								        		</c:when>
								        		<c:otherwise>
								        			<td width='25%' height="170px" align="center">
								        				-
								        			</td>
								        		</c:otherwise>
						        		</c:choose>
						        		<c:choose>
								        		<c:when test="${detail.training_type1_3 =='Y'}">
								        			<td width='25%' height="170px" align="center">
								        				<div id='type1_3_chart'></div>
								        			</td>
								        			<script>							        					
								        					var data = new Array();
								        					
								        					data[0] = new Array();
								        					data[0]['k'] = '메일열람/첨부파일실행O';
								        					data[0]['v'] = "<c:out value="${detail.type1_3_use}"/>";
								        					data[0]['c'] = "#333300";
								        					data[1] = new Array();
								        					data[1]['k'] = '메일열람/첨부파일실행X';
								        					data[1]['v'] = <c:out value="${detail.training_type1_3_cal-detail.type1_3_use}"/>;
								        					data[1]['c'] = "gray";
								        					pieChart('type1_3_chart', data, "", "",300,200);
								        				
								        			</script>							        			
								        		</c:when>
								        		<c:otherwise>
								        			<td width='25%' height="170px" align="center">
								        				-
								        			</td>
								        		</c:otherwise>
						        		</c:choose>
						        		<c:choose>
								        		<c:when test="${detail.training_type2_3 =='Y'}">
								        			<td width='25%' height="170px" align="center">
								        				<div id='type2_3_chart'></div>
								        			</td>
								        			<script>							        				
								        					var data = new Array();
								        					
								        					data[0] = new Array();
								        					data[0]['k'] = '링크(URL)실행/첨부파일실행O';
								        					data[0]['v'] = "<c:out value="${detail.type2_3_use}"/>";
								        					data[0]['c'] = "#CCFF00";
								        					data[1] = new Array();
								        					data[1]['k'] = '링크(URL)실행/첨부파일실행X';
								        					data[1]['v'] = <c:out value="${detail.training_type2_3_cal-detail.type2_3_use}"/>;
								        					data[1]['c'] = "gray";
								        					pieChart('type2_3_chart', data, "", "",300,200);
								        				
								        			</script>							        			
								        		</c:when>
								        		<c:otherwise>
								        			<td width='25%' height="170px" align="center">
								        				-
								        			</td>
								        		</c:otherwise>
						        		</c:choose>
						        		<c:choose>
								        		<c:when test="${detail.training_type1_2_3 =='Y'}">
								        			<td width='25%' height="170px" align="center">
								        				<div id='type1_2_3_chart'></div>
								        			</td>
								        			<script>
								        					//data = ['읽음',100],['data2',200];
								        					var data = new Array();
								        					
								        					data[0] = new Array();
								        					data[0]['k'] = '메일열람/링크(URL)실행/첨부파일 실행 O';
								        					data[0]['v'] = "<c:out value="${detail.type1_2_3_use}"/>";
								        					data[0]['c'] = "#FF0000";
								        					data[1] = new Array();
								        					data[1]['k'] = '메일열람/링크(URL)실행/첨부파일 실행 X';
								        					data[1]['v'] = <c:out value="${detail.training_type1_2_3_cal-detail.type1_2_3_use}"/>;
								        					data[1]['c'] = "gray";
								        					pieChart('type1_2_3_chart', data, "", "","300","200");
								        				
								        			</script>							        			
								        		</c:when>
								        		<c:otherwise>
								        			<td width='25%' height="170px" align="center">
								        				-
								        			</td>
								        		</c:otherwise>
						        		</c:choose>
									</tr>
								</table>
								<!-- 각 훈련 통계 값 출력부 시작-->
							</c:when>
						</c:choose>
						</tr>
						<tr>
			    				<c:choose>
									<c:when test="${detail ne null }">
										<table id="table_training" name="table_training"  width='100%'  style="margin-top:10px" border="1" >
						       		 		<colgroup>
						       		 			<col width="60px">
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
										        <th class="text-center" rowspan='2'>번호</th>
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
										   <c:choose>
											    <c:when test="${fn:length(list)>0}">
											    <c:set var="user_num" value="0"/>
												<c:forEach var="list" items="${list}" varStatus="status">													
															<!-- <tr id="tr_<c:out value="${list.code }"/>">   -->
														<c:set var="user_num" value="${user_num + 1}"/>
    													<tr id="tr_<c:out value="${list.code}"/>">
																<td class="text-center"><c:out value="${user_num}" /></td>
																<td class="text-center"><c:out value="${list.institution_name}" /></td>
		  														<td class="text-center"><c:out value="${list.group_name}" /></td>
																<td class="text-center"><c:out value="${list.tname}" /></td>
																<td class="text-center">
																
																<c:choose>				       		 						
								       		 						<c:when test="${list.status=='ready' }">
								       		 							준비
								       		 						</c:when>
								       		 						<c:when test="${list.status=='sending' || list.status=='send' || list.status=='receive' }">
								       		 							발송중
								       		 						</c:when>
								       		 						<c:when test="${list.status=='step1' }">
								       		 							step1
								       		 						</c:when>
								       		 						<c:when test="${list.status=='end' }">
								       		 							발송완료
								       		 						</c:when>
								       		 						<c:when test="${list.status=='stopping' }">
								       		 							발송중지중
								       		 						</c:when>
								       		 						<c:when test="${list.status=='stop' }">
								       		 							발송중지
								       		 						</c:when>
								       		 						<c:when test="${list.status=='resend' }">
								       		 							재준비중
								       		 						</c:when>
								       		 						<c:when test="${list.status=='init' }">
								       		 							초기화중
								       		 						</c:when>
								       		 						<c:when test="${list.status=='approval' }">
								       		 							승인요청중
								       		 						</c:when>
								       		 						<c:when test="${list.status=='reservation' }">
								       		 							진행대기중
								       		 						</c:when>
								       		 						<c:otherwise>
								       		 							-
								       		 						</c:otherwise>
								       		 					</c:choose>
																	
																</td>
																
																<td class="text-center"><c:out value="${list.all_total}" /></td>
																<td class="text-center"><c:out value="${list.total}" /></td>
																
																<td class="text-center"><c:out value="${list.type1_use}" /></td>
																<td class="text-center"><c:out value="${list.type2_use}" /></td>
																<td class="text-center"><c:out value="${list.type3_use}" /></td>
																
																<td class="text-center"><c:out value="${list.register_cnt}" /></td>																
																<td class="text-center"><c:out value="${list.type1_register}" /></td>
																<td class="text-center"><c:out value="${list.type1_registertime}" /></td>			
															</tr>													
												</c:forEach>
												<c:choose>
												   <c:when test="${listTotal ne null }">
														<tr id="tr_total"/>
															 <td class="text-center"colspan="5">합계</td>
															 
															<td class="text-center"><c:out value="${listTotal.all_total}" /></td>
															<td class="text-center"><c:out value="${listTotal.total}" /></td>
															
															<td class="text-center"><c:out value="${listTotal.type1_use}" /></td>
															<td class="text-center"><c:out value="${listTotal.type2_use}" /></td>
															<td class="text-center"><c:out value="${listTotal.type3_use}" /></td>
															
															<td class="text-center"><c:out value="${listTotal.register_cnt}" /></td>																
															<td class="text-center"><c:out value="${listTotal.type1_register}" /></td>
															<td class="text-center"><c:out value="${listTotal.type1_registertime}" /></td>			
														</tr>
													</c:when>
												</c:choose>		
											</c:when>
								    		<c:otherwise>
								    			<tr>
						       		 				<td colspan="10" align="center">no list</td>
						       		 			</tr>		
				       		 				</c:otherwise>
									 </c:choose>
								</tbody>
						    </table>
						</c:when>
					</c:choose>
    				</tr>
    				<!-- 실데이터 출력부 종료 -->	
						
						</table>
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
    
    
    
    
    <form name='frm' method="post">
    	<input type='hidden' name='code' value=''>
    </form>
    <script> 
    
	
    	/**
    	트레이팅 코드 
    	**/
    	var cur_training_code = "<c:out value="${searchVO.training_code}"/>";
    	$( document ).ready(function() {
    	  
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
				success : function(json)
				{
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
						
						var html = "<select name='training_code' id='training_code' multiple='multiple' style='width: 370px;'>";
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
    
    	var tabList = new Array();
    	<!-- tab메뉴 시작 -->
		<c:choose>
    		<c:when test="${fn:length(trainingTnameList)>0}">
    			<c:forEach var="trainingTnameList" items="${trainingTnameList}" varStatus="status">
    			tabList[<c:out value="${status.index}"/>] = "<c:out value="${trainingTnameList.code}"/>";
    			</c:forEach>
    		</c:when>
		</c:choose>
    	
		
    	function tabView(code)
    	{
    		for(i=0;i<tabList.length;i++)
    		{
    			if(tabList[i]==code)
    			{
    				$("#tabMenu_"+tabList[i]).addClass("active");
    				$("#dataList_"+tabList[i]).show();
    			}
    			else
    			{
    				$("#tabMenu_"+tabList[i]).removeClass("active");
    				$("#dataList_"+tabList[i]).hide();
    			}
    		}
    	}
    	
	    /**
	    검색
	    **/
    	function fn_search()
    	{
    		$('#overlay').show();   
    		
	    	document.search.action = "/statistical/chart.do";
			document.search.submit();
    	}
	    
	    
    	
	    /**
	    페이지 이동
	    **/
    	function goPage(pageno)
    	{
    		location.href="/statistical/chart.do?pageNo="+pageno;
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
     		     		
     		     		var html = "<select name='training_code' id='training_code' multiple='multiple'  style='width: 370px;''>";						
     		     		var count = $("select[name='pickListResult'] option").length;
     					
     					for(i=0;i<count; i++){
     										
     						var option_val= $("select[name='pickListResult'] option")[i].value;
     						var option_name= $("select[name='pickListResult'] option")[i].text;
     						
     						html = html + "<option value='"+option_val+"' selected>"+option_name+"</option>";
     					}    	
     					
 						html = html +"</select>";
 						$("#div_training_code").html(html);
 						
     		        	document.search.action = "/statistical/chart_dialog.do";
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