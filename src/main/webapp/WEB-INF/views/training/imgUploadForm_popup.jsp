<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="kr.nshare.common.util.EgovProperties"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_pop_layout" />
<div class="pop_header">
	<h2><i class="fa-icon-sign-blank"></i><span class="break"></span> 이미지 업로드</h2>
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
		       		 		 		첨부파일에 사용할 이미지를 업로드 하실수있습니다. 업로드는 WIDTH값이 최대 600px 이상이 될수없습니다. 
		       		 		 		<BR>
		       		 		 		600px이상인 이미지를 업로드하시면 자동으로 600px로 수정되게 됩니다.
	       		 		 		</td>
	       		 		 	</tr>
	       		 		 	<tr>
	       		 		 		<th>파일업로드</th>
	       		 		 		<td>
	       		 		 			<input type='file' name='uploadfile' id='uploadfile' style="width:200px">
	       		 		 		</td>
	       		 		 		<td>
	       		 		 			<button type="button" class="btn" onClick='upload();'>파일 업로드</button>
	       		 		 			
	       		 		 			<c:choose>
	       		 		 				<c:when test="${pageType eq 'view' }">
	       		 		 					<button type="button" class="btn" onClick='img_parse();'>적용</button>
	       		 		 				</c:when>
	       		 		 			</c:choose>
	       		 		 			
	       		 		 		
	       		 		 		</td>
	       		 		 	</tr>
	       		 		 	<tr>
	       		 		 		<td colspan="3">
	       		 		 			<c:choose>
	       		 		 				<c:when test="${pageType eq 'view' }">
	       		 		 					<img id="blah" src="<c:out value="${imageUrl }"/>" alt="upload image" />
	       		 		 				</c:when>
	       		 		 				<c:otherwise>
	       		 		 					<img id="blah" src="#" alt="upload image" style="display:none" />
	       		 		 				</c:otherwise>
	       		 		 			</c:choose>
	       		 		 			
	       		 		 		</td>
	       		 		 	</tr>
	       		 		 	
					    </tbody>
	       		 		</table>
	       		 		</form>
	       		 		
						<c:import url="/common/pageLink.do?link=inc/bottom_pop_layout" />
						

       	</div>
</div>
	<input type='hidden' name='code' value='<c:out value="${code }"/>'>
	<input type='hidden' name='imageUrl' value="<c:out value="${imageUrl }"/>">
<script>
	

        $(document).ready(function(){
            $('#uploadfile').change(function(){
                //alert(this.value); //선택한 이미지 경로 표시
                readURL(this);
            });
         });

        function readURL(input) {
        	if (input.files && input.files[0]) {
                var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
               	 reader.onload = function (e) {
                
                	console.log(e);
                    $('#blah').attr('src', e.target.result);
                	$("#blah").show();
                }                   
                reader.readAsDataURL(input.files[0]);
                //File내용을 읽어 dataURL형식의 문자열로 저장
            }
        }
        
    /**
    	파일 업로드
    **/
	function upload()
	{
	
		var thumbext = document.getElementById('uploadfile').value;

		if(thumbext==null || thumbext=="")
		{
			$("#blah").hide();
			alert('업로드할 이미지를 선택하여주세요!');
			return ;
		}
		else
		{
			//var thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase();
			var thumbext = $('#uploadfile').val().split('.').pop().toLowerCase();

			/**
			console.log("######################################");
			console.log(thumbext);
			console.log("######################################");
			alert(thumbext);
			**/
			if(thumbext != "jpg" && thumbext != "jpeg" && thumbext != "png" &&  thumbext != "gif"){
				
				$("#blah").hide();
				alert('썸네일은 이미지 파일(jpg, png, gif)만 등록 가능합니다.');
				return;
			}
			
	    	document.frm.action = "/training/imgUploadProc.do";
			document.frm.submit();
		}
		
		
	}
	
    /**
     페이지에 적용
    **/
	function img_parse()
	{
		if($("input[name='code']").val()=="")
		{
			alert("이미지를 업로드해주시기 바랍니다");
			return ;
		}
		console.log($("input[name='imageUrl']").val());
		opener.setTrainingType3Image($("input[name='code']").val(),$("input[name='imageUrl']").val());
		window.close();
		
	}
</script>