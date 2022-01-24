<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page session="true" %>
<html>
<head>
<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/font-awesome2.css" rel="stylesheet">
<link href="/css/style.css" rel="stylesheet"> 
<style type="text/css">
			body { background: url(/images/login_bg2.jpg) !important; }
		</style>
	<title>D-MESSv1.3</title>
</head>
<body>
<c:choose>
    <c:when test="${searchVO.type eq '100'}">
         <script>
         alert('"아이디 또는 비밀번호가 잘못입력되었습니다. 다시 시도해주시기 바랍니다!".');
         </script>    
    </c:when>
    <c:when test="${searchVO.type eq '101'}">
         <script>
         alert('동일한 사용자가 접속 중입니다.');
         </script>    
    </c:when>       
     <c:when test="${searchVO.type ne ''}">
        <script>
    	alert('사용자 로그인이 실패하였습니다.');
         </script>
    </c:when>      
</c:choose>
<!--  <c:if test="${searchVO.type ne '' }">
	<script>
		alert('사용자 로그인이 실패하였습니다.');
	</script>
	
</c:if>-->
<div class="container-fluid">
		<div class="row-fluid">
					
			<div class="row-fluid">
				<div class="login-box">
					<h2><img src="../images/logo_login.png" style="max-width: 80%; height: auto;"></h2>
					<form action="<c:url value='/member/loginProc.do' />" method="post">
						<div class="form-horizontal">
							
							<div class="input-prepend" title="Username">
								<span class="add-on"><i class="fa-icon-user"></i></span>
								<input class="input-large span10" name="j_username" id="username" type="text" placeholder="type username"/>
							</div>
							<div class="clearfix"></div>

							<div class="input-prepend" title="Password">
								<span class="add-on"><i class="fa-icon-lock"></i></span>
								<input class="input-large span10" name="j_password" id="password" type="password" placeholder="type password"/>
							</div>
							<div class="clearfix"></div>
							<div class="button-login">	
								<button type="button" class="btn btn-primary"   onClick='License_form();'>라이선스 확인</button>
								<button type="submit" class="btn btn-primary"><i class="fa-icon-off"></i> Login</button>
							</div>
							<div class="clearfix"></div>
							<div class="button-login">	
								<p>악성메일 모의훈련 프로그램은 (크롬64 ,크롬32)에 최적화 되어 개발되어져있습니다.</p>
								<p><a href='/download/chrome64.do'>크롬64다운로드</a> /<a href='/download/chrome32.do'>크롬32다운로드</a></p>
							</div>
							<div class="clearfix"></div>
						</div>
					</form>
	
				</div><!--/span-->
			</div><!--/row-->
			
				</div><!--/fluid-row-->
				
	</div><!--/.fluid-container-->
	<script>
	var msg = "<c:out value="${msg}"/>";

		
	window.onload = function()
	{
		if(msg!="")
		{
			alert(msg);
		}
	}
	
	function version()
	{
		var b = "";
		var ua = window.navigator.userAgent;
		if(ua.indexOf('MSIE') > 0 || ua.indexOf('Trident') > 0)
		 b = "IE";
		else if(ua.indexOf('Opera') > 0 || ua.indexOf('OPR') > 0)
		 b = "Opera";
		else if(ua.indexOf('Firefix') > 0)
		 b = "Firefox";
		else if(ua.indexOf('Safari') > 0) {
		 if(ua.indexOf('Chrome') > 0)
		  b = "Chrome";
		 else
		  b = "Safari";
		}
		return b;
	}
	
	//License  파일 등록
		function License_form()
		{
			url = "/common/license_valid_pop.do";
	    	fn_openwindow(url,  '800px', '400px', 'license_info');	
		}
	
		function fn_openwindow(url, width, height, page_id)
		{

			
			if(page_id =="fn_capture_popup")
			{
				var option = 'scrollbars=no,toolbar=no,resizable=yes,fullscreen=yes,left=0,top=0';
			}
			else
			{
				var option = 'scrollbars=no,toolbar=no,resizable=yes,width='+width+',height='+height+',left=0,top=0';
			}
			
			
			var win = null;
			win = window.open(url ,page_id,option);
			win.focus();
		}
		
	</script>
<c:choose>
	<c:when test="${result.alert_message eq '' || empty result.alert_message}">
	</c:when>
	<c:otherwise>
		<script>
			alert("<c:out value="${result.alert_message }"/>");
		</script>
	</c:otherwise>
</c:choose>

</body>
</html>
