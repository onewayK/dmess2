<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_pop_layout" />

<div class="pop_header">
	<h2><i class="fa-icon-sign-blank"></i><span class="break"></span> 기관 리스트
	<div class="pull-right">
	<a href="#" class="pop_btn" onClick='insertInstitution();'>기관추가</a>
	</div>
	</h2>
</div>

	<div class="container-fluid">
		<div class="row-fluid">
					<div class="box-content span12">
			
	       
	       		 	 <form class="form-horizontal" role="form" name='frm' method='post'>
	       		 		<table class="table table-bordered table-striped">
	       		 		<colgroup>
	       		 			<col width="30px">
	       		 			<col width="100px">
	       		 			<col width="*">
	       		 		</colgroup>
	       		 		 <tbody>
	       		 		 	<tr>
	       		 		 		<th>&nbsp;</th>
	       		 		 		<th>기관 코드</th>
	       		 		 		<th>기관명</th>
	       		 		 	</tr>
	       		 		 		
	       		 		 		<c:choose>
						    		<c:when test="${fn:length(list)>0}">
						    			<c:forEach var="list" items="${list}" varStatus="status">
									    	<tr>
									    		<th><input type='checkbox' name='code' value='<c:out value="${list.code }"/>'/></th>
					       		 				<th><c:out value="${list.code}"/></th>
					       		 				<td>
					       		 					<input type='hidden' name='institution_name' value='<c:out value="${list.institution_name}"/>'/>
					       		 					<c:out value="${list.institution_name}"/>
					       		 				</td>
					       		 			</tr>
				       		 			</c:forEach>
						    		</c:when>
						    		<c:otherwise>
						    			<tr>
				       		 				<td colspan="7" align="center">no list</td>
				       		 			</tr>		
		       		 				 </c:otherwise>
					    	</c:choose>
					    </tbody>
	       		 		</table>
	       		 			
	       		 	</form>
	       		 	
	       		 	<div class="pull-left">
						<a href="#" class="btn" onClick='insertInstitution();'>기관추가</a>
					</div>
	       		 	
	       		 	
       		 	</div>
    </div>
    <script>
    
    	
    
	    /**
	    페이지 이동
	    **/
		function goPage(pageno)
		{
			location.href="/system/institutionList.do?pageNo="+pageno;
		}
    	
	    
	    var init_value = "<c:out value="${searchVO.institution_code}"/>";
		$( document ).ready(function() {
		    
			if(init_value!="")
			{
				$.each(init_value.split(","),function(k,v){
					$("input[name=code]:checkbox").each(function(k2,v2) {
						if(v==$(this).val())
						{
							console.log(v+"=="+$(this).val());
							$(this).attr("checked",true);
						}
					});
				});
				
			}
			
		});
	    
    	/**
    	등록
    	**/
    	function insertInstitution(){
    		var cnt = 0;
    		var val = Array();
    		
    		
    		$("input[name=code]:checkbox").each(function(k,v) {
    			
    			if(this.checked==true)
    			{
    				var personInfo = new Object();
    				
    				personInfo.code 					= $(this).val();
    				personInfo.institution_name 	= $("input[name=institution_name]").eq(k).val();
    				val.push(personInfo);
    				cnt++;
    			}
    		});
    		
    		if(cnt>0)
    		{
    			window.opener.setInstitution(val);
    			window.close();
    		}
    		else
    		{
    			alert('추가할 기관을 선택하여주세요!');
    			return ;
    		}
    	
    	}
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_pop_layout" />