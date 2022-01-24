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

	<!-- navi -->
	<ul class="breadcrumb">
		<li><i class="fa-icon-home"></i> Home / <strong>훈련 템플릿 관리</strong>
		</li>
	</ul>

	<div class="panel panel-default">



		<form name="frm" id="frm" method="post"  enctype="multipart/form-data">

		<div class="row-fluid">

				<div class="box span12">
					<div class="box-header">
						<h2>
							<i class="fa-icon-user"></i><span class="break"></span>훈련 템플릿 관리
						</h2>
					</div>
					<div class="box-content">

						<div class="form-horizontal span6">

							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />기관선택</label>
							  <div class="controls">

							  		<c:choose>
							  			<c:when test="${userInfo.lev=='admin' }">
							  				<select name='institution_code' class="fl">
							  					<c:choose>
							  						<c:when test="${detail.institution_code eq null or  detail.institution_code eq '' }">
							  							<option value="" selected='selected'>기관공통</option>
							  						</c:when>
							  						<c:otherwise>
							  							<option value="">기관공통</option>
							  						</c:otherwise>
							  					</c:choose>
												<c:forEach var="institutionList" items="${institutionList}" varStatus="status">
													<c:choose>
														<c:when test="${ detail.institution_code eq institutionList.code}">
															<option value="<c:out value="${institutionList.code}"/>" selected="selected"><c:out value="${institutionList.institution_name}"/></option>
														</c:when>
														<c:otherwise>
															<option value="<c:out value="${institutionList.code}"/>"><c:out value="${institutionList.institution_name}"/></option>
														</c:otherwise>
													</c:choose>

							       		 		</c:forEach>
							       		 	</select>

							  			</c:when>
							  			<c:otherwise>
							  				<select name='institution_code'  class="fl">
							  					<c:forEach var="institutionList" items="${institutionList}" varStatus="status">
							  						<c:choose>
														<c:when test="${ detail.institution_code eq institutionList.code}">
															<option value="<c:out value="${institutionList.code}"/>" selected="selected"><c:out value="${institutionList.institution_name}"/></option>
														</c:when>
														<c:otherwise>
															<option value="<c:out value="${institutionList.code}"/>"><c:out value="${institutionList.institution_name}"/></option>
														</c:otherwise>
													</c:choose>
							       		 		</c:forEach>
							       		 	</select>

							  			</c:otherwise>
							  		</c:choose>


							  </div>
							</div>


							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />템플릿 카테고리 선택</label>
							  <div class="controls">
							  	<c:choose>
									<c:when test="${pageType eq 'insert' }">

										<select name='cate_code' required='required' class="fl" >
											<c:forEach var="templateCateList" items="${templateCateList}" varStatus="status">
												<option value="<c:out value="${templateCateList.code}"/>"><c:out value="${templateCateList.cate_name}"/></option>
						       		 		</c:forEach>
						       		 	</select>

									</c:when>

									<c:when test="${pageType eq 'update'}">
											<input type="hidden" name='code' value='${detail.code }'>
											<input type="hidden"name='pageType' value='${pageType}'>

											 <select name='cate_code' required='required' class="fl" >
												<c:forEach var="templateCateList" items="${templateCateList}" varStatus="status">
													<option value="<c:out value="${templateCateList.code}"/>" <c:if test="${ templateCateList.code == detail.cate_code}"> selected </c:if>><c:out value="${templateCateList.cate_name}"/></option>
								       		 	</c:forEach>
								       		 </select>

									</c:when>

								</c:choose>
							  </div>
							</div>

							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />템플릿 명</label>
							  <div class="controls">
							  	<input style="width: 200px" type='text' name='template_name' required='required' class="fl" value="<c:if test="${pageType=='update'}"><c:out value="${detail.template_name }"/></c:if>">
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
								  	<input type="radio" name="register_type" id='register_type' value="y" <c:if test="${detail.register_type=='y'}"> checked </c:if>>사용
								  	<input type="radio" name="register_type" id='register_type' value="n" <c:if test="${detail.register_type=='n'}"> checked </c:if>>사용안함
							 	</c:if>

							  </div>
							</div>
						</div>



						<div class="form-horizontal span6">

							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />이메일제목</label>
							  <div class="controls">
							  		<input style="width: 200px" type='text' name='title' required='required' class="fl" value="<c:if test="${pageType=='update'}"><c:out value="${detail.title}"/></c:if>">
							  </div>
							</div>

							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />이메일발신자 이름</label>
							  <div class="controls">
							  	<input style="width: 200px" type='text' name='send_name' required='required' class="fl" value="<c:if test="${pageType=='update'}"><c:out value="${detail.send_name }"/></c:if>">
							  </div>
							</div>


							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />발신이메일</label>
							  <div class="controls">
							  	<input style="width: 200px" type='email' name='send_email' maxlength="40" required='required' class="fl" value="<c:if test="${pageType=='update'}"><c:out value="${detail.send_email }"/></c:if>">
							  </div>
							</div>



							<div class="control-group">


							  <%if(EgovProperties.getProperty("Globals.training.del.manual").equals("0")){ %>
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />삭제타입</label>
							  <div class="controls">

							  	<c:if test="${pageType=='insert'}">
							  		<input type="radio" name="del_type" id='del_type' value="m" checked>수동
							  		<input type="radio" name="del_type" id='del_type' value="a" >자동
							  	</c:if>

							  	<c:if test="${pageType=='update'}">
							  	  	<input type="radio" name="del_type" id='del_type' value="m" <c:if test="${detail.del_type=='m'}"> checked="checked" </c:if>>수동
							  		<input type="radio" name="del_type" id='del_type' value="a" <c:if test="${detail.del_type=='a'}">checked="checked" </c:if>>자동
							 	</c:if>
							  	<p id="del_type_comment">
							  		수동삭제시 <%=EgovProperties.getProperty("Globals.training.del.manual") %>일이후 자동삭제됨.
							  	</p>

							  </div>
							  <%}else{ %>
							  	<input type='hidden' name='del_type' id='del_type' value='m'/>
							  <%} %>




							</div>

						</div>

						<div class="clearFix"></div>

						<div class="form-horizontal ">

							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />발신내용</label>


								<div class="controls">
									<textarea id="send_content" name="send_content"></textarea>

<%--									<textarea name="send_content" id="send_content" required='required' class="fl" rows="10" cols="100" style="width:100%; height:412px; display:none;"><c:if test="${pageType=='update'}"><c:out value="${detail.send_content }"/></c:if></textarea>--%>

							  	<p>
							  		<button type="button" class="btn btn-info" onClick='addLink();'>본문에 링크 추가</button>
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
										<li><input name="traing_all" 				type="checkbox" id="traing_all" 			value="Y" onclick="collection_info('0');">전체&nbsp;&nbsp;</li>
										<li><input name="training_type1"	 	type="checkbox" id="training_type1" 	value="Y" onclick="collection_info('1');" checked>메일열람&nbsp;&nbsp;</li>
										<li><input name="training_type2" 		type="checkbox" id="training_type2" 	value="Y" onclick="collection_info('2');">링크(URL)실행&nbsp;&nbsp;</li>
										<li><input name="training_type3" 		type="checkbox" id="training_type3" 	value="Y" onclick="collection_info('3');">첨부파일 실행&nbsp;&nbsp;</li>
									</ul>
									</div>
							  </div>
						</div>
					</div>
					<ul class="nav nav-tabs2" >
						<li id="tabs2" onClick="tabs('2');"  role="presentation" style="display: none;">URL 이동 설정</li>
						<li id="tabs3" onClick="tabs('3');"  role="presentation" style="display: none;">첨부파일 설정</li>
					</ul>



					<div id="tabs-2" >
					<!-- 네베 마그넷 -->
					 <p class="blue">※ 메일 링크 클릭시</p>

					 <p class="blue">
					 	※ 피싱을 사용하기 위해서는 입력창의 시작(#s_custom_form#) 과 끝(#e_custom_form#) 을 입력해주시고
					 	, 이동 버튼에 #action_button_script#를 onClick 이벤트 또는 href 에 입력해주시기 바랍니다.
					 	입력tag (input 의 name은 (t_userId,t_passwd,t_01,t_02,t_03,t_04,t_05)을 입력하여야 합니다.


					 </p>
					<br>
                    <textarea id="training_type2_content" name="training_type2_content"></textarea>
<%--					<textarea name="training_type2_content" id="training_type2_content" rows="10" cols="100" style="width:100%; height:500px;"><c:if test="${pageType=='update'}"><c:out value="${detail.training_type2_content }"/></c:if></textarea>--%>
					</div>
					<div id="tabs-3" >
					<div class="form-horizontal ">

							<div class="control-group">
							  <label class="control-label" for="typeahead">첨부 파일 타입 설정</label>
							  <div class="controls">
							  		<select name='training_type3_file_type' id='training_type3_file_type'>
										<option value='html'  	<c:if test="${pageType=='update' and detail.training_type3_file_type=='html' }"> selected </c:if>>html</option>
										<option value='hwp'		<c:if test="${pageType=='update' and detail.training_type3_file_type=='hwp' }"> selected </c:if>>hwp</option>
										<option value='doc'		<c:if test="${pageType=='update' and detail.training_type3_file_type=='doc' }"> selected </c:if>>doc</option>
										<option value='xls'		<c:if test="${pageType=='update' and detail.training_type3_file_type=='xls' }"> selected </c:if>>xls</option>
										<option value='exe'		<c:if test="${pageType=='update' and detail.training_type3_file_type=='exe' }"> selected </c:if>>exe</option>
									</select>

									<select name='training_type3_file_exe_type' id='training_type3_file_exe_type' style="display:none">
										<option value=''>동작선택</option>
										<option value='default'  	<c:if test="${pageType=='update' and detail.training_type3_file_exe_type=='default' }"> selected </c:if>>동작 없음</option>
										<option value='scr'			<c:if test="${pageType=='update' and detail.training_type3_file_exe_type=='scr' }"> selected </c:if>>화면보호기 실행</option>
										<option value='msg'			<c:if test="${pageType=='update' and detail.training_type3_file_exe_type=='msg' }"> selected </c:if>>메세지 창 출력</option>
									</select>
							  </div>
							</div>

							<div class="control-group" id="div_training_type3_file_name">
							  <label class="control-label" for="typeahead">파일이름</label>
							  <div class="controls">
							  		<input type='text' name='training_type3_file_name' value="<c:if test="${pageType=='update'}"><c:out value="${detail.training_type3_file_name }"/></c:if>">
							  		파일이름 입력시 확장자 까지 같이 입력해주셔야합니다!
							  </div>
							</div>

							<div class="control-group" id="div_training_type3_content">
							  <label class="control-label" for="typeahead">표시될 내용</label>
							  <div class="controls">
<%--							  		<textarea name="training_type3_content" id="training_type3_content" rows="10" cols="100" style="width:100%; height:412px;"><c:if test="${pageType=='update'}"><c:out value="${detail.training_type3_content }"/></c:if></textarea>--%>
							    <textarea id="training_type3_content" name="training_type3_content"></textarea>
							  </div>
							</div>

							<div class="control-group" id="div_training_type3_exe_content" style="display:none">
							  <label class="control-label" for="typeahead">표시될 내용</label>

							  <div class="controls">
							  		<textarea name="training_type3_exe_content" id="training_type3_exe_content" rows="10" cols="63"  wrap="physical" style="width:330px; height:412px;""><c:if test="${pageType=='update'}"><c:out value="${detail.training_type3_exe_content }"/></c:if></textarea>
							 		<button type="button" class="btn btn-info" onClick="insertexecontent();">&lt 예시 적용</button>
							  </div>

							</div>

							<div class="control-group" id="div_training_type3_uploadFile" style="display:none">
							  <label class="control-label" for="typeahead">파일 업로드</label>
							  <div class="controls">
							  	<div>
							  		<div id="div_training_type3_uploadFile_img"></div>
							  		<table width='100%' border="0" style="padding:10px; margin:10px;">
							  			<tr>
							  				<td width='*'>
										  		해당 선택된 파일 확장자에 사용할 img(jpg, png, gif)파일을 선택해주세요.
										  		<br>
										  		<button type="button" class="btn btn-info" onClick='imgUploadForm_popup();'>이미지 파일 업로드</button>
							  				</td>
							  			</tr>
							  			<Tr>
							  				<td>
							  					<br>
							  					<div id="training_type3_upload_image">
							  						<c:if test="${pageType=='update' && (detail.training_type3_file_type=='hwp' || detail.training_type3_file_type=='xls') }">
							  							<c:out value="${detail.training_type3_content }" escapeXml="false"/>
							  						</c:if>
							  					</div>
							  					<div id="training_type3_upload_image_rollover" style="position: absolute;">
							  					</div>
							  				</td>
							  			</Tr>
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
								<c:when test="${pageType eq 'update'}">
									<a href='#' onClick='send()' class="btn">수정</a>
									<c:choose>
										<c:when test="${detail.lev == 'admin' ||detail.lev_use =='Y' }">
											<a href='#' onClick="delete_template();" class="btn">삭제</a>
										</c:when>
									</c:choose>
								</c:when>
							</c:choose>
							<a href='/system/templateList.do' class="btn">리스트</a>
						</div>
						<div class="clearFix"></div>
					</div>


		</div>
		</form>
		</div>
	</div>
</div>

<%-- create ckeditor --%>
<script src="${pageContext.request.contextPath}/js/training/training-ckeditor.js"></script>
<script>

	var pageType = '<c:out value="${pageType}"/>'
	createCkEditorTemplate();
    var training_type1="<c:out value="${detail.training_type1}"/>";
    var training_type2="<c:out value="${detail.training_type2}"/>";
    var training_type3="<c:out value="${detail.training_type3}"/>";
	if(pageType === 'update'){
	setCkEditorContent('send_content', `${detail.send_content}`)
		console.log(training_type2)
		if(training_type2 == "Y"){

			console.log(`${detail.training_type2_content }`)
			setCkEditorContent('training_type2_content', `${detail.training_type2_content }`)
		}
		if(training_type3 == "Y"){
			setCkEditorContent('training_type3_content', `${detail.training_type3_content}`)
		}
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










<%--<script type="text/javascript" src="/js/HuskyEZCreator.js" charset="utf-8"></script>--%>








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
		    var success = confirm('첨부파일  타입변경을 진행하면 이전 작성내용은 초기화 됩니다.');

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

		<c:choose>
			<c:when test="${pageType eq 'update'}">
				<c:choose>
					<c:when test="${detail.training_type1 == 'Y'  and detail.training_type2 == 'Y'  and detail.training_type3 == 'Y' }">
							$("input[name='traing_all']").prop("checked",true);
							$("input[name='training_type1']").prop("checked",true);
							$("input[name='training_type2']").prop("checked",true);
							$("input[name='training_type3']").prop("checked",true);
					</c:when>
					<c:otherwise>

						<c:if test="${detail.training_type1 == 'Y' }">
							$("input[name='training_type1']").prop("checked",true);
						</c:if>
						<c:if test="${detail.training_type2 == 'Y' }">
							$("input[name='training_type2']").prop("checked",true);
						</c:if>
						<c:if test="${detail.training_type3 == 'Y' }">
							$("input[name='training_type3']").prop("checked",true);
						</c:if>

					</c:otherwise>
				</c:choose>

			</c:when>
		</c:choose>



		$("#frm").validate({

			rule: {

				template_name:{
					required:true
				}, title:{
					required:true
				}, send_name:{
					required:true
				}, send_email:{
					required:true
					, email: true
				}, send_content:{
					required:true
				}
			},
			messages: {
				template_name:{
					required:"훈련명을 입력하세요"
				},
				title:{
					required:"이메일 제목을 입력하세요"
				},
				send_name:{
					required:"발신자 이름을 입력하세요"
				},
				send_email: {
					required:"발신이메일을 입력하세요"
					, email : "이메일 양식에 맞게 입력하주시기바랍니다."
				},
				send_content:{
					required:"내용을 입력하세요"
				}
			}
		});




	});


var oEditors = [];

//추가 글꼴 목록
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

// nhn.husky.EZCreator.createInIFrame({
// 	oAppRef: oEditors,
// 	elPlaceHolder: "send_content",
// 	sCSSBaseURI:"/css/",
// 	sSkinURI: "/common/SmartEditor2Skin.do",
//
// 	htParams : {
// 		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
// 		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
// 		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
// 		page_type : "template",			//file.upload.path 경로를 template  or training 폴더로 할 것인지 결정
//  		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
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
// 		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
// 		page_type : "template",			//file.upload.path 경로를 template  or training 폴더로 할 것인지 결정
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

// var oEditors3 = [];

//추가 글꼴 목록
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

// nhn.husky.EZCreator.createInIFrame({
// 	oAppRef: oEditors3,
// 	elPlaceHolder: "training_type3_content",
// 	sSkinURI: "/common/SmartEditor2Skin.do",
// 	htParams : {
// 		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
// 		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
// 		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
// 		page_type : "template",			//file.upload.path 경로를 template  or training 폴더로 할 것인지 결정
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
// 			$("#tabs3").hide();
// 		}
//
// 		$("#tabs-3").hide();
// 		training_type3_upload_file_type_selected();
// 	},
// 	fCreator: "createSEditor2"
// });





	function view(code)
	{
		location.href = "/system/memberForm.do?code=" + code;
	}
	$(function() {

		<%if(EgovProperties.getProperty("Globals.training.del.manual").equals("0")){ %>
		//삭제 타입 선택시 내용 고지 및 값 변경
		$('input[type=radio][name=del_type]').change(function() {
	        if (this.value == 'm') {
	            $("#del_type_comment").show();
	        }
	        else if (this.value == 'a') {
	        	if(confirm("자동선택시 <%=EgovProperties.getProperty("Globals.training.del.auto")%>일 이후에 자동으로 훈련대상자 정보가 자동삭제됩니다.")==false)
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


	});

	function tabs(id)
	{

		for(i=2;i<4;i++)
		{
			temp_tab = "tabs"+i;
			tab_id = "tabs"+id;
			div_id = "tabs-"+i;
			if(temp_tab==tab_id)
			{
				$("#"+tab_id).addClass("active");
				$("#"+div_id).show();

				if(id==2){
					// oEditors2.getById["training_type2_content"].exec("REFRESH_WYSIWYG");
	    			// oEditors2.getById["training_type2_content"].exec("CHANGE_EDITING_MODE", ["HTMLSrc"]);
	        		// oEditors2.getById["training_type2_content"].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
				}else if(id==3){
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



	function filterAdd(type)
	{




	}


	function addLink()
	{

		var title = "";
		title = "본문추가 링크 이름";



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
							    		// oEditors.getById["send_content"].exec("PASTE_HTML", [sHTML]);
										setCkEditorHtmlContent('send_content', sHTML)
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
		var msg = "";
		<c:choose>
		<c:when test="${pageType eq 'insert' }">
			msg = "템플릿을 생성하시겠습니까?";
		</c:when>
		<c:when test="${pageType eq 'update'}">
			msg = "템플릿을 수정하시겠습니까?";
		</c:when>
	</c:choose>


		if($("#frm").valid())
		{
			var frm = document.getElementById("frm");
			frm.action = "<c:url value='/system/templateSave.do'/>";




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

				if(getCkEditorContent('training_type3_content').length<=11 && $("select[name='training_type3_file_type']").val()!="exe")
				{
					alert("첨부파일에 표시될 내용을 입력하여주시기 바랍니다.");
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

			if(ban_tag_valid($("input[name='template_name']").val())){
	    		alert("템플릿 명에 큰따옴표는 입력할 수 없습니다.");
	        	return ;
	    	}

			if(ban_tag_valid($("input[name='title']").val())){
	    		alert("이메일 제목에 큰따옴표는 입력할 수 없습니다.");
	        	return ;
	    	}
			if(ban_tag_valid($("input[name='send_name']").val())){
	    		alert("이메일 발신자이름에 큰따옴표는 입력할 수 없습니다.");
	        	return ;
	    	}

			// oEditors.getById["send_content"].exec("UPDATE_CONTENTS_FIELD", []);
			// oEditors2.getById["training_type2_content"].exec("UPDATE_CONTENTS_FIELD", []);
			// oEditors3.getById["training_type3_content"].exec("UPDATE_CONTENTS_FIELD", []);

			if(confirm(msg)){
				frm.submit();
			}


		}
		else
		{
			alert("입력값을 확인하세요");
		}
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

	function setTrainingType3Image(code, imgUrl)
	{
		if(imgUrl!="")
		{
			imgview = "<img src='"+imgUrl+"' id='training_type3_image_object' style='height:100px;width:auto;' >";
			$("#training_type3_upload_image").html(imgview);

			setCkEditorContent('training_type3_content', imgview)
			// oEditors3.getById["training_type3_content"].exec("SET_CONTENTS", [imgview]);

		}
		else
		{

		}
	}

	/**
	exe 예시 내용 적용
	**/
	function insertexecontent()
	{
		$("textarea[name='training_type3_exe_content']").val("        \“실제였다면 귀하의 PC는 감염되었을 것 입니다!\”\n\n"
			+"======2017년 000000000 해킹메일 대응 모의훈련======\n"
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

	/**
	해당 템플릿 삭제
	**/
	function delete_template()
	{
		var frm = document.getElementById("frm");

		if (confirm("해당 템플릿을 정말 삭제하시겠습니까?\n삭제된 템플릿은 복구는 불가능 합니다. 신중하게 신행해주시기 바랍니다.") == true)
		{
			frm.action = "<c:url value='/system/template_del.do'/>";
			frm.submit();
		}
	}
</script>

<c:import url="/common/pageLink.do?link=inc/bottom_layout" />