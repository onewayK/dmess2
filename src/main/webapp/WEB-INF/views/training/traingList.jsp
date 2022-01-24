<%@page import="kr.nshare.common.util.EgovProperties"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_layout" />
	<script src="<c:url value='/js/bootstrap/bootstrap-dialog.js'/>"></script>

	<!-- bootstrap dialog -->
	<link href="<c:url value='/css/bootstrap/bootstrap-dialog.css'/>" rel="stylesheet">
		
	<div id="PageHeight" class="container-fluid">
		
		
		<ul class="breadcrumb">
            <li>
                  <i class="fa-icon-home"></i> Home / 훈련관리 /<strong>훈련리스트</strong>
            </li>
        </ul>
        <!-- navi 
        <br>
        <ul class="nav nav-tabs">
		  <li class="active"><a href="<c:url value='/training/TrainingList.do'/>">훈련리스트</a></li>
		  <li><a href="<c:url value='/training/TrainingList2.do'/>">취향분석 훈련리스트</a></li>
		</ul>
  -->
        
       		<!-- 검색 -->
        	<form name='search' method="post">
        	<input type='hidden' name='pageNo' value='<c:out value="${searchVO.pageNo }"/>'>
        	
        	<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-user"></i><span class="break"></span>훈련리스트</h2>
					  <%if(EgovProperties.getProperty("Globals.service_type").equals("0")){ %>
						 <c:choose>
                        	<c:when test="${userInfo.lev=='admin'}">
                        			<a  href='#' class="btn-md btn-link" onClick="training_del_valid_pop()" style="float: right"><span class="break"></span><i class="fa fa-trash-o fa-1"></i>&nbsp;&nbsp;삭제될 훈련 조회</a>
	                        </c:when>
	                    </c:choose>
						 <%} %>
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
	       		 			<col width="60px">
	       		 			 <%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
			       		 		  <col width="100px">
	       		 			<%}%>
	       		 			<col width="80px">
	       		 			<col width="250px">
	       		 			<col width="*">
	       		 			<col width="100px">
	       		 			<col width="200px">
	       		 			<col width="120px">
	       		 			<col width="120px">
	       		 			<col width="120px">
	       		 			<col width="130px">
	       		 			<col width="130px">
	       		 		</colgroup>
	       		 		 <thead>
					      <tr>
					        <th rowspan='2'>번호</th>
					        <%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
			       		 		  <th rowspan='2'>서비스타입</th>
			       		 	<%}%>
					        <th rowspan='2'>훈련타입</th>
					        <th rowspan='2'>기관/그룹</th>
					        <th rowspan='2'>훈련명</th>
					        <th rowspan='2'>발신인</th>
					        <th rowspan='2'>발신email</th>
					        <th colspan="3" align="center" width="250px" >훈련타입</th>
					        <th rowspan='2'>등록일</th>
					        <th rowspan='2'>진행상태</th>
					      </tr>
					      <tr>
					      		<th>메일열람</th>
					      		<th>링크(URL)실행</th>
					      		<th>첨부파일실행</th>
					      </tr>
					      
					    </thead>
					    <tbody>
					    	<c:choose>
						    		<c:when test="${fn:length(list)>0}">
						    			<c:forEach var="list" items="${list}" varStatus="status">						    			
								    	<tr>
				       		 				<td><c:out value="${list.code}"/></td>
				       		 			
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
				       		 					<c:choose>
				       		 						<c:when test="${list.type eq '0' }">
				       		 						일반
				       		 						</c:when>
				       		 						<c:when test="${list.type eq '1' }">
				       		 						<li>취향</li>
				       		 						</c:when>
				       		 					</c:choose>
				       		 				</td>
				       		 									       		 			
				       		 				<td>
				       		 					<c:out value="${list.institution_name}"/> / 
				       		 					<c:choose>
				       		 						<c:when test="${ list.group_name eq null || list.group_name eq ''}">
				       		 							[그룹미지정]
				       		 						</c:when>
				       		 						<c:otherwise>
				       		 							<c:out value="${list.group_name}"/>	
				       		 						</c:otherwise>
				       		 					</c:choose>
				       		 					
				       		 				</td>
				       		 				
				       		 				<td>
				       		 					<c:out value="${list.tname}"/>
				       		 					<c:choose>
					       		 					<c:when test="${list.del_flag == 'y' && list.del_type=='a'}">
					       		 						<br><p ><font color='red'>(자동 삭제 정책에 의해서 훈련대상자 정보가 삭제처리됨)</font></p>
					       		 					</c:when>
					       		 					<c:when test="${list.del_flag == 'y' && list.del_type=='a'}">
					       		 						<br><p ><font color='red'>(수동 삭제 정책에 의해서 훈련대상자 정보가 삭제처리됨)</font></p>
					       		 					</c:when>
				       		 					</c:choose>
				       		 				
				       		 				</td>
				       		 				<c:choose>
				       		 					<c:when test="${list.type eq '0' }">
				       		 						<td><c:out value="${list.send_name}"/></td>
				       		 						<td><c:out value="${list.send_email}"/></td>
				       		 						<td class='text-center'><c:out value="${list.training_type1}"/></td>
						       		 				<td class='text-center'><c:out value="${list.training_type2}"/></td>
						       		 				<td class='text-center'><c:out value="${list.training_type3}"/></td>
				       		 					</c:when>
				       		 					<c:otherwise>
				       		 						<td colspan="5" class="center"> 
				       		 							
				       		 							<c:choose>
				       		 								<c:when test="${list.user_cnt<=0   }">
				       		 									<font color='red'>훈련 대상자 미등록 상태 입니다.<br>훈련대상자를 등록하여주세요!</font>
				       		 								</c:when>
				       		 								<c:when test="${list.status=='step1' || list.user_cnt<=0   }">
				       		 									<font color='red'>step2의 정보가 미등록되었습니다.<br> 등록해주세요.</font>
				       		 								</c:when>
				       		 								
				       		 								<c:otherwise>
				       		 									<a href='#' class="btn btn-primary" onClick="type2DetailSetting('<c:out value="${list.code}"/>');">상세보기</a>
				       		 								</c:otherwise>
				       		 							</c:choose>
				       		 							
				       		 							
				       		 						</td>	
				       		 					</c:otherwise>
				       		 				</c:choose>
				       		 				
				       		 				<td><c:out value="${list.sdate}"/></td>				       		 				
				       		 				<td>
				       		 				<c:choose>
				       		 					<c:when test="${list.del_flag == 'y' && list.del_type=='a'}">
				       		 						<a class="btn" onClick="view('${list.code}')">보기</a>
				       		 						
				       		 					</c:when>
				       		 					<c:when test="${list.del_flag == 'y' && list.del_type=='a'}">
				       		 						<a class="btn" onClick="view('${list.code}')">보기</a>
				       		 						
				       		 					</c:when>
				       		 					<c:otherwise>
				       		 							<c:choose>
						       		 						<c:when test="${list.status=='step1' }">
						       		 							<a class="btn" onClick="view('${list.code}')">준비(step1)</a> 
						       		 						</c:when>
						       		 						<c:when test="${list.status=='ready' }">
						       		 							<a class="btn" onClick="view('${list.code}','${list.type }')">준비</a>
						       		 							<a class="btn" onClick='copy("${list.tname}","${list.code}");'>복사</a>
						       		 						</c:when>
						       		 						<c:when test="${list.status=='send' || list.status=='sending' || list.status=='receive'}">
						       		 							<a class="btn" onClick="view('${list.code}','${list.type }')">실행중</a>
						       		 						</c:when>				       		 						
						       		 						<c:when test="${list.status=='end' }">
						       		 							<a class="btn" onClick="view('${list.code}','${list.type }')">완료</a>
						       		 							<a class="btn" onClick='copy("${list.tname}","${list.code}");'>복사</a>
						       		 						</c:when>
						       		 						<c:when test="${list.status=='stop' }">
						       		 							<a class="btn" onClick="view('${list.code}','${list.type }')">발송중지</a>
						       		 						</c:when>
						       		 						<c:when test="${list.status=='stopping' }">
						       		 							<a class="btn" onClick="view('${list.code}','${list.type }')">발송중지중</a>
						       		 						</c:when>
						       		 						<c:when test="${list.status=='resend' }">
						       		 							<a class="btn" onClick="view('${list.code}','${list.type }')">재준비</a>
						       		 						</c:when>
						       		 						<c:when test="${list.status=='init' }">
						       		 							<a class="btn" onClick="view('${list.code}','${list.type }')">초기화중</a>
						       		 						</c:when>
						       		 						<c:when test="${list.status=='approval' }">
						       		 							<a class="btn" onClick="view('${list.code}','${list.type }')">승인요청중</a>
						       		 						</c:when>
						       		 						<c:when test="${list.status=='reservation' }">
						       		 							<a class="btn" onClick="view('${list.code}','${list.type }')">진행대기중</a>
						       		 						</c:when>											       		 						
						       		 						<c:otherwise>
						       		 							null
						       		 						</c:otherwise>
						       		 						
						       		 					</c:choose>
						       		 				</c:otherwise>
				       		 				</c:choose>
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
	       		 	<%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
	       		 		<a href='#' class="btn btn-primary" onClick="choseServicTypeForm();">등록</a>
	       		 	<%}else{%>
	       		 			<a href='#' class="btn btn-primary" onClick="choseInsertForm('훈련등록 타입선택');">등록</a>	       		 		
	       		 	<%}%>
	       		 	</div>
	       		 	
	       		 	<div class="clearFix"></div>
       		 	</div>
			</div>
			</div>
			
    </div>
    <%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
     <div id="dialog-confirm-service" title="훈련 서비스 타입선택" style="display:none">
	  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:15px 15px 40px 0;"></span>
	  	훈련등록시 테스트 훈련과 실전 훈련을 등록하실수있습니다. 등록이 진행된후에는 각 훈련간 변경이 불가능합니다. 주의 하여 선택해주세요.</p>
	  	 
	  	<p>
	  		
	  		<input type="radio" name="service_type" value="0" checked="checked"> 테스트 훈련
	  		<input type="radio" name="service_type" value="1"> 실전 훈련
	  		
	  	</p>
	</div>
	 <%}%>
    
    <div id="dialog-confirm" title="훈련등록 타입선택" style="display:none">
	  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:15px 15px 40px 0;"></span>
	  	훈련등록시 일반훈련과 취향분석 훈련을 등록하실수있습니다. 등록이 진행된후에는 각 훈련간 변경이 불가능합니다. 주의 하여 선택해주세요.</p>
	  <p>
	  		<input type='hidden' name='selected_service_type' id='selected_service_type'>
	  		<input type="radio" name="type" value="0" checked="checked"> 일반훈련
	  		<input type="radio" name="type" value="1"> 취향분석훈련
	  		
	  	</p>
	</div>
    
    <form name='frm' method="post">
    	<input type='hidden' name='code' value='' hidden="hidden">
    </form>
    
    <form name='insert_frm' method="post">
    	<input type='hidden' name='service_type' value='' hidden="hidden">
    </form>
    
    <style>
		.detail-dialog 
		{
			width:1000px;
			position: fixed;
		    left: 40%;
		    
		}	
	</style>
    <script>
	    function choseServicTypeForm()
		{
	    	$("#dialog-confirm-service").dialog({
			      resizable: false,
			      position:'top',
			      height: "auto",
			      width: 800,
			      modal: true,
			      buttons: {
			    	  "테스트 훈련": function() {
			    			$("input:radio[name='service_type']:radio[value='0']").prop("checked",true);
			    	},
	 		        "실전 훈련": function() {
	 		        		$("input:radio[name='service_type']:radio[value='1']").prop("checked",true);
	 		          },
	 		        "다음": function() {
	 		        		var title= "";	
	 		        	
			 		       	if($(':radio[name="service_type"]:checked').val()=="0")
				        	{
		 		        		$("#selected_service_type").val("test");
				        		$("#dialog-confirm-service").dialog("close");			        		
				        		title="테스트 훈련등록 타입선택";
				        	}else if($(':radio[name="service_type"]:checked').val()=="1"){
				        		$("#selected_service_type").val("real");
				        		$("#dialog-confirm-service").dialog("close");				        		
				        		title="실전 훈련등록 타입선택";
				        	}
			 		       	
			 		        choseInsertForm(title);
 		    	    } 		 		     	
		      
			      }
			    });
	    	
		}
    
    	function choseInsertForm(title)
    	{
    		
    		$("#dialog-confirm").dialog({
    				title:title,
    		      resizable: false,
    		      position:'top',
    		      height: "auto",
    		      width: 800,
    		      modal: true,
    		      buttons: {
    		    	  <%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
    		    	
    		    	  "이전":{
    		    		  text: '이전',
    		    		  style:"margin-right:400px",  
	  		              click : function() {
		    		    		$("#dialog-confirm").dialog("close");
		    		    		$("#selected_service_type").val("");
		    		    		choseServicTypeForm();
		    		    		$("dialog-confirm-service").text('훈련 서비스 타입선택'); 
		         		  }
	    		   	},
         		  	<%}%>
   		    	  "일반훈련": function() {
   		    			$("input:radio[name='type']:radio[value='0']").prop("checked",true);
       		        },
       		        "취향분석훈련": function() {
       		        	$("input:radio[name='type']:radio[value='1']").prop("checked",true);
       		        }
       		     	,"생성": function() {	       		    
    		     	
    		        	if($(':radio[name="type"]:checked').val()=="0")
    		        	{
    		        		document.insert_frm.service_type.value = $("#selected_service_type").val();
    		        		document.insert_frm.action = "/training/trainingForm.do";
    		        		document.insert_frm.submit();
    		        	}
    		        	else if( $(':radio[name="type"]:checked').val()=="1")
   		        		{
    		        		document.insert_frm.service_type.value = $("#selected_service_type").val();
    		        		document.insert_frm.action = "/training/trainingForm2_step1.do";
    		        		document.insert_frm.submit();
    		        	}
    		        }
 		      
    		      }
    		    });
    	}
    
    	/**
    	수정 및 상세보기
    	**/
    	function view(code, type)
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
    
	    /**
	    검색
	    **/
    	function fn_search()
    	{
    		document.search.pageNo.value = 1;
    		document.search.action = "/training/TrainingList.do";
    		document.search.submit();
    	}
	    
	    function fn_reload()
	    {
	    	document.search.action = "/training/TrainingList.do";
    		document.search.submit();
	    }
    	
	    /**
	    페이지 이동
	    **/
    	function goPage(pageno)
    	{
	    	document.search.pageNo.value = pageno;
	    	document.search.action = "/training/TrainingList.do";
    		document.search.submit();
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
					messages += "		<th>첨부파일실행</th>";
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
								
					//messages = messages + "<label class='control-label' for='date01'>"+title +"&nbsp;"+"</>";
					
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
	     훈련 복사
	    **/
	    function copy(ori_title, code)
	    {
	    	var ajax_status = false;
	    	var title = "'"+ori_title.replace("'","")+"' 훈련복사";
			var messages ="";
			
			messages = "훈련대상자들은 제외된 상태에서 기존훈련명에 _copy 가 붙은 형태로 생성됩니다.";
			//messages = messages + "<label class='control-label' for='date01'>"+title +"&nbsp;"+"</>";
			
			
			var dia  = BootstrapDialog.show({
				title:title ,
		           message: messages,
		           closable: true,
		           closeByBackdrop: false,
		           closeByKeyboard: false,
		           buttons: [
								{
								    label: '복사',
								    action: function(dialogRef)
								    {
								    	var inputbox = $("input[name='val']").val();
								    	
								    	param = "code="+code;
								    	if (confirm("정말 복사하시겠습니까?") == true){   
								    	    
									    	$.ajax({
												type:'POST',
												url : "<c:url value='/training/training_copy.do'/>",
												data:param,
												dataType : "json",
												contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
												beforeSend: function() {
										        
												},
												success : function(json){
													ajax_status = true;
													console.log(json);
													if(json.status=="ok")
													{
														alert("정상적으로 훈련이 복사 되었습니다.");
														fn_reload();
													}
												},
												error:function(request,status,error){
													alert("복사가 실패하였습니다:"+error);
												}
												
											}).complete(function() {
															
									        });
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
	    $(function(){
			$.contextMenu({
		        selector: '.contentMenu', 
		        trigger: 'left',
		        callback: function(key, options) 
		        {
		        	//ws_code = $(this).attr("ws_code");
		        	if(key=="traing_detail")
		            {
		            	var training_code = $(this).attr("training_code");
						
		            	//상세보기 함수 호출
						type2DetailSetting(training_code);
		            	
		            }
		        },
		        items: {
		        	"traing_detail": {name: "훈려대상자 상세보기"}
		    	}
		        
			        	
				    
		    
		    });
		});
	    
	    function training_del_valid_pop(){
        	
        	url = "/training/training_del_valid_pop.do";
        	fn_openwindow(url,  '800px', '500px', 'training_del_valid_pop');	
        
        }
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />