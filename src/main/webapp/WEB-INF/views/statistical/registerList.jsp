<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="f"           uri="http://nshare.kr/taglib" %>
<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_layout" />
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
            <li>
                <i class="fa-icon-home"></i> Home / 통계 / <strong>신고리스트</strong>
            </li>
        </ul>
        
        	<!-- 검색 -->
        	<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-bar-chart"></i><span class="break"></span>신고리스트</h2>
					</div>
					<div class="box-content">
			        	<form name='search' id='search' method="post">
			        				<input type='hidden' name='pageNo' value='<c:out value="${searchVO.pageNo}"/>'>
			        				<input type='hidden' name='sortcolumn' value='<c:out value="${searchVO.sortcolumn}"/>'>
			        				<input type='hidden' name='orderBy' value='<c:out value="${searchVO.orderBy }"/>'>
				        			<div class="form-horizontal">
										<div class="control-group span10">
										  <label class="control-label" for="typeahead">검색인자</label>
										  <div class="controls">										

											<!-- 기관코드  -->
					        				<select name='searchInstitution' id="searchInstitution" onChange="chgInstitution(this.value)">
												<option value="">선택하세요</option>
												<c:forEach var="list2" items="${list2}" varStatus="status">																						
													<option value="${list2.code }" <c:if test="${searchVO.searchInstitution eq list2.code }"> selected </c:if>><c:out value="${list2.institution_name}"/></option>												
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
						        			
						        			<span>
						        				<select name="searchCondition">
					        						<option value='name' <c:if test="${searchVO.searchCondition=='name' }"> selected </c:if>>이름</option>
					        						<option value='email' <c:if test="${searchVO.searchCondition=='email' }"> selected </c:if>>이메일</option>
					        					</select>
						        				<input type="text" id="searchKeyword" name="searchKeyword" value="${searchVO.searchKeyword }">
						        			</span>
						        			<input type="checkbox" id="reduplication_chk" name="reduplication_chk" onClick="check_reduplication_use();" <c:if test="${searchVO.reduplication== 'Y' }"> checked </c:if>><span tooltipmessage="해당 선택박스 체크하고 검색하실 경우 <br>신고자이메일과 신고자이름이 중복되는 항목 및 사용자 매칭이 실패한 항목을 제외하고 표시합니다.<br>(중복된 항목은 최초 신고항목만 표시)" >매칭항목만 표시</span>
											<input type='hidden' name='reduplication' id='reduplication' value="N"/>
										  </div>
										</div>
										<div class="pull-right">
											<a href='#' onClick='fn_search()' class="btn">검색</a>
										</div>
									</div>
			        	
				        </form>
				        <div class="clearFix"></div>
	        		</div>
	        	</div>
	        </div>
	        
	        <div class="row-fluid">
		        <div class="box span12">
						<div class="box-header">
							<h2>
								<i class="fa-icon-bar-chart"></i><span class="break"></span>
									<c:choose>
										<c:when test="${trainingDetail ne null }">
										
											<c:out value="${trainingDetail.tname }"/>
												(<c:out value="${trainingDetail.start_date }"/>~<c:out value="${trainingDetail.end_date }"/>)
										</c:when>
									</c:choose>									
							</h2>
																					
						<c:choose>
							<c:when test="${trainingDetail ne null }">
							<h2 style="float:right"><span class="break"></span>		
								<a href="#" onclick="register_download(); return false;"><i class="fa-icon-print"></i>Excel</a>
							</h2>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${trainingDetail ne null }">
							<h2 style="float:right"><span class="break"></span>		
								<a href="#" onclick="pop_report();"><i class="fa fa-file-text-o"></i>리포트 조회</a>
							</h2>
							</c:when>
						</c:choose>
						</div>
						<div class="box-content">
						
								<table id="tablesort" name="tablesort" class="table table-bordered table-striped">
				       		 		<colgroup>
				       		 			<col width="60px">
				       		 			<col width="100px">
				       		 			<col width="100px">
				       		 			<col width="100px">
				       		 			<col width="100px">
				       		 			<col width="60px">
				       		 			<col width="100px">
				       		 			<col width="100px">
				       		 			<col width="90px">
				       		 		</colgroup>
				       		 		 <thead>
								      <tr>
								        <th rowspan='1' id="header_code" onclick="goSort('code','<c:out value="${pageing.pageNo}"/>');">번호</i></th>
								        <th rowspan='1' id="header_title" onclick="goSort('title','<c:out value="${pageing.pageNo}"/>');">신고제목 </th>
								        <th rowspan='1' id="header_email" onclick="goSort('email','<c:out value="${pageing.pageNo}"/>');">신고자이메일</th>
								        <th rowspan='1' id="header_name" onclick="goSort('name','<c:out value="${pageing.pageNo}"/>');">신고자이름</th>
								        <th rowspan='1' id="header_matching_flag" onclick="goSort('matching_flag','<c:out value="${pageing.pageNo}"/>');">매칭유무</th>
								        <th rowspan='1' id="header_type1_use" onclick="goSort('type1_use','<c:out value="${pageing.pageNo}"/>');">메일열람</th>
								        <th rowspan='1' id="header_type1_date" onclick="goSort('type1_date','<c:out value="${pageing.pageNo}"/>');">메일열람시간</th>
								        <th rowspan='1' id="header_sdate" onclick="goSort('sdate','<c:out value="${pageing.pageNo}"/>');">신고시간</th>
								        <th rowspan='1' id="header_registertime_use" onclick="goSort('registertime_use','<c:out value="${pageing.pageNo}"/>');">신고시간준수</th>
								      </tr>
								      
								       
								    </thead>
								<!--      <c:set var="register_num" value="${pageing.startRowNum}"/>  <c:set var="register_num" value="${register_num + 1}"/>   <td class="text-center"><c:out value="${register_num}"/></td>-->
								    <tbody>
								    	<c:choose>
									    		<c:when test="${fn:length(list)>0}">
									    			<c:forEach var="list" items="${list}" varStatus="status">
						       		 				<tr onclick="view('<c:out value="${list.code}"/>');" style="cursor: hand">
							       		 				
							       		 				
							       		 				<td class="text-center"><c:out value="${list.code}"/></td>
							       		 				<td class="text-center"><c:out value="${list.title}"/></td>
							       		 				<td class="text-center"><c:out value="${list.email}"/></td>
							       		 				<td  class="text-center"><c:out value="${list.name}"/></td>
							       		 				<td class="text-center">
							       		 					<c:choose>
							       		 						<c:when test="${list.matching_flag eq 'Y'}">사용자 매칭O</c:when>
							       		 						<c:when test="${list.matching_flag eq 'N'}">사용자 매칭X</c:when>
							       		 						<c:when test="${list.matching_flag eq 'C'}">관리자 접수</c:when>
							       		 						<c:when test="${list.matching_flag eq 'C_Y'}">관리자 접수(사용자매칭O)</c:when>
							       		 						<c:when test="${list.matching_flag eq 'C_N'}">관리자 접수(사용자매칭X)</c:when>
							       		 					    <c:otherwise>
																				사용자 매칭X
																</c:otherwise>
							       		 					</c:choose>
							       		 				</td>
							       		 				<td class="text-center"><c:out value="${list.type1_use}"/></td>
							       		 				<td class="text-center">
							       		 					<c:choose>
							       		 						<c:when test="${list.type1_use eq 'O'}"><c:out value="${list.type1_date}"/></c:when>
							       		 						<c:otherwise>
																				-
																</c:otherwise>
							       		 					</c:choose>
							       		 				</td>							       		 				
							       		 				<td  class="text-center"><c:out value="${list.sdate}"/></td>
							       		 				<td  class="text-center">
						       		 						<c:out	value="${list.registertime_use}" />
															<c:choose>
																<c:when test="${list.registertime_use eq 'X'}">
																	<div class="text-center"><span tooltipmessage="신고준수 시간 : <c:out value='${list.register_time}' />뷴 이내" >(초과&nbsp;<c:out value="${list.register_excess_time}" />)</span></div>
																</c:when>
															</c:choose>
							       		 				</td>
							       		 								       		 										       		 				
							       		 			</tr>
							       		 			<td id="tr_<c:out value="${list.code}"/>" colspan="9" style="display:none" onclick="close_view('<c:out value="${list.code}"/>')">
<pre>
<c:out value="${f:nl2br_html(list.content) }" escapeXml="false"/>
</pre>
						       		 				</td>		
							       		 			</c:forEach>
									    		</c:when>
									    		<c:otherwise>
									    			<tr>
							       		 				<td colspan="9" align="center">no list</td>
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
				       		 		<a href='#' class="btn btn-primary" onClick="choseInsertForm();">등록</a>
				       		 	</div>
				       		 	       		 	
								
					    		<div class="clearFix"></div>
		        		</div>
		        </div>
	        </div>
    </div>
    <div id="dialog-confirm" title="신고 등록타입선택" style="display:none">
	  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:15px 15px 40px 0;"></span>
	  	신고등록시 개별적으로 등록과 엑셀파일로 일괄등록 할 수 있습니다. 개별적등록시 신고시간은 설정 불가능합니다. 주의하여 선택해주세요.</p>
	  	<p>
	  		<input type="radio" name="type" value="0" checked="checked"> 개별등록
	  		<input type="radio" name="type" value="1"> 일괄등록
	  	</p>
	</div>
    
    <form name='frm' method="post">
    	<input type='hidden' name='code' value=''>
    </form>
    <script>   

    var cur_training_code = "<c:out value="${searchVO.training_code}"/>";

    $("#training_code").chosen(
    		{
    			no_results_text: "해당 훈련이 존재하지 않습니다.",
    			width: 200		
    		}
    ); 

    <c:choose>
		<c:when test="${trainingDetail ne null }">
				change_header();
		</c:when>
	</c:choose>	
   
    check_reduplication_use();
    
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
					if(cur_training_code==json[i].code)
					{
						html = html + "<option value='"+json[i].code+"' selected >"+json[i].group_name+"</option>";
					}
					else
					{
						html = html + "<option value='"+json[i].code+"'>"+json[i].group_name+"</option>";	
					}
					
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
						if(cur_training_code==json[i].code)
						{
							html = html + "<option value='"+json[i].code+"' selected >"+json[i].tname+"</option>";
						}
						else
						{
							html = html + "<option value='"+json[i].code+"'>"+json[i].tname+"</option>";	
						}
						
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
	
	function fn_search()
	{
		
    	if($("#searchInstitution").val()=="" )
    	{
    		alert('기관을 선택해주세요!');
    		return ;
    	}
    	else if($("#group_code").val()=="")
    	{
    		alert('그룹명을 선택해주세요!');
    		return ;
    	}
    	else if($("#training_code").val()=="")
    	{
    		alert('훈련명을 선택해주세요!');
    		return ;
    	}   
    	else
    	{
    		$('#overlay').show();   
    		
    		document.search.sortcolumn.value = ''; 
        	document.search.orderBy.value = '';
        	
    		document.search.pageNo.value = 1;
			document.search.action = "/statistical/registerList.do";
			document.search.submit();
    	}
	}
	
	  /**
    페이지 이동
    **/
	function goPage(pageno)
	{
		$('#overlay').show();   
		
    	document.search.pageNo.value = pageno;
    	document.search.action = "/statistical/registerList.do";
		document.search.submit();
	}
	
	  /**
    정렬
    **/
	function goSort(column,pageno)
	{
		$('#overlay').show();   
		
		var orderBy=$("input[name='orderBy']").val()
		
		if(column != $("input[name='sortcolumn']").val()){
			orderBy='asc';			
		}else if(orderBy == 'asc'){
			orderBy='desc';		
		}else{
			orderBy='asc';
		}

    	document.search.pageNo.value = pageno;
    	
		document.search.sortcolumn.value = column; 
    	document.search.orderBy.value = orderBy;
		
    	document.search.action = "/statistical/registerList.do";
		document.search.submit();
	} 
	  
	 /**
  	 해더 정렬 이미지 변경
    **/
	function change_header()
	{
		var sort="&nbsp;&nbsp;<i class='fa fa-sort'></i>";
		var sort_desc_asc;
		
		var sortcolumn=$("input[name='sortcolumn']").val();
		var orderBy=$("input[name='orderBy']").val();
		
		if(orderBy == 'desc'){
			sort_desc_asc="&nbsp;&nbsp;<i class='fa fa-sort-desc'></i>";
		}else{
			sort_desc_asc="&nbsp;&nbsp;<i class='fa fa-sort-asc'></i>";
		}
		
		$("#header_code").html("번호"+sort);	
		$("#header_title").html("신고제목"+sort);	
		$("#header_email").html("신고자이메일"+sort);	
		$("#header_name").html("신고자이름"+sort);	
		$("#header_matching_flag").html("매칭유무"+sort);	
		$("#header_type1_use").html("메일열람"+sort);	
		$("#header_type1_date").html("메일열람시간"+sort);	
		$("#header_sdate").html("신고시간"+sort);	
		$("#header_registertime_use").html("신고시간준수"+sort);		
		
		if(sortcolumn == 'code'){
			$("#header_code").html("번호"+sort_desc_asc);	
		}else if(sortcolumn == 'title'){
			$("#header_title").html("신고제목"+sort_desc_asc);	
		}else if(sortcolumn == 'email'){
			$("#header_email").html("신고자이메일"+sort_desc_asc);	
		}else if(sortcolumn == 'name'){
			$("#header_name").html("신고자이름"+sort_desc_asc);	
		}else if(sortcolumn == 'matching_flag'){
			$("#header_matching_flag").html("매칭유무"+sort_desc_asc);	
		}else if(sortcolumn == 'type1_use'){
			$("#header_type1_use").html("메일열람"+sort_desc_asc);
		}else if(sortcolumn == 'type1_date'){
			$("#header_type1_date").html("메일열람시간"+sort_desc_asc);
		}else if(sortcolumn == 'sdate'){
			$("#header_sdate").html("신고시간"+sort_desc_asc);	
		}else if(sortcolumn == 'registertime_use'){
			$("#header_registertime_use").html("신고시간준수"+sort_desc_asc);	
		}else{
			$("#header_code").html("번호"+sort_desc_asc);	
		}
		
		
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
    
	function choseInsertForm()
	{
		
		$("#dialog-confirm").dialog({
		      resizable: false,
		      position:'center',
		      height: "auto",
		      width: 800,
		      modal: true,
		      buttons: {
		    	  "개별등록": function() {
		    			$("input:radio[name='type']:radio[value='0']").prop("checked",true);
   		        },
   		        "일괄등록": function() {
   		        	$("input:radio[name='type']:radio[value='1']").prop("checked",true);
   		        }
   		     	,"실행": function() {
		        	
		        	if($(':radio[name="type"]:checked').val()=="0")
		        	{
		        		$(location).attr('href', '/statistical/register.do');  
		        	}
		        	else if( $(':radio[name="type"]:checked').val()=="1")
		        		{
		        		$(location).attr('href', '/statistical/register2.do');  
		        	}
		        }
		      
		      }
		    });
	}
	
	/**
	* 중복 및 매칭 x 항목 제거 기능 사용 체크
	**/
	function check_reduplication_use()
	{		
		if($("input:checkbox[name='reduplication_chk']").is(":checked")==true)
		{
			$("input[name='reduplication']").val('Y');
			
		}else{		
			$("input[name='reduplication']").val('N');
			
		}
	}
	
	/**
		register donwload
	**/
	function register_download()
	{	
		var frm = document.getElementById("search");
			    	
		frm.action = "<c:url value='/statistical/register_excel.do'/>";
		frm.submit();
	}
	
	//발신자 추가
	function pop_report()
	{
		
		var url = '<c:url value="/statistical/register_report_pop.do"/>';
		
		url = url + "?training_code="+cur_training_code;
		
		
   		fn_openwindow(url,  '1530px', '700px', 'register_report_pop');    	
	}
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />