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
	<title>D-MESSv1.0</title>
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
<c:out value="${msg}"/>
<div class="container-fluid">
		<div class="row-fluid">
					
			<div class="row-fluid">
				<div class="login-box">
					<h2><img src="../images/logo2.png"></h2>
						<p>악성메일 모의 훈련은 크롬 브라우저를 통한 시스템 운영만 지원하고있습니다.</p>
						
						<p>현재 설치하신 브라우저가 크롬이 아니라면 아래의 링크를 통해서 크롬 브라우저를 설치한후</p>
						
						<p>시스템을 사용해주시기 바랍니다.</p>
						<p><a href='/download/chrome64.do'>크롬64다운로드</a> /<a href='/download/chrome32.do'>크롬32다운로드</a></p>
				</div><!--/span-->
			</div><!--/row-->
			
				</div><!--/fluid-row-->
				
	</div><!--/.fluid-container-->
	<input type='hidden' name='username' value='test'>
	
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	
	<script>
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
