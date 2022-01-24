<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	
    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.css" rel="stylesheet">
    <link href="/css/font-awesome2.css" rel="stylesheet">
    <link href="/css/jquery-ui-1.8.21.custom.css" rel="stylesheet">
	<link href="/css/AdminLTE2_0_4/AdminLTE.css" rel="stylesheet">  
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
     <script src="/js/bootstrap/bootstrap.min.js"></script>
     <script src="/js/jquery.dataTables.min.js"></script>
    
    <!-- bootstrap 커스텀 -->
    <!--link href="/css/bootstrap/bootstrap_custom_plugin.css" rel="stylesheet"  -->
    
    <!-- 공통js -->
    <script src="/js/common.js"></script>
    <script src="/js/custom.js"></script>
    <!----> 
    <script src="/js/jquery-ui-1.10.4.custom.js"></script>
    <script src="/js/jquery.validate.js"></script>
    
    
    <!-- validate check plugin -->
    <link href="/css/jquery_plugin/jquery-ui-1.10.4.custom.css" rel="stylesheet">
    
    <style>
.modal {
	position: fixed;
	top: 1%;
	left: 50%;
	z-index: 1050;
	width: 1200px;
	margin-left: -600px;
	background-color: #fff;
	border: 1px solid #999;
	border: 1px solid rgba(0,0,0,0.3);
*border:1px solid #999;
	-webkit-border-radius: 6px;
	-moz-border-radius: 6px;
	border-radius: 6px;
	outline: 0;
	-webkit-box-shadow: 0 3px 7px rgba(0,0,0,0.3);
	-moz-box-shadow: 0 3px 7px rgba(0,0,0,0.3);
	box-shadow: 0 3px 7px rgba(0,0,0,0.3);
	-webkit-background-clip: padding-box;
	-moz-background-clip: padding-box;
	background-clip: padding-box
}
.modal-body {
	position: relative;
	max-height: 700px;
	padding: 15px;
	overflow-y: auto
}
select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
	display: inline-block;
	height: 23px;
	padding: 3px 6px;
	margin-bottom: 5px;
	font-size: 14px;
	line-height: 22px;
	color: #555;
	vertical-align: middle;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
}
.form-actions {
	padding: inherit;
	margin: auto;
	border-top: 0;
 *
	zoom: 1;
}
</style>
    
    
<title>D-MESSv1.0</title>
</head>
<body>
<div class="container-fluid">
<div class="row-fluid">
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-picture"></i><span class="break"></span>Font Awesome</h2>
						<div class="box-icon">
							<a href="#" class="btn-grid"><i class="fa-icon-tasks"></i></a>
							<a href="#" class="btn-table"><i class="fa-icon-table"></i></a>
							<a href="#" class="btn-form"><i class="fa-icon-th-large"></i></a>
						</div>
					</div>
					<div class="box-content">
						
						<br><h1>Web Application Icons</h1><br>
						<div class="row-fluid bs-icons">
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-adjust"></i> fa-icon-adjust</li>
						      <li><i class="fa-icon-asterisk"></i> fa-icon-asterisk</li>
						      <li><i class="fa-icon-ban-circle"></i> fa-icon-ban-circle</li>
						      <li><i class="fa-icon-bar-chart"></i> fa-icon-bar-chart</li>
						      <li><i class="fa-icon-barcode"></i> fa-icon-barcode</li>
						      <li><i class="fa-icon-beaker"></i> fa-icon-beaker</li>
						      <li><i class="fa-icon-bell"></i> fa-icon-bell</li>
						      <li><i class="fa-icon-bolt"></i> fa-icon-bolt</li>
						      <li><i class="fa-icon-book"></i> fa-icon-book</li>
						      <li><i class="fa-icon-bookmark"></i> fa-icon-bookmark</li>
						      <li><i class="fa-icon-bookmark-empty"></i> fa-icon-bookmark-empty</li>
						      <li><i class="fa-icon-briefcase"></i> fa-icon-briefcase</li>
						      <li><i class="fa-icon-bullhorn"></i> fa-icon-bullhorn</li>
						      <li><i class="fa-icon-calendar"></i> fa-icon-calendar</li>
						      <li><i class="fa-icon-camera"></i> fa-icon-camera</li>
						      <li><i class="fa-icon-camera-retro"></i> fa-icon-camera-retro</li>
						      <li><i class="fa-icon-certificate"></i> fa-icon-certificate</li>
						      <li><i class="fa-icon-check"></i> fa-icon-check</li>
						      <li><i class="fa-icon-check-empty"></i> fa-icon-check-empty</li>
						      <li><i class="fa-icon-cloud"></i> fa-icon-cloud</li>
						      <li><i class="fa-icon-cog"></i> fa-icon-cog</li>
						      <li><i class="fa-icon-cogs"></i> fa-icon-cogs</li>
						      <li><i class="fa-icon-comment"></i> fa-icon-comment</li>
						      <li><i class="fa-icon-comment-alt"></i> fa-icon-comment-alt</li>
						      <li><i class="fa-icon-comments"></i> fa-icon-comments</li>
						      <li><i class="fa-icon-comments-alt"></i> fa-icon-comments-alt</li>
						      <li><i class="fa-icon-credit-card"></i> fa-icon-credit-card</li>
						      <li><i class="fa-icon-dashboard"></i> fa-icon-dashboard</li>
						      <li><i class="fa-icon-download"></i> fa-icon-download</li>
						      <li><i class="fa-icon-download-alt"></i> fa-icon-download-alt</li>
						      <li><i class="fa-icon-edit"></i> fa-icon-edit</li>
						      <li><i class="fa-icon-envelope"></i> fa-icon-envelope</li>
						      <li><i class="fa-icon-envelope-alt"></i> fa-icon-envelope-alt</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-exclamation-sign"></i> fa-icon-exclamation-sign</li>
						      <li><i class="fa-icon-external-link"></i> fa-icon-external-link</li>
						      <li><i class="fa-icon-eye-close"></i> fa-icon-eye-close</li>
						      <li><i class="fa-icon-eye-open"></i> fa-icon-eye-open</li>
						      <li><i class="fa-icon-facetime-video"></i> fa-icon-facetime-video</li>
						      <li><i class="fa-icon-film"></i> fa-icon-film</li>
						      <li><i class="fa-icon-filter"></i> fa-icon-filter</li>
						      <li><i class="fa-icon-fire"></i> fa-icon-fire</li>
						      <li><i class="fa-icon-flag"></i> fa-icon-flag</li>
						      <li><i class="fa-icon-folder-close"></i> fa-icon-folder-close</li>
						      <li><i class="fa-icon-folder-open"></i> fa-icon-folder-open</li>
						      <li><i class="fa-icon-gift"></i> fa-icon-gift</li>
						      <li><i class="fa-icon-glass"></i> fa-icon-glass</li>
						      <li><i class="fa-icon-globe"></i> fa-icon-globe</li>
						      <li><i class="fa-icon-group"></i> fa-icon-group</li>
						      <li><i class="fa-icon-hdd"></i> fa-icon-hdd</li>
						      <li><i class="fa-icon-headphones"></i> fa-icon-headphones</li>
						      <li><i class="fa-icon-heart"></i> fa-icon-heart</li>
						      <li><i class="fa-icon-heart-empty"></i> fa-icon-heart-empty</li>
						      <li><i class="fa-icon-home"></i> fa-icon-home</li>
						      <li><i class="fa-icon-inbox"></i> fa-icon-inbox</li>
						      <li><i class="fa-icon-info-sign"></i> fa-icon-info-sign</li>
						      <li><i class="fa-icon-key"></i> fa-icon-key</li>
						      <li><i class="fa-icon-leaf"></i> fa-icon-leaf</li>
						      <li><i class="fa-icon-legal"></i> fa-icon-legal</li>
						      <li><i class="fa-icon-lemon"></i> fa-icon-lemon</li>
						      <li><i class="fa-icon-lock"></i> fa-icon-lock</li>
						      <li><i class="fa-icon-unlock"></i> fa-icon-unlock</li>
						      <li><i class="fa-icon-magic"></i> fa-icon-magic</li>
						      <li><i class="fa-icon-magnet"></i> fa-icon-magnet</li>
						      <li><i class="fa-icon-map-marker"></i> fa-icon-map-marker</li>
						      <li><i class="fa-icon-minus"></i> fa-icon-minus</li>
						      <li><i class="fa-icon-minus-sign"></i> fa-icon-minus-sign</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-money"></i> fa-icon-money</li>
						      <li><i class="fa-icon-move"></i> fa-icon-move</li>
						      <li><i class="fa-icon-music"></i> fa-icon-music</li>
						      <li><i class="fa-icon-off"></i> fa-icon-off</li>
						      <li><i class="fa-icon-ok"></i> fa-icon-ok</li>
						      <li><i class="fa-icon-ok-circle"></i> fa-icon-ok-circle</li>
						      <li><i class="fa-icon-ok-sign"></i> fa-icon-ok-sign</li>
						      <li><i class="fa-icon-pencil"></i> fa-icon-pencil</li>
						      <li><i class="fa-icon-picture"></i> fa-icon-picture</li>
						      <li><i class="fa-icon-plane"></i> fa-icon-plane</li>
						      <li><i class="fa-icon-plus"></i> fa-icon-plus</li>
						      <li><i class="fa-icon-plus-sign"></i> fa-icon-plus-sign</li>
						      <li><i class="fa-icon-print"></i> fa-icon-print</li>
						      <li><i class="fa-icon-pushpin"></i> fa-icon-pushpin</li>
						      <li><i class="fa-icon-qrcode"></i> fa-icon-qrcode</li>
						      <li><i class="fa-icon-question-sign"></i> fa-icon-question-sign</li>
						      <li><i class="fa-icon-random"></i> fa-icon-random</li>
						      <li><i class="fa-icon-refresh"></i> fa-icon-refresh</li>
						      <li><i class="fa-icon-remove"></i> fa-icon-remove</li>
						      <li><i class="fa-icon-remove-circle"></i> fa-icon-remove-circle</li>
						      <li><i class="fa-icon-remove-sign"></i> fa-icon-remove-sign</li>
						      <li><i class="fa-icon-reorder"></i> fa-icon-reorder</li>
						      <li><i class="fa-icon-resize-horizontal"></i> fa-icon-resize-horizontal</li>
						      <li><i class="fa-icon-resize-vertical"></i> fa-icon-resize-vertical</li>
						      <li><i class="fa-icon-retweet"></i> fa-icon-retweet</li>
						      <li><i class="fa-icon-road"></i> fa-icon-road</li>
						      <li><i class="fa-icon-rss"></i> fa-icon-rss</li>
						      <li><i class="fa-icon-screenshot"></i> fa-icon-screenshot</li>
						      <li><i class="fa-icon-search"></i> fa-icon-search</li>
						      <li><i class="fa-icon-share"></i> fa-icon-share</li>
						      <li><i class="fa-icon-share-alt"></i> fa-icon-share-alt</li>
						      <li><i class="fa-icon-shopping-cart"></i> fa-icon-shopping-cart</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-signal"></i> fa-icon-signal</li>
						      <li><i class="fa-icon-signin"></i> fa-icon-signin</li>
						      <li><i class="fa-icon-signout"></i> fa-icon-signout</li>
						      <li><i class="fa-icon-sitemap"></i> fa-icon-sitemap</li>
						      <li><i class="fa-icon-sort"></i> fa-icon-sort</li>
						      <li><i class="fa-icon-sort-down"></i> fa-icon-sort-down</li>
						      <li><i class="fa-icon-sort-up"></i> fa-icon-sort-up</li>
						      <li><i class="fa-icon-star"></i> fa-icon-star</li>
						      <li><i class="fa-icon-star-empty"></i> fa-icon-star-empty</li>
						      <li><i class="fa-icon-star-half"></i> fa-icon-star-half</li>
						      <li><i class="fa-icon-tag"></i> fa-icon-tag</li>
						      <li><i class="fa-icon-tags"></i> fa-icon-tags</li>
						      <li><i class="fa-icon-tasks"></i> fa-icon-tasks</li>
						      <li><i class="fa-icon-thumbs-down"></i> fa-icon-thumbs-down</li>
						      <li><i class="fa-icon-thumbs-up"></i> fa-icon-thumbs-up</li>
						      <li><i class="fa-icon-time"></i> fa-icon-time</li>
						      <li><i class="fa-icon-tint"></i> fa-icon-tint</li>
						      <li><i class="fa-icon-trash"></i> fa-icon-trash</li>
						      <li><i class="fa-icon-trophy"></i> fa-icon-trophy</li>
						      <li><i class="fa-icon-truck"></i> fa-icon-truck</li>
						      <li><i class="fa-icon-umbrella"></i> fa-icon-umbrella</li>
						      <li><i class="fa-icon-upload"></i> fa-icon-upload</li>
						      <li><i class="fa-icon-upload-alt"></i> fa-icon-upload-alt</li>
						      <li><i class="fa-icon-user"></i> fa-icon-user</li>
						      <li><i class="fa-icon-user-md"></i> fa-icon-user-md</li>
						      <li><i class="fa-icon-volume-off"></i> fa-icon-volume-off</li>
						      <li><i class="fa-icon-volume-down"></i> fa-icon-volume-down</li>
						      <li><i class="fa-icon-volume-up"></i> fa-icon-volume-up</li>
						      <li><i class="fa-icon-warning-sign"></i> fa-icon-warning-sign</li>
						      <li><i class="fa-icon-wrench"></i> fa-icon-wrench</li>
						      <li><i class="fa-icon-zoom-in"></i> fa-icon-zoom-in</li>
						      <li><i class="fa-icon-zoom-out"></i> fa-icon-zoom-out</li>
						    </ul>
						  </div>
						</div>
						<br><br><br><h1>Text Editor Icons</h1><br>
						<div class="row-fluid bs-icons">
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-file"></i> fa-icon-file</li>
						      <li><i class="fa-icon-cut"></i> fa-icon-cut</li>
						      <li><i class="fa-icon-copy"></i> fa-icon-copy</li>
						      <li><i class="fa-icon-paste"></i> fa-icon-paste</li>
						      <li><i class="fa-icon-save"></i> fa-icon-save</li>
						      <li><i class="fa-icon-undo"></i> fa-icon-undo</li>
						      <li><i class="fa-icon-repeat"></i> fa-icon-repeat</li>
						      <li><i class="fa-icon-paper-clip"></i> fa-icon-paper-clip</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-text-height"></i> fa-icon-text-height</li>
						      <li><i class="fa-icon-text-width"></i> fa-icon-text-width</li>
						      <li><i class="fa-icon-align-left"></i> fa-icon-align-left</li>
						      <li><i class="fa-icon-align-center"></i> fa-icon-align-center</li>
						      <li><i class="fa-icon-align-right"></i> fa-icon-align-right</li>
						      <li><i class="fa-icon-align-justify"></i> fa-icon-align-justify</li>
						      <li><i class="fa-icon-indent-left"></i> fa-icon-indent-left</li>
						      <li><i class="fa-icon-indent-right"></i> fa-icon-indent-right</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-font"></i> fa-icon-font</li>
						      <li><i class="fa-icon-bold"></i> fa-icon-bold</li>
						      <li><i class="fa-icon-italic"></i> fa-icon-italic</li>
						      <li><i class="fa-icon-strikethrough"></i> fa-icon-strikethrough</li>
						      <li><i class="fa-icon-underline"></i> fa-icon-underline</li>
						      <li><i class="fa-icon-link"></i> fa-icon-link</li>
						      <li><i class="fa-icon-columns"></i> fa-icon-columns</li>
						      <li><i class="fa-icon-table"></i> fa-icon-table</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-th-large"></i> fa-icon-th-large</li>
						      <li><i class="fa-icon-th"></i> fa-icon-th</li>
						      <li><i class="fa-icon-th-list"></i> fa-icon-th-list</li>
						      <li><i class="fa-icon-list"></i> fa-icon-list</li>
						      <li><i class="fa-icon-list-ol"></i> fa-icon-list-ol</li>
						      <li><i class="fa-icon-list-ul"></i> fa-icon-list-ul</li>
						      <li><i class="fa-icon-list-alt"></i> fa-icon-list-alt</li>
						    </ul>
						  </div>
						</div>
						<br><br><br><h1>Directional Icons</h1><br>
						<div class="row-fluid bs-icons">
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-arrow-down"></i> fa-icon-arrow-down</li>
						      <li><i class="fa-icon-arrow-left"></i> fa-icon-arrow-left</li>
						      <li><i class="fa-icon-arrow-right"></i> fa-icon-arrow-right</li>
						      <li><i class="fa-icon-arrow-up"></i> fa-icon-arrow-up</li>
						      <li><i class="fa-icon-chevron-down"></i> fa-icon-chevron-down</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-circle-arrow-down"></i> fa-icon-circle-arrow-down</li>
						      <li><i class="fa-icon-circle-arrow-left"></i> fa-icon-circle-arrow-left</li>
						      <li><i class="fa-icon-circle-arrow-right"></i> fa-icon-circle-arrow-right</li>
						      <li><i class="fa-icon-circle-arrow-up"></i> fa-icon-circle-arrow-up</li>
						      <li><i class="fa-icon-chevron-left"></i> fa-icon-chevron-left</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-caret-down"></i> fa-icon-caret-down</li>
						      <li><i class="fa-icon-caret-left"></i> fa-icon-caret-left</li>
						      <li><i class="fa-icon-caret-right"></i> fa-icon-caret-right</li>
						      <li><i class="fa-icon-caret-up"></i> fa-icon-caret-up</li>
						      <li><i class="fa-icon-chevron-right"></i> fa-icon-chevron-right</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-hand-down"></i> fa-icon-hand-down</li>
						      <li><i class="fa-icon-hand-left"></i> fa-icon-hand-left</li>
						      <li><i class="fa-icon-hand-right"></i> fa-icon-hand-right</li>
						      <li><i class="fa-icon-hand-up"></i> fa-icon-hand-up</li>
						      <li><i class="fa-icon-chevron-up"></i> fa-icon-chevron-up</li>
						    </ul>
						  </div>
						</div>
						<br><br><br><h1>Video Player Icons</h1><br>
						<div class="row-fluid bs-icons">
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-play-circle"></i> fa-icon-play-circle</li>
						      <li><i class="fa-icon-play"></i> fa-icon-play</li>
						      <li><i class="fa-icon-pause"></i> fa-icon-pause</li>
						      <li><i class="fa-icon-stop"></i> fa-icon-stop</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-step-backward"></i> fa-icon-step-backward</li>
						      <li><i class="fa-icon-fast-backward"></i> fa-icon-fast-backward</li>
						      <li><i class="fa-icon-backward"></i> fa-icon-backward</li>
						      <li><i class="fa-icon-forward"></i> fa-icon-forward</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-fast-forward"></i> fa-icon-fast-forward</li>
						      <li><i class="fa-icon-step-forward"></i> fa-icon-step-forward</li>
						      <li><i class="fa-icon-eject"></i> fa-icon-eject</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-fullscreen"></i> fa-icon-fullscreen</li>
						      <li><i class="fa-icon-resize-full"></i> fa-icon-resize-full</li>
						      <li><i class="fa-icon-resize-small"></i> fa-icon-resize-small</li>
						    </ul>
						  </div>
						</div>
						<br><br><br><h1>Social Icons</h1><br>
						<div class="row-fluid bs-icons">
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-phone"></i> fa-icon-phone</li>
						      <li><i class="fa-icon-phone-sign"></i> fa-icon-phone-sign</li>
						      <li><i class="fa-icon-facebook"></i> fa-icon-facebook</li>
						      <li><i class="fa-icon-facebook-sign"></i> fa-icon-facebook-sign</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-twitter"></i> fa-icon-twitter</li>
						      <li><i class="fa-icon-twitter-sign"></i> fa-icon-twitter-sign</li>
						      <li><i class="fa-icon-github"></i> fa-icon-github</li>
						      <li><i class="fa-icon-github-sign"></i> fa-icon-github-sign</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-linkedin"></i> fa-icon-linkedin</li>
						      <li><i class="fa-icon-linkedin-sign"></i> fa-icon-linkedin-sign</li>
						      <li><i class="fa-icon-pinterest"></i> fa-icon-pinterest</li>
						      <li><i class="fa-icon-pinterest-sign"></i> fa-icon-pinterest-sign</li>
						    </ul>
						  </div>
						  <div class="span3">
						    <ul class="the-icons">
						      <li><i class="fa-icon-google-plus"></i> fa-icon-google-plus</li>
						      <li><i class="fa-icon-google-plus-sign"></i> fa-icon-google-plus-sign</li>
						      <li><i class="fa-icon-sign-blank"></i> fa-icon-sign-blank</li>
						    </ul>
						  </div>
						</div>
						
					</div>
					
				</div><!--/span-->

			</div><!--/row-->	
			
<div class="modal hide fade" id="myModal">
		<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>그리드</h3>
			</div>
			<div class="modal-body">
			
			
				<div class="row-fluid sortable">
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-th"></i><span class="break"></span>소스</h2>
						<div class="box-icon">
							<a href="#" class="btn-setting"><i class="fa-icon-wrench"></i></a>
							<a href="#" class="btn-minimize"><i class="fa-icon-chevron-up"></i></a>
							<a href="#" class="btn-close"><i class="fa-icon-remove"></i></a>
						</div>
					</div>
					<div class="box-content">
<xmp>
<div class="row-fluid sortable">
		<div class="box span12">
			<div class="box-header">
				<h2><i class="fa-icon-th"></i><span class="break"></span>Grid 12</h2>
				<div class="box-icon">
					<a href="#" class="btn-setting"><i class="fa-icon-wrench"></i></a>
					<a href="#" class="btn-minimize"><i class="fa-icon-chevron-up"></i></a>
					<a href="#" class="btn-close"><i class="fa-icon-remove"></i></a>
				</div>
			</div>
			<div class="box-content">
                	<p>
					</p>
                </div>
		</div><!--/span-->
</div><!--/row-->
					
</xmp>
                  </div>
				</div><!--/span-->
			</div><!--/row-->
			
			<div class="row-fluid sortable">
				<div class="box span3">
					<div class="box-header">
						<h2><i class="fa-icon-th"></i><span class="break"></span>Grid 3</h2>
						<div class="box-icon">
							<a href="#" class="btn-close"><i class="fa-icon-remove"></i></a>
						</div>
					</div>
					<div class="box-content">
                  	  	<p>
							Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
		             	</p>                  
                  </div>
				</div><!--/span-->
				<div class="box span3">
					<div class="box-header">
						<h2><i class="fa-icon-th"></i><span class="break"></span>Grid 3</h2>
						<div class="box-icon">
							<a href="#" class="btn-close"><i class="fa-icon-remove"></i></a>
						</div>
					</div>
					<div class="box-content">
                  	  	<p>
							Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
		             	</p>                   
                  </div>
				</div><!--/span-->
				<div class="box span3">
					<div class="box-header">
						<h2><i class="fa-icon-th"></i><span class="break"></span>Grid 3</h2>
						<div class="box-icon">
							<a href="#" class="btn-close"><i class="fa-icon-remove"></i></a>
						</div>
					</div>
					<div class="box-content">
                  	  	<p>
							Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
		             	</p>                  
                  </div>
				</div><!--/span-->
				<div class="box span3">
					<div class="box-header">
						<h2><i class="fa-icon-th"></i><span class="break"></span>Grid 3</h2>
						<div class="box-icon">
							<a href="#" class="btn-close"><i class="fa-icon-remove"></i></a>
						</div>
					</div>
					<div class="box-content">
                  	  	<p>
							Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
		             	</p>                  
                  </div>
			</div><!--/row-->
			
			
			
			
			</div>
			</div>
			
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">Close</a>
			</div>
		</div>
		
		
		
		
		
		
		
		
		
		
		<div class="modal hide fade" id="myModal2">
		<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>테이블</h3>
			</div>
			<div class="modal-body">
			
			<div class="row-fluid sortable">		
				<div class="box span12">
					<div class="box-header" data-original-title>
						<h2><i class="fa-icon-user"></i><span class="break"></span>소스</h2>
						<div class="box-icon">
							<a href="#" class="btn-setting"><i class="fa-icon-wrench"></i></a>
							<a href="#" class="btn-minimize"><i class="fa-icon-chevron-up"></i></a>
							<a href="#" class="btn-close"><i class="fa-icon-remove"></i></a>
						</div>
					</div>
					<div class="box-content">
<xmp>
<table class="table table-striped table-bordered">
  <thead>
	  <tr>
		  <th>Username</th>
		  <th>Date registered</th>
		  <th>Role</th>
		  <th>Status</th>
		  <th>Actions</th>
	  </tr>
  </thead>   
  <tbody>
	<tr>
		<td>Anton Phunihel</td>
		<td class="center">2012/01/01</td>
		<td class="center">Member</td>
		<td class="center">
			<span class="label label-success">Active</span>
		</td>
		<td class="center">
			<a class="btn btn-success" href="#">
				<i class="fa-icon-zoom-in icon-white"></i>  
			</a>
			<a class="btn btn-info" href="#">
				<i class="fa-icon-edit icon-white"></i>  
			</a>
			<a class="btn btn-danger" href="#">
				<i class="fa-icon-trash icon-white"></i> 
			</a>
		</td>
	</tr>
	</tbody>
</table>
</xmp>
					
					</div>
				</div>
			</div>
			
			
			<div class="row-fluid sortable">		
				<div class="box span12">
					<div class="box-header" data-original-title>
						<h2><i class="fa-icon-user"></i><span class="break"></span>Members</h2>
						<div class="box-icon">
							<a href="#" class="btn-setting"><i class="fa-icon-wrench"></i></a>
							<a href="#" class="btn-minimize"><i class="fa-icon-chevron-up"></i></a>
							<a href="#" class="btn-close"><i class="fa-icon-remove"></i></a>
						</div>
					</div>
					<div class="box-content">
						<table class="table table-striped table-bordered bootstrap-datatable datatable">
						  <thead>
							  <tr>
								  <th>Username</th>
								  <th>Date registered</th>
								  <th>Role</th>
								  <th>Status</th>
								  <th>Actions</th>
							  </tr>
						  </thead>   
						  <tbody>
							<tr>
								<td>Anton Phunihel</td>
								<td class="center">2012/01/01</td>
								<td class="center">Member</td>
								<td class="center">
									<span class="label label-success">Active</span>
								</td>
								<td class="center">
									<a class="btn btn-success" href="#">
										<i class="fa-icon-zoom-in icon-white"></i>  
									</a>
									<a class="btn btn-info" href="#">
										<i class="fa-icon-edit icon-white"></i>  
									</a>
									<a class="btn btn-danger" href="#">
										<i class="fa-icon-trash icon-white"></i> 
									</a>
								</td>
							</tr>
							<tr>
								<td>Alphonse Ivo</td>
								<td class="center">2012/01/01</td>
								<td class="center">Member</td>
								<td class="center">
									<span class="label label-success">Active</span>
								</td>
								<td class="center">
									<a class="btn btn-success" href="#">
										<i class="fa-icon-zoom-in icon-white"></i>  
									</a>
									<a class="btn btn-info" href="#">
										<i class="fa-icon-edit icon-white"></i>  
									</a>
									<a class="btn btn-danger" href="#">
										<i class="fa-icon-trash icon-white"></i> 
									</a>
								</td>
							</tr>
							<tr>
								<td>Thancmar Theophanes</td>
								<td class="center">2012/01/01</td>
								<td class="center">Member</td>
								<td class="center">
									<span class="label label-success">Active</span>
								</td>
								<td class="center">
									<a class="btn btn-success" href="#">
										<i class="fa-icon-zoom-in icon-white"></i>  
									</a>
									<a class="btn btn-info" href="#">
										<i class="fa-icon-edit icon-white"></i>  
									</a>
									<a class="btn btn-danger" href="#">
										<i class="fa-icon-trash icon-white"></i> 
									</a>
								</td>
								</td>
							</tr>
							<tr>
								<td>Bünyamin Kasper</td>
								<td class="center">2012/08/23</td>
								<td class="center">Staff</td>
								<td class="center">
									<span class="label label-important">Banned</span>
								</td>
								<td class="center">
									<a class="btn btn-success" href="#">
										<i class="fa-icon-zoom-in icon-white"></i>                                            
									</a>
									<a class="btn btn-info" href="#">
										<i class="fa-icon-edit icon-white"></i>                                            
									</a>
									<a class="btn btn-danger" href="#">
										<i class="fa-icon-trash icon-white"></i> 
										
									</a>
								</td>
							</tr>
							<tr>
								<td>Crofton Arran</td>
								<td class="center">2012/08/23</td>
								<td class="center">Staff</td>
								<td class="center">
									<span class="label label-important">Banned</span>
								</td>
								<td class="center">
									<a class="btn btn-success" href="#">
										<i class="fa-icon-zoom-in icon-white"></i>                                            
									</a>
									<a class="btn btn-info" href="#">
										<i class="fa-icon-edit icon-white"></i>                                            
									</a>
									<a class="btn btn-danger" href="#">
										<i class="fa-icon-trash icon-white"></i> 
										
									</a>
								</td>
							</tr>
							<tr>
								<td>Bernhard Shelah</td>
								<td class="center">2012/06/01</td>
								<td class="center">Admin</td>
								<td class="center">
									<span class="label">Inactive</span>
								</td>
								<td class="center">
									<a class="btn btn-success" href="#">
										<i class="fa-icon-zoom-in icon-white"></i>                                            
									</a>
									<a class="btn btn-info" href="#">
										<i class="fa-icon-edit icon-white"></i>                                            
									</a>
									<a class="btn btn-danger" href="#">
										<i class="fa-icon-trash icon-white"></i> 
										
									</a>
								</td>
							</tr>
							<tr>
								<td>Grahame Miodrag</td>
								<td class="center">2012/03/01</td>
								<td class="center">Member</td>
								<td class="center">
									<span class="label label-warning">Pending</span>
								</td>
								<td class="center">
									<a class="btn btn-success" href="#">
										<i class="fa-icon-zoom-in icon-white"></i>                                            
									</a>
									<a class="btn btn-info" href="#">
										<i class="fa-icon-edit icon-white"></i>                                            
									</a>
									<a class="btn btn-danger" href="#">
										<i class="fa-icon-trash icon-white"></i> 
										
									</a>
								</td>
							</tr>
							<tr>
								<td>Innokentiy Celio</td>
								<td class="center">2012/03/01</td>
								<td class="center">Member</td>
								<td class="center">
									<span class="label label-warning">Pending</span>
								</td>
								<td class="center">
									<a class="btn btn-success" href="#">
										<i class="fa-icon-zoom-in icon-white"></i>                                            
									</a>
									<a class="btn btn-info" href="#">
										<i class="fa-icon-edit icon-white"></i>                                            
									</a>
									<a class="btn btn-danger" href="#">
										<i class="fa-icon-trash icon-white"></i> 
										
									</a>
								</td>
							</tr>
							
						  </tbody>
					  </table>            
					</div>
				</div><!--/span-->
			
			</div><!--/row-->
			
			
			</div>
			
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">Close</a>
			</div>
		</div>
		
		
		
		
		
		
		<div class="modal hide fade" id="myModal3">
		<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>form</h3>
			</div>
			<div class="modal-body">
			
			
			
			<div class="row-fluid sortable">
				<div class="box span12">
					<div class="box-header" data-original-title>
						<h2><i class="fa-icon-edit"></i><span class="break"></span>Form Elements</h2>
						<div class="box-icon">
							<a href="#" class="btn-setting"><i class="fa-icon-wrench"></i></a>
							<a href="#" class="btn-minimize"><i class="fa-icon-chevron-up"></i></a>
							<a href="#" class="btn-close"><i class="fa-icon-remove"></i></a>
						</div>
					</div>
<div class="box-content">
<xmp>
<form class="form-horizontal">
  <fieldset>
	<div class="control-group">
	  <label class="control-label" for="typeahead">Auto complete </label>
	  <div class="controls">
		<input type="text" class="span6 typeahead" id="typeahead"  data-provide="typeahead" data-items="4" data-source=''>
		<p class="help-block">Start typing to activate auto complete!</p>
	  </div>
	</div>
	<div class="control-group">
	  <label class="control-label" for="date01">Date input</label>
	  <div class="controls">
		<input type="text" class="input-xlarge datepicker" id="date01" value="02/16/12">
	  </div>
	</div>

	<div class="control-group">
	  <label class="control-label" for="fileInput">File input</label>
	  <div class="controls">
		<input class="input-file uniform_on" id="fileInput" type="file">
	  </div>
	</div>          
	<div class="control-group hidden-phone">
	  <label class="control-label" for="textarea2">Textarea WYSIWYG</label>
	  <div class="controls">
		<textarea class="cleditor" id="textarea2" rows="3"></textarea>
	  </div>
	</div>
	<div class="form-actions">
	  
	  
	</div>
  </fieldset>
</form>  
</xmp>
</div>				
					<div class="box-content">
						<form class="form-horizontal">
						  <fieldset>
							<div class="control-group">
							  <label class="control-label" for="typeahead">Auto complete </label>
							  <div class="controls">
								<input type="text" class="span6 typeahead" id="typeahead"  data-provide="typeahead" data-items="4" data-source='["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Dakota","North Carolina","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]'>
								<p class="help-block">Start typing to activate auto complete!</p>
							  </div>
							</div>
							<div class="control-group">
							  <label class="control-label" for="date01">Date input</label>
							  <div class="controls">
								<input type="text" class="input-xlarge datepicker" id="date01" value="02/16/12">
							  </div>
							</div>

							<div class="control-group">
							  <label class="control-label" for="fileInput">File input</label>
							  <div class="controls">
								<input class="input-file uniform_on" id="fileInput" type="file">
							  </div>
							</div>          
							<div class="control-group hidden-phone">
							  <label class="control-label" for="textarea2">Textarea WYSIWYG</label>
							  <div class="controls">
								<textarea class="cleditor" id="textarea2" rows="3"></textarea>
							  </div>
							</div>
							<div class="form-actions">
							  
							  
							</div>
						  </fieldset>
						</form>   

					</div>
				</div><!--/span-->

			</div><!--/row-->

			<div class="row-fluid sortable">
				<div class="box span12">
					<div class="box-header" data-original-title>
						<h2><i class="fa-icon-edit"></i><span class="break"></span>Form Elements</h2>
						<div class="box-icon">
							<a href="#" class="btn-setting"><i class="fa-icon-wrench"></i></a>
							<a href="#" class="btn-minimize"><i class="fa-icon-chevron-up"></i></a>
							<a href="#" class="btn-close"><i class="fa-icon-remove"></i></a>
						</div>
					</div>
					
<div class="box-content">
<xmp>
<form class="form-horizontal">
<fieldset>
  <div class="control-group">
	<label class="control-label" for="focusedInput">Focused input</label>
	<div class="controls">
	  <input class="input-xlarge focused" id="focusedInput" type="text" value="This is focused…">
	</div>
  </div>
  <div class="control-group">
	<label class="control-label">Uneditable input</label>
	<div class="controls">
	  <span class="input-xlarge uneditable-input">Some value here</span>
	</div>
  </div>
  <div class="control-group">
	<label class="control-label" for="disabledInput">Disabled input</label>
	<div class="controls">
	  <input class="input-xlarge disabled" id="disabledInput" type="text" placeholder="Disabled input here…" disabled="">
	</div>
  </div>
  <div class="control-group">
	<label class="control-label" for="optionsCheckbox2">Disabled checkbox</label>
	<div class="controls">
	  <label class="checkbox">
		<input type="checkbox" id="optionsCheckbox2" value="option1" disabled="">
		This is a disabled checkbox
	  </label>
	</div>
  </div>
  <div class="control-group warning">
	<label class="control-label" for="inputWarning">Input with warning</label>
	<div class="controls">
	  <input type="text" id="inputWarning">
	  <span class="help-inline">Something may have gone wrong</span>
	</div>
  </div>
  <div class="control-group error">
	<label class="control-label" for="inputError">Input with error</label>
	<div class="controls">
	  <input type="text" id="inputError">
	  <span class="help-inline">Please correct the error</span>
	</div>
  </div>
  <div class="control-group success">
	<label class="control-label" for="inputSuccess">Input with success</label>
	<div class="controls">
	  <input type="text" id="inputSuccess">
	  <span class="help-inline">Woohoo!</span>
	</div>
  </div>
  <div class="control-group">
	<label class="control-label" for="selectError3">Plain Select</label>
	<div class="controls">
	  <select id="selectError3">
		<option>Option 1</option>
		<option>Option 2</option>
		<option>Option 3</option>
		<option>Option 4</option>
		<option>Option 5</option>
	  </select>
	</div>
  </div>
  <div class="control-group">
	<label class="control-label" for="selectError">Modern Select</label>
	<div class="controls">
	  <select id="selectError" data-rel="chosen">
		<option>Option 1</option>
		<option>Option 2</option>
		<option>Option 3</option>
		<option>Option 4</option>
		<option>Option 5</option>
	  </select>
	</div>
  </div>
  <div class="control-group">
	<label class="control-label" for="selectError1">Multiple Select / Tags</label>
	<div class="controls">
	  <select id="selectError1" multiple data-rel="chosen">
		<option>Option 1</option>
		<option selected>Option 2</option>
		<option>Option 3</option>
		<option>Option 4</option>
		<option>Option 5</option>
	  </select>
	</div>
  </div>
  <div class="control-group">
	<label class="control-label" for="selectError2">Group Select</label>
	<div class="controls">
		<select data-placeholder="Your Favorite Football Team" id="selectError2" data-rel="chosen">
			<option value=""></option>
			<optgroup label="NFC EAST">
			  <option>Dallas Cowboys</option>
			  <option>New York Giants</option>
			  <option>Philadelphia Eagles</option>
			  <option>Washington Redskins</option>
			</optgroup>
			<optgroup label="NFC NORTH">
			  <option>Chicago Bears</option>
			  <option>Detroit Lions</option>
			  <option>Green Bay Packers</option>
			  <option>Minnesota Vikings</option>
			</optgroup>
			<optgroup label="NFC SOUTH">
			  <option>Atlanta Falcons</option>
			  <option>Carolina Panthers</option>
			  <option>New Orleans Saints</option>
			  <option>Tampa Bay Buccaneers</option>
			</optgroup>
			<optgroup label="NFC WEST">
			  <option>Arizona Cardinals</option>
			  <option>St. Louis Rams</option>
			  <option>San Francisco 49ers</option>
			  <option>Seattle Seahawks</option>
			</optgroup>
			<optgroup label="AFC EAST">
			  <option>Buffalo Bills</option>
			  <option>Miami Dolphins</option>
			  <option>New England Patriots</option>
			  <option>New York Jets</option>
			</optgroup>
			<optgroup label="AFC NORTH">
			  <option>Baltimore Ravens</option>
			  <option>Cincinnati Bengals</option>
			  <option>Cleveland Browns</option>
			  <option>Pittsburgh Steelers</option>
			</optgroup>
			<optgroup label="AFC SOUTH">
			  <option>Houston Texans</option>
			  <option>Indianapolis Colts</option>
			  <option>Jacksonville Jaguars</option>
			  <option>Tennessee Titans</option>
			</optgroup>
			<optgroup label="AFC WEST">
			  <option>Denver Broncos</option>
			  <option>Kansas City Chiefs</option>
			  <option>Oakland Raiders</option>
			  <option>San Diego Chargers</option>
			</optgroup>
	  </select>
	</div>
  </div>
  <div class="form-actions">
	
	
  </div>
</fieldset>
 </form>
</xmp>
</div>
					
					<div class="box-content">
						<form class="form-horizontal">
							<fieldset>
							  <div class="control-group">
								<label class="control-label" for="focusedInput">Focused input</label>
								<div class="controls">
								  <input class="input-xlarge focused" id="focusedInput" type="text" value="This is focused…">
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label">Uneditable input</label>
								<div class="controls">
								  <span class="input-xlarge uneditable-input">Some value here</span>
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label" for="disabledInput">Disabled input</label>
								<div class="controls">
								  <input class="input-xlarge disabled" id="disabledInput" type="text" placeholder="Disabled input here…" disabled="">
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label" for="optionsCheckbox2">Disabled checkbox</label>
								<div class="controls">
								  <label class="checkbox">
									<input type="checkbox" id="optionsCheckbox2" value="option1" disabled="">
									This is a disabled checkbox
								  </label>
								</div>
							  </div>
							  <div class="control-group warning">
								<label class="control-label" for="inputWarning">Input with warning</label>
								<div class="controls">
								  <input type="text" id="inputWarning">
								  <span class="help-inline">Something may have gone wrong</span>
								</div>
							  </div>
							  <div class="control-group error">
								<label class="control-label" for="inputError">Input with error</label>
								<div class="controls">
								  <input type="text" id="inputError">
								  <span class="help-inline">Please correct the error</span>
								</div>
							  </div>
							  <div class="control-group success">
								<label class="control-label" for="inputSuccess">Input with success</label>
								<div class="controls">
								  <input type="text" id="inputSuccess">
								  <span class="help-inline">Woohoo!</span>
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label" for="selectError3">Plain Select</label>
								<div class="controls">
								  <select id="selectError3">
									<option>Option 1</option>
									<option>Option 2</option>
									<option>Option 3</option>
									<option>Option 4</option>
									<option>Option 5</option>
								  </select>
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label" for="selectError">Modern Select</label>
								<div class="controls">
								  <select id="selectError" data-rel="chosen">
									<option>Option 1</option>
									<option>Option 2</option>
									<option>Option 3</option>
									<option>Option 4</option>
									<option>Option 5</option>
								  </select>
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label" for="selectError1">Multiple Select / Tags</label>
								<div class="controls">
								  <select id="selectError1" multiple data-rel="chosen">
									<option>Option 1</option>
									<option selected>Option 2</option>
									<option>Option 3</option>
									<option>Option 4</option>
									<option>Option 5</option>
								  </select>
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label" for="selectError2">Group Select</label>
								<div class="controls">
									<select data-placeholder="Your Favorite Football Team" id="selectError2" data-rel="chosen">
										<option value=""></option>
										<optgroup label="NFC EAST">
										  <option>Dallas Cowboys</option>
										  <option>New York Giants</option>
										  <option>Philadelphia Eagles</option>
										  <option>Washington Redskins</option>
										</optgroup>
										<optgroup label="NFC NORTH">
										  <option>Chicago Bears</option>
										  <option>Detroit Lions</option>
										  <option>Green Bay Packers</option>
										  <option>Minnesota Vikings</option>
										</optgroup>
										<optgroup label="NFC SOUTH">
										  <option>Atlanta Falcons</option>
										  <option>Carolina Panthers</option>
										  <option>New Orleans Saints</option>
										  <option>Tampa Bay Buccaneers</option>
										</optgroup>
										<optgroup label="NFC WEST">
										  <option>Arizona Cardinals</option>
										  <option>St. Louis Rams</option>
										  <option>San Francisco 49ers</option>
										  <option>Seattle Seahawks</option>
										</optgroup>
										<optgroup label="AFC EAST">
										  <option>Buffalo Bills</option>
										  <option>Miami Dolphins</option>
										  <option>New England Patriots</option>
										  <option>New York Jets</option>
										</optgroup>
										<optgroup label="AFC NORTH">
										  <option>Baltimore Ravens</option>
										  <option>Cincinnati Bengals</option>
										  <option>Cleveland Browns</option>
										  <option>Pittsburgh Steelers</option>
										</optgroup>
										<optgroup label="AFC SOUTH">
										  <option>Houston Texans</option>
										  <option>Indianapolis Colts</option>
										  <option>Jacksonville Jaguars</option>
										  <option>Tennessee Titans</option>
										</optgroup>
										<optgroup label="AFC WEST">
										  <option>Denver Broncos</option>
										  <option>Kansas City Chiefs</option>
										  <option>Oakland Raiders</option>
										  <option>San Diego Chargers</option>
										</optgroup>
								  </select>
								</div>
							  </div>
							  <div class="form-actions">
								
								
							  </div>
							</fieldset>
						  </form>
					
					</div>
				</div><!--/span-->
			
			</div><!--/row-->
			
			<div class="row-fluid sortable">
				<div class="box span12">
					<div class="box-header" data-original-title>
						<h2><i class="fa-icon-edit"></i><span class="break"></span>Form Elements</h2>
						<div class="box-icon">
							<a href="#" class="btn-setting"><i class="fa-icon-wrench"></i></a>
							<a href="#" class="btn-minimize"><i class="fa-icon-chevron-up"></i></a>
							<a href="#" class="btn-close"><i class="fa-icon-remove"></i></a>
						</div>
					</div>
					
<div class="box-content">
<xmp>
<form class="form-horizontal">
<fieldset>
  <div class="control-group">
	<label class="control-label" for="prependedInput">Prepended text</label>
	<div class="controls">
	  <div class="input-prepend">
		<span class="add-on">@</span><input id="prependedInput" size="16" type="text">
	  </div>
	  <p class="help-block">Here's some help text</p>
	</div>
  </div>
  <div class="control-group">
	<label class="control-label" for="appendedInput">Appended text</label>
	<div class="controls">
	  <div class="input-append">
		<input id="appendedInput" size="16" type="text"><span class="add-on">.00</span>
	  </div>
	  <span class="help-inline">Here's more help text</span>
	</div>
  </div>
  <div class="control-group">
	<label class="control-label" for="appendedPrependedInput">Append and prepend</label>
	<div class="controls">
	  <div class="input-prepend input-append">
		<span class="add-on">$</span><input id="appendedPrependedInput" size="16" type="text"><span class="add-on">.00</span>
	  </div>
	</div>
  </div>
  <div class="control-group">
	<label class="control-label" for="appendedInputButton">Append with button</label>
	<div class="controls">
	  <div class="input-append">
		<input id="appendedInputButton" size="16" type="text"><button class="btn" type="button">Go!</button>
	  </div>
	</div>
  </div>
  <div class="control-group">
	<label class="control-label" for="appendedInputButtons">Two-button append</label>
	<div class="controls">
	  <div class="input-append">
		<input id="appendedInputButtons" size="16" type="text">
		<button class="btn" type="button">Search</button>
		<button class="btn" type="button">Options</button>
	  </div>
	</div>
  </div>
  <div class="control-group">
	<label class="control-label">Checkboxes</label>
	<div class="controls">
	  <label class="checkbox inline">
		<input type="checkbox" id="inlineCheckbox1" value="option1"> Option 1
	  </label>
	  <label class="checkbox inline">
		<input type="checkbox" id="inlineCheckbox2" value="option2"> Option 2
	  </label>
	  <label class="checkbox inline">
		<input type="checkbox" id="inlineCheckbox3" value="option3"> Option 3
	  </label>
	</div>
  </div>
  <div class="control-group">
	<label class="control-label">File Upload</label>
	<div class="controls">
	  <input type="file">
	</div>
  </div>
  <div class="control-group">
	<label class="control-label">Radio buttons</label>
	<div class="controls">
	  <label class="radio">
		<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked="">
		Option one is this and that—be sure to include why it's great
	  </label>
	  <div style="clear:both"></div>
		  <label class="radio">
			<input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
			Option two can be something else and selecting it will deselect option one
		  </label>
		</div>
	  </div>
	  <div class="form-actions">
		
		
	  </div>
	</fieldset>
</form>  
</xmp>
</div>	
					
					
					<div class="box-content">
						<form class="form-horizontal">
							<fieldset>
							  <div class="control-group">
								<label class="control-label" for="prependedInput">Prepended text</label>
								<div class="controls">
								  <div class="input-prepend">
									<span class="add-on">@</span><input id="prependedInput" size="16" type="text">
								  </div>
								  <p class="help-block">Here's some help text</p>
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label" for="appendedInput">Appended text</label>
								<div class="controls">
								  <div class="input-append">
									<input id="appendedInput" size="16" type="text"><span class="add-on">.00</span>
								  </div>
								  <span class="help-inline">Here's more help text</span>
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label" for="appendedPrependedInput">Append and prepend</label>
								<div class="controls">
								  <div class="input-prepend input-append">
									<span class="add-on">$</span><input id="appendedPrependedInput" size="16" type="text"><span class="add-on">.00</span>
								  </div>
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label" for="appendedInputButton">Append with button</label>
								<div class="controls">
								  <div class="input-append">
									<input id="appendedInputButton" size="16" type="text"><button class="btn" type="button">Go!</button>
								  </div>
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label" for="appendedInputButtons">Two-button append</label>
								<div class="controls">
								  <div class="input-append">
									<input id="appendedInputButtons" size="16" type="text"><button class="btn" type="button">Search</button><button class="btn" type="button">Options</button>
								  </div>
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label">Checkboxes</label>
								<div class="controls">
								  <label class="checkbox inline">
									<input type="checkbox" id="inlineCheckbox1" value="option1"> Option 1
								  </label>
								  <label class="checkbox inline">
									<input type="checkbox" id="inlineCheckbox2" value="option2"> Option 2
								  </label>
								  <label class="checkbox inline">
									<input type="checkbox" id="inlineCheckbox3" value="option3"> Option 3
								  </label>
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label">File Upload</label>
								<div class="controls">
								  <input type="file">
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label">Radio buttons</label>
								<div class="controls">
								  <label class="radio">
									<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked="">
									Option one is this and that—be sure to include why it's great
								  </label>
								  <div style="clear:both"></div>
								  <label class="radio">
									<input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
									Option two can be something else and selecting it will deselect option one
								  </label>
								</div>
							  </div>
							  <div class="form-actions">
								
								
							  </div>
							</fieldset>
						</form>
					</div>
				</div><!--/span-->

			</div><!--/row-->
			
			
			
			</div>
			
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">Close</a>
			</div>
		</div>
		
		
		
		
		
		
		
		
		
		
</div>
</body>
</html>

<script>
function template_functions(){
	$('.btn-grid').click(function(e){
		e.preventDefault();
		$('#myModal').modal('show');
	});
	$('.btn-table').click(function(e){
		e.preventDefault();
		$('#myModal2').modal('show');
	});
	$('.btn-form').click(function(e){
		e.preventDefault();
		$('#myModal3').modal('show');
	});
}
</script>