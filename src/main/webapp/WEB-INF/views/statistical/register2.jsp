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
		<ul class="breadcrumb">
            <li>
                <i class="fa-icon-home"></i> Home / 통계 / <strong>신고접수</strong>
            </li>
        </ul>		

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
	<div class="panel panel-default">
		
		
		
		<form name="frm" id="frm" method="post"  enctype="multipart/form-data">
			<input type="hidden" name="t" value="<c:out value="${searchVO.t }"/>">		
		<div class="row-fluid">
				
				<div class="box span12">
					
					<div class="box-header">
						                     			
                       	<h2><i class="fa-icon-user"></i><span class="break"></span>신고접수(일괄)</h2>
					</div>
					<div class="box-content">						
						
						<div class="form-horizontal "> 
							
							
									<div class="control-group">
										<label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />훈련명</label>
										<div class="controls">
												              			
			                       			<select name="searchInstitution" id="searchInstitution" onChange="chgInstitution(this.value)">
												<option value="">선택하세요</option>
												<c:forEach var="list" items="${list}" varStatus="status">																						
													<option value="${list.code }" <c:if test="${searchVO.searchInstitution eq list.code }"> selected </c:if>><c:out value="${list.institution_name}"/></option>												
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
												<select name="training_code" id="training_code" >
													<option value="">선택하세요</option>
													<c:forEach var="trainingList" items="${trainingList}" varStatus="status">																						
															<option value="${trainingList.code }" <c:if test="${searchVO.training_code eq trainingList.code }"> selected </c:if>><c:out value="${trainingList.tname}"/></option>																									
													</c:forEach>
												</select>
					        				</span>	
					        				
										</div>
									</div>														
						</div>
						
						<div class="form-horizontal "> 
							<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />신고추가</label>
							  <div class="controls">
							  		<button id="btn_add" type="button" class="btn btn-info" onClick='pop_register();'>신고내역 추가</button>
							  		<button id="btn_matching" type="button" class="btn btn-info" onClick='matching_flag_load();'>신고자 매칭</button>
							 </div>	
							</div>	
						</div>			
										
					 <div class="form-horizontal "> 
					 		<div class="control-group">
							  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />신고리스트</label>
							  <div class="controls">
							  		<div class="box-content" style='padding:3px';> 
							  		<div style='height:400px; overflow-y: scroll;'>
								  		<table class="table table-bordered table-striped">
					       		 		<colgroup>
					       		 			<col width="30%">
					       		 			<col width="10%">
					       		 			<col width="10%">
					       		 			<col width="10%">
					       		 			<col width="10%">
					       		 			<col width="10%">
					       		 		</colgroup>
					       		 		 <thead>
									      <tr>
									        <th rowspan='1'>신고제목</th>
									        <th rowspan='1'>수신자 이메일</th>
									        <th rowspan='1'>수신자 이름</th>								        
									        <th rowspan='1'>신고일</th>
									        <th rowspan='1'>매칭유무</th>
									        <th rowspan='1'>수정/삭제</th>
									      </tr>
									    </thead>
									    <tbody id='registerList'>								    	
										    	<tr>
									       		 	<td colspan="9" align="center">no list</td>
									       		</tr>			
									    </tbody>								    
					       		 	  </table>
							  		</div>
				       		 	</div>
							</div>	
						</div>	
							
				 </div>					 
						
						<div class="pull-right">
							<button type="button" id="btn_send" onClick='send()' class="btn btn-primary" disabled='disabled'>등록</button>
							<button type="button" class="btn btn-primary" onClick='movelist();'>리스트</button>
						</div>
						<div class="clearFix"></div>	
			
					</div>				
		</div>
		</form>
		</div>
	</div>
	</div>
</div>
<script>
	
	var msg = "<c:out value="${msg}"/>";
	$( document ).ready(function() {
	  
	
		
	});
	
	 $("#training_code").chosen(
	    		{
	    			no_results_text: "해당 훈련이 존재하지 않습니다.",
	    			width: 200		
	    		}
	    ); 
	
	function movelist()
	{
		location.href="/statistical/registerList.do";
	}
	
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
					html = html + "<option value='"+json[i].code+"'>"+json[i].group_name+"</option>";	
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
			var html = "<select name='training_code' id='training_code'><option value=''>선택하세요</option>";
			html = html +"</select>";
			
			$("#div_training_code").html(html);				
			
			$("#training_code").chosen(
		    		{
		    			no_results_text: "해당 훈련이 존재하지 않습니다.",
		    			width: 200		
		    			
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
					
					var html = "<select name='training_code' id='training_code'><option value=''>선택하세요</option>";
					
					for(i=0;i<json.length;i++)
					{
						html = html + "<option value='"+json[i].code+"'>"+json[i].tname+"</option>";	
					}
					
					html = html +"</select>";
					$("#div_training_code").html(html);
					
					$("#training_code").chosen(
				    		{
				    			no_results_text: "해당 훈련이 존재하지 않습니다.",
				    			width: 200		
				    			
				    		}
				    ); 
				}
	   		});
		}
	}
		
	function send()
	{
		if($("select[name='searchInstitution']").val()=="" )
    	{
    		alert('기관은 필수선택사항입니다.');
    		return ;
    	}
		
    	 if($("select[name='group_code']").val()=="")
    	{
    		alert('그룹명은 필수선택사항입니다.');
    		return ;
    	}
    	 
    	 if($("select[name='training_code']").val()=="")
    	{
    		alert('훈련명은 필수선택사항입니다.');
    		return ;
    	} 		
		
   		if(listcnt <= 0){
   			alert("업로드하신 신고내역이 존재하지 않습니다.");
   			return;
   		}
    	 
		document.frm.action = "/statistical/register_save2.do";
		
		if(confirm("등록하신 신고내역은 수정하실 수 업습니다.\n신고내역 접수하시겠습니까?")){
			document.frm.submit();
		}
				
	}
	
	//신고내역 추가
	function pop_register()
	{
		url = '<c:url value="/statistical/register_add_pop.do"/>';
		fn_openwindow(url,  '800px', '400px', 'pop_institution_list');
	}
	
	var registerList = "";
	var listcnt = 0;
	function addRegisterClear()
	{
		listcnt = 0;
		registerList = "";
	}
	
	//적용
	function addRegisterFlush(){		
		$("#registerList").html(registerList);		
	}
		
	function addRegisterList(title, email, name, content, sdate)
	{	
		var matching_flag = "-";
		
		registerList = registerList +"<tr id='key_"+listcnt+"' onclick='view("+listcnt+");' style='cursor: hand'> <input type='hidden' name='listvo["+listcnt+"].code' value='"+listcnt+"'></td>";
		registerList = registerList +"	<td><span id='p_title_"+listcnt+"'> "+title+"</span><input type='hidden' name='listvo["+listcnt+"].title' value='"+title+"'></td>";
		registerList = registerList +"	<td><span id='p_email_"+listcnt+"'> "+email+"</span><input type='hidden' name='listvo["+listcnt+"].email' value='"+email+"'></td>";
		registerList = registerList +"	<td><span id='p_name_"+listcnt+"'>"+name+"</span><input type='hidden' name='listvo["+listcnt+"].name' value='"+name+"'></td>";
		registerList = registerList +"	<td><span id='p_sdate_"+listcnt+"'>"+sdate+"</span><input type='hidden' name='listvo["+listcnt+"].sdate' value='"+sdate+"'></td>";
		registerList = registerList +"	<td><span id='p_matching_flag_"+listcnt+"'>"+matching_flag+"</span><input type='hidden' name='listvo["+listcnt+"].matching_flag' value='"+matching_flag+"'></td>";
		
		registerList = registerList +"	<td><button type='button' class='btn btn-info' onClick=\"register_modfiy('"+listcnt+"');\">수정</button>&nbsp;<button type='button' class='btn btn-info' onClick=\"register_del(this,'"+listcnt+"');\">삭제</button></td>";
		registerList = registerList +"</tr>";
			
		registerList = registerList +"<td id='tr_"+listcnt+"' colspan='9' style='display:none' onclick='close_view("+listcnt+");'><pre>";
		registerList = registerList +"<span id='p_content_"+listcnt+"'>"+content+"</span>";
		registerList = registerList +	"</pre><input type='hidden' name='listvo["+listcnt+"].content' value='"+content+"'></td>";
		
		listcnt++;
		return registerList;
	}
	
	 /**
	상세정보 보기
	**/
	function view(code)
	{
		$("#tr_"+code).fadeToggle( "fast", "linear" );	
	}
	
	function close_view(code)
	{
		view(code);	
	}
	
	
	function register_modfiy(key)
	{
		var rtitle 			= $("input[name='listvo["+key+"].title']").val();
		var email 			= $("input[name='listvo["+key+"].email']").val();
		var name 			= $("input[name='listvo["+key+"].name']").val();		
		var content 		= $("input[name='listvo["+key+"].content']").val();
		var sdate 			= $("input[name='listvo["+key+"].sdate']").val();
		
		var title = "신고내용 수정";
		
		var message ="";
		message = message + "<div>";
		message = message + "		<span style='width:80px;float:left'>신고제목</span>		<span width='*'><input type='text' class='input-xlarge' name='val1' value=\""+rtitle+"\"></span><br>";
		message = message + "		<span style='width:80px;float:left'>email</span>		<span width='*'><input type='text' class='input-xlarge' name='val2' value=\""+email+"\"></span><br>";
		message = message + "		<span style='width:80px;float:left'>이름</span>			<span width='*'><input type='text' class='input-xlarge' name='val3' value=\""+name+"\"></span><br>";
		message = message + "		<span style='width:80px;float:left'>신고내용</span>			<span width='*'><textarea type='text' class='input-xlarge' name='val4'>"+content+"</textarea></span><br>";
		message = message + "		<span style='width:80px;float:left'>신고시간</span>	<span width='*'><input type='text' class='input-xlarge' name='val5' value=\""+sdate+"\"></span><br>";
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
							    	var val1 = $("input[name='val1']").val(); //신고제목
							    	var val2 = $("input[name='val2']").val(); //수신자 이메일
							    	var val3 = $("input[name='val3']").val(); //수신자 이름
							    	var val4 = $("textarea[name='val4']").val(); //신고 내용
							    	var val5 = $("input[name='val5']").val();  //신고 시간
							    	
									 //Pattern p = Pattern.compile(regex);
									 //Matcher m = p.matcher(email);
							    	
							    	if(val1=="")
							        {
							    		alert("신고제목 은 필수입력입니다.");
							        	$("input[name='val1']").focus();
							        	return ;
							        }
							    	
							    	if(val2=="")
							        {
							    		alert("수신자 이메일은 필수입력입니다.");
							        	$("input[name='val1']").focus();
							        	return ;
							        }
							    	
							    	var regex = "^[_a-zA-Z0-9-\\.]+@[\\.a-zA-Z0-9-]+\\.[a-zA-Z]+$";
							    	if (!val2.match(regex))
							    	{
							    		alert("수신자 이메일을 잘못 입력하셨습니다.");
							    		return ;
							    	}							    	
							    	
							    	if(val3=="")
								        {
							        	alert("수신자 이름 은 필수입력입니다.");
							        	return ;
							        }
							    	
							    	if(val4=="")
							        {
							        	alert("신고 내용은 필수입력입니다.");
							        	return ;
							        }
							    	
							    	if(val5=="")
								    {
							        	alert("날짜는 필수입력입니다.");
							        	return ;
							        }
							    	
							    	var regex2 = "^[0-9][0-9][0-9][0-9]\\-[0-9][0-9]\\-[0-9][0-9]\\s[0-9][0-9]:[0-9][0-9]$";
							    	if (!val5.match(regex2))
							    	{
							    		alert("날짜을 잘못 입력하였습니다.");
							    		return ;
							    	}	
							    	
							    	$("input[name='listvo["+key+"].title']").val(val1);
							    	$("input[name='listvo["+key+"].email']").val(val2);
									$("input[name='listvo["+key+"].name']").val(val3);
									$("input[name='listvo["+key+"].content']").val(val4);
									$("input[name='listvo["+key+"].sdate']").val(val5);
							    	
									
									$("#p_title_"+key).html(val1);
									$("#p_email_"+key).html(val2);
									$("#p_name_"+key).html(val3);
									$("#p_content_"+key).html(val4);
									$("#p_sdate_"+key).html(val5);
									
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
	function register_del(obj,code)
	{
		if(confirm('해당 신고내역을 삭제하시겠습니까?'))
		{
			var tr = $(obj).parent().parent();
			tr.remove();
			$("#tr_"+code).remove();
			listcnt--;
		}
	}
	
	/**
	해당 신고내역 리스트에 대한 매칭 유무 판단
	**/
	function matching_flag_load()
	{
		 if($("select[name='training_code']").val()=="")
    	{
    		alert('훈련명은 필수선택사항입니다.');
    		return ;
    	} 		
		 
		if(listcnt <= 0){
			alert("업로드하신 신고내역이 존재하지 않습니다.");
			return;
		}
		
		if(confirm("신고 수에 따라  다소 시간이 걸릴 수 있습니다\n업로드한 신고내역에 대한 사용자 매칭을 시작하시게습니까?"))
		{	
			$('#overlay').show();   
			//매칭중 신고 추가, 신고자 매칭, 등록 버튼 비활성화
			$("#btn_add").attr("disabled","disabled");
			$("#btn_matching").attr("disabled","disabled");
			$("#btn_send").attr("disabled","disabled");
			
			var param = $("form[name=frm]").serialize() ;
			
			
			$.ajax({
				type:'POST',
				url : "<c:url value='/statistical/ajax_register_matching_list.do'/>",
				data:param,
				dataType : "json",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
				beforeSend: function() {
		        },
				success : function(json){
				
					for(i=0;i<json.length;i++)
					{
						var key=json[i].userCode;					
							
						if(null != json[i].matching_flag && "Y" == json[i].matching_flag ){
							
							$("input[name='listvo["+key+"].matching_flag']").val("Y");
							$("#p_matching_flag_"+key).html("사용자매칭");
						}else{
							$("input[name='listvo["+key+"].matching_flag']").val("N");
							$("#p_matching_flag_"+key).html("매칭정보없음");
						}
						
					}					
				},
				error:function(request,status,error){
				}
				
			}).complete(function() {
				alert("신고자 매칭이 완료되었습니다.");
				//버튼 활성화
				$("#btn_add").removeAttr("disabled");
				$("#btn_matching").removeAttr("disabled");
				$("#btn_send").removeAttr("disabled");		
				$('#overlay').hide();   
	        });
			
		}		
	}
	
</script>


<c:import url="/common/pageLink.do?link=inc/bottom_layout" />