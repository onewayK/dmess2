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

	<!-- navi -->
	<ul class="breadcrumb">
		<li><i class="fa-icon-home"></i> Home / <strong>카테고리 등록</strong>
		</li>
	</ul>

	<div class="panel panel-default">
		
		
		
		<form name="frm" id="frm" method="post"  enctype="multipart/form-data">
		
		<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-user"></i><span class="break"></span>카테고리 등록</h2>
					</div>
					<div class="box-content">
							<div class="form-horizontal "> 
							
									<div class="control-group">
									  <label class="control-label" for="typeahead"><img src="<c:url value='/'/>images/required.gif" width="15" height="15" />카테고리명</label>
									  <div class="controls">
									  <input type="hidden"name='pageType' value='${pageType}'>
									  <input type="hidden" name='code' value='${detail.code }'>
									  
										<input style="width: 200px" type='text' name='cate_name' maxlength='20' required='required' class="fl" value="<c:if test="${pageType=='update'}"><c:out value="${detail.cate_name }"/></c:if>">
							  			</div>
									</div>
									
									<div class="form-horizontal "> 
										<div class="control-group">
										  <label class="control-label" for="typeahead">단어추가</label>
										  <div class="controls">
										  		<button id="btn_add" type="button" class="btn btn-info" onClick='add_word();'>단어등록</button>
										 </div>	
										</div>	
									</div>		
									
									<div class="form-horizontal "> 
							 		<div class="control-group">
									  <label class="control-label" for="typeahead">단어리스트</label>
									  <div class="controls">
									  		<div class="box-content" style='padding:3px';> 
									  		<div style='height:400px; overflow-y: scroll;'>
										  		<table class="table table-bordered table-striped">
							       		 		<colgroup>
							       		 			<col width="60%">
							       		 			<col width="15%">
							       		 			<col width="15%">
							       		 			<col width="10%">
							       		 		</colgroup>
							       		 		 <thead>
											      <tr>
											         <th rowspan='1'>단어</th>
											        <th rowspan='1'>가중치</th>								        
											        <th rowspan='1'>순번</th>
											        <th rowspan='1'>수정/삭제</th>
											      </tr>
											    </thead>
											    <tbody id='wordList' name='wordList'>								    	
												
											    </tbody>								    
							       		 	  </table>
									  		</div>
						       		 	</div>
									</div>	
								</div>	
									
						 </div>				
					 
						<div class="pull-right">
							<c:choose>
								<c:when test="${pageType eq 'insert' }">
									<a href='#' onClick='category_send()' class="btn btn-primary">등록</a>
								</c:when>
								<c:when test="${pageType eq 'update'}">
									<a href='#' onClick='category_send()' class="btn">수정</a>
									<c:choose>
										<c:when test="${detail.lev == 'admin'}">
											<a href='#' onClick="deleteCategory();" class="btn">삭제</a>
										</c:when>
									</c:choose>
								</c:when>
							</c:choose>
							<a href="/system/templateHitManagerList.do" class="btn">리스트</a>
						</div>
						<div class="clearFix"></div>
				
						</div>
						
					</div>
				</div>
			</div>
		</form>
		</div>
	</div>
</div>
<script type="text/javascript" src="/js/HuskyEZCreator.js" charset="utf-8"></script>
<script>

	var listcnt = 0;

	$( document ).ready(function() {
		
		<c:choose>
		<c:when test="${fn:length(list)>0}">
			<c:forEach var="list" items="${list}" varStatus="status">
			     
				word_html=addWordList('${list.word}','${list.val}','${list.ord}');
			     if(listcnt == 0){
			    		$('#wordList').html(word_html);
			    	}else{
			    		$('#wordList:last').append(word_html);
			    }
			     listcnt++;
			</c:forEach>
		</c:when>
		<c:otherwise>
		('#wordList').html("<tr><td colspan='4' align='center'>no list</td></tr>");	
		 </c:otherwise>
		</c:choose>
	})

	//저장
	function category_send()
	{
		//훈련명 체크
		if($("input[name='cate_name']").val().length > 15)
		{
			alert('카테고리명은 15자 이상을 초과할 수 없습니다..');
			return ;
		}
		
		//훈련기간 체크
		if($("input[name='cate_name']").val() =="")
		{
			alert('카테고리명을 입력해주세요!');
			return ;
		}
		
		
		var frm = document.getElementById("frm");
		frm.action = "<c:url value='/system/categorySave.do'/>";
		<c:choose>
			<c:when test="${pageType eq 'insert' }">
				if(confirm("해당 카테고리를 생성하시겠습니까?")){
					frm.submit();
				}
			</c:when>
				
			<c:when test="${pageType eq 'update'}">
			if(confirm("해당 카테고리을 수정하시겠습니까?")){
				frm.submit();
			}
			</c:when>
		</c:choose>
	}
	
	/**
	 카테고리 삭제
	**/
	function deleteCategory()
	{
		var frm = document.getElementById("frm");
		
		if (confirm("해당 카테고리을 정말 삭제하시겠습니까?\n해당 카테고리에 속한 모든 템플릿과 단어들이 같이 삭제되며, \n복구는 불가능 합니다. 신중하게 신행해주시기 바랍니다.") == true)
		{  
			frm.action = "<c:url value='/system/category_del.do'/>";
			frm.submit();
		}
	}
	
	var listObj = null;
	
	function addWordList(word,val,ord)
	{
		var html = "";
		
		var btn_edit = "<button type='button' class='btn btn-info' onClick=\"edit_word('"+listcnt+"');\">수정</button>";
   		var btn_del = "<button type='button' class='btn btn-info' onClick=\"del_word(this);\">삭제</button>";
		
		html = html +"<tr id='key_"+listcnt+"'>";
		html = html +"	<td class='text-center'><span id='p_word_"+listcnt+"'> "+word+"</span><input type='hidden' name='wlistvo["+listcnt+"].word' value='"+word+"'></td>";
		html = html +"	<td class='text-center'><span id='p_val_"+listcnt+"'>"+val+"</span><input type='hidden' name='wlistvo["+listcnt+"].val' value='"+val+"'></td>";
		html = html +"	<td class='text-center'><span id='p_ord_"+listcnt+"'>"+ord+"</span><input type='hidden' name='wlistvo["+listcnt+"].ord' value='"+ord+"'></td>";
		html = html +"	<td  class='text-center'> "+btn_edit+"&nbsp;"+btn_del+"</td>";
		html = html +"<tr>";
		
		return html;
	}
	
	
	function add_word()
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
							    	
							    	var word_html=addWordList(val1,val2,val3);
							    	
							    	if(listcnt == 0){
							    		$('#wordList').html(word_html);
							    	}else{
							    		$('#wordList:last').append(word_html);
							    	}
							    	
							    	listcnt++;
							    	
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
	function edit_word(key)
	{	
		var title = "단어수정";
		var message ="";
		
		var word 	= $("input[name='wlistvo["+key+"].word']").val();
		var  val		= $("input[name='wlistvo["+key+"].val']").val();
		var ord 		= $("input[name='wlistvo["+key+"].ord']").val();
								
		message = message + "<div>";
		message = message + "		<span style='width:80px;float:left'>단어</span>			<span width='*'><input type='text' class='input-xlarge' name='val1' value='"+word+"'></span><br>";
		message = message + "		<span style='width:80px;float:left'>가중치</span>		<span width='*'><input type='text' class='input-xlarge' name='val2' value='"+val+"'></span><br>";
		message = message + "		<span style='width:80px;float:left'>순번</span>			<span width='*'><input type='text' class='input-xlarge' name='val3' value='"+ord+"'></span><br>";
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
							    	
							    	$("input[name='wlistvo["+key+"].word']").val(val1);
									$("input[name='wlistvo["+key+"].val']").val(val2);
									$("input[name='wlistvo["+key+"].ord']").val(val3);
									
									$("#p_word_"+key).html(val1);
									$("#p_val_"+key).html(val2);
									$("#p_ord_"+key).html(val3);			
							    	
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
	
	/** 단어 삭제
	**/
	function del_word(obj)
	{
		if(confirm('해당 매칭단어를 삭제하시겠습니까?'))
		{
			var tr = $(obj).parent().parent();
			tr.remove();
			
			listcnt--;		
		}
	}
</script>

<c:import url="/common/pageLink.do?link=inc/bottom_layout" />