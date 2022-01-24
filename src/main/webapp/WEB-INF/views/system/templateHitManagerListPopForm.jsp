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
	<h2><i class="fa-icon-sign-blank"></i><span class="break"></span> 분류 기준 등록</h2>
</div>
	<div class="container-fluid">
			<div class="row-fluid">
					<div class="box-content span12">
	       		 	 <form class="form-horizontal" role="form" name='frm' method='post'>
	       		 	 	
	       		 	 	
	       		 	 	 
	       		 		<table class="table table-bordered table-striped">
	       		 		<colgroup>
	       		 			<col width="100px">
	       		 			<col width="*">
	       		 			<col width="250px">
	       		 			<col width="100px">
	       		 		</colgroup>
	       		 		 <tbody>
	       		 		 	<tr>
	       		 		 		<td colspan="3">
		       		 		 		카테고리 분류 : <c:out value="${detail.cate_name}"/>  
	       		 		 		</td>
	       		 		 	</tr>
					    </tbody>
	       		 		</table>
	       		 		
	       		 		
	    				<div style="text-align: right">
	    					<button type="button" class="btn" onClick='add_form();'>단어등록</button>
	    					
	    				</div>
	    					<input type='hidden' name='type' value = 'add'>
	    					<input type='hidden' name='tc_code' value="<c:out value='${searchVO.tc_code}'/>"/>
	       		 		</form>
	       		 		
	       		 		<!-- 리스트 출력 -->
	       		 		<div id="listpage"></div>
	       							 
	       		 	
	       		 	
       		 	</div>
    </div>
    <form name="filedownload" target="iframe" hidden="hidden">
    </form>
    <iframe name="iframe" hidden="hidden">
    
    </iframe>
    <script>
    	
    var listObj = null;
    	
	    $( document ).ready(function() {
			
	    	//등록
	    	var param = "tc_code="+$("input[name='tc_code']").val();
	    	param = param + "&type=list";
	    	$.ajax({
				type:'POST',
				url : "<c:url value='/system/templateHitManagerListPopProc.do'/>",
				data:param,
				dataType : "json",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
				beforeSend: function() {
		        	
		        },
				success : function(json){
					drawList(json['list']);
				},
				
				error:function(request,status,error){
					
				}
				
			}).complete(function() {
				
	        });
	    	
	    	
		});

    	
    	/**
    	리스트 다시 작성
    	**/
    	function drawList(list)
    	{
    		listObj = list;
    		var html = "";
    		html += " 		<table class='table table-bordered table-striped'>";
    		html += "<colgroup>	";
    		html += "		<col width='150px'>"
   			html += "		<col width='*'>	";
   			html += "		<col width='150px'>	";
   			html += "		<col width='150px'>	";
   			html += "		<col width='150px'>	";
        	html += "</colgroup>	       						";
        	
    		html += "<tr><th>No.</th><th>단어</th><th>가중치</th><th>순번</th><th>수정/삭제</th></tr>";
			
    		for(i=0;i<list.length;i++)
    		{
    			btn_edit = "<button type='button' class='btn' onClick=\"edit_form('"+list[i].code+"');\">수정</button>";
        		btn_del = "<button type='button' class='btn' onClick=\"del_proc('"+list[i].code+"');\">삭제</button>";
    			
    			html += "<tr>";
    			html += "	<td> "+list[i].code+"	</td>";
    			html += "	<td>	"+list[i].word+"	</td>";
    			html += "	<td>	"+list[i].val+"	</td>";
    			html += "	<td>	"+list[i].ord+"	</td>";
    			html += "	<td> "+btn_edit+"&nbsp;"+btn_del+"</td>";
    			html += "</tr>";
    			
    		}
    		html += "</table>";
			
    		$("#listpage").html(html);
    	}
    	
    	
    	
    	function add_form()
    	{
    		var title = "단어추가";
    		
    		var message ="";
    		message = message + "<div>";
    		message = message + "		<span style='width:80px;float:left'>단어</span>			<span width='*'><input type='text' class='input-xlarge' name='val1'></span><br>";
    		message = message + "		<span style='width:80px;float:left'>가중치</span>		<span width='*'><input type='text' class='input-xlarge' name='val2'></span><br>";
    		message = message + "		<span style='width:80px;float:left'>순번</span>			<span width='*'><input type='text' class='input-xlarge' name='val3'></span><br>";
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
    							    	
    							        
    							    	if(val1=="")
    							        {
    							        	alert("단어는 필수입력입니다.");
    							        	$("input[name='val1']").focus();
    							        	return ;
    							        }
    							    	
    							    	if(val2==""  || $.isNumeric(val2)==false)
    								    {
    							        	alert("가중치는 숫자만 입력가능하고, 필수입력입니다.");
    							        	$("input[name='val2']").focus();
    							        	return ;
    							        }
    							    	
    							    	if(val3=="" || $.isNumeric(val3)==false)
    							        {
    							        	alert("순번은 숫자만 입력가능하고, 필수입력입니다.");
    							        	$("input[name='val3']").focus();
    							        	return ;
    							        }
    							    	
    							    	
    							    	
    							    	
    							    	//등록
    							    	var param = "tc_code="+$("input[name='tc_code']").val();
    							    	param = param + "&word="+val1;
    							    	param = param + "&val="+val2;
    							    	param = param + "&ord="+val3;
    							    	param = param + "&type=add";
    							    	
    							    	
    						    		$.ajax({
    										type:'POST',
    										url : "<c:url value='/system/templateHitManagerListPopProc.do'/>",
    										data:param,
    										dataType : "json",
    										contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
    										beforeSend: function() {
    								        	
    								        },
    										success : function(json){
    											drawList(json['list']);
    										},
    										
    										error:function(request,status,error){
    											
    										}
    										
    									}).complete(function() {
    										
    							        });
    							    	
    							    	
    							    	//ajax로 데이터 처리
    							    	
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
    	수정 폼
    	**/
    	function edit_form(code)
    	{
    		
			var title = "단어수정";
    		var message ="";
    		var tempList = new Object();
    		var val1;
    		var val2;
    		var val3;
    		
    		for(i=0;i<listObj.length;i++)
    		{
    			if(listObj[i].code==code)
    			{
    				tempList = listObj[i];
    				break;
    			}
    		}
    		
    		
    		
    		
    		
    		message = message + "<div>";
    		message = message + "		<span style='width:80px;float:left'>단어</span>			<span width='*'><input type='text' class='input-xlarge' name='val1' value='"+tempList.word+"'></span><br>";
    		message = message + "		<span style='width:80px;float:left'>가중치</span>		<span width='*'><input type='text' class='input-xlarge' name='val2' value='"+tempList.val+"'></span><br>";
    		message = message + "		<span style='width:80px;float:left'>순번</span>			<span width='*'><input type='text' class='input-xlarge' name='val3' value='"+tempList.ord+"'></span><br>";
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
    							    	
    							        
    							    	if(val1=="")
    							        {
    							        	alert("단어는 필수입력입니다.");
    							        	$("input[name='val1']").focus();
    							        	return ;
    							        }
    							    	
    							    	if(val2==""  || $.isNumeric(val2)==false)
    								    {
    							        	alert("가중치는 숫자만 입력가능하고, 필수입력입니다.");
    							        	$("input[name='val2']").focus();
    							        	return ;
    							        }
    							    	
    							    	if(val3=="" || $.isNumeric(val3)==false)
    							        {
    							        	alert("순번은 숫자만 입력가능하고, 필수입력입니다.");
    							        	$("input[name='val3']").focus();
    							        	return ;
    							        }
    							    	
    							    	//수정
    							    	var param = "tc_code="+$("input[name='tc_code']").val();
    							    	param = param + "&code="+code;
    							    	param = param + "&word="+val1;
    							    	param = param + "&val="+val2;
    							    	param = param + "&ord="+val3;
    							    	param = param + "&type=update";
    							    	
    							    	
    						    		$.ajax({
    										type:'POST',
    										url : "<c:url value='/system/templateHitManagerListPopProc.do'/>",
    										data:param,
    										dataType : "json",
    										contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
    										beforeSend: function() {
    								        	
    								        },
    										success : function(json){
    											drawList(json['list']);
    										},
    										
    										error:function(request,status,error){
    											
    										}
    										
    									}).complete(function() {
    										
    							        });
    							    	
    							    	
    							    	//ajax로 데이터 처리
    							    	
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
    		삭제
    	**/
    	function del_proc(code)
    	{
    		//수정
	    	var param = "tc_code="+$("input[name='tc_code']").val();
	    	param = param + "&code="+code;
	    	param = param + "&type=delete";
	    	
	    	$.ajax({
				type:'POST',
				url : "<c:url value='/system/templateHitManagerListPopProc.do'/>",
				data:param,
				dataType : "json",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
				beforeSend: function() {
		        	
		        },
				success : function(json){
					drawList(json['list']);
				},
				
				error:function(request,status,error){
					
				}
				
			}).complete(function() {
				
	        });
    	}
    	
    	
    	
    	
    </script>
   
			<c:import url="/common/pageLink.do?link=inc/bottom_pop_layout" />
       	</div>
</div>