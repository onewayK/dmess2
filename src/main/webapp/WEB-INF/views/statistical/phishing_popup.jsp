<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="kr.nshare.common.util.EgovProperties"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_pop_layout" />
<div class="pop_header">
	<h2><i class="fa-icon-sign-blank"></i><span class="break"></span> 피싱 리스트</h2>
</div>
	<div class="container-fluid">
			<div class="row-fluid">
					<div class="box-content span12">
	       		 	 
	       		 	 <form class="form-horizontal" role="form" name='frm' method='post' enctype="multipart/form-data">
	       		 		<table class="table table-bordered table-striped">
	       		 		<colgroup>
	       		 			<col width="80px">
	       		 			<col width="*">
	       		 			<col width="180px">
	       		 		</colgroup>
	       		 		 <tbody>
	       		 		 	<tr>
	       		 		 		<th>코드</th>
	       		 		 		<th>아이디</th>
	       		 		 		<th>비밀번호 입력자릿수</th>
	       		 		 	</tr>
	       		 		 	<c:forEach var="list" items="${list}" varStatus="status">
		       		 		 	<tr>
		       		 		 		<td><c:out value="${list.code }"/> </td>
		       		 		 		<td><c:out value="${list.t_userId }"/></td>
		       		 		 		<td><c:out value="${list.t_passwd }"/></td>
		       		 		 	</tr>
	       		 		 	</c:forEach>
	       		 		 	
					    </tbody>
	       		 		</table>
	       		 		</form>
	       		 		
						<c:import url="/common/pageLink.do?link=inc/bottom_pop_layout" />
						
				</div>
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
     페이지에 적용
    **/
	function img_parse()
	{
		if($("input[name='code']").val()=="")
		{
			alert("이미지를 업로드해주시기 바랍니다.");
			return ;
		}
		opener.setTrainingType3Image($("input[name='code']").val(),$("input[name='imageUrl']").val());
		window.close();
		
	}
</script>