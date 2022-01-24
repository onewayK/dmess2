<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<c:import url="/common/pageLink.do?link=inc/top_layout" />
	<div id="PageHeight" class="container-fluid">
		
		<!-- navi -->
		<ul class="breadcrumb">
            <li>
                 <i class="fa-icon-home"></i> Home / Faq / <strong>사용자 메뉴얼</strong>
            </li>
        </ul>
        
			<div class="row-fluid">
				
				<div class="box span12">
					<div class="box-header">
						<h2><i class="fa-icon-tasks"></i><span class="break"></span>사용자 메뉴얼</h2>
					</div>
					<div class="box-content">
						<p align="center">
							본시스템은 실제 악성메일과 유사한 메일을 발송하고, 사용자들이 해당 메일을 수신, 링크, 파일 실행등을 하는 행위들을 분석하고, 분석된 내용으로 차트 및 리포를 제공하여 
							기관의 보안의식 향상시키는 목적으로 개발된 서비스 입니다.  
						</p>
						<p>
							<img src='/images/usemual_01.png'>
						</p>
						<br>
					<button type="button" class="btn btn-info" onclick="dwn();">상세메뉴얼 받기</button>
    				</div>
    			</div>
    		</div>
      </div>
    <script>
    	function dwn()
    	{
    		ifr_hidden.location.href="/download/manual.do";
    	}
    </script>
   
<c:import url="/common/pageLink.do?link=inc/bottom_layout" />