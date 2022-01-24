<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page session="true" %>
				<div class="pop_footer">
					<a href='#' class="btn fr" onClick='window.close();'>닫기</a>
				</div>
            </div>
    </div>
</body>
</html>
<script>
	function parent_reload()
	{
		try{
			opener.location.reload();
		}
		catch(e)
		{
			
		}
	}
</script>