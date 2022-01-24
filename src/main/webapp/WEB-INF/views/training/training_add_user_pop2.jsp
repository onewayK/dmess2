<%@page import="kr.nshare.common.util.EgovProperties"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_pop_layout" />

<!-- bootstrap dialog -->
<script src="<c:url value='/js/bootstrap/bootstrap-dialog.js'/>"></script>

<!-- bootstrap dialog -->
<link href="<c:url value='/css/bootstrap/bootstrap-dialog.css'/>" rel="stylesheet">


<div class="pop_header">
	<h2><i class="fa-icon-sign-blank"></i><span class="break"></span> 훈련 인원 등록</h2>
</div>
	<div class="container-fluid">
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
			<div class="row-fluid">
					<div class="box-content span12">
	       		 	 <form class="form-horizontal" role="form" name='frm' method='post' enctype="multipart/form-data">
	       		 		<table class="table table-bordered table-striped">
	       		 		<colgroup>
	       		 			<col width="100px">
	       		 			<col width="300px">
	       		 			<col width="*">
	       		 		</colgroup>
	       		 		 <tbody>
	       		 		 	<tr>
	       		 		 		<td colspan="3">
		       		 		 		sample xls를 다운로드하신후 등록하시고자하는 사용자 리스트를 등록하신후
		       		 		 		파일 업로드를 해주시기 바랍니다.
	       		 		 		</td>
	       		 		 	</tr> 
	       		 		 	<tr>
	       		 		 		<th>대상등록</th>
	       		 		 		<td><input type='file' name="uploadfile" id="uploadfile"></td>
	       		 		 		<td><a href='#' class="btn" onClick="dwn_sample();">sample xls</a></td>
	       		 		 	</tr>
					    </tbody>
	       		 		</table>
	       		 		</form>
	       		 		
	       				<div class="form-horizontal "> 
							<div id='userlist' class="userlist" style="height: 250px">
							</div>
						</div>
	       				
	       							 
	       		 	
	       		 	<table class="table table-bordered table-striped">
				    	<tr>
				    		<td width="50px">
				    			
				    			<c:choose>
				    				<c:when test="${pageType=='form' }">
				    					<button type="button" class="btn" onClick='xls_parse_new();'>수신자 파싱(신규)</button>
				    					<button type="button" class="btn" onClick='xls_parse_existing();'>수신자 파싱(추가)</button>
				    				</c:when>
				    				<c:otherwise>
				    					<button type="button" class="btn" onClick='xls_parse_new();'>수신자 파싱(신규)</button>
				    					<button type="button" class="btn" onClick='xls_parse_existing();'>수신자 파싱(추가)</button>				    					
				    				<c:choose>				    					
				    						<c:when test="${parseType!='success' }">
				    						</c:when>
				    						<c:otherwise>
				    							<button type="button" class="btn" onClick='user_add();'>적용</button>				    							
				    					</c:otherwise>
				    			</c:choose>
				    				</c:otherwise>
				    			</c:choose>
				    			
				    			
				    			
							</td>
				    	</tr>
					 </table>
       		 	</div>
    </div>
    <form name="filedownload" target="iframe" hidden="hidden">
    </form>
    <iframe name="iframe" hidden="hidden">
    
    </iframe>
    <script>
    var pageType = "<c:out value="${pageType}"/>";
    var paserType = "<c:out value="${parseType}"/>";
	var errList = "";
	var rDate_val = []; 
	
    <c:choose>
		<c:when test="${parseType == 'success' and pageType ==  'proc'}">
			createUserFields();
	    	<c:forEach var="errList" items="${list}" varStatus="status">
	    		rDate_val[${status.index}] ={email: '${errList.email}',name: '${errList.name}', department_name: '${errList.department_name}', unikey: '${errList.unikey}'};
				//errList = errList + "<c:out value="${errList.email}"/> | <c:out value="${errList.name}"/> | <c:out value="${errList.department_name}"/>  | <c:out value="${errList.unikey}"/>";  
	    	</c:forEach>
		    addUserfush(rDate_val);				
    	</c:when>
    </c:choose>
    
    //최초 로드시 
    $(document).ready(function() {
    	
    	
    	if(paserType=='user_false')
    	{
    		var user_cnt= <%=EgovProperties.getProperty("Globals.training.max.user.count") %>
    		alert("총 훈련 대상자 수 "+user_cnt +"명을 초과할 수 없습니다. \n다시 등록해주시기 바랍니다.");	
    		
    	}else if(paserType=='false_zero')
    	{
    		alert("해당 훈련에 등록된 카테고리 정보가 잘못되었습니다.");	
    	}else if(paserType!='success'){
    		alert("아래의 row가 등록에 문제가 있습니다. \n문제 되는 부분을 제거하고 다시 등록해주시기 바랍니다.\n"+errList);	
       }else if ( pageType == 'proc' && paserType=='success'){
    		window.opener.ajax_proc(' ',' ');
    	}
    });
    
    
    function dwn_sample()
    {
    	document.filedownload.action = "/download/file.do";
    	document.filedownload.submit();
    }
    
    
    function xls_parse_new()
    {
    
	    	
    		var strFile = $("#uploadfile").val();    // 파일명
	    	 var pathLen = strFile.lastIndexOf(".");  // 파일명의 확장자를 제외한 거리 까지의 길이
	    	 var strExt  = strFile.substring(pathLen+1); // 파일 확장자 추출
	    	
	    	if($("#uploadfile").val()=="" ||  $('#uploadfile').val().split('.').pop().toLowerCase()!="xls" )
	    	{
	    		alert('사용자 등록을 원하시면 정해진 xls파일 을 입력하여주시기 바랍니다.');
	    		return ;
	    	}
	    	else
	    	{
	    		if(confirm("파싱이 정상적으로 완료되면 자동으로 디비에 저장됩니다! 진행하시겠습니까?"))
	        	{
	    			$('#overlay').show();   
			    	document.frm.action = "/training/training_add_user_pop2.do";
			    	document.frm.submit();
			    }
	    	}	    	
	    	 
	    
    }
    
    function xls_parse_existing()
    {
    	
	    	var strFile = $("#uploadfile").val();    // 파일명
	    	 var pathLen = strFile.lastIndexOf(".");  // 파일명의 확장자를 제외한 거리 까지의 길이
	    	 var strExt  = strFile.substring(pathLen+1); // 파일 확장자 추출
	    	
	    	if($("#uploadfile").val()=="" ||  $('#uploadfile').val().split('.').pop().toLowerCase()!="xls" )
	    	{
	    		alert('사용자 등록을 원하시면 정해진 xls파일 을 입력하여주시기 바랍니다.');
	    		return ;
	    	}
	    	else
	    	{
	    		//전체 랜덤할 것인지 기존 템플릿에 추가할 것인지 선택 창 출력
	    		pop_training_user_add();	    		
	    	}	    	
    }
   
	/**
	 템플릿 선택하여 수신자 일괄등록
	**/
	function pop_training_user_add()
	{	
		var select_html = select_template_main_list("add","");	

		var title = "템플릿 선택";		
		
		var message ="";
		message = message + "<div>";		
		message = message + "		<span style='width:80px;float:left'>카테고리</span><span width='*'><select name='cate_main_list' id='cate_main_list' onchange='select_template_sub_list(this.value,\"add\",\"\");'>"+select_html+"</select>";
		message = message + "		<select name='cate_sub_list' id='cate_sub_list' ><option value=\"\">템플릿선택</option></select>";
		message = message + "		<input type='checkbox' name='random_add' id='random_add'>전체 랜덤</span><br>";
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
							    	var formInput1 = document.createElement("input"); 
				    			  	formInput1.setAttribute("type", "hidden");
				    			  	formInput1.setAttribute("name", "random_insert_use");
				    			  	formInput1.setAttribute("id", "random_insert_use"); 
				    			  	formInput1.setAttribute("value", $('#random_add').is(":checked"));
							    	
				    			  	document.frm.appendChild(formInput1); 
				    			  	
							    	if($('#random_add').is(":checked") == true){
							    		if(confirm("[젠체랜덤]\n파싱이 정상적으로 완료되면 자동으로 디비에 저장됩니다! 진행하시겠습니까?"))
							        	{
							    			$('#overlay').show();   
									    	document.frm.action = "/training/training_add_user_pop2_existing.do";
									    	document.frm.submit();	
									    	
									    	dialogRef.close();	
							        	}
							    	}else{
							    		var val1 = $("select[name='cate_sub_list']").val();
								    	
							    		if(confirm("[기존 템플릿 선택]\n파싱이 정상적으로 완료되면 자동으로 디비에 저장됩니다! 진행하시겠습니까?"))
							        	{
							    			if(val1=="")
										    {
									        	alert("기존 카테고리에 훈련대상자 적용시 카테고리 선택은 필수입력입니다.");
									        	$("input[name='cate_sub_list']").focus();
									        	return ;
									        }
							    			
							    			
							    			document.frm.action = "/training/training_add_user_pop2_existing.do";
											
							    			//동적 폼 생성후 값 전송
						    			  	var formInput2 = document.createElement("input"); 
						    			  	formInput2.setAttribute("type", "hidden");
						    			  	formInput2.setAttribute("name", "tg_code");
						    			  	formInput2.setAttribute("id", "tg_code"); 
						    			  	formInput2.setAttribute("value", val1);						    			  
						    			 	
							    			document.frm.appendChild(formInput2); 
							    			
							    			$('#overlay').show();   
									    	document.frm.submit();	
									    	
							    			dialogRef.close();	
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
    
    function openerAdd(email, name, department_name, unikey)
   	{
    	
   	}
    
    /**
    사용자 적용
    **/
    function user_add()
    {    	
    	window.close();
    	window.opener.send_num_init();
    }
    
    /**
	 훈련 대상자 추가(개별)시 신규체크박스에 따른 소분류 리스트 출력
	**/
	function select_template_sub_list(code,type,grpCode)
	{
		
		var select_html="<option value=\"\">템플릿선택</option>";		
		
		var param = "training_code="+"<c:out value="${training_code}"/>";
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
	템플릿 선택 창 팝업(주분류)
	**/
	function select_template_main_list(type,cateCode)
	{		
		var select_html="<option value=\"\">선택하세요</option>";
		var param = "training_code="+"<c:out value="${training_code}"/>";
		
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
						dup_code_list.add(json[i].cate_code);
						select_html = select_html +"<option value='"+json[i].cate_code+"' >"+json[i].cate_name+"</option>";	
					}
				} 				
			},
			error:function(request,status,error){
			}
			
		}).complete(function() {
						
	    });
		
		return select_html;
	}	
	
	  //slick grid 필드 생성
	function createUserFields(){
		
		var fields=[];
		
		fields.push({name : "이메일주소",id: "email"});
		fields.push({name : "이름",id: "name"});
		fields.push({name : "부서",id: "department_name"});
		fields.push({name : "사번/아이디",id: "unikey"});
	
		setSlickHeader(fields);	
	}
  
	//slick grid 생성 및 유저 리스트 추가
	function addUserfush(rdata){
		//데이터 삽입
		setSlickData_first(rdata);
		
		//slick grid 생성
		create_slick_grid("#userlist");
	}
    </script>
    <c:out value="${jsonList}"/>
<c:import url="/common/pageLink.do?link=inc/bottom_pop_layout" />


       	</div>
</div>