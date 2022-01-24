<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="kr.nshare.common.util.EgovProperties"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_pop_layout" />
<script type="text/javascript" src="../../../js/ckeditor/ckeditor.js"></script>

<div class="pop_header">
	<h2><i class="fa-icon-sign-blank"></i><span class="break"></span> 템플릿선택</h2>
</div>
	<div class="container-fluid">
			<div class="row-fluid">
					<div class="box-content span12">
	       		 	 <form class="form-horizontal" role="form" name='frm' method='post' enctype="multipart/form-data">
	       		 		<table class="table table-bordered table-striped">
	       		 		<colgroup>
	       		 			<col width="100px">
	       		 			<col width="*">
	       		 			<col width="220px">
	       		 		</colgroup>
	       		 		 <tbody>
	       		 		 	<tr>
	       		 		 		<td colspan="3">
		       		 		 		이미 검증된 템플릿을 통해 원활하고 쉽게 훈련을 생성할수있또록 가이드 해주는 기능입니다.
	       		 		 		</td>
	       		 		 	</tr>
	       		 		 	<tr>
	       		 		 		<th>대상등록</th>
	       		 		 		<td>
	       		 		 		<select name='cate_code' onchange="selectCateCode(this.value);">
	       		 		 				<c:forEach var="cateList" items="${cateList}" varStatus="status">
	       		 		 						<option value="<c:out value="${cateList.code}"/>" <c:if test="${searchVO.cate_code eq cateList.code }"> selected </c:if>><c:out value="${cateList.cate_name}"/></option>
										</c:forEach>
	       		 		 		</select>
	       		 		 		
	       		 		 		<span id='tempalte_code_div'>
	       		 		 			<select name='template_code' id='template_code'>
		       		 		 			<option value=''>카테고리를 선택해주세요.</option>
		       		 		 			<c:forEach var="templateList" items="${templateList}" varStatus="status">
	       		 		 						<option value="<c:out value="${templateList.code}"/>" <c:if test="${searchVO.template_code eq templateList.code }"> selected </c:if>><c:out value="${templateList.template_name}"/></option>
										</c:forEach>
		       		 		 			
		       		 		 		</select>
	       		 		 		</span>
	       		 		 		</td>
	       		 		 		<td>
	       		 		 			<button type="button" class="btn" onClick='view_template();'>템플릿 보기</button>
	       		 		 			<button type="button" class="btn" onClick='xls_parse();'>템플릿 적용</button>
	       		 		 		</td>
	       		 		 	</tr>
					    </tbody>
	       		 		</table>
	       		 		</form>
	       		 		<div id="htmlview"></div>
	       				
	       				<!-- 템플릿 내용 시작  -->
	       				<c:if test="${pageType=='view'}">
		       				<div class="box-content">
							
							<div class="form-horizontal span6"> 
							
								<div class="control-group">
								  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />템플릿 카테고리 </label>
								  <div class="controls">
								 
												<input type="hidden" name='code' value='${detail.code }'>
												<input type="hidden"name='pageType' value='${pageType}'>
												
												<c:out value = "${detail.cate_name }"/>											
												
	
								
								  </div>
								</div>
								
								<div class="control-group">
								  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />템플릿 명</label>
								  <div class="controls">
								  	<input style="width: 200px" type='text' name='template_name' required='required' class="fl" value="<c:if test="${pageType=='view'}"><c:out value="${detail.template_name }"/></c:if>">
								  </div>
								</div>
								
								
								
								
								<div class="control-group">
								  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />신고기능사용유무</label>
								  <div class="controls">
								  	<c:if test="${pageType=='insert'}">
								  		<input type="radio" name="register_type" id='register_type' value="y" checked>사용
								  		<input type="radio" name="register_type" id='register_type' value="n">사용안함
								  	</c:if>
								  	<c:if test="${pageType=='view'}">
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
								  		<input style="width: 200px" type='text' name='title' required='required' class="fl" value="<c:if test="${pageType=='view'}"><c:out value="${detail.title }"/></c:if>">
								  </div>
								</div>
								
								<div class="control-group">
								  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />이메일발신자 이름</label>
								  <div class="controls">
								  	<input style="width: 200px" type='text' name='send_name' required='required' class="fl" value="<c:if test="${pageType=='view'}"><c:out value="${detail.send_name }"/></c:if>">
								  </div>
								</div>
								
								<div class="control-group">
								  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />발신이메일</label>
								  <div class="controls">
								  	<input style="width: 200px" type='email' name='send_email' maxlength="40" required='required' class="fl" value="<c:if test="${pageType=='view'}"><c:out value="${detail.send_email }"/></c:if>">
								  </div>
								</div>
								
								
								
								<div class="control-group">
								  
								  						  
								  <%if(EgovProperties.getProperty("Globals.training.del.manual").equals("0")){ %>
								  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />삭제타입</label>
								  <div class="controls">
								  
								  	<c:if test="${pageType=='view'}">
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
								  		<textarea name="send_content" id="send_content" required='required' class="fl" rows="10" cols="100" style="width:100%; height:412px; display:none;"><c:if test="${pageType=='view'}"><c:out value="${detail.send_content }"/></c:if></textarea>
								  	
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
							<li id="tabs2" onClick="tabs('2');"  role="presentation" style="display: none;">URL 이동 설정</li>
							<li id="tabs3" onClick="tabs('3');"  role="presentation" style="display: none;">첨부파일 설정</li>
						</ul>
					
						
						
						<div id="tabs-2">
						
						 <p class="blue">※ 메일 링크 클릭시</p>
						<br>
						<textarea name="training_type2_content" id="training_type2_content" rows="10" cols="100" style="width:100%; height:500px;"><c:if test="${pageType=='view'}"><c:out value="${detail.training_type2_content }"/></c:if></textarea>
						</div>
						<div id="tabs-3" style="display:none;">
						<div class="form-horizontal "> 
							
								<div class="control-group">
								  <label class="control-label" for="typeahead">첨부 파일 타입 설정</label>
								  <div class="controls">
								  		<select name='training_type3_file_type' id='training_type3_file_type'>
											<option value='html'  	<c:if test="${pageType=='view' and detail.training_type3_file_type=='html' }"> selected </c:if>>html</option>
											<option value='hwp'		<c:if test="${pageType=='view' and detail.training_type3_file_type=='hwp' }"> selected </c:if>>hwp</option>
											<option value='doc'		<c:if test="${pageType=='view' and detail.training_type3_file_type=='doc' }"> selected </c:if>>doc</option>
											<option value='xls'		<c:if test="${pageType=='view' and detail.training_type3_file_type=='xls' }"> selected </c:if>>xls</option>
											<option value='exe'		<c:if test="${pageType=='view' and detail.training_type3_file_type=='exe' }"> selected </c:if>>exe</option>
										</select>
										
										<select name='training_type3_file_exe_type' id='training_type3_file_exe_type' style="display:none">
										<option value=''>동작선택</option>
										<option value='default'  	<c:if test="${pageType=='view' and detail.training_type3_file_exe_type=='default' }"> selected </c:if>>동작 없음</option>
										<option value='scr'			<c:if test="${pageType=='view' and detail.training_type3_file_exe_type=='scr' }"> selected </c:if>>화면보호기 실행</option>
										<option value='msg'			<c:if test="${pageType=='view' and detail.training_type3_file_exe_type=='msg' }"> selected </c:if>>메세지 창 출력</option>
									</select>
								  </div>
								</div>
								
								<div class="control-group" id="div_training_type3_file_name">
								  <label class="control-label" for="typeahead">파일이름</label>
								  <div class="controls">
								  		<input type='text' name='training_type3_file_name' value="<c:if test="${pageType=='view'}"><c:out value="${detail.training_type3_file_name }"/></c:if>">
								  		파일이름 입력시 확장자 까지 같이 입력해주셔야합니다!
								  </div>
								</div>
								
								<div class="control-group" id="div_training_type3_content">
								  <label class="control-label" for="typeahead">표시될 내용</label>
								  <div class="controls">
								  		<textarea name="training_type3_content" id="training_type3_content" rows="10" cols="100" style="width:100%; height:412px;"><c:if test="${pageType=='view'}"><c:out value="${detail.training_type3_content }"/></c:if></textarea>
								  </div>
								</div>
								
								<div class="control-group" id="div_training_type3_exe_content" style="display:none">
							 		 <label class="control-label" for="typeahead">표시될 내용</label>
							  
							 		 <div class="controls">
							  		<textarea name="training_type3_exe_content" id="training_type3_exe_content" rows="10" cols="63"  wrap="physical" style="width:330px; height:412px;""><c:if test="${pageType=='view'}"><c:out value="${detail.training_type3_exe_content }"/></c:if></textarea>
							 	
								  </div>
								</div>

								<div class="control-group" id="div_training_type3_uploadFile" style="display:none">
									  <label class="control-label" for="typeahead">파일 업로드</label>
									  <div class="controls">
									  	<div>	
									  		<div id="div_training_type3_uploadFile_img"></div>
									  		<table width='100%'>
									  			<tr>
									  				<td width="*">
									  					<div id="training_type3_upload_image">
									  						<c:if test="${pageType=='view' && (detail.training_type3_file_type=='hwp' || detail.training_type3_file_type=='xls') }">
									  							<c:out value="${detail.training_type3_content }" escapeXml="false"/>
									  						</c:if>
									  					</div>
									  					<div id="training_type3_upload_image_rollover" style="position:;">									  						
									  					</div>
									  				</td>
									  			</tr>
									  		</table>
									  		
									  	</div>	
									  </div>
									</div>
							</div>
							
							</div>
							
							
							</div>
							
						</div>

                    <%-- create ckeditor --%>
                <script src="${pageContext.request.contextPath}/js/training/training-ckeditor.js"></script>
<%--						<script type="text/javascript" src="/js/HuskyEZCreator.js" charset="utf-8"></script>--%>
						<script>



	var training_type1="<c:out value="${detail.training_type1}"/>";
	var training_type2="<c:out value="${detail.training_type2}"/>";
	var training_type3="<c:out value="${detail.training_type3}"/>";
	
	<!--체크박스(수집정보)-->
	$(function() {
      createCkEditorTraining();

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

		training_type3_upload_file_type_selected()

		function training_type3_upload_file_type_selected()
		{
			//html은 text를 이용하여 작성가능해야함 그외의 것들은 이미지 첨부로 대체함.
			if($("select[name='training_type3_file_type']").val()=="html" || $("select[name='training_type3_file_type']").val()=="doc")
			{
				$("#training_type3_upload_image_rollover").hide();
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
				$("#training_type3_upload_image_rollover").hide();
				$("#div_training_type3_content").hide();
				$("#div_training_type3_file_name").show();
				$("#div_training_type3_uploadFile").hide();
				$("#training_type3_file_exe_type").show();
				if($("select[name='training_type3_file_exe_type']").val()=="msg"){
					$("#div_training_type3_exe_content").show();
				}
			}
		}




		<c:choose>
			<c:when test="${pageType eq 'view'}">
				addUserClear();
				<c:forEach var="trainingUserList" items="${trainingUserList}" varStatus="status">
					addUserList('${trainingUserList.email}', '${trainingUserList.name}', '${trainingUserList.department_name}', '${trainingUserList.unikey}');
				</c:forEach>
				addUserfush();
				
				<!--check box-->
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
				end_date:{
					required:"훈련기간을 선택하세요"
				}, 
				send_content:{
					required:"내용을 입력하세요"
				}
			}
		});
		
		
		
		
	});
	
	var userList = "";
	var listcnt = 0;
	function addUserClear()
	{
		listcnt = 0;
		userList = "<table width='100%' class='table'>";
		userList = userList +"<tr>";
		userList = userList +"	<th>email</th>";
		userList = userList +"	<th>이름</th>";
		userList = userList +"	<th>부서</th>";
		userList = userList +"	<th>사번/아이디</th>";
		userList = userList +"<tr>";
	}
	
	//적용
	function addUserfush(){
		userList = userList +"</table>";
		$("#userlist").html(userList);
	}
	
	function makeRand()
	{
		return "";
	}
	
	function addUserList(email, name, department_name, unikey)
	{
			
		userList = userList +"<tr>";
		userList = userList +"	<td>"+email+"<input type='hidden' name='listvo["+listcnt+"].email' value='"+email+"'></td>";
		userList = userList +"	<td>"+name+"<input type='hidden' name='listvo["+listcnt+"].name' value='"+name+"'></td>";
		userList = userList +"	<td>"+department_name+"<input type='hidden' name='listvo["+listcnt+"].department_name' value='"+department_name+"'></td>";
		userList = userList +"	<td>"+unikey+"<input type='hidden' name='listvo["+listcnt+"].unikey' value='"+unikey+"'></td>";
		userList = userList +"<tr>";
		listcnt++;
	}
	
	
	
	//발신자 추가
	function pop_training_user()
	{
		url = '<c:url value="/training/training_add_user_pop.do"/>';
   		fn_openwindow(url,  '600px', '400px', 'pop_institution_list');
    	
	}
	
var oEditors = [];

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
// 		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
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
// 		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
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
// 		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
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


	
	

	function view(code) 
	{
		location.href = "/system/memberForm.do?code=" + code;
	}
	$(function() {
		
		
		/**
		file type 3 변경 이벤트 
		**/
		$('#training_type3_file_type').focus(function() 
		{
		    prev_val = $(this).val();
		}).change(function() {
		    
			$(this).blur();
		    var success = confirm('첨부파일 파일 파일 타입변경을 진행하면 이전 작성내용은 초기화 됩니다.');
		    
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
		
		
		$("#searchBgnDe")
				.datepicker(
						{
							showOn : "button",
							buttonImage : "<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif'/>",
							buttonImageOnly : true,
							dateFormat : "yy-mm-dd",
							buttonText : "calendar"				
						});

		$("#searchEndDe")
				.datepicker(
						{
							showOn : "button",
							buttonImage : "<c:url value='/images/egovframework/com/cmm/icon/bu_icon_carlendar.gif'/>",
							buttonImageOnly : true,
							dateFormat : "yy-mm-dd",
							buttonText : "calendar"
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
			
			
			
			//훈련기간 체크
			if($("#searchBgnDe").val()=="" || $("#searchEndDe").val()=="")
			{
				alert('훈련기간을 입력하여주세요!');
				return ;
			}
			else if(Number($("#searchBgnDe").val().replace(/\-/g,''))>Number($("#searchEndDe").val().replace(/\-/g,'')))
			{
				alert('훈련 시작일이 종료일 보다 작아야합니다.');
				return ;
			}
			
			//url이동 설정(url이동시 표시될 내용)
			
			
			if($("input:checkbox[name='training_type2']").is(":checked")==true)
			{
				var check1 = oEditors2.getById["training_type2_content"].getIR()
				
				
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
				
				if(oEditors3.getById["training_type3_content"].getIR().length<=11)
				{
					alert("점부파일에 표시될 내용을 입력하여주시기 바랍니다.");
					return ;
				}
				
			}
			
			
				
			oEditors.getById["send_content"].exec("UPDATE_CONTENTS_FIELD", []);
			oEditors2.getById["training_type2_content"].exec("UPDATE_CONTENTS_FIELD", []);
			oEditors3.getById["training_type3_content"].exec("UPDATE_CONTENTS_FIELD", []);
			
			if(confirm("훈련을 생성하시겠습니까?")){
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
	
</script>
						
						
						
						
					</c:if>
					<!-- 템플릿 내용 종료 -->
	       				
	       			
       		 	</div>
    </div>
    <form name="filedownload" target="iframe" hidden="hidden">
    </form>
    <iframe name="iframe" hidden="hidden">
    
    </iframe>
    <script>
    
    	var pageType = "<c:out value="${pageType}"/>";
    	
    	
    
    	$( document ).ready(function() {
      	  
    		<c:choose>
    			<c:when test="${pageType eq 'view'}">
    				selectCateCode("<c:out value="${searchVO.cate_code}"/>");	
    			</c:when>
    			<c:otherwise>
    				selectCateCode($("select[name='cate_code']").val());
    			</c:otherwise>
    		</c:choose>    		
    	});
    	
    	
    	/**
    	템플릿 확인용
    	**/
    	function view_template()
    	{
    		var code = $("select[name='template_code']").val();
    		
    		if(code=="")
    		{
    			alert("템플릿 코드가 존재하지 않습니다. 다른 템플릿을 선택하여주시기 바랍니다.");
    			return null;
    		}
    		document.frm.action = "/training/template_select_popup.do";
    		document.frm.submit();
    		
    	}
    	
    	var template_code = "<c:out value='${searchVO.template_code}'/>";
    	
    	/**
    		카테고리 코드로 생성된 카테로리를 생성
    	**/
    	function selectCateCode(code)
    	{
    		var selected = "";
    		var html="";
			var select_html="";
			param = "code="+code;
			$.ajax({
				type:'POST',
				url : "<c:url value='/training/ajax_tempalte_list.do'/>",
				data:param,
				dataType : "json",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
				beforeSend: function() {
		        },
				success : function(json){
					for(i=0;i<json.length;i++)
					{
						if(template_code==json[i].code)
						{
							select_html = select_html +"<option value='"+json[i].code+"' selected >"+json[i].template_name+"</option>";
						}
						else
						{
							select_html = select_html +"<option value='"+json[i].code+"' >"+json[i].template_name+"</option>";
						}
					}
					
					html = "<select name='template_code' id='template_name'>";
					html = html + "<option value=''>그룹선택</option>";
					html = html + select_html;
					html = html + "</select>";
					
					$("#tempalte_code_div").html(html);
					
				},
				error:function(request,status,error){
				}
				
			}).complete(function() {
							
	        });
    			 
    	}

    	/**
    	템플릿 창에서 설정 된 내용을 훈련 생성시 맴핑 작업을 진행.
    	**/
    	function xls_parse()
    	{
    		//훈련 제목
    		opener.document.frm.title.value 						= $("input[name='title']").val();
    		
    		//이메일발신자 이름
    		opener.document.frm.send_name.value 			= $("input[name='send_name']").val();
    		
    		//이메일발신자 이메일 주소
    		opener.document.frm.send_email.value 			= $("input[name='send_email']").val();
    		
    		//신고내용 사용유무
    		$(opener.document).find("input[name='register_type']").filter("input[value="+$(':radio[name="register_type"]:checked').val()+"]").prop("checked", "checked");
    		
    		//본문 내용 적용
			var send_content = getCkEditorContent('send_content')
			opener.setCkEditorContent('send_content', send_content)
    		// var send_content = oEditors.getById["send_content"].getIR();
    		// opener.oEditors.getById["send_content"].exec("SET_CONTENTS", [""]);
    		// opener.oEditors.getById["send_content"].exec("PASTE_HTML", [send_content]);
    		// opener.oEditors.getById["send_content"].exec("REFRESH_WYSIWYG");
    		// opener.oEditors.getById["send_content"].exec("CHANGE_EDITING_MODE", ["HTMLSrc"]);
    		// opener.oEditors.getById["send_content"].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
    		
    		
    		
    		//URL이동 
    		if($("input:checkbox[name='training_type2']").is(":checked")==true)
    		{
    			opener.$("input:checkbox[name='training_type2']").prop("checked","checked");
    			opener.collection_info('2');

    			var training_type2_content_html = getCkEditorContent('training_type2_content')
				opener.setCkEditorContent('training_type2_content', training_type2_content_html)

    			// var training_type2_content_html = oEditors2.getById["training_type2_content"].getIR();
    			// opener.oEditors2.getById["training_type2_content"].exec("SET_CONTENTS", [""]);
    			// opener.oEditors2.getById["training_type2_content"].exec("PASTE_HTML", [training_type2_content_html]);
    			// opener.oEditors2.getById["training_type2_content"].exec("CHANGE_EDITING_MODE", ["HTMLSrc"]);
        		// opener.oEditors2.getById["training_type2_content"].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
        		// opener.oEditors2.getById["training_type2_content"].exec("REFRESH_WYSIWYG");
    			
    			
    		}
    		else {
				opener.$("input:checkbox[name='training_type2']").prop("checked", false);
				opener.collection_info('2');
				opener.setCkEditorContent('training_type2_content', '')
				// 	opener.oEditors2.getById["training_type2_content"].exec("SET_CONTENTS", [""]);
				// 	opener.oEditors2.getById["training_type2_content"].exec("REFRESH_WYSIWYG");
			}
    		
    		
    		//첨부파일 실행
    		if($("input:checkbox[name='training_type3']").is(":checked")==true)
    		{
    			opener.$("input:checkbox[name='training_type3']").prop("checked","checked");

    			opener.collection_info('3');
    			
    			
    			
    			opener.$("select[name='training_type3_file_type']").val($("select[name='training_type3_file_type']").val());
    			
    			opener.$("input[name='training_type3_file_name']").val($("input[name='training_type3_file_name']").val());
    			
    			if($("select[name='training_type3_file_type']").val() == "exe" ){
    				opener.$("select[name='training_type3_file_exe_type']").val($("select[name='training_type3_file_exe_type']").val());
    				opener.$("#training_type3_file_exe_type").show();
    				opener.$("#div_training_type3_uploadFile").hide();
    				opener.$("#div_training_type3_content").hide();
    				opener.$("#training_type3_upload_image_rollover").hide();
    				
	    			if($("select[name='training_type3_file_exe_type']").val() == "msg"){	    				
	    				opener.$("textarea[name='training_type3_exe_content']").val($("textarea[name='training_type3_exe_content']").val());        			
	    				opener.$("#div_training_type3_exe_content").show();
	    			}else{    			
	    				opener.$("#div_training_type3_exe_content").hide();	    				
	    			}
    			}else{
    				if($("select[name='training_type3_file_type']").val() == "html" || $("select[name='training_type3_file_type']").val() == "doc" ){
    					opener.$("#div_training_type3_content").show();
    					opener.$("#div_training_type3_uploadFile").hide();        				
    				}else{
    					opener.$("#training_type3_upload_image_rollover").show();
    					opener.$("#div_training_type3_content").hide();
    					opener.$("#div_training_type3_uploadFile").show();
    					opener.$("#div_training_type3_uploadFile").show();

						var type3ImageContent = $('#training_type3_upload_image').html()
    					console.log(type3ImageContent)

    					opener.$("#training_type3_upload_image").html(getCkEditorContent('training_type3_content'));
    					// opener.$("#training_type3_upload_image").html($("textarea[name='training_type3_content']").val());



    				}
    				opener.$("select[name='training_type3_exe_type']").val("");
    				opener.$("#training_type3_file_exe_type").hide();
    				opener.$("#div_training_type3_exe_content").hide();	    			

    				var training_type3_content_html = getCkEditorContent('training_type3_content')
					opener.setCkEditorContent('training_type3_content', training_type3_content_html)

	    			// var training_type3_content_html = oEditors3.getById["training_type3_content"].getIR();
	    			// opener.oEditors3.getById["training_type3_content"].exec("SET_CONTENTS", [""]);
	    			// opener.oEditors3.getById["training_type3_content"].exec("PASTE_HTML", [training_type3_content_html]);
	    			// opener.oEditors3.getById["training_type3_content"].exec("REFRESH_WYSIWYG");
	    			// opener.oEditors3.getById["training_type3_content"].exec("CHANGE_EDITING_MODE", ["HTMLSrc"]);
	        		// opener.oEditors3.getById["training_type3_content"].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
	    		}
    		}
    		else
    		{
    			opener.$("input:checkbox[name='training_type3']").prop("checked",false);
    			opener.collection_info('3');
    			opener.oEditors3.getById["training_type3_content"].exec("SET_CONTENTS", [""]);
    			opener.$("select[name='training_type3_file_type']").val("html");
    			opener.$("input[name='training_type3_file_name']").val("");
    			opener.$("select[name='training_type3_exe_type']").val("");
    			opener.$("textarea[name='training_type3_exe_content']").val("");        			
    			opener.$("#training_type3_file_exe_type").hide();
    			
    			// opener.oEditors3.getById["training_type3_content"].exec("REFRESH_WYSIWYG");
    			
    		}
    		
    		//초기화
    		setTimeout("window.close();", 100);
    		
    	}
    	
    	
    	function training_type3_upload_file_type_selected()
    	{    		
    		//html은 text를 이용하여 작성가능해야함 그외의 것들은 이미지 첨부로 대체함.
    		if($("select[name='training_type3_file_type']").val()=="html" || $("select[name='training_type3_file_type']").val()=="doc")
    		{
    			$("#training_type3_upload_image_rollover").hide();
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
    			$("#training_type3_upload_image_rollover").hide();
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
    			$("#training_type3_upload_image").html(imgview);
    			
    			setCkEditorContent('training_type3_content', imgview)
    			// oEditors3.getById["training_type3_content"].exec("SET_CONTENTS", [imgview]);
    			
    		}
    		else
    		{
    			
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
    	
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_pop_layout" />


       	</div>
</div>