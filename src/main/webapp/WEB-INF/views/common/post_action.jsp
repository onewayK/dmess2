<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page session="true" %>
<form name='frm' method="post">
<c:choose>
	<c:when test="${fn:length(list)>0}">
			<c:forEach var="list" items="${list}" varStatus="status">
   				<input type='hidden' name='<c:out value="${list.key }"/>' value='<c:out value="${list.value }"/>'/>
   			</c:forEach>
   	</c:when>
 </c:choose>
	</form>
<script>
	window.onload = function()
	{
		document.frm.action = "<c:out value="${action_url }"/>";
		document.frm.submit();
	}
</script>