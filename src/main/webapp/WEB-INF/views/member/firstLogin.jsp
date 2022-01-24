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
<script src="/js/jquery-1.11.2.min.js"></script> 

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
<c:out value="${msg}"/>
<div class="container-fluid">
		<div class="row-fluid">
					
			<div class="row-fluid">
				<div class="login-box">
					<h2><img src="../images/logo2.png"></h2>
					<form action="<c:url value='/member/changePasswd.do' />" method="post" onsubmit="return sendit();"> 
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
							<div class="input-prepend" title="Password">
								<span class="add-on"><i class="fa-icon-lock"></i></span>
								<input class="input-large span10" name="chgPasswd" id="chgPasswd" type="password" placeholder="change passwd"/>
							</div>
							<div class="clearfix"></div>
							<div class="button-login">	
								<button type="submit" class="btn btn-primary"><i class="fa-icon-off"></i> Login</button>
							</div>
							<div class="clearfix"></div>
						</div>
					</form>
	
				</div><!--/span-->
			</div><!--/row-->
			
		</div><!--/fluid-row-->		
	</div><!--/.fluid-container-->
	<script>
		function sendit()
		{
			
			
			if($("#username").val()=="" && $("#username").val().length<4)
			{
				alert('사용자 계정은 4자리 이상이어야합니다.');
				return false;
			}
			else if($("#password").val()=="" && $("#password").val().length<4)
			{
				alert('비밀번호는 4자리 이상이어야합니다.');
				return false;
			}
			
			else if($("#chgPasswd").val()=="" && $("#chgPasswd").val().length<4)
			{
				alert('변경 비밀번호는 4자리 이상이어야합니다.');
				return false;
			}else
			{
				return true;
			}
		}
		
	</script>

</body>
</html>
