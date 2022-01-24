<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_pop_layout" />
<div class="pop_header">
	<h2><i class="fa-icon-sign-blank"></i><span class="break"></span> 라이선스 파일 등록</h2>
</div>
	<div class="container-fluid">
			<div class="row-fluid">
					<div class="box-content span12">
	       		 	 <form class="form-horizontal" role="form" name='frm' method='post' enctype="multipart/form-data">
	       		 		<table class="table table-bordered table-striped">
	       		 		<colgroup>
	       		 			<col width="100px">
	       		 			<col width="*">
	       		 		</colgroup>
	       		 		 <tbody>	       		 		 
	       		 		 	<tr>
	       		 		 		<th>라이선스 등록</th>
	       		 		 		<td><input type='file' name="uploadfile" id="uploadfile"></td>	       		 		 	
	       		 		 	</tr>
					    </tbody>
	       		 		</table>
	       		 		</form>
	       				
	       							 
	       		 	
	       		 	<table class="table table-bordered table-striped">
				    	<tr>
				    		<td width="50px">   
				    		<c:choose>
				    				<c:when test="${pageType=='form' }">
				    					<button type="button" class="btn" onClick='licenseFile_upload();'>라이선스 등록</button>	
				    				</c:when>
				    				<c:otherwise>
				    					<button type="button" class="btn" onClick='licenseFile_upload();'>라이선스 등록</button>	
				    					<button type="button" class="btn" onClick='window_close();'>적용</button>
				    				</c:otherwise>
				    			</c:choose>
				    		</td>
				    	</tr>
					 </table>
       		 	</div>
    </div>   
  
    <script>
    
    var paserType = "<c:out value="${parseType}"/>";
	var errList = "";
    
    //최초 로드시 
    $(document).ready(function() {
      
    	if(paserType == 'fail')
    	{
    		alert("잘못된 License 파일입니다.");	
    		
    	}else if (paserType=='success'){
    		window.opener.location.reload();        
    		alert("정상적으로 업로드되었습니다.");	
    	}else{
    		
    	}
    	
    });
       
    function licenseFile_upload()
    {
    	if($("#uploadfile").val()=="" )
    	{
    		alert('업로드하실 파일을 선택하셔야 합니다..');
    		return ;
    	}
    	
   		if(confirm("기존의 License 파일이 지워집니다! 계속  진행하시겠습니까?"))
       	{
	    	document.frm.action = "/common/license_upload_pop.do";
	    	document.frm.submit();
	    }    	
    }
    
    /**
    사용자 적용
    **/
    function window_close()
    {      	
    	window.close();
    }
    </script>
   

       	</div>
</div>