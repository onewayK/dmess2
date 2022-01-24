<%@page import="kr.nshare.common.util.EgovProperties"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>

<c:import url="/common/pageLink.do?link=inc/top_layout" />

<!-- bootstrap dialog -->
<script src="<c:url value='/js/bootstrap/bootstrap-dialog.js'/>"></script>

<!-- bootstrap dialog -->
<link href="<c:url value='/css/bootstrap/bootstrap-dialog.css'/>" rel="stylesheet">

<div id="PageHeight" class="container-fluid">

	<div id="overlay1" >
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
		<li><i class="fa-icon-home"></i> Home / <strong>취향분석등록</strong>
		</li>
	</ul>

	<div class="panel panel-default">
		<form name="frm" id="frm" method="post"  enctype="multipart/form-data">
			<input type='hidden' name='type' value='1'>
			<input type='hidden' name='training_code' value='<c:out value="${training_detail.code}"/>' />
			<input type='hidden' name='training_status' value='<c:out value="${training_detail.status}"/>' />
		<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2>
							<%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
								<c:choose>
									<c:when test="${service_type eq 'test' }">
											<i class="fa-icon-user"></i><span class="break"></span>취향분석 훈련 생성(테스트)
									</c:when>
									<c:when test="${service_type eq 'real' }">
											<i class="fa-icon-user"></i><span class="break"></span>취향분석 훈련 생성(실전)
									</c:when>
									<c:otherwise>
										<i class="fa-icon-user"></i><span class="break"></span> 취향분석훈련생성
									</c:otherwise>
								</c:choose>
								<input type='hidden' name='service_setting_code' id='service_setting_code' value="<c:out value="${serviceSetting.code}"/>"/>
								<input type='hidden' name='service_type' id='service_type' value="<c:out value="${service_type}"/>"/>
							
							<%}else {%>
								<i class="fa-icon-user"></i><span class="break"></span> 취향분석 훈련생성
							<%}%>
						</h2>
					</div>
					<div class="box-content">
						
						<div class="form-horizontal span6"> 
						
							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />기관/그룹</label>
							  <div class="controls">
							  	<c:choose>
									<c:when test="${pageType eq 'insert' }">
									
										<select name='institution_code' required='required' class="fl" onchange="ig_load(this.value);">
											<option value="">선택하세요</option>
											<c:forEach var="institutionList" items="${institutionList}" varStatus="status">
												<option value="<c:out value="${institutionList.code}"/>"><c:out value="${institutionList.institution_name}"/></option>
						       		 		</c:forEach>	
						       		 	</select>
						       		 	
						       		 	<div id="ig_code_div">
							       		 	<select name='ig_code' id="required" required="required" class="fl">
							       		 		<option value=''>그룹선택</option>	
							       		 	</select>
						       		 	</div>
					       		 	
									</c:when>
									
									<c:when test="${pageType eq 'update'}">
											<input type="hidden" name='code' value='${training_detail.code }'>
											<input type="hidden"name='pageType' value='${pageType}'>
											
											<c:forEach var="institutionList" items="${institutionList}" varStatus="status" >
												<c:if test="${ institutionList.code == training_detail.institution_code}">
													<c:out value="${institutionList.institution_name}"/>
												</c:if>
											</c:forEach>
											 / <c:out value="${training_detail.group_name }"/>
									</c:when>
									
								</c:choose>
							  </div>
							</div>
							
							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />훈련명</label>
							  <div class="controls">
							  	<input style="width: 200px" type='text' name='tname' required='required' maxlength="40" class="fl" value="<c:if test="${pageType=='update'}"><c:out value="${training_detail.tname }"/></c:if>">
							  </div>
							</div>
							
							<div class="control-group">
								  <label class="control-label" for="typeahead"><span tooltipmessage="발송 간격  설정 사용시 설정된 시간/건수로 발송진행<br>예) 1 분당 10건 => 1초당 10건씩 메일 발송 진행" >발송간격</span></label>
								  <div >
									<ul class="setup_list">
										<c:if test="${pageType=='insert'}">
									  		<li style="margin-left: 20px;"><input style="width: 70px" type='number' min='0' name='spam_time'  maxlength="40" class="fl" value="" disabled='true'>&nbsp;분당</li>
											<li><input style="width: 70px" type='number' name='spam_number' min='0' maxlength="40" class="fl" value="" disabled='true'>&nbsp;건</li>
											<li><input type="checkbox" id="spam_type_chk" name="spam_type_chk" onClick="check_spam_use();">사용</li>
											<input type='hidden' name='spam_type' id='spam_type' value="N"/>
										</c:if>
									  	<c:if test="${pageType=='update'}">
										  	<li style="margin-left: 20px;"><input style="width: 70px" type='number' min='0' name='spam_time' maxlength="40" class="fl" value="<c:out value="${training_detail.spam_time}"/>" <c:if test="${training_detail.spam_type!='Y'}"> disabled='true'</c:if>>&nbsp;분당</li>
											<li><input style="width: 70px" type='number' name='spam_number' min='0' maxlength="40" class="fl" value="<c:out value="${training_detail.spam_number}"/>" <c:if test="${training_detail.spam_type!='Y'}"> disabled='true'</c:if>>&nbsp;건</li>
											<li> <input type="checkbox" name="spam_type_chk" id="spam_type_chk" onClick="check_spam_use();" <c:if test="${training_detail.spam_type=='Y'}"> checked </c:if>>사용</li>
											<input type='hidden' name='spam_type' id='spam_type' value="<c:if test="${pageType=='update'}"><c:out value="${training_detail.spam_type}"/></c:if>"/>
										</c:if>
									</ul>
								 </div>				
							</div>
							
							<div class="control-group">
							  <label class="control-label" for="typeahead">발송예약시간</label>
							  <div >
								<ul class="setup_list">
								
									<c:if test="${pageType=='insert'}">
								  		<li style="margin-left: 20px;"><input style="width: 200px"  type='text' class='input-xlarge' name='reservation_date' id='reservation_date' value="" readonly disabled='true'></li>
										<li><input type="checkbox" id="reservation_type_chk" name="reservation_type_chk" onClick="check_reservation_use();">사용</li>
										<input type='hidden' name='reservation_type' id='reservation_type' value="N"/>
									</c:if>
								  	<c:if test="${pageType=='update'}">
									  	<li style="margin-left: 20px;"><input style="width: 200px"  type='text' class='input-xlarge' name='reservation_date' id='reservation_date' readonly value="<c:out value="${training_detail.reservation_date}"/>" <c:if test="${training_detail.reservation_type!='Y'}"> disabled='true'</c:if>></li>
										<li> <input type="checkbox" name="reservation_type_chk" id="reservation_type_chk" onClick="check_reservation_use();" <c:if test="${training_detail.reservation_type=='Y'}"> checked </c:if>>사용</li>
										<input type='hidden' name='reservation_type' id='reservation_type' value="<c:if test="${pageType=='update'}"><c:out value="${training_detail.reservation_type}"/></c:if>"/>
									</c:if>
								</ul>
							 </div>				
							</div>
							
						</div>
						
						
						
						<div class="form-horizontal span6"> 
						
							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />훈련기간</label>
							  <div class="controls">
							  		<input style="width: 130px" readonly type='text' name='start_date' id='searchBgnDe' value="<c:if test="${pageType=='update'}"><c:out value="${training_detail.start_date }"/></c:if>">
									&nbsp;~&nbsp;<input style="width: 130px" readonly type='text' name='end_date' id='searchEndDe' value="<c:if test="${pageType=='update'}"><c:out value="${training_detail.end_date }"/></c:if>">
							  		<c:if test="${training_detail.status=='end'}"><a href='#' onClick='update_training_date();' class="btn">훈련종료일 수정</a></c:if>		
							 </div>
							</div>
							
							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />신고기능사용유무</label>
							  <div class="controls">
							  	<c:if test="${pageType=='insert'}">
							  		<input type="radio" name="register_type" id='register_type' value="y" checked>사용
							  		<input type="radio" name="register_type" id='register_type' value="n">사용안함
							  	</c:if>
							  	<c:if test="${pageType=='update'}">
								  	<input type="radio" name="register_type" id='register_type' onClick="register_use('y');" value="y" <c:if test="${training_detail.register_type=='y'}"> checked </c:if>>사용
								  	<input type="radio" name="register_type" id='register_type' onClick="register_use('n');" value="n" <c:if test="${training_detail.register_type=='n'}"> checked </c:if>>사용안함
							 	</c:if>
							 	<c:if test="${pageType=='update'}">
								 	<label id="register_type_url_view">
								 		<c:choose>
								 			<c:when test="${training_detail.register_type=='y' }">
								 				<c:out value='${training_detail.register_url }'/><c:out value='${training_detail.register_url_param }'/>	
								 			</c:when>
								 			<c:otherwise>-</c:otherwise>
								 		</c:choose>
								 		
								 	</label>
							 	</c:if>
							  </div>
							</div>
							
							<div class="control-group">
							  <label class="control-label" for="typeahead">신고시간준수</label>
							  <div >
								<ul class="setup_list">
									<c:if test="${pageType=='insert'}">
								  		<li style="margin-left: 20px;"><input style="width: 130px; text-align:right;" type='number' min='0' name='register_time'  maxlength="40" class="fl" value="" disabled='true'>&nbsp;분&nbsp;이내</li>
										<li><input type="checkbox" id="registerTime_type_chk" name="registerTime_type_chk" onClick="check_registerTime_use();">사용</li>
										<input type='hidden' name='register_time_type' id='register_time_type' value="N"/>
									</c:if>
								  	<c:if test="${pageType=='update'}">
									  	<li style="margin-left: 20px;"><input style="width: 130px; text-align:right;" type='number' min='0' name='register_time' maxlength="40" class="fl" value="<c:out value="${training_detail.register_time}"/>" <c:if test="${training_detail.register_time_type!='Y'}"> disabled='true'</c:if>>&nbsp;분&nbsp;이내</li>
										<li> <input type="checkbox" name="registerTime_type_chk" id="registerTime_type_chk" onClick="check_registerTime_use();" <c:if test="${training_detail.register_time_type=='Y'}"> checked </c:if>>사용</li>
										<input type='hidden' name='register_time_type' id='register_time_type' value="<c:if test="${pageType=='update'}"><c:out value="${training_detail.register_time_type}"/></c:if>"/>
									</c:if>
								</ul>
							 </div>				
							</div>
							
							<div class="control-group">
							  <%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />삭제타입</label>
							  <div class="controls">
							  
							  	<c:if test="${pageType=='insert'}">
							  		<input type="radio" name="del_type" id='del_type' value="m" checked>수동
							  		<input type="radio" name="del_type" id='del_type' value="a" >자동
							  	</c:if>
							  	
							  	<c:if test="${pageType=='update'}">
							  	  	<input type="radio" name="del_type" id='del_type' value="m" <c:if test="${training_detail.del_type=='m'}"> checked="checked" </c:if>>수동
							  		<input type="radio" name="del_type" id='del_type' value="a" <c:if test="${training_detail.del_type=='a'}">checked="checked" </c:if>>자동
							 	</c:if>
							  	<p id="del_type_comment">
							  		<c:choose>
								 			<c:when test="${serviceSetting.passive_del_type=='Y' }">
								 				<c:choose>
										 			<c:when test="${service_type=='test' }">
										 				수동삭제시  <c:out value='${serviceSetting.passive_test_del_date }'/>일이후 자동삭제됨.
										 			</c:when>
										 			<c:when test="${service_type=='real' }">
										 				수동삭제시  <c:out value='${serviceSetting.passive_real_del_date }'/>일이후 자동삭제됨.
										 			</c:when>
										 			<c:otherwise>
										 				수동삭제시 <%=EgovProperties.getProperty("Globals.training.del.manual") %>일이후 자동삭제됨.
										 			</c:otherwise>
										 		</c:choose>								 				
								 			</c:when>
								 			<c:otherwise>
								 				수동삭제시 <%=EgovProperties.getProperty("Globals.training.del.manual") %>일이후 자동삭제됨.
								 			</c:otherwise>
								 		</c:choose>
							  	</p>
							 	
							  </div>
							  <%}else{ %>
							  	<input type='hidden' name='del_type' id='del_type' value='m'/>
							  <%} %>							  
							</div>
							
						</div>
			
						<div class="clearFix"></div>
						
						</div>
						
						<div class="box-content">
							
							<div class="form-horizontal span8"> 
								<div class="control-group" >
								  <div class="controls">
								  <c:choose>
										<c:when test="${pageType eq 'update' and (training_detail.status=='step1'  || training_detail.status=='ready' )}">
										
									  		<button type="button" class="btn btn-info" onClick='pop_training_user();'>수신자 추가(Excel)</button>
									  		<button type="button" class="btn btn-info" onClick='pop_training_single_adduser();'>수신자 추가(개별)</button>
									  		<button type="button" class="btn btn-info" onClick='pop_training_single_addcate();'>분류 카테고리 추가</button>
								  		
								  		</c:when>
								  </c:choose>
								  </div>
								  
								</div>
								
								
							</div>
							<div class="form-horizontal span4"> 
							<div class="control-group">
								  <label class="control-label" for="typeahead">발송설정</label>
								  <div >
									<ul class="setup_list">
										<c:if test="${pageType=='insert'}">
									  		<li style="margin-left: 20px;"><input style="width: 70px" type='number' name='send_percent' onkeyup="return send_num_Check(1)" min="0" max="100" id='send_percent' maxlength="40" class="fl" value='' disabled='true'>&nbsp;%</li>
											<li><input style="width: 70px" type='number' name='send_number' id='send_number' onkeyup="return send_num_Check(2)" min="0" maxlength="40" class="fl" value='' disabled='true'>&nbsp;명</li>
											<li><input name="all_send_type_chk" type="checkbox" id="all_send_type_chk" onClick="check_all_send_use();" checked>전체발송</li>
											<input type='hidden' name='all_send_type' id='all_send_type' value="Y"/>
										</c:if>
									  	<c:if test="${pageType=='update'}">
										  	<li style="margin-left: 20px;"><input style="width: 70px" type='number' onkeyup="return send_num_Check(1)" name='send_percent' id='send_percent' min="0" max="100" maxlength="40" class="fl" value="<c:out value="${training_detail.send_percent}"/>" <c:if test="${training_detail.all_send_type=='Y'}"> disabled='true'</c:if>>&nbsp;%</li>
											<li><input style="width: 70px" type='number' name='send_number' id='send_number' onkeyup="return send_num_Check(2)" maxlength="40" class="fl" min="0" value="<c:out value="${training_detail.send_number}"/>" <c:if test="${training_detail.all_send_type=='Y'}"> disabled='true'</c:if>>&nbsp;명</li>
											<li> <input name="all_send_type_chk" type="checkbox" id="all_send_type_chk" onClick="check_all_send_use();" <c:if test="${training_detail.all_send_type=='Y'}"> checked </c:if>>전체발송</li>
											<input type='hidden' name='all_send_type' id='all_send_type' value="<c:if test="${pageType=='update'}"><c:out value="${training_detail.all_send_type}"/></c:if>"/>
										</c:if>
									</ul>
								 </div>				
								</div>
								
						</div>
												
							<div id='total_usercnt' class="total_usercnt">
							</div>
							
						<div class="clearFix"></div>
						<div id='list'></div>
						</div>
						
						
						<div class="box-content">
								<div class="pull-right">
									<c:choose>
										<c:when test="${pageType eq 'update' and (training_detail.status=='step1'  || training_detail.status=='ready' )}">
											<a href='#' onClick='send()' class="btn">STEP2저장</a>
											<a href='#' onClick="deleteTraining();" class="btn">삭제</a>
												<c:choose>
													<c:when test="${training_detail.lev == 'admin' || training_detail.approval_type == 'y'}">												
													</c:when>
													<c:otherwise>
														<a href='#' onClick="approval_req();" class="btn">승인요청</a>
													</c:otherwise>
												</c:choose>	
										</c:when>
										<c:when test="${pageType eq 'update' and training_detail.status=='approval' and training_detail.approval_type=='n'}">
											<c:choose>
													<c:when test="${training_detail.lev == 'admin' }">
														<a href='#' onClick="approval();" class="btn">승인</a>
														<a href='#' onClick="approval_cancel();" class="btn">승인요청취소</a>
													</c:when>
													<c:otherwise>
														<a href='#' onClick="approval_cancel();" class="btn">승인요청취소</a>	
													</c:otherwise>
											</c:choose>	
										</c:when>										
									</c:choose>
									
									<c:choose>
										<c:when test="${pageType eq 'update' and training_detail.status=='end' and training_detail.lev == 'admin' }">
											<a href='#' onClick="deleteTraining();" class="btn">삭제</a>
										</c:when>
									</c:choose>
									
									<c:choose>
										<c:when test="${pageType eq 'update' }">
											<a href='#' onClick="executePageLink()" class="btn">훈련실행 페이지</a>	
										</c:when>
									</c:choose>
									
									<c:choose>
										<c:when test="${pageType eq 'update' and training_detail.status=='reservation'}">
											<a href='#' onClick="reservation_cancel()" class="btn">발송예약취소</a>	
										</c:when>
									</c:choose>
									
									<c:choose>
										<c:when test="${pageType eq 'update' and training_detail.status=='stop'}">
											<a href='#' onClick="executeInit()" class="btn">발송 초기화</a>	
										</c:when>
									</c:choose>
									
									<a href='/training/TrainingList.do' class="btn">리스트</a>
								</div>
								<div class="clearFix"></div>
							</div>
		</div>
		</form>
		</div>
	</div>
</div>
<form name="link_temp" method="post">
		<input type="hidden" name="searchCondition" value="tname" /> 
		<input type="hidden" name="searchKeyword" value="" />
</form>
<script type="text/javascript" src="/js/HuskyEZCreator.js" charset="utf-8"></script>
<script>
	
function executePageLink()
{
	//"/execute/TrainingExcuteList.do?searchCondition=tname&searchKeyword=testkim12";
	
	
	var messages ="";
	messages+="훈련 실행 페이지로 이동하시겠습니까?";
	
	
	if(confirm(messages))
	{
		
		
		document.link_temp.searchKeyword.value= $("input[name='tname']").val();
		document.link_temp.action = "/execute/TrainingExcuteList.do";
    		
		
		document.link_temp.submit();
	}
	
	
}


	var status = "<c:out value="${training_detail.status}"/>";
	var pageType = "<c:out value="${pageType}"/>";
	
	window.onload = function()
	{		
		ajax_proc(' ',' ');
	}
	
	/**
	ajax처리(카테고리)
	**/
	function ajax_cate(type, obj)
	{
		
		url = "<c:url value='/training/ajax_training2Cate.do'/>";
		var param = "";
		param = "training_code="+$("input[name='training_code']").val();
		param = param + "&type="+type+obj;
		
		$.ajax({
			type:'POST',
			url : url,
			data:param,
			dataType : "json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
			beforeSend: function() {
	        	//실행전처리
	        },
			success : function(json){
				ajax_proc(' ',' ');
			},
			
			error:function(request,status,error){
			
			}
			
		}).complete(function() {
	
        });
		
	}
	
	/**
	ajax처리(훈련 대상자)
	**/
	function ajax_proc(type, obj)
	{	
		$('#overlay1').show();   
		//slick grid 항목 초기화
		slick_grid_list=[];
		listcnt=0;
		url = "<c:url value='/training/ajax_training2Porc.do'/>";
		var param = "";
		
		param = "training_code="+$("input[name='training_code']").val();
		param = param + "&type="+type+obj;
		
		
		
		$.ajax({
			type:'POST',
			url : url,
			data:param,
			dataType : "json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
			beforeSend: function() {
	        	//실행전처리
	        },
			success : function(json){
								
				var user_list = new Array();
				var group_list =new Array();
				var dup_group_list =new Set();
				var group_list_num=0;
			
				//정상값받았을때	
				for(i=0;i<json.length;i++)
				{				
					if(!dup_group_list.has(json[i].tg_code))
					{
						dup_group_list.add(json[i].tg_code);
						group_list[group_list_num] = new Array();
						group_list[group_list_num]['code'] = json[i].tg_code;
						
						group_list[group_list_num]['cate_code']=json[i].cate_code;
						group_list[group_list_num]['cate_name'] = json[i].cate_name;
						group_list[group_list_num]['tc_code']=json[i].tc_code;
						group_list[group_list_num]['template_name'] = json[i].template_name;
						
						group_list[group_list_num]['gp_title'] = json[i].gp_title;
						group_list[group_list_num]['gp_send_name'] = json[i].gp_send_name;
						group_list[group_list_num]['gp_send_email'] = json[i].gp_send_email;
						
						group_list[group_list_num]['training_type1'] = json[i].training_type1;
						group_list[group_list_num]['training_type2'] = json[i].training_type2;
						group_list[group_list_num]['training_type3'] = json[i].training_type3;

						group_list_num++;
					}
					
						user_list[i]= new Array();	
						
						user_list[i]['code']=json[i].code;
						user_list[i]['tg_code']=json[i].tg_code;
						user_list[i]['cate_code']=json[i].cate_code;
						
						user_list[i]['email']=json[i].email;
						user_list[i]['department_name']=json[i].department_name;
						user_list[i]['name']=json[i].name;
						user_list[i]['unikey']=json[i].unikey;
						
						if(!(status ==  "ready" || status== "step1")){
							user_list[i]['status']=json[i].status;
						}
				}
			
				make_group_table(group_list, user_list);
			},
			
			error:function(request,status,error){
				//에러처리
			}
			
		}).complete(function() {
			//이모든것이 끝났을때
			percent_calcul();
			$('#overlay1').hide();   
        });
		
	}
	
	
	
	
	/**
	* 인력셋팅
	**/
	function make_user_list(code, list)
	{
		var rdata_val=[];
		var idx= 0;
		
		for(var i =0;i<list.length;i++)
		{
			if(list[i].tg_code == code && null!=list[i].code)
			{
				rdata_val[idx]=addUserList(list[i]);
				idx++;
			}
		}
				
		return rdata_val;
	}
	
	/*
		user
	*/
	function addUserList(obj)
	{
		var result=null;
		
		var code_val					=obj['code'];
		var tg_code_val				=obj['tg_code'];
		var cate_code_val			=obj['cate_code'];
		
		var email_val					=obj['email'];
		var name_val					=obj['name'];
		var department_name_val	=obj['department_name'];
		var unikey_val					=obj['unikey'];
		
		if(status ==  "ready" || status== "step1"){
			result={code: code_val, tg_code: tg_code_val,cate_code : cate_code_val,email:email_val , name: name_val , department_name: department_name_val, unikey: unikey_val};
		}else {
			var send_status=obj['status'];
			var status_val="";
			
			if(send_status == "ready"){
				status_val="발송대기";
			}else if(send_status == "nosend"){
				status_val="발송안함";
			}else if(send_status == "end"){
				status_val="발송완료";		
			}else{
				status_val="-";			
			}	
			
			result={code: code_val, tg_code: tg_code_val,cate_code : cate_code_val,email:email_val , name: name_val , department_name: department_name_val, unikey: unikey_val, status: status_val};
		}
		
		listcnt++;
		usercnt++;
		total_usercnt++;		
		
		return result;
		
	}
	
	function pop_training_single_moduser(row)
	{
		var code 					= row.code;
		var tg_code 				= row.tg_code;
		var cate_code 			= row.cate_code;
		
		var email 					= row.email;
		var name 					= row.name;
		var department 			= row.department_name;
		var unikey 					= row.unikey;
		
		var select_html 			= select_template_main_list("modfiy",cate_code);	
		var sub_select_html 	=select_template_sub_list(cate_code,"modfiy_first",tg_code);
			
		var title = "훈련대상자 수정";
		
		
		var message ="";
		message = message + "<div>";		
		message = message + "		<span style='width:80px;float:left'>email</span>		<span width='*'><input type='text' class='input-xlarge' name='val1' value=\""+email+"\"></span><br>";
		message = message + "		<span style='width:80px;float:left'>이름</span>			<span width='*'><input type='text' class='input-xlarge' name='val2' value=\""+name+"\"></span><br>";
		message = message + "		<span style='width:80px;float:left'>부서</span>			<span width='*'><input type='text' class='input-xlarge' name='val3' value=\""+department+"\"></span><br>";
		message = message + "		<span style='width:80px;float:left'>사번/아이디</span>	<span width='*'><input type='text' class='input-xlarge' name='val4' value=\""+unikey+"\"></span><br>";
		message = message + "		<span style='width:80px;float:left'>카테고리</span><span width='*'><select name='cate_main_list' id='cate_main_list' onchange='select_template_sub(this.value,\"modfiy\",\""+tg_code+"\");'>"+select_html+"</select>";
		message = message + "		<select name='cate_sub_list' id='cate_sub_list' >"+sub_select_html+"</select>";
		message = message + "		<input type='checkbox' name='new_cate_list' id='new_cate_list' onClick='checkbox_new_template(this)'>신규</span><br>";
		message = message + "<input type='hidden' name='val6' value='"+code+"'>";
		message = message + "</div>";
		
		var dia  = BootstrapDialog.show({
			title:title ,
	           message: message,
	           closable: true,
	           closeByBackdrop: false,
	           closeByKeyboard: false,
	           buttons: [
							{
							    label: '수정',
							    action: function(dialogRef){
							    	var val1 = $("input[name='val1']").val();
							    	var val2 = $("input[name='val2']").val();
							    	var val3 = $("input[name='val3']").val();
							    	var val4 = $("input[name='val4']").val();							    
							    	var val5 = $("select[name='cate_sub_list']").val();
							    	var val6 = $("input[name='val6']").val();	
							    	
							    	if(val1=="")
							        {
							    		alert("email 은 필수입력입니다.");
							        	$("input[name='val1']").focus();
							        	return ;
							        }
							    	
							    	var regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";
							    	if (!val1.match(regex))
							    	{
							    		alert("이메일을 입력해주시기 바랍니다.");
							    		return ;
							    	}
							    	
							    	
							    	if(val2=="")
								        {
							        	alert("이름 은 필수입력입니다.");
							        	return ;
							        }
							    	
							    	if(val3=="")
							        {
							        	alert("부서 은 필수입력입니다.");
							        	return ;
							        }
							    	
							    	if(val4=="")
								    {
							        	alert("사번/아이디 는 필수입력입니다.");
							        	return ;
							        } 	
							    	if(val5=="")
								    {
							        	alert("카테고리는 필수입력입니다.");
							        	return ;
							        } 	
									
									var Userinfo="";
									
							    	Userinfo= Userinfo +"&email="+encodeURIComponent(val1);
							    	Userinfo= Userinfo +"&name="+encodeURIComponent(val2);
							    	Userinfo= Userinfo +"&department_name="+encodeURIComponent(val3);
							    	Userinfo= Userinfo +"&unikey="+encodeURIComponent(val4);
							    	
							    	if($('#new_cate_list').is(":checked") == true){
							    		Userinfo= Userinfo +"&tc_code="+encodeURIComponent(val5);
							    	}else{
							    		Userinfo= Userinfo +"&tg_code="+encodeURIComponent(val5);
							    	}
							    	
							    	Userinfo= Userinfo +"&code="+encodeURIComponent(val6);			
							    	
							    	ajax_proc("mod_user", Userinfo);
							    	
									dialogRef.close();							       
									
									if($('#new_cate_list').is(":checked") == true){
										//신규 템플릿 생성을 통해서 이동시 해당 템플릿에 등록된 훈련대상자가 없으면 해당 템플릿 삭제 확인
										var grp_cnt	=$("input[name='grplistvo["+tg_code+"].usercnt']").val();
										
										grp_cnt--;
										
										if(grp_cnt <= 0){
											if(confirm('이전 카테고리에 등록된 인원이 없으므로 삭제하려고 합니다.\n삭제하시겠습니까?'))
											{		
												var tempinfo="&code="+tg_code+"&tg_code="+tg_code;								   
										    	
												ajax_cate("del_cate", tempinfo);
											}
										}
									}
						    	}
							},
	                    	{
			                	label: '닫기',
			                	action: function(dialogRef){
			                    	dialogRef.close();
			             		}
	           				}
						]
		
	       });		
		
	}
	
	/**
	훈련 대상자 삭제
	**/
	function pop_training_single_deluser(row)
	{
		if(confirm('해당 훈련 대상을 삭제하시겠습니까?'))
		{
			
			var code 		= row.code;
			var tg_code	=row.tg_code;
			var grp_cnt	=$("input[name='grplistvo["+tg_code+"].usercnt']").val();
			
			var Userinfo="&code="+code;
			
			grp_cnt--;
			
			if(grp_cnt <= 0){
				pop_training_single_delcate(tg_code);
			}
			
			ajax_proc("del_user", Userinfo);
		}
	}
	
	
	function make_group_table(group_list, user_list)
	{
		total_usercnt=0;
		
		var grid_userlist= new Map();

		
		var group_table_head = "";
		var group_table_foot = "";
		var group_table_list = "";
		
		group_table_head += "<div >등록 훈련대상자 : <span id='total_user'>"+total_usercnt+"</span>&nbsp;명</div>";
		group_table_head += "<table width='100%' class='table table-bordered table-striped'>";
		group_table_head += "	<colgroup>";
		group_table_head += "		<col width='15%'/>";
		group_table_head += "		<col width='*'/>";
		group_table_head += "	</colgroup>";
		group_table_head += "<tr><th>분류그룹</th><th>훈련대상자</th></tr>";
		group_table_foot = "</table>";
		
		
		for(var i=0;i<group_list.length;i++)
		{
			var group_code 			= group_list[i]['code'];
		 
			var cate_code 			= group_list[i]['cate_code'];
			var cate_name 			= group_list[i]['cate_name'];
			var tc_code				= group_list[i]['tc_code'];
			var template_name 		= group_list[i]['template_name'];	
			
			var gp_title					= group_list[i]['gp_title'];
			var gp_send_name		= group_list[i]['gp_send_name'];
			var gp_send_email		= group_list[i]['gp_send_email'] ;
						
			var training_type1 		= group_list[i]['training_type1']; 
			var training_type2 		= group_list[i]['training_type2'];
			var training_type3 	= group_list[i]['training_type3'];
				
			var grid_id= "userlist_"+group_code;
			var one_user_list = make_user_list(group_code, user_list);
			
			gp_title = tag_valid(gp_title);		
			gp_send_name = tag_valid(gp_send_name);
			gp_send_email= tag_valid(gp_send_email);
			template_name=tag_valid(template_name);
			
			var gp_tooltipmessage = "<span>발신 제목 : "+gp_title+"</span><br><span>발신자 : "+ gp_send_name+"</span><br><span>발신 email : "+gp_send_email+"</span>";
			gp_tooltipmessage 		+="<br> <span>메일열람 : "+training_type1+ "</span><br><span> 링크(URL)실행 : "+training_type2+ "</span><br> <span>첨부파일 실행: "+training_type3+"</span>";
			gp_tooltipmessage 		+="<br> <span>등록 인원: "+usercnt+"명</span>";
			
			group_table_list +="<tr><td style='vertical-align: middle;' class='center'>";
			group_table_list +="<span style='cursor:hand' tooltipmessage=\""+gp_tooltipmessage+"\">"+cate_name+"</span></h5><br>"+template_name+"<br>";
			group_table_list +="<input type='hidden' name='grplistvo["+group_code+"].usercnt' value='"+usercnt+"'>";
			group_table_list +="<input type='hidden' name='grplistvo["+group_code+"].gp_title' value=\""+gp_title+"\">";
			group_table_list +="<input type='hidden' name='grplistvo["+group_code+"].gp_send_name' value=\""+gp_send_name+"\">";
			group_table_list +="<input type='hidden' name='grplistvo["+group_code+"].gp_send_email' value=\""+gp_send_email+"\">";
			
			group_table_list +="<input type='hidden' name='grplistvo["+group_code+"].cate_code' value='"+cate_code+"'>";
			group_table_list +="<input type='hidden' name='grplistvo["+group_code+"].tc_code' value='"+tc_code+"'>";
		
			if(status ==  "ready" || status== "step1"){
				group_table_list +="<button type='button' class='btn btn-info ' onClick=\"update_template_popup('"+group_code+"'); return false;\">수정</button>&nbsp;";
				group_table_list +="<button type='button' class='btn btn-info' onClick=\"pop_training_single_delcate('"+group_code+"');\">삭제</button><br>";				
			}
			
			group_table_list +="<td><div class='userlist' id='userlist_"+group_code+"'style='width:1350px; height:300px;'></div></td></tr>";
							
			grid_userlist.set(grid_id, one_user_list);					
												
			usercnt=0;
			
		}	
		
		$("#list").html(group_table_head+group_table_list+group_table_foot);
		
		grid_userlist.forEach(function (v,k) {		
			addUserfush(k,v);
		});
		
		$("#total_user").html(total_usercnt);
	}
	
		$("#frm").validate({
			rule: {
				institution_code:{
					required:true
				}
				, ig_code:{
					required:true
				}
				, tname:{
					required:true
				}, title:{
					required:true
				}, send_name:{
					required:true
				}, send_email:{
					required:true
					, email: true
				}, end_date:{
					required:true
				}, send_content:{
					required:true
				}
			},
			messages: {
				institution_code:
				{
					required:"훈련생성기관을 선택하세요"
				}, 
				ig_code:
				{
					required:"그룹을 선택하세요."
				}, 
				tname:{
					required:"훈련명을 입력하세요"
					,maxlength: $.validator.format('{0}자 이내로 입력해주세요!')
				}, 
				title:{
					required:"이메일 제목을 입력하세요"
					,maxlength: $.validator.format('{0}자 이내로 입력해주세요!')
				}, 
				send_name:{
					required:"발신자 이름을 입력하세요"
					,maxlength: $.validator.format('{0}자 이내로 입력해주세요!')
				},
				send_email: {
					required:"발신이메일을 입력하세요"
					, email : "이메일 양식에 맞게 입력하주시기바랍니다."
					
				}, 
				end_date:{
					required:"훈련기간을 선택하세요"
				}, 
				send_content:{
					required:"내용을 입력하세요"
				}
			}
		});
	
	var userList = "";
	var listcnt = 0;
	var usercnt=0;		
	var total_usercnt=0;		
	var maxcnt= <%=EgovProperties.getProperty("Globals.training.max.user.count") %>
	
	function makeRand()
	{
		return "";
	}
	
	//발신자 추가
	function pop_training_user()
	{
		
		param = "?training_code="+$("input[name='training_code']").val();
		url = '<c:url value="/training/training_add_user_pop2.do"/>';
		
		url = url + param;
   		fn_openwindow(url,  '800px', '500px', 'pop_institution_list');
    	
	}
		

	function view(code) 
	{
		location.href = "/system/memberForm.do?code=" + code;
	}
	$(function() {
		
		createUserFields();
		
		<%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
		//삭제 타입 선택시 내용 고지 및 값 변경
		$('input[type=radio][name=del_type]').change(function() {
	        if (this.value == 'm') {
	            $("#del_type_comment").show();
	        }
	        else if (this.value == 'a') {
	        	
	        	<c:choose>
		 			<c:when test="${serviceSetting.auto_del_type=='Y' }">
			 			<c:choose>
				 			<c:when test="${service_type=='test' }">
				 				var msg="자동삭제시 "  +<c:out value='${serviceSetting.auto_test_del_date }'/>+"일 이후에 자동으로 훈련대상자 정보가 자동삭제됩니다.";
				 			</c:when>
				 			<c:when test="${service_type=='real' }">
				 				var msg="자동삭제시 "  +<c:out value='${serviceSetting.auto_real_del_date }'/>+"일 이후에 자동으로 훈련대상자 정보가 자동삭제됩니다.";
				 			</c:when>
				 			<c:otherwise>
				 				var msg ="자동선택시 "+ <%=EgovProperties.getProperty("Globals.training.del.auto")%>+"일 이후에 자동으로 훈련대상자 정보가 자동삭제됩니다.";
				 			</c:otherwise>
			 			</c:choose>					 			
		 			</c:when>
		 			<c:otherwise>
		 				var msg ="자동선택시 "+ <%=EgovProperties.getProperty("Globals.training.del.auto")%>+"일 이후에 자동으로 훈련대상자 정보가 자동삭제됩니다.";
		 			</c:otherwise>
	 			</c:choose>	        	
	        	
	        	if(confirm(msg)==false)
	        	{
	        		$("input:radio[name='del_type'][value='m']").prop('checked', true);
	        		$("#del_type_comment").show();
	        	}
	        	else
	        	{
	        		$("#del_type_comment").hide();
	        	}
	        }
	    });
		<%}%>
		
		
		$("#searchBgnDe")		
		.datetimepicker(
				{
					format: 'Y-m-d H:i',
					step : 5
					 
				});

	$("#searchEndDe")
			.datetimepicker(
				{
					format: 'Y-m-d H:i',
					step : 5
				});

	$('#reservation_date').datetimepicker(
			{format: 'Y-m-d H:i',
				step : 5,
				minDate: 0
			});
	
	});
	
	function tabs(id)
	{
		
		for(i=1;i<4;i++)
		{
			temp_tab = "tabs"+i;
			tab_id = "tabs"+id;
			div_id = "tabs-"+i;
			if(temp_tab==tab_id)
			{
				$("#"+tab_id).addClass("active");
				$("#"+div_id).show();
			}
			else
			{
				$("#"+temp_tab).removeClass("active");
				$("#"+div_id).hide();
			}
		}
	}
	
	/**
	* 탭네뮤 생성 및 hide
	**/
	function collection_info(id)
	{
		//전체 선택 또는 해제
		if(id=="0")
		{
			//전체 선택을 체크한 경우
			if($("input:checkbox[name='traing_all']").is(":checked")==true)
			{
				$("input[name='training_type1']").prop("checked",true);
				$("input[name='training_type2']").prop("checked",true);
				$("input[name='training_type3']").prop("checked",true);
				
				$("#tabs3").show();
				$("#tabs2").show();
				$("#tabs1").show();
				
				
				tabs(3);
				tabs(2);
				tabs(1);
				
			}
			else
			{
				//$("input:checkbox[name='traing_type1']").attr("checked",false);
				$("input[name='training_type1']").prop("checked",false);
				$("input[name='training_type2']").prop("checked",false);
				$("input[name='training_type3']").prop("checked",false);
				
				$("#tabs2").hide();
				$("#tabs3").hide();
			}
		}
		else if(id=="1")
		{
			
			if($("input:checkbox[name='training_type1']").is(":checked")==true)
			{
				tabs(id);
				$("#tabs1").show();			
			}
		}
		else if(id=="2")
		{
			if($("input:checkbox[name='training_type2']").is(":checked")==true)
			{
					
				$("#tabs2").show();
			}
			else
			{
				$("#tabs2").hide();
			}
			
		}
		else if(id=="3")
		{
			if($("input:checkbox[name='training_type3']").is(":checked")==true)
			{
					
				$("#tabs3").show();
			}
			else
			{
				$("#tabs3").hide();
			}
		}
	}	
	
	function addLink()
	{
		
		var title = "본문추가 링크 이름";
		var messages ="<label class='control-label' for='date01'>"+title +"&nbsp;:&nbsp;"+"</>" + "<input type='text' class='input-xlarge' name='val'>"; 
		
		var dia  = BootstrapDialog.show({
			title:title ,
	           message: messages,
	           closable: true,
	           closeByBackdrop: false,
	           closeByKeyboard: false,
	           buttons: [
							{
							    label: '적용',
							    action: function(dialogRef){
							        if($("input[name='val']").val()=="")
							        {
							        	alert(title+"은 필수입력입니다.");
							        	return ;
							        }
							        else
							        {
							        	var inputbox = $("input[name='val']").val();
							        	
							        	var sHTML = "<a href='#link_url#'>"+inputbox+"</a>";
							    		oEditors.getById["send_content"].exec("PASTE_HTML", [sHTML]);
							        	dialogRef.close();
							        }
						    	}
							},
	                    	{
			                	label: '닫기',
			                	action: function(dialogRef){
			                    	dialogRef.close();
			             		}
	           				}
						]
		
	       });
		
	}
	
	//저장
	function send()
	{
		if($("#frm").valid())
		{
			var frm = document.getElementById("frm");
			frm.action = "<c:url value='/training/trainingSave.do'/>";
			
			//훈련명 체크
			if($("input[name='tname']").val().length > 30)
			{
				alert('훈련명 길이는 30자 이상을 초과할 수 없습니다.');
				return ;
			}else{
				var err_char=["[","]","/","*","?"];
				for(i=0;i<err_char.length;i++)
				{
					if($("input[name='tname']").val().indexOf(err_char[i]) != -1){
						alert('훈련명에 해당 문자열([,],/,*,?)을 사용할 수  없습니다.');
						return ;
					}
				}
			}
			
			//훈련기간 체크
			if($("#searchBgnDe").val()=="" || $("#searchEndDe").val()=="")
			{
				alert('훈련기간을 입력하여주세요!');
				return ;
			}
			else if(Number($("#searchBgnDe").val().replace(/\-/g,'').replace(' ','').replace(':',''))>Number($("#searchEndDe").val().replace(/\-/g,'').replace(/\:/g,'').replace(' ','').replace(':','')))
			{
				alert('훈련 시작일이 종료일 보다 작아야합니다.');
				return ;
			}
			
			if($("input:checkbox[name='spam_type_chk']").is(":checked")==true)
			{
				
				if($("input[name='spam_time']").val() == '' || $("input[name='spam_time']").val() <= 0)
				{
					alert('발송간격 설정에 대한 시간을 입력하주세요!');
					return ;
				}
				
				if($("input[name='spam_number']").val() == '' || $("input[name='spam_number']").val() <= 0)			
				{
					alert('발송간격 설정에 대한 발송 수를 입력하주세요!');
					return ;
				}
			}
			
			if($("input:checkbox[name='all_send_type_chk']").is(":checked")==false)
			{
				if($("input[name='send_percent']").val() == '' || $("input[name='send_percent']").val() <= 0)			
				{
					alert('랜덤 발송에 대한 퍼센트를 입력하주세요!');
					return ;
				}
				
				if($("input[name='send_number']").val() == '' || $("input[name='send_number']").val() <= 0)			
				{
					alert('랜덤 발송에 대한 인원 수을 입력하주세요!');
					return ;
				}
			}
			
			if($("input:checkbox[name='reservation_type_chk']").is(":checked")==true)
			{
				
				if($("input[name='reservation_date']").val() == '')
				{
					alert('메일발송을 진행할 예약 시간을 입력하주세요!');
					return ;
				}
				
				if(Number($("#searchBgnDe").val().replace(/\-/g,'').replace(' ','').replace(':',''))>Number($("#reservation_date").val().replace(/\-/g,'').replace(/\:/g,'').replace(' ','').replace(':','')))
				{
					alert('메일발송을 진행할 예약 시간은 훈련시작 시간과 같거나 이후로 설정되어야 합니다.');
					return ;
				}
			}
			
			if($("input:checkbox[name='registerTime_type_chk']").is(":checked")==true)
			{
				if($("input[type=radio][name=register_type]:checked").val() =='n'){
					alert('신고기능사용유무를 다시 설정해주세요!');
					return ;
				}
				
				if($("input[name='register_time']").val() == '' || $("input[name='register_time']").val() <= 0)
				{
					alert('신고시간준수 설정에 대한 시간을 입력하주세요!');
					return ;
				}
			}
			//url이동 설정(url이동시 표시될 내용)
			
			
			if(confirm("훈련을 저장 하시겠습니까?")){
				$('#overlay1').show(); 
				frm.submit();
			}
			
			
		}
		else
		{
			alert("입력값을 확인하세요");
		}
	}
	
	
	/**
	그룹 정보 설정
	**/
	/**
	실제
	<select name='ig_code' id="ig_code" required="required" class="fl">
		<option>그룹선택</option>	
	</select>
	**/
	function ig_load(code)
	{
		
			var html="";
			var select_html="";
			param = "code="+code;
			$.ajax({
				type:'POST',
				url : "<c:url value='/training/ajax_group_list.do'/>",
				data:param,
				dataType : "json",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
				beforeSend: function() {
		        },
				success : function(json){
					for(i=0;i<json.length;i++)
					{
						select_html = select_html +"<option value='"+json[i].code+"'>"+json[i].group_name+"</option>";
					}
					
					html = "<select name='ig_code' id='ig_code' required='required' class='fl'>";
					html = html + "<option value=''>그룹선택</option>";
					html = html + select_html;
					html = html + "</select>";
					
					$("#ig_code_div").html(html);
					
				},
				error:function(request,status,error){
				}
				
			}).complete(function() {
							
	        });
		
	}
	
	
	/**
	훈련삭제
	**/
	function deleteTraining()
	{
		var frm = document.getElementById("frm");
		
		if (confirm("해당 훈련을 정말 삭제하시겠습니까?\n삭제를 진행하면 복구는 불가능 합니다. \n신중하게 신행해주시기 바랍니다.") == true)
		{  
			frm.action = "<c:url value='/training/training_del.do'/>";
			frm.submit();
		}
	}
	
	/**
	훈련 발송 초기화
	**/
	function executeInit()
	{
		var frm = document.getElementById("frm");
		
		if (confirm("해당 훈련의 발송상태를 초기화 하시겠습니까?\n초기화할 시 훈련 실행으로 소비된 과금 및 발송로그는 삭제됩니다.\n신중하게 신행해주시기 바랍니다.") == true)
		{    
			frm.action = "<c:url value='/training/training_execute_init.do'/>";
			frm.submit();
		}
	}
	
	<c:choose>
	<c:when test="${pageType eq 'insert' }">
	</c:when>
	<c:when test="${pageType eq 'update' and (training_detail.status=='ready' or training_detail.status=='step1') }">
	</c:when>
	<c:otherwise>
	$(function() {
		
		$("input").attr("readonly",true);
		$("select").attr("disabled", "disabled");
		
		document.frm.register_type[0].disabled = true;
		document.frm.register_type[1].disabled = true;

		document.frm.del_type[0].disabled = true;
		document.frm.del_type[1].disabled = true;
		
		$("#spam_type_chk").attr("disabled", true);
		$("#reservation_type_chk").attr("disabled", true);
		$("#registerTime_type_chk").attr("disabled", true);			
		$("#all_send_type_chk").attr("disabled", true);
		
		$("#traing_all").attr("disabled", true);
		$("#training_type1").attr("disabled", true);
		$("#training_type2").attr("disabled", true);
		$("#training_type3").attr("disabled", true);
		
		<c:choose>
		<c:when test="${training_detail.status=='end'}">
			$('#reservation_date').prop('disabled', true);
		</c:when>
		</c:choose>
		
		$('#searchBgnDe').prop('disabled', true);
	});
	</c:otherwise>
</c:choose>
	
	function pop_training_single_addcate()
	{
		
		var select_html = select_template_all_list("maincate","");	
		
		var title = "분류 카테고리 추가";		
		var message ="";		
		message = message + "<div>";
		message = message + "		<span style='width:80px;float:left'>카테고리</span><span width='*'><select name='cate_main_list' id='cate_main_list' onchange='select_template_all_list(\"subcate\",this.value);'>"+select_html+"</select>";
		message = message + "		<select name='cate_sub_list' id='cate_sub_list' ><option value=\"\">템플릿선택</option></select></span><br>";
		message = message + "</div>";
		
		var dia  = BootstrapDialog.show({
			title:title ,
	           message: message,
	           closable: true,
	           closeByBackdrop: false,
	           closeByKeyboard: false,
	           buttons: [
							{
							    label: '추가',
							    action: function(dialogRef){						    	
							    	var val1 = $("select[name='cate_sub_list']").val();
							    	
							    	if(val1=="")
								    {
							        	alert("템플릿는 필수입력입니다.");
							        	$("input[name='cate_main_list']").focus();
							        	return ;
							        }						    	
							    	
							    	var tmpinfo="&tc_code="+val1;	
							    	
							    	ajax_cate("add_cate", tmpinfo);						    	
							        dialogRef.close();
						    	}
							},
	                    	{
			                	label: '닫기',
			                	action: function(dialogRef){
			                    	dialogRef.close();
			             		}
	           				}
						]
	       }); 
	
	}
	
	
	function pop_training_single_modcate(key)
	{
		var cate_code 			=$("input[name='grplistvo["+key+"].cate_code']").val();
		var tc_code				=$("input[name='grplistvo["+key+"].tc_code']").val();
		
		var gp_title				=$("input[name='grplistvo["+key+"].gp_title']").val();
		var gp_send_name	=$("input[name='grplistvo["+key+"].gp_send_name']").val();
		var gp_send_email		=$("input[name='grplistvo["+key+"].gp_send_email']").val();
		
		gp_title = tag_valid(gp_title);
		
		var select_html = select_template_all_list2("maincate",cate_code,tc_code);	
		
		var sub_select_html = select_template_all_list2("subcate_first",cate_code,tc_code);	
		
		var title = "분류 카테고리 수정";
		
		
		var message ="";
		message = message + "<div>";		
		message = message + "		<span style='width:80px;float:left'>발신 제목</span><span width='*'><input type='text' class='input-xlarge' name='val1' value=\""+gp_title+"\"></span><br>";
		message = message + "		<span style='width:80px;float:left'>발신자</span><span width='*'><input type='text' class='input-xlarge' name='val2' value=\""+gp_send_name+"\"></span><br>";
		message = message + "		<span style='width:80px;float:left'>발신 email</span><span width='*'><input type='text' class='input-xlarge' name='val3'value=\""+gp_send_email+"\" ></span><br>";
		message = message + "		<span style='width:80px;float:left'>카테고리</span><span width='*'><select name='cate_main_list' id='cate_main_list' onchange='select_template_all_list2(\"subcate\",this.value,"+tc_code+");'>"+select_html+"</select>";
		message = message + "		<select name='cate_sub_list' id='cate_sub_list' >"+sub_select_html+"</select></span><br>";
		message = message + "<input type='hidden' name='val4' value='"+key+"'>";
		message = message + "</div>";
		
		var dia  = BootstrapDialog.show({
			title:title ,
	           message: message,
	           closable: true,
	           closeByBackdrop: false,
	           closeByKeyboard: false,
	           buttons: [
							{
							    label: '수정',
							    action: function(dialogRef){
							    	
							    	var val_title = $("input[name='val1']").val();
							    	var val_name = $("input[name='val2']").val();
							    	var val_email = $("input[name='val3']").val();
							    	var val_cate_code = $("select[name='cate_sub_list']").val();
							    	var val_tg_code = $("input[name='val4']").val();
							    	
							    
							    	if(val_title=="")
								    {
							        	alert("발신 제목은 필수입력입니다.");
							        	return ;
							        } 		
							    	
							    	if(ban_tag_valid(val_title)){
							    		alert("발신 제목에 큰따옴표는 입력할 수 없습니다.");
							        	return ;
							    	}
							    	
							    	if(val_name=="")
								    {
							        	alert("발신자는 필수입력입니다.");
							        	return ;
							        } 		
							    	
							    	if(ban_tag_valid(val_name)){
							    		alert("발신자에 큰따옴표는 입력할 수 없습니다.");
							        	return ;
							    	}
							    	
							    	if(val_email=="")
							        {
							        	alert("발신 email 은 필수입력입니다.");
							        	$("input[name='val3']").focus();
							        	return ;
							        }
							    	
							    	var regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";
							    	if (!val_email.match(regex))
							    	{
							    		alert("이메일을 입력해주시기 바랍니다.");
							    		$("input[name='val3']").focus();
							    		return ;
							    	}
							    	
							    	if(val_cate_code=="")
								    {
							        	alert("카테고리는 필수선택입니다.");
							        	return ;
							        } 	
							    	
							    	var tmpinfo= "";
							    	
							    	if(tc_code != val_cate_code){	
							    		 if(confirm('카테고리 변경시  발신 제목,  발신자, 발신 email이 변경 될 수 있습니다. 변경하시겠습니까?'))
									    {
								    		tmpinfo = tmpinfo +"&tc_code="+val_cate_code; 
								    		tmpinfo = tmpinfo +"&tg_code="+encodeURIComponent(val_tg_code);	
									    }
							    	}else{							    		
							    		if(gp_title	 != val_title || gp_send_name!= val_name || gp_send_email != val_email){
							    			tmpinfo = tmpinfo +"&gp_title="+encodeURIComponent(val_title);
											tmpinfo = tmpinfo +"&gp_send_name="+encodeURIComponent(val_name);
											tmpinfo = tmpinfo +"&gp_send_email="+encodeURIComponent(val_email);
											tmpinfo = tmpinfo +"&tg_code="+encodeURIComponent(val_tg_code);	
								    	}							    		
							    	}								
									
							    	if(tmpinfo != ""){
							    		ajax_cate("mod_cate", tmpinfo);
							    	}
									
									dialogRef.close();
							       
									
						    	}
							},
	                    	{
			                	label: '닫기',
			                	action: function(dialogRef){
			                    	dialogRef.close();
			             		}
	           				}
						]
		
	       });
	
	}
	
	/**
	카테고리 삭제
	**/
	function pop_training_single_delcate(key)
	{
		if(confirm('해당 카테고리을 삭제하시겠습니까?'))
		{		
			var tempinfo="&code="+key+"&tg_code="+key;							   
	    	
			ajax_cate("del_cate", tempinfo);
		}
	}
	
	function pop_training_single_adduser()
	{
		if(total_usercnt+1 > maxcnt){
			alert("총 훈련 대상자 수 "+maxcnt +"명을 초과할 수 없습니다.");				
		}else{
		
			var select_html = select_template_main_list("add","");	
			
			var title = "훈련대상자 추가";		
			var message ="";		
			message = message + "<div>";
			message = message + "		<span style='width:80px;float:left'>email</span>		<span width='*'><input type='text' class='input-xlarge' name='val1'></span><br>";
			message = message + "		<span style='width:80px;float:left'>이름</span>			<span width='*'><input type='text' class='input-xlarge' name='val2'></span><br>";
			message = message + "		<span style='width:80px;float:left'>부서</span>			<span width='*'><input type='text' class='input-xlarge' name='val3'></span><br>";
			message = message + "		<span style='width:80px;float:left'>사번/아이디</span>	<span width='*'><input type='text' class='input-xlarge' name='val4'></span><br>";
			message = message + "		<span style='width:80px;float:left'>카테고리</span><span width='*'><select name='cate_main_list' id='cate_main_list' onchange='select_template_sub(this.value,\"add\",\"\");'>"+select_html+"</select>";
			message = message + "		<select name='cate_sub_list' id='cate_sub_list' ><option value=\"\">템플릿선택</option></select>";
			message = message + "		<input type='checkbox' name='new_cate_list' id='new_cate_list' onClick='checkbox_new_template(this)'>신규</span><br>";
			message = message + "</div>";
			
			var dia  = BootstrapDialog.show({
				title:title ,
		           message: message,
		           closable: true,
		           closeByBackdrop: false,
		           closeByKeyboard: false,
		           buttons: [
								{
								    label: '추가',
								    action: function(dialogRef){
								    	var val1 = $("input[name='val1']").val();
								    	var val2 = $("input[name='val2']").val();
								    	var val3 = $("input[name='val3']").val();
								    	var val4 = $("input[name='val4']").val();
								    	var val5 = $("select[name='cate_sub_list']").val();
								    	
								    	if(val1=="")
								        {
								        	alert("email 은 필수입력입니다.");
								        	$("input[name='val1']").focus();
								        	return ;
								        }
								    	
								    	var regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";
								    	if (!val1.match(regex))
								    	{
								    		alert("이메일을 입력해주시기 바랍니다.");
								    		$("input[name='val1']").focus();
								    		return ;
								    	}
								    	
								    	if(val2=="")
									        {
								        	alert("이름 은 필수입력입니다.");
								        	$("input[name='val2']").focus();
								        	return ;
								        }
								    	
								    	if(val3=="")
								        {
								        	alert("부서 은 필수입력입니다.");
								        	$("input[name='val3']").focus();
								        	return ;
								        }
								    	
								    	if(val4=="")
									    {
								        	alert("사번/아이디 는 필수입력입니다.");
								        	$("input[name='val4']").focus();
								        	return ;
								        }
								    	if(val5=="")
									    {
								        	alert("카테고리는 필수입력입니다.");
								        	$("input[name='cate_sub_list']").focus();
								        	return ;
								        }
								    	
								    	var Userinfo="";
								    	
								    	Userinfo= Userinfo +"&email="+encodeURIComponent(val1);
								    	Userinfo= Userinfo +"&name="+encodeURIComponent(val2);
								    	Userinfo= Userinfo +"&department_name="+encodeURIComponent(val3);
								    	Userinfo= Userinfo +"&unikey="+encodeURIComponent(val4);
								
								    	if($('#new_cate_list').is(":checked") == true){
								    		Userinfo= Userinfo +"&tc_code="+encodeURIComponent(val5);
								    	}else{
								    		Userinfo= Userinfo +"&tg_code="+encodeURIComponent(val5);
								    	}
								    	
								    	ajax_proc("add_user", Userinfo);
								    	send_num_init();
								        dialogRef.close();
							    	}
								},
		                    	{
				                	label: '닫기',
				                	action: function(dialogRef){
				                    	dialogRef.close();
				             		}
		           				}
							]
		       }); 
		}
	}
		
	/**
	템플릿 선택 창 팝업(주분류)
	**/
	function select_template_main_list(type,cateCode)
	{		
		var select_html="<option value=\"\">선택하세요</option>";
		
		var param = "training_code="+$("input[name='training_code']").val();		
		
		$.ajax({
			type:'POST',
			url : "<c:url value='/training/ajax_tempalte_main_list.do'/>",
			data:param,
			dataType : "json",
			async:false,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
			beforeSend: function() {
	        },
			success : function(json){
				
				var dup_code_list =new Set();
						
				for(i=0;i<json.length;i++)	
				{
					if(!dup_code_list.has(json[i].cate_code))
					{
						if(type=="add"){
							
							dup_code_list.add(json[i].cate_code);
							select_html = select_html +"<option value='"+json[i].cate_code+"' >"+json[i].cate_name+"</option>";							
				
						}else if(type == "modfiy"){
							
							if(cateCode == json[i].cate_code){
								
								dup_code_list.add(json[i].cate_code);
								select_html = select_html +"<option value='"+json[i].cate_code+"' selected>"+json[i].cate_name+"</option>";	
						
							}else{
								
								dup_code_list.add(json[i].cate_code);
								select_html = select_html +"<option value='"+json[i].cate_code+"' >"+json[i].cate_name+"</option>";	
							
							}								
						}
						
					}
				} 				
			},
			error:function(request,status,error){
			}
			
		}).complete(function() {
						
	    });
		
		return select_html;
	}	
	
	/**
	템플릿 선택 창 팝업(소분류)
	**/
	function select_template_sub_list(code,type,grpCode)
	{
		
		var select_html="<option value=\"\">템플릿선택</option>";		
		
		var param = "training_code="+$("input[name='training_code']").val();		
		param = param + "&cate_code="+code;
		
		$.ajax({
			type:'POST',
			url : "<c:url value='/training/ajax_tempalte_sub_list.do'/>",
			data:param,
			async:false,
			dataType : "json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
			beforeSend: function() {
	        },
			success : function(json){
				for(i=0;i<json.length;i++)	
				{
					if(type=="add"){				
						
						select_html = select_html +"<option value='"+json[i].tg_code+"' >"+json[i].template_name+"</option>";
						
					}else if(type == "modfiy" || type == "modfiy_first"){
						
						if(grpCode == json[i].tg_code){
							
							select_html = select_html +"<option value='"+json[i].tg_code+"' selected>"+json[i].template_name+"</option>";
							
						}else{
							
							select_html = select_html +"<option value='"+json[i].tg_code+"' >"+json[i].template_name+"</option>";
							
						}
					}
				}
				if(type != "modfiy_first"){				
				
					$("#cate_sub_list").html(select_html);
					
				}
				
			},
			error:function(request,status,error){
			}
			
		}).complete(function() {
						
	    });
		
		return select_html;
	}
	
	/**
	템플릿 추가 창 팝업(주분류, 소분류)
	**/
	function select_template_all_list(type,cateCode)
	{		
		var select_html="<option value=\"\">선택하세요</option>";
		
		var param = "training_code="+$("input[name='training_code']").val();	
		
		if(type=="maincate"){		
			param = param+ "&type="+type ;
		}
		else if(type=="subcate"){
			select_html="<option value=\"\">템플릿선택</option>";
			param = param+ "&type="+type + "&cate_code="+cateCode;
		}
		
		$.ajax({
			type:'POST',
			url : "<c:url value='/training/ajax_tempalte_all_list.do'/>",
			data:param,
			dataType : "json",
			async:false,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
			beforeSend: function() {
	        },
			success : function(json){
				
				var dup_code_list =new Set();
				
				for(i=0;i<json.length;i++)	
				{
						if(type=="maincate"){
							
							if(!dup_code_list.has(json[i].cate_code))
							{
								dup_code_list.add(json[i].cate_code);
								select_html = select_html +"<option value='"+json[i].cate_code+"' >"+json[i].cate_name+"</option>";							
							}
							
						}else if(type == "subcate"){
							
							select_html = select_html +"<option value='"+json[i].tc_code+"' >"+json[i].template_name+"</option>";				
						}					
				} 				
			},
			error:function(request,status,error){
			}
			
		}).complete(function() {
						
	    });
		
		if(type=="maincate"){
			
			return select_html;						
			
		}else if(type == "subcate"){
			
			$("#cate_sub_list").html(select_html);		
		}
		
	}
	
	/**
	템플릿 수정 창 팝업(주분류, 소분류)
	**/
	function select_template_all_list2(type,cateCode,tcCode)
	{	
		var select_html = "";
		
		var param = "training_code="+$("input[name='training_code']").val();	
		
	
		if(type=="maincate"){		
			param = param+ "&type=maincate"+"&tc_code="+tcCode  ;
		}
		else if(type=="subcate" || type == "subcate_first"){
			select_html="<option value=\"\">템플릿선택</option>";
			param = param+ "&type=subcate" +"&tc_code="+tcCode+"&cate_code="+cateCode;
		}
		
		$.ajax({
			type:'POST',
			url : "<c:url value='/training/ajax_tempalte_all_list.do'/>",
			data:param,
			dataType : "json",
			async:false,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
			beforeSend: function() {
	        },
			success : function(json){
				
				var dup_code_list =new Set();
				
				for(i=0;i<json.length;i++)	
				{
						if(type=="maincate"){
							
							if(!dup_code_list.has(json[i].cate_code))
							{
								dup_code_list.add(json[i].cate_code);
								if(cateCode == json[i].cate_code){
									select_html = select_html +"<option value='"+json[i].cate_code+"' selected>"+json[i].cate_name+"</option>";	
								}else{
									select_html = select_html +"<option value='"+json[i].cate_code+"' >"+json[i].cate_name+"</option>";	
								}			
							}
							
						}else if(type == "subcate" || type == "subcate_first"){
							if(tcCode == json[i].tc_code && type == "subcate_first"){
								select_html = select_html +"<option value='"+json[i].tc_code+"' selected>"+json[i].template_name+"</option>";		
							}else{
								select_html = select_html +"<option value='"+json[i].tc_code+"' >"+json[i].template_name+"</option>";		
							}								
						}					
				} 				
			},
			error:function(request,status,error){
			}
			
		}).complete(function() {
						
	    });
		
		if(type=="maincate"|| type == "subcate_first"){
			
			return select_html;						
			
		}else if(type == "subcate"){
			
			$("#cate_sub_list").html(select_html);		
		}
		
	}
	
	/**
	 훈련 대상자 추가(개별)시 신규체크박스에 따른 소분류 리스트 출력
	**/
	function select_template_sub(cate_code,type,grpCode)
	{
		if($('#new_cate_list').is(":checked") == true){ //신규 체크박스 체크시 
			
			select_template_all_list("subcate",cate_code);  //해당 GRP에 등록된 템플릿을 제외한 템플릿 리스트 출력
			
		}else{ //신규 체크박스 해제시
			
			select_template_sub_list(cate_code,type,grpCode); // 해당 GRP에 등록된 템플릿을 등록된  템플릿 리스트 출력
			
		}		
	}
	
	/**
	  훈련 대상자 추가시(신규 체크박스 클릭 이벤트)
	**/
	function checkbox_new_template(chk_val)
	{	
		var select_sub_html="<option value=\"\">템플릿선택</option>";

		if(chk_val.checked == true){ //신규 체크박스 체크시 			
			
			var select_main_html = select_template_all_list("maincate","");
			
			$("#cate_main_list").html(select_main_html);
			$("#cate_sub_list").html(select_sub_html);
			
		}else{ //신규 체크박스 체크해체시 
			var select_main_html = select_template_main_list("add","");	
			
			$("#cate_main_list").html(select_main_html);
			$("#cate_sub_list").html(select_sub_html);			
		}
	}
	
	/**
	템플릿 수정 창 팝업
	**/
	function update_template_popup(grp_code)
	{	
		var code=$("input[name='training_code']").val();
		url = "/training/template_update_popup.do?training_code="+code+"&tg_code="+grp_code;
		width="1224";
		height ="600";
		page_id = "template_update_popup";
		var popup = fn_openwindow(url, width, height, page_id);
	}
	
	//숫자만 입력하도록 하는 자바스크립트
	function numkeyCheck(e) { 
		var keyValue = event.keyCode; 
		
		if( ((keyValue >= 48) && (keyValue <= 57)) ||((keyValue >= 96) && (keyValue <= 105)) ) 
			return true; 
		else 
		return false;
	}
	
	/**
	비율에 따른 인원수 조정 및 / 지정할수 있는 값 0 < 퍼센트 < 100
	인원 수에 따른 비율 변환 /  지정할수 있는 값  0 < 인원수 < 등록된 인원수
	**/
	function send_num_init() {
		$("input[name='send_percent']").val(0);
		$("input[name='send_number']").val(0);
		
	}
	
	
	function send_num_Check(id) { 
		
		var keyValue = event.keyCode; 	
		
		//숫자 및 백스페이스만 이벤트 처리
		if(((keyValue >= 48) && (keyValue <= 57)) ||((keyValue >= 96) && (keyValue <= 105)) || keyValue==8 ){
			var percent=$("input[name='send_percent']").val();
			var num=$("input[name='send_number']").val();
			
			if(null == percent || ''==percent ){
				percent=0;
			}
			if(null == num || ''==num ){
				num=0;
			}			
			var result=0;
	
			if(listcnt==0){
				$("input[name='send_percent']").val(0);
				$("input[name='send_number']").val(0);
				return false;
			}
			
			if(1==id){
				result=percent/100*listcnt;				
				
				if((result < 0) || (result > listcnt)){
					$("input[name='send_percent']").val(100);
					$("input[name='send_number']").val(listcnt);
					return false;
					
				}else{
					$("input[name='send_number']").val(result.toFixed(0));
					return true;
				}
				
			}else if(2==id){
				result=parseInt(num)/parseInt(listcnt)*100;				
			
				if((result < 0) || (result > 100)){
					$("input[name='send_percent']").val(100);
					$("input[name='send_number']").val(listcnt);
					return false;
					
				}else{
					
					$("input[name='send_percent']").val(result.toFixed(0));
					return true;
				}	
								
			}
			return false;
			
		}else	{	
			return false;
		}
	}
	
	
	/**
	* 스팸 사용 체크에 따른 입력폼 비활성화
	**/
	function check_spam_use()
	{		
		if($("input:checkbox[name='spam_type_chk']").is(":checked")==true)
		{
			$("input[name='spam_number']").attr('disabled' ,false);
			$("input[name='spam_time']").attr('disabled' ,false);
			$("input[name='spam_type']").val('Y');
			
		}else{
			$("input[name='spam_number']").attr('disabled' ,true);
			$("input[name='spam_time']").attr('disabled' ,true);
			
			$("input[name='spam_type']").val('N');
			$("input[name='spam_number']").val('');
			$("input[name='spam_time']").val('');			
		
		}
	}
	
	/**
	* 발송예약 사용 체크에 따른 입력폼 비활성화
	**/
	function check_reservation_use()
	{		
		if($("input:checkbox[name='reservation_type_chk']").is(":checked")==true)
		{
			$("input[name='reservation_date']").attr('disabled' ,false);
			$("input[name='reservation_type']").val('Y');
			
		}else{
			$("input[name='reservation_date']").attr('disabled' ,true);
			$("input[name='reservation_date']").val('');	
			
			$("input[name='reservation_type']").val('N');		
		}
	}
	
	/**
	* 전체 발송 사용 유무 
	**/
	function check_all_send_use()
	{		
		if($("input:checkbox[name='all_send_type_chk']").is(":checked")==true)
		{
			$("input[name='send_percent']").attr('disabled' ,true);
			$("input[name='send_number']").attr('disabled' ,true);
			
			$("input[name='all_send_type']").val('Y');
			$("input[name='send_percent']").val('');
			$("input[name='send_number']").val('');
						
		}else{
			$("input[name='send_percent']").attr('disabled' ,false);
			$("input[name='send_number']").attr('disabled' ,false);
			$("input[name='all_send_type']").val('N');
			
			send_num_init();
		}
	}
	
	/**
	* 신고 시간 준수 설정 
	**/
	function check_registerTime_use()
	{		
		if($("input:checkbox[name='registerTime_type_chk']").is(":checked")==true)
		{
			$("input[name='register_time']").attr('disabled' ,false);
			$("input[name='register_time_type']").val('Y');
			
		}else{
			$("input[name='register_time']").attr('disabled' ,true);
			
			$("input[name='register_time']").val('');	
			$("input[name='register_time_type']").val('N');
		}
	}
	
	function percent_calcul(){
	
		if($("input:checkbox[name='all_send_type_chk']").is(":checked")==false)
		{
			var num=$("input[name='send_number']").val();
			var result=0;
			if(listcnt < num){
				$("input[name='send_number']").val(0);
				$("input[name='send_percent']").val(0);
				return;
			}				
			if(null == num || ''==num || listcnt==0){
				num=0;
				$("input[name='send_percent']").val(0);
				$("input[name='send_number']").val(0);
			}else{			
						
				result=parseInt(num)/parseInt(listcnt)*100;				
							
				$("input[name='send_percent']").val(result.toFixed(0));
				return true;
				
			}
		}	
		return false;
	}
	/**
	훈련 승인
	**/
	function approval()
	{
		var frm = document.getElementById("frm");
		
		
		if (confirm("해당 훈련 진행을 정말 승인하시겠습니까?") == true)
		{  
			
			frm.action = "<c:url value='/training/training_approval.do'/>";
			frm.submit();
		}
	}
	
	/**
	훈련 승인
	**/
	function approval_req()
	{
		var frm = document.getElementById("frm");
		
		
		if (confirm("관리자에게 승인요청하시겠습니까?") == true)
		{  
			
			frm.action = "<c:url value='/training/training_approval_request.do'/>";
			frm.submit();
		}
	}
	
	/**
	훈련 승인
	**/
	function approval_cancel()
	{
		var frm = document.getElementById("frm");
		
		
		if (confirm("해당 훈련에 대한 승인요청을 취소하시겠습니까?") == true)
		{  
			
			frm.action = "<c:url value='/training/training_approval_cancel.do'/>";
			frm.submit();
		}
	}

	/**
	발송예약 취소
	**/
	function reservation_cancel()
	{
		var frm = document.getElementById("frm");
		
		
		if (confirm("해당 훈련에 대한 발송예약을 취소하시겠습니까?") == true)
		{  
			
			frm.action = "<c:url value='/training/training_reservation_cancel.do'/>";
			frm.submit();
		}
	}
	
	/**
	* 신고 사용여부에 따른 URL 생성/표시 및 비활성화
	**/
	function register_use(type)
	{	
		
		if(type == 'y')
		{	
			var param = "code="+$("input[name='code']").val();		
			
			$.ajax({
				type:'POST',
				url : "<c:url value='/training/ajax_register_url_create.do'/>",
				data:param,
				dataType : "json",
				async:false,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
				beforeSend: function() {
		        },
				success : function(json){
					
					for(i=0;i<json.length;i++)	
					{
						if("success" ==json[i].status){
							$("#register_type_url_view").html(json[i].register_url); 
						}else if("fail" ==json[i].status){
							$("#register_type_url_view").html("-");
						}
					} 				
				},
				error:function(request,status,error){
				}
				
			}).complete(function() {
							
		    });			
		}else{
			$("#register_type_url_view").html("-");
			
			$("input[name='register_time']").attr('disabled' ,true);			
			$("input[name='register_time']").val('');	
			$("input[name='register_time_type']").val('N');

			$("input[name='registerTime_type_chk']").prop("checked",false);
		}
	}
	
	/**
	* 훈련 기간 수정
	**/
	function update_training_date()
	{	
			var param =  "end_date="+$("input[name='end_date']").val();		
			param += "&code="+$("input[name='code']").val();	
			
			//훈련기간 체크
			if($("#searchEndDe").val()=="")
			{
				alert('훈련종료일을 입력하여주세요!');
				return ;
			}			
			else if(Number($("#searchBgnDe").val().replace(/\-/g,'').replace(' ','').replace(':',''))>Number($("#searchEndDe").val().replace(/\-/g,'').replace(/\:/g,'').replace(' ','').replace(':','')))
			{
				alert('훈련 시작일이 종료일 보다 작아야합니다.');
				return ;
			}else{
			
				$.ajax({
					type:'POST',
					url : "<c:url value='/training/ajax_training_date_update.do'/>",
					data:param,
					dataType : "json",
					async:false,
					contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
					beforeSend: function() {
			        },
					success : function(json){					
						var msg=""
						for(i=0;i<json.length;i++)	
						{
							if("success" ==json[i].status){
								msg="훈련 기간 변경되었습니다.";
							}else{
								msg="훈련 기간 변경이 실패하였습니다.";
							}
						} 			
						alert(msg);
					
					},
					error:function(request,status,error){
						alert("훈련 기간 변경이 실패하였습니다.");
					}
					
				}).complete(function() {
								
			    });			
			}
	}
	
	//slick grid 필드 생성
	function createUserFields(){
		
		var fields=[];
		
		fields.push({name : "code",id: "code",type:"hide"});
		fields.push({name : "tg_code",id: "tg_code",type:"hide"});
		fields.push({name : "cate_code", id: "cate_code",type:"hide"});		
		
		fields.push({name : "이메일주소",id: "email"});
		fields.push({name : "이름",id: "name"});
		fields.push({name : "부서",id: "department_name"});
		fields.push({name : "사번/아이디",id: "unikey"});
	
		if(pageType == "insert" || status ==  "ready" || status== "step1"){
			setSlickBtn(	"mod","수정");
			setSlickBtn(	"del","삭제");
			
			fields.push({name : "등록/수정",id: "status",type:"btn"});
			
		}else{						
			fields.push({name : "발송상태",id: "status"});			
		}				
		
		
		setSlickHeader(fields);	
	}
	
	//slick grid 생성 및 유저 리스트 추가
	function addUserfush(div_name,rdata){
		//데이터 삽입
		setSlickData_first(rdata);
		setSort_multi_table
		
		//slick grid 생성
		create_slick_grid("#"+div_name);
		
		//정렬 이벤트 추가
		setSort_multi_table();
		if(pageType == "insert" || status ==  "ready" || status== "step1"){
			//등록 , 수정 버튼 이벤트 추가
			set_btn_update_delete_event(slick_grid_list.length -1);
		}	
	}
	
	/**
	 * training 전용 이벤트 추가 폼 
	 * @param row
	 */
	function set_btn_update_delete_event(num)
	{
		if(slick_grid != null && slick_grid !=""){
			 //button event
			slick_grid.onClick.subscribe(function (e, args) {
		    	if ($(e.target).hasClass("btn")) {
		    		var item = slick_grid_list[num].getData().getItem(args.row);
		    		 
		    		if($(e.target).attr('id') == "mod"){
		    			pop_training_single_moduser(item);
		    		}else if($(e.target).attr('id') == "del"){
		    			pop_training_single_deluser(item);
		    		}
		        }	    	
		    	e.stopImmediatePropagation();
		    });  	
		}else{
			console.log(" slick grid is null");
			return;
		}		
		
	}	
	
</script>

<c:import url="/common/pageLink.do?link=inc/bottom_layout" />