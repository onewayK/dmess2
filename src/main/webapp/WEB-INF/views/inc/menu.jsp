<%@page import="kr.nshare.common.util.EgovProperties"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page session="true" %>
<%
				/************************************************************************
				* menu
				************************************************************************/	
%>

	

	<div class="navbar">
		<div class="navbar-inner">
			<div class="container-fluid">
                      <a class="brand" href="/"><img src="../images/logo_main.png"></a>
                    <div class="nav-no-collapse header-nav">
					<ul class="nav">
                        
                        <c:forEach var="list" items="${menuList}" varStatus="status">
                        	<c:choose>
                        		<c:when test="${list.parent_id eq '0' and list.sub_menu_flag eq 'n' }">
                        			<li ><a href="<c:out value="${list.url}"/>"><c:out value="${list.name}"/></a></li>
                        		</c:when>
                        		<c:when test="${list.parent_id eq '0' and list.sub_menu_flag eq 'y'}">
                        		  <li class="dropdown">
			                          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><c:out value="${list.name}"/></a></a>
			                          <ul class="dropdown-menu" role="menu">
			                          	<c:forEach var="list2"  items="${menuList}" varStatus="status2">
			                          		<c:choose>
			                          			<c:when test="${list.menu_id eq list2.parent_id}">
			                          				<c:choose>
					                          			<c:when test="${status2.index eq '0' }">
					                          				<li class="dropdown"><a href="${list2.url }">${list2.name }</a></li>
					                          			</c:when>
					                          			<c:otherwise>
					                          				<li class="dropdown"><a href="${list2.url }">${list2.name }</a></li>
					                          			</c:otherwise>
					                          		</c:choose>	
			                          			</c:when>
			                          		</c:choose>
			                          		
			                          	</c:forEach>
			                          </ul>
                        		</c:when>
                        		
                        	</c:choose>
                        
						</c:forEach>                        
                       </ul>
                      
                      <ul class="side_menu pull-right">
                     
                        <li>
                        	<c:choose>
                        		<c:when test="${userInfo.lev=='admin'}">
                        			<div class="btn-small btn-primary">관리자</div>
                        		</c:when>
                        		<c:when test="${userInfo.lev=='institution_admin'}">
                        			<div class="btn-small btn-danger">기관관리자</div>
                        		</c:when>
                        		<c:when test="${userInfo.lev=='institution_user'}">
                        			<div class="btn-small btn-warning">기관사용자</div>
                        		</c:when>
                        	</c:choose>
                        </li>
                        <li>
                        <!-- 사용저 접속 이름 및 훈련가능 코인수 -->
                        <c:choose>
                        	<c:when test="${userInfo.lev=='admin' || userInfo.lev=='institution_user'}">
                        		<strong><c:out value="${userInfo.name }"/></strong> 님 환영합니다 &nbsp;
                        	</c:when>
                        	<c:otherwise>
                        		<strong><c:out value="${userInfo.name }"/></strong> 님 환영합니다 &nbsp;
                        <!--	 <%if(EgovProperties.getProperty("Globals.service_type").equals("0")){ %>
                        			<span tooltipmessage="과금내역 : <c:out value="${userInfo.paycnt }"/>개<br>">(과금내역)</span>
                        		<%} %> -->   
                        	</c:otherwise>
                        </c:choose>
                        </li>
                        <%if(EgovProperties.getProperty("Globals.training.service.setting.type").equals("1")){ %>
                        <c:choose>
                        	<c:when test="${userInfo.lev=='admin' || userInfo.lev=='institution_user'}">
                        	
	                        </c:when>	                      
	                        <c:when test="${userInfo.service_use=='N' || userInfo.service_use==null || userInfo.service_use==''}">
	                        	 <li style="padding-top:10px;">
	                       			<strong style="color:red;">
	                       			  훈련 서비스 기간이 아닙니다.<br>
	                       			  관리자에게 문의 해주세요
	                       			</strong>
		                        </li>
	                        </c:when>
	                        <c:otherwise>
		                        <li style="padding-top:0px;">
	                       			<div>
	                       			<div>전체 훈련 기간 : <c:out value="${userInfo.start_date }"/>&nbsp;~&nbsp;<c:out value="${userInfo.end_date}"/></div>
	                       			<div> 테스트 훈련 발송 인원  : <c:out value="${userInfo.test_send_number }"/> / 
		                       			<span style="color:red;">
		                       				<c:choose>
					                        	<c:when test="${trainingService.test_sended_number == null || trainingService.test_sended_number == ''}">
					                        		0
						                        </c:when>	  
		                       					<c:otherwise>
		                       						<c:out value="${trainingService.test_sended_number }"/> 
		                       					</c:otherwise>
		                       				</c:choose>
		                       			</span>
	                       			</div> 
	                       			<div> 실전 훈련 발송 인원  : <c:out value="${userInfo.real_send_number }"/> / 
	                       				<span style="color:red;">
	                       					<c:choose>
					                        	<c:when test="${trainingService.real_sended_number == null || trainingService.real_sended_number == ''}">
					                        		0
						                        </c:when>	  
		                       					<c:otherwise>
		                       						<c:out value="${trainingService.real_sended_number }"/> 
		                       					</c:otherwise>
		                       				</c:choose>
                       					</span>
                    				</div>
	                       			</div>
		                        </li>
	                        </c:otherwise>
	                     </c:choose>  
                        <%} %>
                        <li><i class="fa-icon-off"></i><a href='/member/logOut.do'> 로그아웃</a></li>
                      </ul>
                      
                    </div><!-- /.navbar-collapse -->
                  </div><!-- /.container-fluid -->
               </div>
               </div>
                <script>
                
               
                </script>