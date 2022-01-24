<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"			uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="true" %>


<c:import url="/common/pageLink.do?link=inc/top_pop_layout" />
		<ul class="breadcrumb" style="width:93%">
            <li>
                <i class="fa-icon-home"></i> Home / 시스템 관리 / <strong>과금관리</strong>
            </li>
        </ul>
        <script>
        	var now_paycnt = "${memberInfo.paycnt }";
        </script>		
	<div id="content2">
			<div class="panel panel-default">
       		 	<div class="panel-heading">
       		 		
       		 	</div>
	       		 	 <form class="form-horizontal" role="form" name='frm' method='post'>
	       		 		<table class="table table-bordered">
	       		 		<colgroup>
	       		 			<col width="150px">
	       		 			<col width="150px">
	       		 			<col width="150px">
	       		 			<col width="*">
	       		 		</colgroup>
	       		 		 <tbody>
	       		 		 	<tr>
	       		 		 		<th>아이디(사용자명)</th>
	       		 		 		<td>${memberInfo.userid }(${memberInfo.name })</td>
	       		 		 		<th>잔여과금</th>
	       		 		 		<td>${memberInfo.paycnt }</td>
	       		 		 	</tr>
	       		 		 	<tr>
	       		 		 		<td colspan="4" align="center" style="text-align: center"><b>관리 기관</b></tr></td>
	       		 		 	</tr>
	       		 		 	<tr>
	       		 		 		<th>No</th>
	       		 		 		<th colspan="2">기관명</th>
	       		 		 		<th>기관 등록시간</th>
	       		 		 	</tr>
	       		 		 	<c:choose>
						    		<c:when test="${fn:length(authList)>0}">
						    			
						    			<c:forEach var="authList" items="${authList}" varStatus="status">
									    	<tr>
					       		 		 		<td align="center" style="text-align: center;">${status.count }</td>
					       		 		 		<td colspan="2" align="center" style="text-align: center;">${authList.institution_name }</td>
					       		 		 		<td>${authList.sdate }</td>
					       		 		 	</tr>
				       		 			</c:forEach>
						    		</c:when>
						    		<c:otherwise>
						    			<tr>
				       		 				<td colspan="4" align="center">no list</td>
				       		 			</tr>		
		       		 				 </c:otherwise>
					    	</c:choose>
	       		 		 	<tr>
	       		 		 		<th>과금추가</th>
	       		 		 		<td>
	       		 		 		<select name='type' onchange="payment_analyst();">
	       		 		 			<option value='plus'>추가</option>
	       		 		 			<option value='minus'>차감</option>
	       		 		 		</select>
	       		 		 		<select name='paycnt' onchange="payment_analyst();" >
	       		 		 			<c:forEach begin="1" end="10" var="paycnt">
	       		 		 				<option value="${paycnt}">${paycnt}</option>	
	       		 		 			</c:forEach>
	       		 		 		</select></td>
	       		 		 		<th>총과금수</th>
	       		 		 		<td><div id='total_payment_view'>${memberInfo.paycnt }</div><input type='hidden' name='total_payment' id='total_payment' value='${memberInfo.paycnt }'></td>
	       		 		 	</tr>
	       		 		 	<tr>
	       		 		 		<td colspan="4" align="right" style="text-align: right">
	       		 		 			<font color='red' size="1">※총과금은 현재 잔여과금에 추가 및 차감한 값입니다.</font>
	       		 		 		</td>
	       		 		 	</tr>
	       		 		 	<tr>
	       		 		 		<th>comment</th>
	       		 		 		<td colspan="3">
	       		 		 			<textarea id='comment' name='comment' rows="10" cols="10" style="width:100%"></textarea>
	       		 		 		</td>
	       		 		 	</tr>	
	       		 		 		
					    </tbody>
	       		 		</table>
	       				
	       				<input type='hidden' name='code' value="${searchVO.code}"/>
	       							
	       		 	</form>
	       		 	<table width='100%' border='0'>
				    	<tr>
				    		<td width="50px" align="right">
				    			<button type="button" class="btn btn-default" onClick='insertPaymentPop();'>과금실행</button>
							</td>
				    	</tr>
					 </table>
       		 	</div>
    </div>
    <script>
    
    /**
    과금 실행
    **/
    function insertPaymentPop()
    {
    	document.frm.action = "/system/paymanage_proc.do";
    	document.frm.submit();
    	
    }
    	
    function payment_analyst()
    {
    	var chk = true;
    	//총갯수
    	var total_payment = Number(now_paycnt);
    	var paycnt = Number($("select[name='paycnt']").val());
    	
    	if($("select[name='type']").val()=="plus")
    	{
    		total_payment = total_payment + paycnt;	
    	}
    	else if($("select[name='type']").val()=="minus")
    	{
    		total_payment = total_payment-paycnt;
    		
    		if(total_payment<0)
    		{
    			alert("현재 차감하실려는 갯수는('"+paycnt+"')는 총갯수 보다 많습니다. 그렇기때문에 차감하실수없습니다.");
    			
    			chk=false;
    		}
    		
    	}
    	if(chk==true)
   		{
    		$("#total_payment").val(total_payment);
   			$("#total_payment_view").html(total_payment);
   		}
    	return chk;
    	
    }
    
	    
    
    </script>
<c:import url="/common/pageLink.do?link=inc/bottom_pop_layout" />