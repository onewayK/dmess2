<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="kr.nshare.common.util.EgovProperties"%>
<%@ taglib prefix="c"      		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>



<c:import url="/common/pageLink.do?link=inc/top_layout" />

<!-- bootstrap dialog -->
<script src="<c:url value='/js/bootstrap/bootstrap-dialog.js'/>"></script>

<!-- bootstrap dialog -->
<link href="<c:url value='/css/bootstrap/bootstrap-dialog.css'/>" rel="stylesheet">

	<div id="PageHeight" class="container-fluid">
		
		<!-- navi -->
		<ul class="breadcrumb">
            <li>
                <i class="fa-icon-home"></i> Home / <strong>훈련실행</strong>
            </li>
        </ul>
        
  
        
        <!-- 검색 -->
        	<form name='search' method="post">
        	<input type='hidden' name='pageNo' value='<c:out value="${searchVO.pageNo }"/>'>
        	<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-user"></i><span class="break"></span>훈련실행</h2>
					</div>
					<div class="box-content">
        	
        					<div class="form-horizontal">
								<div class="control-group span9">
								  <label class="control-label" for="typeahead">검색인자</label>
								  <div class="controls">
									  <select name='searchInstitution'>
											<option value="">선택하세요</option>
											<c:forEach var="list2" items="${list2}" varStatus="status">																						
												<option value="${list2.code }" <c:if test="${searchVO.searchInstitution eq list2.code }"> selected </c:if>><c:out value="${list2.institution_name}"/></option>												
											</c:forEach>										
										</select>		
								  
				        			<select name="searchCondition">
				        				<option value='tname' <c:if test="${searchVO.searchCondition=='tname' }"> selected </c:if>>훈련명</option>
				        				<option value='send_name' <c:if test="${searchVO.searchCondition=='send_name' }"> selected </c:if>>발신인</option>
				        				<option value='create_id' <c:if test="${searchVO.searchCondition=='create_id' }"> selected </c:if>>훈련생성 아이디</option>
				        				
				        				
				        			</select>
				        			<input type='text' name='searchKeyword' value="${searchVO.searchKeyword }">
								  </div>
								</div>
								<div class="pull-right">
									<a href='#' onClick='fn_search()' class="btn">검색</a>
								</div>
							</div>
        	
	        </form>
	        
	       		 	<table class="table table-bordered table-striped">
	       		 		<colgroup>
	       		 			<col width="200px">
	       		 			<%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
			       		 		<col width="100px">
			       		 	<%}%>
	       		 			<col width="*">
	       		 			<col width="100px">
	       		 			<col width="200px">
	       		 			<col width="110px">
	       		 			<col width="110px">
	       		 			<col width="110px">
	       		 			<col width="160px">
	       		 			<col width="50px">
	       		 			<col width="100px">
	       		 			<col width="120px">
	       		 		</colgroup>
	       		 		 <thead>
					      <tr>
					        <th rowspan='2'>기관/그룹</th>
					        <%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
			       		 		  <th rowspan='2'>서비스타입</th>
			       		 	<%}%>
					        <th rowspan='2'>훈련명</th>
					        <th rowspan='2'>발신인</th>
					        <th rowspan='2'>발신email</th>
					        <th colspan="3" align="center" >훈련타입</th>
					        <th rowspan='2'>등록일</th>
					        <th rowspan='2'>대상자수</th>
					        <th rowspan='2'>진행상태</th>
					        <th rowspan='2'>훈련실행</th>
					      </tr>
					      <tr>
					      		<th>메일열람</th>
					      		<th>링크(URL)실행</th>
					      		<th>첨부파일실행</th>
					      </tr>
					       
					    </thead>
					    <tbody>
					    	<c:set value="" var="total_code"/>
					    	<c:choose>
						    		<c:when test="${fn:length(list)>0}">
						    			<c:forEach var="list" items="${list}" varStatus="status">
								    	
								    	<c:choose>
								    		<c:when test="${total_code ==''  }">
								    			<c:set var="total_code" value="${list.code }"/>
								    		</c:when>
								    		<c:otherwise>
								    			<c:set var="total_code" value="${total_code}_${list.code}"/>
								    		</c:otherwise>
								    	</c:choose>
								    	
								    	<tr id="tr_<c:out value="${list.code }"/>" scope="row">
				       		 				<c:choose>
				       		 					<c:when test="${list.row_number=='1'}">
				       		 						
				       		 						<c:forEach var="list2" items="${summaryList}" varStatus="status">
				       		 							<c:choose>
					       		 							<c:when test="${list2.group_code eq list.group_code }">
					       		 								<th rowspan="<c:out value="${list2.group_cnt}"/>"><c:out value="${list.institution_name}"/> / <c:out value="${list.group_name}"/></th>	
					       		 							</c:when>
				       		 							</c:choose>
				       		 						</c:forEach>
				       		 										       		 						
				       		 					</c:when>
				       		 				</c:choose>
				       		 				
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
				       		 					<div style="width: 100%">
				       		 						
				       		 						
				       		 						<span style="float: left;">
				       		 								<c:choose>
						       		 							<c:when test="${list.type == '1' }">
						       		 								<b>(취)</b>
						       		 							</c:when>
						       		 						</c:choose>
				       		 								<c:out value="${list.tname}"/>
				       		 						</span>
				       		 						
				       		 						
				       		 						
				       		 						<span><li><i class="fa-icon-bar-chart contentMenu" institution_code="<c:out value="${list.institution_code}"/>" group_code="<c:out value="${list.group_code}"/>" training_code="<c:out value="${list.code}"/>"></i> </li></span>
				       		 					</div>
				       		 					
				       		 					
				       		 					<c:choose>
					       		 					<c:when test="${list.del_flag == 'y' && list.del_type=='a'}">
					       		 						<br><p ><font color='red'>(자동 삭제 정책에 의해서 훈련대상자 정보가 삭제처리됨)</font></p>
					       		 					</c:when>
					       		 					<c:when test="${list.del_flag == 'y' && list.del_type=='a'}">
					       		 						<br><p ><font color='red'>(수동 삭제 정책에 의해서 훈련대상자 정보가 삭제처리됨)</font></p>
					       		 					</c:when>
				       		 					</c:choose>
				       		 				
				       		 				</td>
				       		 				<!--  -->
				       		 				<c:choose>
				       		 					<c:when test="${list.type eq '0' }">
				       		 							<td><c:out value="${list.send_name}"/></td>				       		 				
							       		 				<td><c:out value="${list.send_email}"/></td>
							       		 				<td class="text-center"><c:out value="${list.training_type1}"/></td>
							       		 				<td class="text-center"><c:out value="${list.training_type2}"/></td>
							       		 				<td class="text-center"><c:out value="${list.training_type3}"/></td>
				       		 					</c:when>
				       		 					<c:otherwise>
				       		 						<td colspan="5" class="center"> 
				       		 							<a href='#' class="btn btn-primary" onClick="type2DetailSetting('<c:out value="${list.code}"/>');">상세보기</a>
				       		 						</td>	
				       		 					</c:otherwise>
				       		 				</c:choose>
				       		 				<!--  -->
				       		 				<td><c:out value="${list.sdate}"/></td>
				       		 				
				       		 				
				       		 				<td style='text-align: center'><c:out value="${list.user_cnt}"/></td>
				       		 				
				       		 				<td class="text-center">
				       		 				
				       		 				
				       		 					<c:choose>
				       		 						
				       		 						<c:when test="${list.status=='ready' }">
				       		 							<span id="<c:out value="${list.code }" />_status" >준비</span>
				       		 						</c:when>
				       		 						<c:when test="${list.status=='sending' || list.status=='send' || list.status=='receive' }">
				       		 							<span  id="<c:out value="${list.code }" />_status">발송중</span>
				       		 						</c:when>
				       		 						
				       		 						<c:when test="${list.status=='step1' }">
				       		 							<span id="<c:out value="${list.code }" />_status">step1</span>
				       		 						</c:when>
				       		 						
				       		 						
				       		 						<c:when test="${list.status=='end' }">
				       		 							<span  id="<c:out value="${list.code }" />_status">완료</span>
				       		 						</c:when>
				       		 						<c:when test="${list.status=='stopping' }">
				       		 							<span  id="<c:out value="${list.code }" />_status">발송중지중</span>
				       		 						</c:when>
				       		 						<c:when test="${list.status=='stop' }">
				       		 							<span  id="<c:out value="${list.code }" />_status">발송중지</span>
				       		 						</c:when>
				       		 						<c:when test="${list.status=='resend' }">
				       		 							<span  id="<c:out value="${list.code }" />_status">재준비중</span>
				       		 						</c:when>
				       		 						<c:when test="${list.status=='init' }">
				       		 							<span  id="<c:out value="${list.code }" />_status">초기화중</span>
				       		 						</c:when>
				       		 						<c:when test="${list.status=='approval' }">
				       		 							<span  id="<c:out value="${list.code }" />_status">승인요청중</span>
				       		 						</c:when>
				       		 						<c:when test="${list.status=='reservation' }">
				       		 							<span  id="<c:out value="${list.code }" />_status">진행대기중</span>
				       		 						</c:when>
				       		 						<c:otherwise>
				       		 							null
				       		 						</c:otherwise>
				       		 						
				       		 					</c:choose>
				       		 				</td>
				       		 				<td>
				       		 					
				       		 					<c:choose>
				       		 						<c:when test="${list.user_cnt <=0}">
				       		 							<a href="#"  onClick="view('${list.code}','${list.type }','user')"> 훈련대상자<br><font color='red'>미지정</font></a>
				       		 						</c:when>
				       		 						
				       		 						<c:when test="${list.status=='ready' }">
				       		 						  <%if(EgovProperties.getProperty("Globals.approval_type").equals("1")){ %>
				       		 							<c:choose>
			       		 						  			<c:when test="${list.approval_type=='n' }">	
					       		 								<a href="#" onClick="view('${list.code}','${list.type }','approval')"> 관리자 <font color='red'>승인</font> 필요</a>
					       		 							</c:when>
						       		 						<c:when test="${list.validation=='success' }">
						       		 							<a href="#" id="excute_btn_<c:out value="${list.code }"/>" class="btn btn-primary" onClick="excute('${list.code}')">훈련실행</a>
						       		 							<a href="#" id="stop_btn_<c:out value="${list.code }"/>" class="btn btn-primary" onClick="excute_stop('${list.code}')" style="display: none;">일시정지</a>
						       		 						</c:when>
						       		 						<c:when test="${list.reservation_type=='Y' }">
						       		 							<a href="#" id="excute_btn_<c:out value="${list.code }"/>" class="btn btn-primary" onClick="excute('${list.code}')">훈련실행</a>
						       		 							<a href="#" id="stop_btn_<c:out value="${list.code }"/>" class="btn btn-primary" onClick="excute_stop('${list.code}')" style="display: none;">일시정지</a>
						       		 						</c:when>
						       		 						<c:otherwise>
						       		 							<a href='#' title="<c:out value="${list.start_date }"/>~<c:out value="${list.end_date }"/>"  onClick="view('${list.code}','${list.type }','date')"/>훈련 기간  아님</a> 
						       		 						</c:otherwise>
						       		 					</c:choose>
				       		 						 <%}else{ %>
				       		 						 		<c:choose>
						       		 						<c:when test="${list.validation=='success' }">	
						       		 							<a href="#" id="excute_btn_<c:out value="${list.code }"/>" class="btn btn-primary" onClick="excute('${list.code}')">훈련실행</a>
						       		 							<a href="#" id="stop_btn_<c:out value="${list.code }"/>" class="btn btn-primary" onClick="excute_stop('${list.code}')" style="display: none;">일시정지</a>
						       		 						</c:when>
						       		 						<c:when test="${list.reservation_type=='Y' }">
						       		 							<a href="#" id="excute_btn_<c:out value="${list.code }"/>" class="btn btn-primary" onClick="excute('${list.code}')">훈련실행</a>
						       		 							<a href="#" id="stop_btn_<c:out value="${list.code }"/>" class="btn btn-primary" onClick="excute_stop('${list.code}')" style="display: none;">일시정지</a>
						       		 						</c:when>
						       		 						<c:otherwise>
						       		 							<a href='#' title="<c:out value="${list.start_date }"/>~<c:out value="${list.end_date }"/>"  onClick="view('${list.code}','${list.type }','date')"/>훈련 기간  아님</a> 
						       		 						</c:otherwise>
						       		 					</c:choose>
				       		 						<%}%>	
				       		 						
				       		 						</c:when>
				       		 					</c:choose>
				       		 					
				       		 					<c:choose>		
					       		 					<c:when test="${list.status=='reservation' }">
					       		 							<a href='#' id="reserv_str_<c:out value="${list.code }"/>" onClick="view('${list.code}','${list.type }','reservation')" />훈련진행시간 :<br><c:out value="${list.reservation_date }"/></a> 
							       		 			</c:when>
							       		 			<c:otherwise>
						       		 					<a href='#'  id="reserv_str_<c:out value="${list.code }"/>" onClick="view('${list.code}','${list.type }','reservation')" style="display: none;"/>훈련진행시간 :<br><c:out value="${list.reservation_date }"/></a> 
						       		 				</c:otherwise>
				       		 					</c:choose>
				       		 							
				       		 					<c:choose>				       		 					
				       		 						<c:when test="${list.status=='receive' }">
				       		 							<a href="#" id="stop_btn_<c:out value="${list.code }"/>" class="btn btn-primary" onClick="excute_stop('${list.code}')" >일시정지</a>
						       		 					<a href="#" id="reexcute_btn_<c:out value="${list.code }"/>" class="btn btn-primary" onClick="re_excute('${list.code}')" style="display: none;">재실행</a>
						       		 				</c:when>
						       		 				<c:when test="${list.status=='stop' }">
				       		 							<a href="#" id="stop_btn_<c:out value="${list.code }"/>" class="btn btn-primary" onClick="excute_stop('${list.code}')" style="display: none;">일시정지</a>
						       		 					<a href="#" id="reexcute_btn_<c:out value="${list.code }"/>" class="btn btn-primary" onClick="re_excute('${list.code}')" >재실행</a>
						       		 				</c:when>
						       		 				<c:otherwise>
						       		 					<a href="#" id="stop_btn_<c:out value="${list.code }"/>" class="btn btn-primary" onClick="excute_stop('${list.code}')" style="display: none;">일시정지</a>
						       		 					<a href="#" id="reexcute_btn_<c:out value="${list.code }"/>" class="btn btn-primary" onClick="re_excute('${list.code}')" style="display: none;">재실행</a>
						       		 				</c:otherwise>
						       		 			</c:choose>
						       		 		</td>
				       		 			</tr>
				       		 			<tr >
			       		 					
				       		 				
				       		 				<td colspan="11" align="center" style="padding: 0;border-top: 0;">
				       		 					
				       		 					<c:choose>
								        		<c:when test="${list.status=='sending' || list.status=='send' || list.status=='receive' || list.status=='stopping'|| list.status=='stop' || list.status=='resend'|| list.status=='reservation'}">
								        			<div class="bar_area"  id="<c:out value="${list.code }" />_tr_progress" >
								        		</c:when>
								        		<c:otherwise>
								        			<div class="bar_area" style="display:none"  id="<c:out value="${list.code }" />_tr_progress" > 
								        		</c:otherwise>
								        	</c:choose>
				       		 					
													
															<div class="bar_graph span12" style="white-space:nowrap" >	
													        	<div class="graph_sum">		
														        	<div >			
														        		<div id="<c:out value="${list.code }" />_progress"  class="type_red" style="width:00.00%"></div>
														        	</div>
														        	<p id="<c:out value="${list.code }" />_progress_txt">0%</p>		
													        	</div>	
												        	</div>
												        
										        	
										        	
									        	</div>
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
    <form name='frm' method="post">
    	<input type='hidden' name='code' value=''>
    </form>
    <c:import url="/common/pageLink.do?link=inc/bottom_layout" />
        
    <div class="modal hide fade" id="myModal">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>훈련 진행</h3>
			</div>
			<div class="modal-body">
				<p><div id="progressbar"><div class="progress-label">Loading...</div></div></p>
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">Close</a>
			</div>
		</div>
 
    <script>
        var search_code_list = '<c:out value="${total_code }"/>';
    	var list = new Array();
    	
		<c:forEach var="list" items="${list}" varStatus="status">
			list[<c:out value="${list.code}"/>] = new Array();
			list[<c:out value="${list.code}"/>]['status'] = "<c:out value="${list.status}"/>"; 
			list[<c:out value="${list.code}"/>]['progress'] = "<c:out value="${list.progress}"/>";
		</c:forEach>
		
    	//stop / ing 
    	var modal_status = "stop";
    	var checkStatus;
    	
    	
    	$( document ).ready(function() {
    		checkStatus = setInterval(function() {ajax_statusCheck()}, 5000);
    	});
    	
    	/********
    	* 상태 체크
    	********/
    	function ajax_statusCheck()
    	{
    		var param = "training_code="+search_code_list;
    		$.ajax({
				type:'POST',
				url : "<c:url value='/execute/ajax_TrainingExcuteList.do'/>",
				data:param,
				dataType : "json",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
				beforeSend: function() {
		        	
		        },
				success : function(json){
					for(i=0;i<json.length;i++)
					{
						obj = json[i];
						progress_id = obj.code+"_progress";
						progress_txt_id = obj.code+"_progress_txt";
						progress_tr_id = obj.code+"_tr_progress";
						btn_status = obj.code+"_status";
						btn_stop= "stop_btn_"+obj.code;
						btn_reexec= "reexcute_btn_"+obj.code;
						reserv_str="reserv_str_"+obj.code;
						
						if(obj.status!='end' && obj.status!='ready' && obj.status!='stop' && obj.status!='stopping' && obj.status!='resend' && obj.status!='init' && obj.status!='approval' && obj.status!='reservation')
						{
							$("#"+progress_tr_id).css("display","");
							
							total 	= obj.progress.split("/")[0];
							cur	= obj.progress.split("/")[1]; 
							percent = (cur*100)/total;
							percent = percent.toFixed(3),
							
							$("#"+progress_txt_id).html(percent+"%");
							$("#"+progress_id).css("width",percent+"%");
							
							$("#"+btn_status).html("진행중");
							
							$("#"+btn_stop).show();
							$("#"+btn_reexec).hide();
							$("#"+reserv_str).hide();
							
						}else if(obj.status=='stopping'){
							$("#"+progress_tr_id).css("display","");
							
							total 	= obj.progress.split("/")[0];
							cur	= obj.progress.split("/")[1]; 
							percent = (cur*100)/total;
							percent = percent.toFixed(3),
							
							$("#"+progress_txt_id).html(percent+"%");
							$("#"+progress_id).css("width",percent+"%");
							
							$("#"+btn_status).html("발송정지중");
							
						}else if(obj.status=='stop'){
							$("#"+progress_tr_id).css("display","");
							
							total 	= obj.progress.split("/")[0];
							cur	= obj.progress.split("/")[1]; 
							percent = (cur*100)/total;
							percent = percent.toFixed(3),
							
							$("#"+progress_txt_id).html(percent+"%");
							$("#"+progress_id).css("width",percent+"%");
							
							$("#"+btn_status).html("발송중지");
							
							$("#"+btn_stop).hide();
							$("#"+btn_reexec).show();
							$("#"+reserv_str).hide();
							
						}else if(obj.status=='resend'){
							$("#"+progress_tr_id).css("display","");
							
							total 	= obj.progress.split("/")[0];
							cur	= obj.progress.split("/")[1]; 
							percent = (cur*100)/total;
							percent = percent.toFixed(3),
							
							$("#"+progress_txt_id).html(percent+"%");
							$("#"+progress_id).css("width",percent+"%");
							
							$("#"+btn_status).html("재준비");
							
						}else if(obj.status=='reservation'){
							$("#"+progress_tr_id).css("display","");
							
							total 	= obj.progress.split("/")[0];
							cur	= obj.progress.split("/")[1]; 
							percent = (cur*100)/total;
							percent = percent.toFixed(3),
							
							$("#"+progress_txt_id).html(percent+"%");
							$("#"+progress_id).css("width",percent+"%");
							
							$("#"+btn_status).html("진행대기중");
							
							$("#"+reserv_str).html("훈련진행시간 :<br>"+obj.reservation_date);
							$("#"+reserv_str).show();
						}
						else
						{
							if(obj.status=='end')
							{
								$("#"+btn_stop).hide();
								$("#"+btn_status).html("완료");
							}
							else if(obj.status=="ready")
							{
								$("#"+btn_status).html("준비");
							}
							else if(obj.status=="init")
							{
								$("#"+btn_status).html("초기화중");
							}else if(obj.status=="approval")
							{
								$("#"+btn_status).html("승인요청중");
							}								
							$("#"+progress_tr_id).css("display","none");
						}
					}
				},
				
				error:function(request,status,error){
					
				}
				
			}).complete(function() {
				
	        });
    	}
    	
    	/**
    	일시정지
    	**/
    	function excute_stop(code)
    	{
    		if(confirm("해당 훈련을 발송중지하시겠습니까??")){
    			var Flag;    			
    			param = "code="+code;
    			$.ajax({
    				type:'POST',
    				url : "<c:url value='/execute/ajax_stopTraining.do'/>",
    				data:param,
    				dataType : "json",
    				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
    				beforeSend: function() {
    		        },
    				success : function(json){
    					for(i=0; i<json.length; i++)
						{							
    						Flag = json[i].status;
						}
    					
    					if(Flag == "success"){
    						alert('정상적으로 발송중지 요청을 하였습니다.\n 잠시만 기다려주시기바랍니다. ');
    					}
    					else
    					{
    						alert(Flag);
    					}
    					
    				},
    				error:function(request,status,error){
    				}
    				
    			}).complete(function() {
    				if(Flag == "success"){    	
    					$("#stop_btn_"+code).hide();
    					$("#"+code+"_status").html("발송중지중");
    				}
    	        });
    		}
    	}
    	
    	/**
    	실제
    	**/
    	function excute(code)
    	{
    		if(confirm('해당 훈련을 진행하시겠습니까?'))
    		{
    			var Flag;	
    			$("#"+code+"_tr_progress").css("display","");
    			param = "code="+code;
    			$.ajax({
    				type:'POST',
    				url :"<c:url value='/execute/ajax_excuteTraining.do'/>",
    				data:param,
    				dataType : "json",
    				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
    				beforeSend: function() {
    		        },
    				success : function(json){
    					for(i=0; i<json.length; i++)
						{							
    						Flag = json[i].status;
						}
    					
    					if(Flag == "success"){
    						alert('정상적으로 훈련이 시작되었습니다.');
    					}
    					else
    					{
    						alert(Flag);
    					}
    					
    				},
    				error:function(request,status,error){
    				}
    				
    			}).complete(function() {
    				if(Flag == "success"){    					
    					$("#excute_btn_"+code).hide();
    				} else {    					
    					$("#"+code+"_tr_progress").hide();
    				}    				
    	        });
    		}
    	}
    	
    	
    	/**
    	재 실행
    	**/
    	function re_excute(code)
    	{
    		if(confirm('해당 훈련을 다시 진행하시겠습니까?'))
    		{
    			var Flag;	
    			$("#"+code+"_tr_progress").css("display","");
    			param = "code="+code;
    			$.ajax({
    				type:'POST',
    				url : "<c:url value='/execute/ajax_reexcuteTraining.do'/>",
    				data:param,
    				dataType : "json",
    				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
    				beforeSend: function() {
    		        },
    				success : function(json){
    					for(i=0; i<json.length; i++)
						{							
    						Flag = json[i].status;
						}
    					
    					if(Flag == "success"){
    						alert('정상적으로 훈련이 다시 시작되었습니다.');
    					}
    					else
    					{
    						alert(Flag);
    					}
    					
    				},
    				error:function(request,status,error){
    				}
    				
    			}).complete(function() {
    				if(Flag == "success"){    	
    					$("#reexcute_btn_"+code).hide();
    					$("#"+code+"_status").html("재준비");
    				}				
    	        });
    		
    		}
    	}
    	/**
    	모달창 출력 및 진행 상태 출력
    	**/
    	function modal_show(code)
    	{
    		$("#myModal").modal();
    		modal_status = "ing";
    		$("#progressbar").attr("aria-valuenow",40);
    	}
    	
    
    	
    	/**
	    검색
	    **/
    	function fn_search()
    	{
    		document.search.pageNo.value = 1;
    		document.search.action = "/execute/TrainingExcuteList.do";
    		document.search.submit();
    	}
    	
	    /**
	    페이지 이동
	    **/
    	function goPage(pageno)
    	{
    		document.search.pageNo.value = pageno;
    		document.search.action = "/execute/TrainingExcuteList.do";
    		document.search.submit();
    	}
    	
    	$(function(){
			$.contextMenu({
		        selector: '.contentMenu', 
		        trigger: 'left',
		        callback: function(key, options) {
		        	var type ='wm';
		        	ws_code = $(this).attr("ws_code");
		        	
		            if(key=="chart")
		            {
		            	var institution_code = $(this).attr("institution_code");
						var group_code = $(this).attr("group_code");
			    		var training_code = $(this).attr("training_code");
					   	chartLink(institution_code, group_code,training_code );
		            }
		            else if(key=="report")
		            {
		            	var institution_code = $(this).attr("institution_code");
						var group_code = $(this).attr("group_code");
			    		var training_code = $(this).attr("training_code");
					   	reportLink(institution_code, group_code,training_code );
		            }
		        },
		        items: {
		        	"chart": {name: "차트별 통계 페이지 이동"}
		    		,"report": {name: "리포트 페이지 이동"}
		        
			        	
				    
		        }
		    });
		});
    	
    	
    	/**
    	차트페이지로 이동
    	**/
    	function chartLink(searchInstitution ,group_code, training_code)
    	{
    		if(confirm("차트페이지로 이동하시겠습니까?")){
	    		var url = "/statistical/chart.do?searchInstitution="+searchInstitution+"&group_code="+group_code+"&training_code="+training_code;
	    		document.location.replace(url);
    		}
    	}
    	/**
    	리포트페이지로 이동
    	**/
    	function reportLink(searchInstitution ,group_code, training_code)
    	{
    		if(confirm("리포트페이지로 이동하시겠습니까?")){
	    		var url = "/statistical/report.do?searchCondition=type1&searchInstitution="+searchInstitution+"&group_code="+group_code+"&training_code="+training_code;
	    		document.location.replace(url);
    		}
    	}
	    
    	/**
    	상세보기
    **/
    function type2DetailSetting(code)
   	{
    		
    	var title = "";
		var messages ="";
		var training_type1 = "";
		var training_type2 = "";
		var training_type3 = "";
		param = "code="+code;
								
		$.ajax({
			type:'POST',
			url : "<c:url value='/training/type2_detail_list.do'/>",
			data:param,
			dataType : "json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
			beforeSend: function() 
			{
			        
			},
			success : function(json)
			{					
				
				title = "<h1>"+json[0]["tname"]+"</h1>";					
				messages+="";					
				messages += "<table width='100%' class='table table-bordered table-striped'>";
				messages += "<colgroup>";
				messages += "		<col width='*'>";
				messages += "		<col width='120px'>";
				messages += "		<col width='120px'>";
				messages += "		<col width='120px'>";
				messages += "		<col width='100px'>";
				messages += "		<col width='100px'>";
				messages += "</colgroup>";
				
				messages += "<tr>";
				messages += "		<th>템플릿</th>";
				messages += "		<th>메일열람</th>";
				messages += "		<th>링크(URL)실행</th>";
				messages += "		<th>첨부파일 실행</th>";
				messages += "		<th>발신인</th>";
				messages += "		<th>발신email</th>";
				messages += "<tr>";
					
				for(i=0;i<json.length;i++)
				{			
					if(json[i]["training_type1"]==undefined)
					{
						training_type1 = "";
					}
					else
					{
						training_type1 = json[i]["training_type1"];
					}
					
					if(json[i]["training_type2"]==undefined)
					{
						training_type2 = "";
					}
					else
					{
						training_type2 = json[i]["training_type2"];
					}
					
					if(json[i]["training_type3"]==undefined)
					{
						training_type3 = "";
					}
					else
					{
						training_type3 = json[i]["training_type3"];
					}
					
					
					messages += "<tr>";
					messages += "		<td>"+json[i]["template_name"]+"</td>";
					
					if(training_type1=="")
					{
						messages += "		<td style='background: gray;'>"+training_type1+"</td>";
					}
					else
					{
						messages += "		<td class='text-center'>"+training_type1+"</td>";	
					}
					
					if(training_type2=="")
					{
						messages += "		<td style='background: gray;'>"+training_type2+"</td>";
					}
					else
					{
						messages += "		<td class='text-center'>"+training_type2+"</td>";	
					}
					
					if(training_type3=="")
					{
						messages += "		<td style='background: gray;'>"+training_type3+"</td>";
					}
					else
					{
						messages += "		<td class='text-center'>"+training_type3+"</td>";	
					}
					
					messages += "		<td>"+json[i]["send_name"]+"</td>";						
					messages += "		<td>"+json[i]["send_email"]+"</td>";
					messages += "<tr>";
				}
				
				messages += "</table>";
							
				var dia  = BootstrapDialog.show({
					title:title ,
					   cssClass:'detail-dialog',
			           message: messages,
			           size: BootstrapDialog.SIZE_LARGE,
			           closable: true,
			           closeByBackdrop: false,
			           closeByKeyboard: false,
			           buttons: [
									{
					                	label: '닫기',
					                	action: function(dialogRef){
					                    	dialogRef.close();
					             		}
			           				}
								]
				
			       })
				
			},
			error:function(request,status,error)
			{
				alert("복사가 실패하였습니다:"+error);
			}
					
			}).complete(function() {
				
		    });
		
   	}
    
    /**
	수정 및 상세보기
	**/
	function view(code, type,msgtype)
	{
    	var messages ="";
    	
    	if(msgtype =="user"){
    		messages+="훈련 대상자를 입력하기 위해 수정 페이지로 이동하시겠습니까?";
    	}else if(msgtype =="date"){
    		messages+="훈련 기간을 수정하기 위해 수정 페이지로 이동하시겠습니까?";
    	}else if(msgtype =="approval"){
    		messages+="승인 요청하기 위해 수정 페이지로 이동하시겠습니까?";
    	}else if(msgtype =="reservation"){
    		messages+="발송예약시간을 수정하기 위해 수정 페이지로 이동하시겠습니까?";
    	}
    	
		if(confirm(messages))
		{
			if(type=='0')
			{
				document.frm.code.value = code ;
	    		document.frm.action = "/training/trainingForm.do";
	    			
			}
			else
			{
				document.frm.code.value = code ;
	    		document.frm.action = "/training/trainingForm2.do";
	    		
			}
			document.frm.submit();
		}
	}
    	
    </script>
<style>
		.detail-dialog 
		{
			width:1000px;
			position: fixed;
		    left: 40%;
		    
		}	
	</style>