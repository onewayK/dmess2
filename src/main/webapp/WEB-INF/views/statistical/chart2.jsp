<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_layout" />
		
	<link href="/css/c3.min.css" rel="stylesheet">
	<script src="/js/d3.min.js"></script>
    <script src="/js/c3.min.js"></script>
	
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
                <i class="fa-icon-home"></i> Home / 통계 / <strong>그룹별 훈련 통계	</strong>
            </li>
        </ul>
        
  
        
        	<!-- 검색 -->
        	
        	
        	<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-bar-chart"></i><span class="break"></span>그룹별 훈련 통계	</h2>
					</div>
					<div class="box-content">
			        	<form name='search' id='search' method="post">
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
			        							<select name='group_code' id="group_code" multiple='multiple' style="width: 370px;">
													<c:forEach var="groupList" items="${groupList}" varStatus="status">																						
														<option value="${groupList.code }" <c:out value="${groupList.selected}"/>><c:out value="${groupList.group_name}"/></option>												
													</c:forEach>										
												</select>
					        				</span>						        		
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
								그룹별 훈련 통계	
																		
							</h2>
						</div>
						<div class="box-content">
							<div id='chartview' class="chartview">로딩중...</div>
							
		        		</div>
		        		<div class="clearFix"></div>
		        		<br>
		        	
		        </div>
		    
		        
	        </div>
    </div>
    <form name='frm' method="post">
    	<input type='hidden' name='code' value=''>
    </form>
    <style>
    	.chartview{
		  width: 100%;height: 450px;
		  
		}
    </style>
    
    
    <c:set var="chart_total" value=""/>
    <c:set var="chart_type1" value = ""/>
    <c:set var="chart_type2" value = ""/>
    <c:set var="chart_type3" value = ""/>
    <c:set var="chart_register" value = ""/>
     <c:set var="chart_type1_register" value = ""/>
    <c:set var="chart_group_name"/>
    
    
    
    <c:choose>
	    <c:when test="${fn:length(list)>0}">
	    			<c:forEach var="list" items="${list}" varStatus="status">
	    				<c:choose>
	    					<c:when test="${status.index eq '0' }">
	    						<c:set var="chart_total" value="${list.total }"/>
	    						
	    						<c:set var="chart_type1" value="${list.type1_use }"/>
	    						<c:set var="chart_type2" value="${list.type2_use }"/>
	    						<c:set var="chart_type3" value="${list.type3_use }"/>
	    						<c:set var="chart_register" value="${list.register_cnt }"/>
	    						<c:set var="chart_type1_register" value="${list.type1_register_cnt }"/>
	    						<c:set var="chart_group_name" value="\'${list.group_name }\'"/>
	 
	 
	    							
	    					</c:when>
	    					<c:otherwise>
	    						<c:set var="chart_total" 				value="${chart_total },${list.total }"/>
	 	   						<c:set var="chart_type1" 				value="${chart_type1 },${list.type1_use }"/>
	    						<c:set var="chart_type2" 				value="${chart_type2 },${list.type2_use }"/>
	    						<c:set var="chart_type3" 				value="${chart_type3 },${list.type3_use }"/>
	    						<c:set var="chart_register" 			value="${chart_register },${list.register_cnt }"/>
	    						<c:set var="chart_type1_register" value="${chart_type1_register },${list.type1_register_cnt }"/>
	    						<c:set var="chart_group_name"	 	value="${chart_group_name },\"${list.group_name }\""/>
	 
	    					</c:otherwise>
	    				</c:choose>
	    				
	    				
	    			</c:forEach>
	    </c:when>
    </c:choose>
    
    <script>
    var group_name = "<c:out value="${chart_group_name }"/>";
    var chart = c3.generate({
    	bindto: '#chartview',
	  	
        data: {
        	x:'x'
        	,columns: [
        			['x', '기능형테스트베드', 200, 200, 400, 1000, 1500]        
        	 ]
            ,type: 'line'
        }
        ,axis: {
            x: {
                type: 'category'                
            }
        }
    });
    
    
    
    
    function loadData2()
    {
    	<c:choose>
	 	   <c:when test="${fn:length(list)>0}">
		    	 chart.load({
		  	         columns: [
						 ['x', 	
						   <c:choose>
						 	   <c:when test="${fn:length(list)>0}">
				    				<c:forEach var="list" items="${list}" varStatus="status">
				    					<c:choose>
				    						<c:when test="${status.index eq '0'}">
				    							'<c:out value="${list.group_name }"/>'
				    						</c:when>
				    						<c:otherwise>
				    							,'<c:out value="${list.group_name }"/>'
				    						</c:otherwise>
				    					</c:choose>
				    				</c:forEach>
								</c:when>
							</c:choose>
						]
						, ['훈련대상자',	<c:out value="${chart_total }"/>]
		                , ['읽기',			<c:out value="${chart_type1 }"/>]
		                , ['링크', 			<c:out value="${chart_type2 }"/>]
		                , ['파일',  			<c:out value="${chart_type3 }"/>]
		                , ['신고(전체)', 			<c:out value="${chart_register }"/>]
						, ['신고(메일열람)', 			<c:out value="${chart_type1_register }"/>]
		            ]
		    	    });
		   </c:when>
		   </c:choose>
    }
    
    	/**
    	트레이팅 코드 
    	**/
    	var cur_training_code = "<c:out value="${searchVO.training_code}"/>";
    	$( document ).ready(function() {
    		
    	  loadData2();
    	  /**멀티 선택**/
    	  $("#group_code").multiselect(
    		{
    			noneSelectedText:'선택해주세요'
    			,checkAllText:'전체선택'
    			,uncheckAllText:'선택해제'
    		}  
    	  ).multiselectfilter(
    			  {
		    			label:'훈련검색',
		    			placeholder: '훈련명 입력',
		    			width : 100
		    		}	  
  	 		);
    	});
    	
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
					
					var html = "<select name='group_code' id='group_code' multiple='multiple' style='width: 370px;'>";
					for(i=0;i<json.length;i++)
					{
						html = html + "<option value='"+json[i].code+"' selected>"+json[i].group_name+"</option>";
					}
					html = html +"</select>";
					$("#div_group").html(html);
					
					/**멀티 선택**/
			    	  $("#group_code").multiselect(
			    		{
			    			noneSelectedText:'선택해주세요'
			    			,checkAllText:'전체선택'
			    			,uncheckAllText:'선택해제'
			    		}).multiselectfilter(
			    			  {
					    			label:'훈련검색',
					    			placeholder: '훈련명 입력',
					    			width : 100
					    		}	  
				    	 );
				},
				error:function(request,status,error){
					
				}
				
			}).complete(function() {
				
	        });
    	}
    	
       /**
	    검색
	    **/
    	function fn_search()
    	{	
	    	$('#overlay').show();   
	    	
	    	document.search.action = "/statistical/chart2.do";
			document.search.submit();
    	}
	    
    
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />