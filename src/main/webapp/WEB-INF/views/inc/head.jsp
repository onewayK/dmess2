<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page session="true" %>
<%
	/********************************************************************************
	* 각종 공통 부분 js, css, 기타 
	**********************************************************************************/
%>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.css" rel="stylesheet">
    
    <link href="/css/font-awesome2.css" rel="stylesheet">
    <link href="/css/font-awesome4.css" rel="stylesheet">
    
    <link href="/css/jquery-ui-1.8.21.custom.css" rel="stylesheet">
	<link href="/css/AdminLTE2_0_4/AdminLTE.css" rel="stylesheet">
	
	<link href="/css/smart_editor2_out.css" rel="stylesheet">
	  
	<link href="/css/style.css" rel="stylesheet">  
    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="/js/bootstrap/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/js/bootstrap/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="/js/bootstrap/html5shiv.min.js"></script>
      <script src="/js/bootstrap/respond.min.js"></script>
    <![endif]-->
     <script src="/js/jquery-1.11.2.min.js"></script>
     <script src="/js/bootstrap/bootstrap.js"></script>
     <script src="/js/jquery.dataTables.min.js"></script>
    
    <!-- bootstrap 커스텀 -->
    <!--link href="/css/bootstrap/bootstrap_custom_plugin.css" rel="stylesheet"  -->
    
    <!-- 공통js -->
    <script src="/js/common.js"></script>
    <script src="/js/custom.js"></script>
    
    
    <!-- --> 
    <script src="/js/jquery-ui-1.10.4.custom.js"></script>
    <script src="/js/jquery.validate.js"></script>
    
    
    <!-- validate check plugin -->
    <link href="/css/jquery_plugin/jquery-ui-1.10.4.custom.css" rel="stylesheet">
	
	
	<link href="/css/jquery.multiselect.css" rel="stylesheet">
	<link href="/css/jquery.multiselect.filter.css" rel="stylesheet">
	<!-- multiple-selectbox -->
	<script src="/js/jquery.multiselect.filter.js"></script>
	<script src="/js/jquery.multiselect.js"></script>
	
	<!-- chosen -->
	<link href="/css/chosen.css" rel="stylesheet">
	<script src="/js/chosen.jquery.js" ></script>
	
	<!-- table sort -->
	<link href="/css/tablesorter/theme.bootstrap_2.css" rel="stylesheet">
	<script src="/js/tablesorter/jquery.tablesorter.min.js" ></script>
	
	
	<link rel="stylesheet" href="/css/jquery.contextMenu.css" type="text/css" media="screen">
	<script type="text/javascript" src="/js/jquery.contextMenu.js"></script>
	
	<!-- bootstrap dialog -->
	<script src="<c:url value='/js/jquery.datetimepicker.js'/>"></script>
	<!-- bootstrap dialog -->
	<link href="<c:url value='/css/jquery.datetimepicker.css'/>" rel="stylesheet">
	
	<!-- slick -->
	<link rel="stylesheet" href="/js/SlickGrid/css/smoothness/jquery-ui-1.8.16.custom.css" type="text/css"/>
	<link rel="stylesheet" href="/js/SlickGrid/slick.grid.css" type="text/css"/>
	<link rel="stylesheet" href="/js/SlickGrid/slick-default-theme.css" type="text/css"/>
	
	<script src="/js/SlickGrid/lib/jquery.event.drag-2.2.js"></script>
	
	<script src="/js/SlickGrid/slick.core.js"></script>
	<script src="/js/SlickGrid/slick.grid.js"></script>
	<script src="/js/SlickGrid/slick.dataview.js"></script>
	<script src="/js/SlickGrid/slick_com.js"></script>
	
	<link rel="stylesheet" href="/js/SlickGrid/css/slick.columngroup.css" type="text/css"/>	
	<script src="/js/SlickGrid/slick.columngroup.js"></script>
	
	
	<script>
	$(function() {
        $( document ).tooltip(
        	{width:'1000px' ,
      	 	  items: "[tooltipmessage]",
      	      content: function() 
      	      {
      	        var element = $( this );
      	        if ( element.is( "[tooltipmessage]" ) ) {
      	          return element.attr( "tooltipmessage" );
      	        }
      	        
      	      }
        	
        	}
        );
	});
	</script>
	