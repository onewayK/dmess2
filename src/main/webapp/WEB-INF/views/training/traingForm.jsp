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
<script type="text/javascript" src="../../../js/ckeditor/ckeditor.js"></script>
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
		<li><i class="fa-icon-home"></i> Home / <strong>훈련생성</strong>
		</li>
	</ul>

	<div class="panel panel-default">
		
		
		
		<form name="frm" id="frm" method="post"  enctype="multipart/form-data">
		<input type='hidden' name='type' value='0'>
		<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2>
						<%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
							<c:choose>
								<c:when test="${service_type eq 'test' }">
										<i class="fa-icon-user"></i><span class="break"></span>일반 훈련 생성(테스트)
								</c:when>
								<c:when test="${service_type eq 'real' }">
										<i class="fa-icon-user"></i><span class="break"></span>일반 훈련 생성(실전)
								</c:when>
								<c:otherwise>
									<i class="fa-icon-user"></i><span class="break"></span>훈련생성
								</c:otherwise>
							</c:choose>
							<input type='hidden' name='service_setting_code' id='service_setting_code' value="<c:out value="${serviceSetting.code}"/>"/>
							<input type='hidden' name='service_type' id='service_type' value="<c:out value="${service_type}"/>"/>
						
						<%}else {%>
							<i class="fa-icon-user"></i><span class="break"></span>훈련생성
						<%}%>
						</h2>
						<h2 style="float:right"><span class="break"></span>
							<a href="#" id="template_view" onclick="select_template_popup(); return false;"><i class="fa-icon-cogs"></i>템플릿</a>
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
							  		<input type="radio" name="register_type" id='register_type'  value="y" checked>사용
							  		<input type="radio" name="register_type" id='register_type'  value="n">사용안함
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
								 			<c:otherwise>
								 				-
								 			</c:otherwise>
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
						
						
						
						<div class="form-horizontal span6"> 
						
							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />이메일제목</label>
							  <div class="controls">
							  		<input style="width: 200px" type='text' name='title' required='required' class="fl" maxlength="40" value="<c:if test="${pageType=='update'}"><c:out value="${training_detail.title }"/></c:if>">
							  </div>
							</div>
							
							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />이메일발신자 이름</label>
							  <div class="controls">
							  	<input style="width: 200px" type='text' name='send_name' required='required' maxlength="40" class="fl" value="<c:if test="${pageType=='update'}"><c:out value="${training_detail.send_name }"/></c:if>">
							  </div>
							</div>
							
							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />발신이메일</label>
							  <div class="controls">
							  	<input style="width: 200px" type='email' name='send_email' maxlength="40" required='required' class="fl" value="<c:if test="${pageType=='update'}"><c:out value="${training_detail.send_email}"/></c:if>">
							  </div>
							</div>
							
							<div class="control-group">
							  <label class="control-label" for="typeahead"><span tooltipmessage="발송간격 설정 사용시 설정된 시간/건수로 발송진행<br>예) 1 분당 10건 => 1초당 10건씩 메일 발송 진행" >발송간격</span></label>
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
			
						<div class="clearFix"></div>
						
						<div class="form-horizontal "> 
						
							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />발신내용</label>
							  <div class="controls">
							  			
							  			<c:choose>
											<c:when test="${pageType eq 'insert' }">
<%--												<textarea name="send_content" id="send_content" required='required' class="fl" rows="10" cols="100" style="width:100%; height:412px; display:none;"><c:if test="${pageType=='update'}"><c:out value="${training_detail.send_content }"/></c:if></textarea>--%>
												<textarea id="send_content" name="send_content"></textarea>
											</c:when>
											<c:when test="${pageType eq 'update' and training_detail.status=='ready'}">
<%--												<textarea name="send_content" id="send_content" required='required' class="fl" rows="10" cols="100" style="width:100%; height:412px; display:none;"><c:if test="${pageType=='update'}"><c:out value="${training_detail.send_content }"/></c:if></textarea>--%>
												<textarea id="send_content" name="send_content"></textarea>
											</c:when>
											<c:otherwise>
												<div class="se2_outputarea">
													<c:out value="${training_detail.send_content }" escapeXml="false" />
													<textarea name="send_content" id="send_content" required='required' class="fl" rows="10" cols="100" style="width:100%; height:412px; display:none;"><c:out value="${training_detail.send_content }" escapeXml="false"/></textarea>
												</div>
											</c:otherwise>
										</c:choose>
							  		
							  	
							  	<p>
							  	<c:choose>
									<c:when test="${pageType eq 'insert'  or (pageType eq 'update' and (training_detail.status=='step1'  || training_detail.status=='ready' ))}">
										<button type="button" class="btn btn-info" onClick='addLink();'>본문에 링크 추가</button>
							  		</c:when>
								</c:choose>
								
						  		<c:choose>
									<c:when test="${pageType eq 'insert' }"></c:when>
									<c:when test="${pageType eq 'update' and training_detail.status=='ready'}"></c:when>
									<c:otherwise>
										<button type="button" class="btn btn-info" onClick="contentView();">본문미리보기</button>
									</c:otherwise>
								</c:choose>
							  		
							  	</p>
							  	<p>
								  	본문에 URL이동 을 유도하기 위해 아래의 내용을 본문에 입력하여주시기 바랍니다.<br>
						    		<br>
						    		 ex) '<b>국민의료보험 지급내역</b>' 이라는 문구로 링크를 유도시 	&lt;a href ='#link_url#'	&gt;<b>국민의료보험 지금내역</b>&lt;/a	&gt; 이라고 작성하여주시기 바랍니다.<br><Br>
						    		 본문에 입력할 정보중 훈련인원에 대한 정보를 기입할필요가있을때는 별도의 해시 태그를 제공하고 있습니다.<br>
						    		 
					    		 	 email => #email#, name=>#name#, 부서=>#department_name#, 사번/아이디=>#unikey#, <br>
									 년도(ex: 2016) => #year#, 월(ex:08) => #month#, 일(ex:03) => #day#, 년-월-일 시:분:초(ex:2016-08-25 15:39:10) =>#ymdhis#
					    		</p>
							  </div>
							</div>
							
						</div>
						<div class="clearFix"></div>
				</div>
						
				<div class="box-content">
					<div class="form-horizontal setup_list_area"> 
					<div class="control-group">
							  <label class="control-label" for="typeahead">수집정보</label>
							  <div class="controls">
							  		
									 <div name="co_info">
									 <ul class="setup_list">
										<li><input name="traing_all" 				type="checkbox" id="traing_all" 		value="Y" onclick="collection_info('0');">전체&nbsp;&nbsp;</li>
										<li><input name="training_type1"	 	type="checkbox" id="training_type1" 	value="Y" onclick="collection_info('1');" checked>메일열람&nbsp;&nbsp;</li>
										<li><input name="training_type2" 		type="checkbox" id="training_type2" 	value="Y" onclick="collection_info('2');">링크(URL)실행&nbsp;&nbsp;</li>
										<li><input name="training_type3" 		type="checkbox" id="training_type3" 	value="Y" onclick="collection_info('3');">첨부파일 실행&nbsp;&nbsp;</li>
									</ul>
									</div>
							  </div>
						</div>
					</div>
					<ul class="nav nav-tabs2" >
						<li id="tabs1" class="active" onClick="tabs('1');"  role="presentation" >훈련대상자</li>
						<li id="tabs2" onClick="tabs('2');"  role="presentation" style="display: none;">URL 이동 설정</li>
						<li id="tabs3" onClick="tabs('3');"  role="presentation" style="display: none;">첨부파일 설정</li>
					</ul>
				
					
					<div id='tabs-1'>
						<div class="form-horizontal  span8"> 
						 <c:choose>
								<c:when test="${pageType eq 'insert'  or (pageType eq 'update' and (training_detail.status=='step1'  || training_detail.status=='ready' ))}">
							<div class="control-group">							
							  <label class="control-label" for="typeahead">수신대상자</label>
							  <div class="controls">
							  		<button type="button" class="btn btn-info" onClick='pop_training_user();'>수신자 추가(Excel)</button>
							  		<button type="button" class="btn btn-info" onClick='pop_training_single_adduser();'>수신자 추가(개별)</button>
							  </div>
							</div>
							</c:when>
						</c:choose>
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
						<div>등록 훈련대상자 : <span id='total_user'>0</span>&nbsp;명</div>
						<div class="clearFix"></div>
						
						<div class="form-horizontal "> 
							<div id='userlist' class="userlist">
							</div>
						</div>
						
					</div>
					
					
					<div id="tabs-2">
					
					 <p class="blue">※ 메일 링크 클릭시</p>
					<br>
					
					<c:choose>
						<c:when test="${pageType eq 'insert' }">
							<textarea id="training_type2_content" name="training_type2_content"></textarea>
<%--							<textarea name="training_type2_content" id="training_type2_content" rows="10" cols="100" style="width:100%; height:500px;"><c:if test="${pageType=='update'}"><c:out value="${training_detail.training_type2_content }"/></c:if></textarea>--%>
						</c:when>
						<c:when test="${pageType eq 'update' and training_detail.status=='ready'}">
							<textarea id="training_type2_content" name="training_type2_content"></textarea>
<%--							<textarea name="training_type2_content" id="training_type2_content" rows="10" cols="100" style="width:100%; height:500px;"><c:if test="${pageType=='update'}"><c:out value="${training_detail.training_type2_content }"/></c:if></textarea>--%>
						</c:when>
						<c:otherwise>
							<div class="se2_outputarea">
								<c:out value="${training_detail.training_type2_content }" escapeXml="false" />
								
							</div>
						</c:otherwise>
					</c:choose>
					

					</div>
					<div id="tabs-3">
					
					<div class="form-horizontal "> 
					
							<div class="control-group">
							  <label class="control-label" for="typeahead">첨부 파일 타입 설정</label>
							  <div class="controls">
							  		<select name='training_type3_file_type' id='training_type3_file_type' >
										<option value='html'  	<c:if test="${pageType=='update' and training_detail.training_type3_file_type=='html' }"> selected </c:if>>html</option>
										<option value='hwp'		<c:if test="${pageType=='update' and training_detail.training_type3_file_type=='hwp' }"> selected </c:if>>hwp</option>
										<option value='doc'		<c:if test="${pageType=='update' and training_detail.training_type3_file_type=='doc' }"> selected </c:if>>doc</option>
										<option value='xls'		<c:if test="${pageType=='update' and training_detail.training_type3_file_type=='xls' }"> selected </c:if>>xls</option>
										<option value='exe'		<c:if test="${pageType=='update' and training_detail.training_type3_file_type=='exe' }"> selected </c:if>>exe</option>
									</select>
									
									<select name='training_type3_file_exe_type' id='training_type3_file_exe_type' style="display:none">
										<option value=''>동작선택</option>
										<option value='default'  	<c:if test="${pageType=='update' and training_detail.training_type3_file_exe_type=='default' }"> selected </c:if>>동작 없음</option>
										<option value='scr'			<c:if test="${pageType=='update' and training_detail.training_type3_file_exe_type=='scr' }"> selected </c:if>>화면보호기 실행</option>
										<option value='msg'			<c:if test="${pageType=='update' and training_detail.training_type3_file_exe_type=='msg' }"> selected </c:if>>메세지 창 출력</option>
									</select>
							  </div>
							</div>
							
							<div class="control-group" id="div_training_type3_file_name">
							  <label class="control-label" for="typeahead">파일이름</label>
							  <div class="controls">
							  		<input type='text' name='training_type3_file_name' maxlength="20" value="<c:if test="${pageType=='update'}"><c:out value="${training_detail.training_type3_file_name }"/></c:if>">
							  		파일이름 입력시 확장자 까지 같이 입력해주셔야합니다!
							  </div>
							</div>
							
							<div class="control-group" id="div_training_type3_content">
							  <label class="control-label" for="typeahead">표시될 내용</label>
							  <div class="controls">

									<c:choose>
										<c:when test="${pageType eq 'insert' }">
											<textarea id="training_type3_content" name="training_type3_content"></textarea>
<%--											<textarea name="training_type3_content" id="training_type3_content" rows="10" cols="100" style="width:100%; height:412px;"><c:if test="${pageType=='update'}"><c:out value="${training_detail.training_type3_content }"/></c:if></textarea>--%>
										</c:when>
										<c:when test="${pageType eq 'update' and training_detail.status=='ready'}">
											<textarea id="training_type3_content" name="training_type3_content"></textarea>
<%--											<textarea name="training_type3_content" id="training_type3_content" rows="10" cols="100" style="width:100%; height:412px;"><c:if test="${pageType=='update'}"><c:out value="${training_detail.training_type3_content }"/></c:if></textarea>--%>
										</c:when>
										<c:otherwise>
											<div class="se2_outputarea">
												<c:out value="${training_detail.training_type3_content }" escapeXml="false" />
											</div>
										</c:otherwise>
									</c:choose>
							  		

							  </div>
							</div>
							<div class="control-group" id="div_training_type3_exe_content" style="display:none">
							  <label class="control-label" for="typeahead">표시될 내용</label>
							  <div class="controls">

									<c:choose>
										<c:when test="${pageType eq 'insert' }">
											<textarea name="training_type3_exe_content" id="training_type3_exe_content" rows="10" cols="63"  wrap="physical" style="width:330px; height:412px;"><c:if test="${pageType=='update'}"><c:out value="${training_detail.training_type3_exe_content }"/></c:if></textarea>
											<button type="button" class="btn btn-info" onClick="insertexecontent();">&lt 예시 적용</button>
										</c:when>
										<c:when test="${pageType eq 'update' and training_detail.status=='ready'}">
											<textarea name="training_type3_exe_content" id="training_type3_exe_content" rows="10" cols="63" wrap="physical" style="width:330px; height:412px;"><c:if test="${pageType=='update'}"><c:out value="${training_detail.training_type3_exe_content }"/></c:if></textarea>
											<button type="button" class="btn btn-info" onClick="insertexecontent();">&lt 예시 적용</button>
										</c:when>
										<c:otherwise>
											<textarea name="training_type3_exe_content" id="training_type3_exe_content" rows="10" cols="63" wrap="physical" readonly="readonly" style="width:330px; height:412px;"><c:out value="${training_detail.training_type3_exe_content }"/></textarea>
										</c:otherwise>
									</c:choose>
									
							  </div>
							</div>
							
							<div class="control-group" id="div_training_type3_uploadFile" style="display:none">
							  <label class="control-label" for="typeahead">파일 업로드</label>
							  <div class="controls">
							  	<div>	
							  		<div id="div_training_type3_uploadFile_img"></div>
							  		<table width='100%'>
							  			<tr>
							  				<Td width='350px'>
										  		해당 선택된 파일 확장자에 사용할 img(jpg, png, gif)파일을 선택해주세요.<br>
										  		<button type="button" class="btn btn-info" onClick='imgUploadForm_popup();'>이미지 파일 업로드</button>
										  		
							  				</Td>
							  			</tr>
							  			<tr>
							  				<td>
							  					<br>
							  					<div id="training_type3_upload_image">
							  						<c:if test="${pageType=='update' && (training_detail.training_type3_file_type=='hwp' || training_detail.training_type3_file_type=='xls') }">
<c:out value="${training_detail.training_type3_content }" escapeXml="false"/>
							  						</c:if>
							  					</div>
							  					<div id="training_type3_upload_image_rollover" style="position: absolute;">
							  					</div>
							  				</td>
							  			</tr>
							  		</table>
							  		
							  	</div>	
							  </div>
							</div>
							
							
						</div>
						
						</div>
						
						<div class="pull-right">
							<c:choose>
								<c:when test="${pageType eq 'insert' }">
									<a href='#' onClick='send()' class="btn btn-primary">등록</a>
								</c:when>
								<c:when test="${pageType eq 'update' and training_detail.status=='ready'}">
									<a href='#' onClick='send()' class="btn">수정</a>									
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
			<input type="hidden" name="json_userlist" value=""/>
		
		</div>
		</form>
		</div>
	</div>
</div>
<form name="link_temp" method="post">
	<input type="hidden" name="searchCondition" value="tname"/>
	<input type="hidden" name="searchKeyword" value=""/>
</form>

<%--<script type="text/javascript" src="/js/HuskyEZCreator.js" charset="utf-8"></script>--%>
<%-- create ckeditor --%>
<script src="${pageContext.request.contextPath}/js/training/training-ckeditor.js"></script>
<script>
	var pageType = '<c:out value="${pageType}"/>'
	var status = '<c:out value="${training_detail.status=='ready'}"/>'
	var training_type1="<c:out value="${training_detail.training_type1}"/>";
	var training_type2="<c:out value="${training_detail.training_type2}"/>";
	var training_type3="<c:out value="${training_detail.training_type3}"/>";
	if(pageType === 'update' && status !== 'false'){
		createCkEditorTraining();
		setCkEditorContent('send_content', `${training_detail.send_content}`)

		if(training_type2 == "Y"){
			setCkEditorContent('training_type2_content', `${training_detail.training_type2_content }`)
		}
		if(training_type3 == "Y"){
			setCkEditorContent('training_type3_content', `${training_detail.training_type3_content}`)
		}
	}else if(pageType === "insert"){
		createCkEditorTraining();
	}

		if(training_type2 == "Y"){
			$("#tabs2").show();
			$("#tabs2").removeClass("active");

		}else{
			$("#tabs2").hide();
		}
		$("#tabs-2").hide();

		if(training_type3 == "Y"){
			$("#tabs3").show();
			$("#tabs3").removeClass("active");
		}else{
			$("#tabs3").hide();
		}

		$("#tabs-3").hide();



	training_type3_upload_file_type_selected();




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

var rDate_val = []; 


var status = "<c:out value="${training_detail.status}"/>";

var status = "<c:out value="${training_detail.status}"/>";
var pageType = "<c:out value="${pageType}"/>";

var training_type1="<c:out value="${training_detail.training_type1}"/>";
var training_type2="<c:out value="${training_detail.training_type2}"/>";
var training_type3="<c:out value="${training_detail.training_type3}"/>";

<c:choose>
	<c:when test="${(pageType eq 'insert') or  (pageType eq 'update' and training_detail.status=='ready') }">
	var oEditors = [];

	//this.oApp.exec("STOP_AUTORESIZE_EDITING_AREA");	// [SMARTEDITORSUS-677] 사용자가 편집영역 사이즈를 변경하면 자동확장 기능 중지
	//this.oApp.exec("SHOW_EDITING_AREA_COVER");
	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	// nhn.husky.EZCreator.createInIFrame({
	// 	oAppRef: oEditors,
	// 	elPlaceHolder: "send_content",
	// 	sCSSBaseURI:"/css/",
	// 	sSkinURI: "/common/SmartEditor2Skin.do",
	// 	htParams : {
	// 		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	// 		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	// 		bUseModeChanger : true,		// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	// 		page_type : "training",			//file.upload.path 경로를 template  or training 폴더로 할 것인지 결정
	// 		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
	// 		fOnBeforeUnload : function(){
	// 			//alert("완료!");
	// 		}
	// 	}, //boolean
	// 	fOnAppLoad : function(){
	// 		//예제 코드
	// 		//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	// 	},
	// 	fCreator: "createSEditor2"
	// });


	var oEditors2 = [];

	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

	// nhn.husky.EZCreator.createInIFrame({
	// 	oAppRef: oEditors2,
	// 	elPlaceHolder: "training_type2_content",
	// 	sSkinURI: "/common/SmartEditor2Skin.do",
	// 	htParams : {
	// 		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	// 		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	// 		bUseModeChanger : true,		// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	// 		page_type : "training",			//file.upload.path 경로를 template  or training 폴더로 할 것인지 결정
	// 		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
	//
	// 		fOnBeforeUnload : function(){
	// 			//alert("완료!");
	// 		}
	// 	}, //boolean
	// 	fOnAppLoad : function(){
	// 		//예제 코드
	// 		//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	// 		if(training_type2 == "Y"){
	// 			$("#tabs2").show();
	// 			$("#tabs2").removeClass("active");
	// 		}else{
	// 			$("#tabs2").hide();
	// 		}
	//
	// 		$("#tabs-2").hide();
	// 	},
	// 	fCreator: "createSEditor2"
	// });

	var oEditors3 = [];

	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

	// nhn.husky.EZCreator.createInIFrame({
	// 	oAppRef: oEditors3,
	// 	elPlaceHolder: "training_type3_content",
	// 	sSkinURI: "/common/SmartEditor2Skin.do",
	// 	htParams : {
	// 		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	// 		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	// 		bUseModeChanger : true,		// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	// 		page_type : "training",			//file.upload.path 경로를 template  or training 폴더로 할 것인지 결정
	// 		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
	//
	// 		fOnBeforeUnload : function(){
	// 			//alert("완료!");
	// 		}
	// 	}, //boolean
	// 	fOnAppLoad : function(){
	// 		//예제 코드
	// 		//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	// 		if(training_type3 == "Y"){
	// 			$("#tabs3").show();
	// 			$("#tabs3").removeClass("active");
	// 		}else{
	//
	// 			$("#tabs3").hide();
	// 		}
	//
	// 		$("#tabs-3").hide();
	//
	// 		training_type3_upload_file_type_selected();
	// 	},
	// 	fCreator: "createSEditor2"
	// });
	
	</c:when>
</c:choose>

	function training_user_modfiy(row)
	{		
		var email 			= row.email;
		var name 			= row.name;
		var department 	= row.department_name;
		var unikey 			= row.unikey;
		
		var title = "훈련대상자 수정";
		
		var message ="";
		message = message + "<div>";
		message = message + "		<span style='width:80px;float:left'>email</span>		<span width='*'><input type='text' class='input-xlarge' name='val1' value=\""+email+"\"></span><br>";
		message = message + "		<span style='width:80px;float:left'>이름</span>			<span width='*'><input type='text' class='input-xlarge' name='val2' value=\""+name+"\"></span><br>";
		message = message + "		<span style='width:80px;float:left'>부서</span>			<span width='*'><input type='text' class='input-xlarge' name='val3' value=\""+department+"\"></span><br>";
		message = message + "		<span style='width:80px;float:left'>사번/아이디</span>	<span width='*'><input type='text' class='input-xlarge' name='val4' value=\""+unikey+"\"></span><br>";
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
							        
									 //Pattern p = Pattern.compile(regex);
									 //Matcher m = p.matcher(email);
							    	
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
							    	
							    	row['email'] = val1;
							    	row['name'] = val2;
							    	row['department_name'] = val3;
							    	row['unikey'] = val4;
							    	
							    	one_grid_modfiy(row);
							    	
							    	$("#total_user").html( total_grid_number());
							    	
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
	**/
	function training_user_del(obj)
	{
		if(confirm('해당 훈련 대상자를 삭제하시겠습니까?'))
		{
			one_grid_delete(obj.id);		
			
			$("#total_user").html( total_grid_number());
		}
	}
	
	function training_type3_file_exe_type_selected()
	{
		if($("select[name='training_type3_file_exe_type']").val()=="msg"){
			$("#div_training_type3_content").hide();
			$("#div_training_type3_exe_content").show();
		}else{
			$("#div_training_type3_content").hide();
			$("#div_training_type3_exe_content").hide();	
		}
	}
	
	
	<!--체크박스(수집정보)-->
	$(function() {	
		
		/**
		file type 3 변경 이벤트 
		**/
		$('#training_type3_file_type').focus(function() 
		{
		    prev_val = $(this).val();
		}).change(function() {
		    
			$(this).blur();
		    var success = confirm('첨부파일 타입변경을 진행하면 이전 작성내용은 초기화 됩니다.');
		    
		    if(success)
		    {
		    	training_type3_upload_file_type_selected();
		    }  
		    else
		    {
		        $(this).val(prev_val);
		        return false; 
		    }
		});
				
		/**
		exe file sub type 3 변경 이벤트 
		**/
		$('#training_type3_file_exe_type').focus(function() 
		{
		}).change(function() {
			
			training_type3_file_exe_type_selected();
		  
		});
				
		<c:choose>
			<c:when test="${pageType eq 'insert'}">
				createUserFields();
				addUserfush(rDate_val);
			</c:when>
			<c:when test="${pageType eq 'update'}">
				createUserFields();
				<c:forEach var="trainingUserList" items="${trainingUserList}" varStatus="status">
					<c:choose>
						<c:when test="${training_detail.status != 'ready'}">
							var send_status="<c:out value="${trainingUserList.status}"/>";
							
							if(send_status == "ready"){
								send_status = "발송대기";
							}else if(send_status == "nosend"){
								send_status = "발송안함";
							}else if(send_status == "end"){
								send_status = "발송완료";					
							}else{
								send_status = "-";					
							}							
							rDate_val[${status.index}] ={email: '${trainingUserList.email}',name: '${trainingUserList.name}', department_name: '${trainingUserList.department_name}', unikey: '${trainingUserList.unikey}',status: send_status};
						</c:when>
						<c:otherwise>					
							rDate_val[${status.index}] ={email: '${trainingUserList.email}',name: '${trainingUserList.name}', department_name: '${trainingUserList.department_name}', unikey: '${trainingUserList.unikey}'};
						</c:otherwise>
					</c:choose>
				</c:forEach>				
				addUserfush(rDate_val);				
				
				<!--check box-->
				<c:choose>
					<c:when test="${training_detail.training_type1 == 'Y'  and training_detail.training_type2 == 'Y'  and training_detail.training_type3 == 'Y' }">
							$("input[name='traing_all']").prop("checked",true);
							$("input[name='training_type1']").prop("checked",true);
							$("input[name='training_type2']").prop("checked",true);
							$("input[name='training_type3']").prop("checked",true);
					</c:when>
					<c:otherwise>
						
						<c:if test="${training_detail.training_type1 == 'Y' }">
							$("input[name='training_type1']").prop("checked",true);
						</c:if>
						<c:if test="${training_detail.training_type2 == 'Y' }">
							$("input[name='training_type2']").prop("checked",true);
						</c:if>
						<c:if test="${training_detail.training_type3 == 'Y' }">
							$("input[name='training_type3']").prop("checked",true);
						</c:if>
					
					</c:otherwise>
				</c:choose>
				
			</c:when>
			
		</c:choose>
		
		<c:choose>
			<c:when test="${(pageType eq 'update' and !(training_detail.status=='ready')) }">
				collection_info(1);
				collection_info(2);
				collection_info(3);
				tabs(1);
			</c:when>
		</c:choose>
		
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
				
	});
	
	var maxcnt= <%=EgovProperties.getProperty("Globals.training.max.user.count") %>
		
	//slick grid 필드 생성
	function createUserFields(){
		
		var fields=[];
		
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
	function addUserfush(rdata){
		//데이터 삽입
		setSlickData_first(rdata);
		
		//slick grid 생성
		create_slick_grid("#userlist");
		
		setSort_one_table();
		if(pageType == "insert" || status ==  "ready" || status== "step1"){
			//등록 , 수정 버튼 이벤트 추가
			set_btn_update_delete_event();
		}
		
		$("#total_user").html(total_grid_number());		
	}	
	
	//발신자 추가
	function pop_training_user()
	{
		url = '<c:url value="/training/training_add_user_pop.do"/>';
   		fn_openwindow(url,  '800px', '600px', 'pop_institution_list');
    	
	}
		

	function view(code) 
	{
		location.href = "/system/memberForm.do?code=" + code;
	}
	
		
	$(function() {
		
		
		percent_calcul();
		
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
				
				if(id==2 && (pageType == 'insert' || ( pageType == 'update' && status=='ready'))){
					
					// oEditors2.getById["training_type2_content"].exec("REFRESH_WYSIWYG");
	    			// oEditors2.getById["training_type2_content"].exec("CHANGE_EDITING_MODE", ["HTMLSrc"]);
	        		// oEditors2.getById["training_type2_content"].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
					
				}else if(id==3 && (pageType == 'insert' || ( pageType == 'update' && status=='ready'))){
					
					// oEditors3.getById["training_type3_content"].exec("REFRESH_WYSIWYG");
	    			// oEditors3.getById["training_type3_content"].exec("CHANGE_EDITING_MODE", ["HTMLSrc"]);
	        		// oEditors3.getById["training_type3_content"].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
					
				}
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
				$("#tabs-2").hide();
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
				$("#tabs-3").hide();
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
							        	
							        	var sHTML = "<a href='#link_url#' target='_blank'>"+inputbox+"</a>";
										setCkEditorHtmlContent('send_content', sHTML)

							    		// oEditors.getById["send_content"].exec("PASTE_HTML", [sHTML]);
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
			$("input[name='json_userlist']").val( JSON.stringify(slick_data));	
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
			
			//url이동 설정(url이동시 표시될 내용)
			
			
			if($("input:checkbox[name='training_type2']").is(":checked")==true)
			{
				var check1 = getCkEditorContent('training_type2_content')
				
				if(check1.length<=11)
				{
					alert("url이동시 표시될 페이지 내용을 입력하여주시기 바랍니다.");
					return ;
				}
			}
			
			
			//확장자 체크
			if($("input:checkbox[name='training_type3']").is(":checked")==true)
			{
				if($("input[name='training_type3_file_name']").val()=="")
				{
					alert('파일 확장자를 입력하주세요!');
					return ;
				}
				else
				{
					var ext = $("input[name='training_type3_file_name']").val().split('.').pop().toLowerCase();
					if($("select[name='training_type3_file_type']").val()!=ext)
					{
						alert("해당 파일 확장자는 '" + $("select[name='training_type3_file_type']").val() +"' 를 사용하셔야합니다.");
						return ;
					}
				}
				
				if(getCkEditorContent('training_type3_content').length<=11 && $("select[name='training_type3_file_type']").val()!="exe" )
				{
					alert("점부파일에 표시될 내용을 입력하여주시기 바랍니다.");
					return ;
				}
				
				if($("select[name='training_type3_file_type']").val()=="exe" )
				{
					if($("select[name='training_type3_file_exe_type']").val()==""){
						alert("exe 파일에 대한 동작을 선택해주시기 바랍니다.");
						return ;	
					}
					
					if($("textarea[name='training_type3_exe_content']").val().length <= 11 && $("select[name='training_type3_file_exe_type']").val()=="msg"){
						alert("점부파일에 표시될 내용을 입력하여주시기 바랍니다.");
						return ;	
					}
				}
				
			}
			
			if(ban_tag_valid($("input[name='title']").val())){
	    		alert("이메일 제목에 큰따옴표는 입력할 수 없습니다.");
	        	return ;
	    	}
			
			if(ban_tag_valid($("input[name='send_name']").val())){
	    		alert("이메일 발신자이름에 큰따옴표는 입력할 수 없습니다.");
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
			
			// oEditors.getById["send_content"].exec("UPDATE_CONTENTS_FIELD", []);
			// oEditors2.getById["training_type2_content"].exec("UPDATE_CONTENTS_FIELD", []);
			// oEditors3.getById["training_type3_content"].exec("UPDATE_CONTENTS_FIELD", []);
			
			if(confirm("훈련을 생성하시겠습니까?")){
				$('#overlay').show(); 
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
	템플릿 선택 창 팝업
	**/
	function select_template_popup()
	{
		url = "/training/template_select_popup.do";
		width="1224";
		height ="600";
		page_id = "template_select_popup";
		var popup = fn_openwindow(url, width, height, page_id);
	}
	
	/**
	이미지 파일 업로드
	**/
	function imgUploadForm_popup()
	{
		url = "/training/imgUploadForm_popup.do";
		width="750";
		height ="600";
		page_id = "imgUploadForm_popup";
		var popup = fn_openwindow(url, width, height, page_id);
	}
	
	/**
	* 
	**/
	function setTrainingType3Image(code, imgUrl)
	{
		if(imgUrl!="")
		{
			imgview = "<img src='"+imgUrl+"' id='training_type3_image_object' style='height:100px;width:auto;' >";
			imgview_content = "<img src='"+imgUrl+"' >";
			$("#training_type3_upload_image").html(imgview);

			setCkEditorContent('training_type3_content', imgview)
			// oEditors3.getById["training_type3_content"].exec("SET_CONTENTS", [imgview]);
			
		}
	}
	
	function mover(obj)
	{
		img = "<img src='"+obj.src+"' id='view_img'>";
		$("#training_type3_upload_image_rollover").html(img);
		$("#training_type3_upload_image_rollover").css("top",""+"50"+"px");
		$("#training_type3_upload_image_rollover").show();
	}
	
	function mout(obj)
	{
		$("#training_type3_upload_image_rollover").hide();
	}
	 
	function training_type3_upload_file_type_selected()
	{
		$("#training_type3_upload_image_rollover").hide();
    	
		//html은 text를 이용하여 작성가능해야함 그외의 것들은 이미지 첨부로 대체함.
		if($("select[name='training_type3_file_type']").val()=="html" || $("select[name='training_type3_file_type']").val()=="doc")
		{
			$("#div_training_type3_content").show();
			$("#div_training_type3_file_name").show();
			$("#div_training_type3_uploadFile").hide();
			$("#training_type3_file_exe_type").hide();
			$("select[name='training_type3_file_exe_type']").val("");
			$("#div_training_type3_exe_content").hide();	
			
			// oEditors3.getById["training_type3_content"].exec("REFRESH_WYSIWYG");
  			// oEditors3.getById["training_type3_content"].exec("CHANGE_EDITING_MODE", ["HTMLSrc"]);
      		// oEditors3.getById["training_type3_content"].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
		}
		else if($("select[name='training_type3_file_type']").val()=="hwp" || $("select[name='training_type3_file_type']").val()=="xls")
		{
			$("#training_type3_upload_image_rollover").show();
			$("#div_training_type3_content").hide();
			$("#div_training_type3_file_name").show();
			$("#div_training_type3_uploadFile").show();
			$("#training_type3_file_exe_type").hide();
			$("select[name='training_type3_file_exe_type']").val("");
			$("#div_training_type3_exe_content").hide();	
		}else{ //첨부파일 타입이 exe일 경우
			$("#div_training_type3_content").hide();
			$("#div_training_type3_file_name").show();
			$("#div_training_type3_uploadFile").hide();
			$("#training_type3_file_exe_type").show();
			if($("select[name='training_type3_file_exe_type']").val()=="msg"){
				$("#div_training_type3_exe_content").show();		
			}
		}
	}
	
	/**
	훈련삭제
	**/
	function deleteTraining()
	{
		var frm = document.getElementById("frm");		
		
		if (confirm("정말 삭제하시겠습니까?\n삭제를 진행하면 복구는 불가능 합니다. \n신중하게 신행해주시기 바랍니다.") == true)
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
		<c:when test="${pageType eq 'update' and training_detail.status=='ready'}">
	</c:when>
	<c:otherwise>
		$(function() {
			//입력 폼 disable
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
			
			$('#template_view').attr("onclick",  null);
			
			$('#searchBgnDe').prop('disabled', true);
			
		});
		</c:otherwise>
	</c:choose>
	
	
	function pop_training_single_adduser()
	{
		if(total_grid_number() > maxcnt){
			alert("총 훈련 대상자 수 "+maxcnt +"명을 초과할 수 없습니다.");				
		}else{
			
			var title = "훈련대상자 추가";
			
			var message ="";
			message = message + "<div>";
			message = message + "		<span style='width:80px;float:left'>email</span>		<span width='*'><input type='text' class='input-xlarge' name='val1'></span><br>";
			message = message + "		<span style='width:80px;float:left'>이름</span>			<span width='*'><input type='text' class='input-xlarge' name='val2'></span><br>";
			message = message + "		<span style='width:80px;float:left'>부서</span>			<span width='*'><input type='text' class='input-xlarge' name='val3'></span><br>";
			message = message + "		<span style='width:80px;float:left'>사번/아이디</span>	<span width='*'><input type='text' class='input-xlarge' name='val4'></span><br>";
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
								    	var val5 = "";
								    	
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
								    	
								   		var val_arr=[];
								   		
								   		val_arr.push(val1);
								   		val_arr.push(val2);
								   		val_arr.push(val3);
								   		val_arr.push(val4);
								   		
								   		//slick grid에 행추가
								    	one_grid_append(val_arr);
								   		
								    	$("#total_user").html(total_grid_number());
								    	
								        dialogRef.close();
								        
								        send_num_init();
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
	본문미리보기
	**/
	function contentView()
	{
		preViewHtml($('#send_content').text(),"본문 미리보기","");	
	}
	
	/**
	exe 예시 내용 적용
	**/
	function insertexecontent()
	{
		$("textarea[name='training_type3_exe_content']").val("        \“실제였다면 귀하의 PC는 감염되었을 것 입니다!\”\n\n"
			+"======2018년 000000000 해킹메일 대응 모의훈련======\n"
			+"본 메일과 첨부파일은 해킹메일 대응 모의훈련과 관련하여\n "
			+"발송한 훈련용 메일입니다.\n"
			+"본 메일과 첨부파일은 사용자 PC에 어떠한 영향도 주지 않습\n"
			+"니다.\n"
			+"※ 전자메일(e-mail)사용 시 주의사항\n"
			+"1. 출처가 불분명한 메일은 열람하지 말고 삭제\n"
			+"- 메일 열람 전 발신자 주소 필히 확인\n"
			+"2. 메일을 열람하더라도 URL 링크 등은 절대 클릭하지 말 것\n"
			+"3. 첨부파일을 저장하거나 실행하지 말 것\n"
			+"4. 저장을 하거나 실행한 경우 반드시 지정된 백신으로 검사\n"
			+"를 실시할 것.\n"
			+"각종 바이러스 및 악성코드의 감염은 개인의 철저한 보안준\n"
			+"수를 통하여 예방할 수 있습니다.\n"
			+"앞으로도 정보보안에 계속적인 관심을 기울여 주시기 바랍니\n"
			+"다.\n\n"
			+"문의전화 : 042-000-0000(담당주무관), \n"
			+"                042-000-0000(사이버안전센터)\n\n"
			+"============000000000 사이버안전센=============");

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
			var listcnt =  total_grid_number();
			
			
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
			
		}else		
			return false;
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
	
	function percent_calcul(){
	
		if($("input:checkbox[name='all_send_type_chk']").is(":checked")==false)
		{
			var num=$("input[name='send_number']").val();
			var result=0;
			var listcnt=	total_grid_number();
			
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
			var param= "end_date="+$("input[name='end_date']").val();		
			param += "&code="+$("input[name='code']").val();	
			
			//훈련기간 체크
			if($("#searchEndDe").val()=="")
			{
				alert('훈련 종료일을 입력하여주세요!');
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
	
	/**
	 * training 전용 이벤트 추가 폼 
	 * @param row
	 */
	function set_btn_update_delete_event()
	{
		if(slick_grid != null && slick_grid !=""){
			 //button event
			slick_grid.onClick.subscribe(function (e, args) {
		    	if ($(e.target).hasClass("btn")) {
		    		var item = slick_dataView.getItem(args.row);
		    		 
		    		if($(e.target).attr('id') == "mod"){
			  			 training_user_modfiy(item);
		    		}else if($(e.target).attr('id') == "del"){
		    			training_user_del(item);
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