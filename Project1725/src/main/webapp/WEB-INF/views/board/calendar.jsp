<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="com.berlizz.domain.SecurityUserVO" %>

<%
	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	Object principal = auth.getPrincipal();

	String userId = "";		// 사용자 아이디
	String userName = "";	// 사용자 이름

	if(principal != null && principal instanceof SecurityUserVO) {
		userId = ((SecurityUserVO)principal).getUsername();	// 사용자 아이디
		userName = ((SecurityUserVO)principal).getName();	// 사용자 이름
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>project1725</title>

<link href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="/resources/datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/calendar.css" rel="stylesheet" type="text/css" />

<%-- csrf, csrf header --%>
<sec:csrfMetaTags/>
 
</head>
<body>

	
	<div style="height:100px; width:100%; font-size:50px; text-align:center; background-color:#337ab7;">
		<a href="/" style="decoration:none; color:white;">hello</a>
	</div>
	
	
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#"></a>
			</div>
			
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="/board/list">List <span class="sr-only">(current)</span></a></li>
					<li class="active"><a href="/board/calendar">Calendar</a></li>
					<li><a href="/board/archive">Archive</a></li>
					<li><a href="#">Link4</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><span class="glyphicon glyphicon-user"></span> <%=userName%><span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#">Link1</a></li>
							<li><a href="#">Link2</a></li>
							<li><a href="#">Link3</a></li>
							<li class="divider"></li>
							<li><a href="javascript:signOut()">Sign out</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	
	
	<%-- 사용자 아이디 저장 --%>
	<input type="hidden" id="userId" value="<%=userId%>">
	<%-- <input type="hidden" id="userId" value="${signIn.userId}"> --%>
	
	
	<div class="table">
		
		<div class="container">
			<div class="">
		        <div class="form-inline">
		        	<div  class="form-group">
			            <div class="input-group date" id="datetimepicker10">
			                <input type="text" id="dateInput" class="form-control"/>
			                <span class="input-group-addon">
			                    <span class="glyphicon glyphicon-calendar">
			                    </span>
			                </span>
			            </div>
		            </div>
		            <div class="form-group">
		            	<button type="button" id="makeCalendar" class="btn btn-primary">go</button>
		            </div>
		        </div>
		    </div>		
		</div>

		
		<table>
			<tr>
				<th colspan="2" style="color:red;">SUN</th>
				<th colspan="2">MON</th>
				<th colspan="2">TUE</th>
				<th colspan="2">WED</th>
				<th colspan="2">THU</th>
				<th colspan="2">FRI</th>
				<th colspan="2">SAT</th>
			</tr>
			<tr class="col_0">
				<td class="row_0"></td>
				<td class="row_1"></td>
				<td class="row_2"></td>
				<td class="row_3"></td>
				<td class="row_4"></td>
				<td class="row_5"></td>
				<td class="row_6"></td>
				<td class="row_7"></td>
				<td class="row_8"></td>
				<td class="row_9"></td>
				<td class="row_10"></td>
				<td class="row_11"></td>
				<td class="row_12"></td>
				<td class="row_13"></td>
			</tr>
			<tr class="col_1">
				<td class="row_0"></td>
				<td class="row_1"></td>
				<td class="row_2"></td>
				<td class="row_3"></td>
				<td class="row_4"></td>
				<td class="row_5"></td>
				<td class="row_6"></td>
				<td class="row_7"></td>
				<td class="row_8"></td>
				<td class="row_9"></td>
				<td class="row_10"></td>
				<td class="row_11"></td>
				<td class="row_12"></td>
				<td class="row_13"></td>
			</tr>
			<tr class="col_2">
				<td class="row_0"></td>
				<td class="row_1"></td>
				<td class="row_2"></td>
				<td class="row_3"></td>
				<td class="row_4"></td>
				<td class="row_5"></td>
				<td class="row_6"></td>
				<td class="row_7"></td>
				<td class="row_8"></td>
				<td class="row_9"></td>
				<td class="row_10"></td>
				<td class="row_11"></td>
				<td class="row_12"></td>
				<td class="row_13"></td>
			</tr>
			<tr class="col_3">
				<td class="row_0"></td>
				<td class="row_1"></td>
				<td class="row_2"></td>
				<td class="row_3"></td>
				<td class="row_4"></td>
				<td class="row_5"></td>
				<td class="row_6"></td>
				<td class="row_7"></td>
				<td class="row_8"></td>
				<td class="row_9"></td>
				<td class="row_10"></td>
				<td class="row_11"></td>
				<td class="row_12"></td>
				<td class="row_13"></td>
			</tr>
			<tr class="col_4">
				<td class="row_0"></td>
				<td class="row_1"></td>
				<td class="row_2"></td>
				<td class="row_3"></td>
				<td class="row_4"></td>
				<td class="row_5"></td>
				<td class="row_6"></td>
				<td class="row_7"></td>
				<td class="row_8"></td>
				<td class="row_9"></td>
				<td class="row_10"></td>
				<td class="row_11"></td>
				<td class="row_12"></td>
				<td class="row_13"></td>
			</tr>
			<tr class="col_5">
				<td class="row_0"></td>
				<td class="row_1"></td>
				<td class="row_2"></td>
				<td class="row_3"></td>
				<td class="row_4"></td>
				<td class="row_5"></td>
				<td class="row_6"></td>
				<td class="row_7"></td>
				<td class="row_8"></td>
				<td class="row_9"></td>
				<td class="row_10"></td>
				<td class="row_11"></td>
				<td class="row_12"></td>
				<td class="row_13"></td>
			</tr>
			<tr class="col_6">
				<td class="row_0"></td>
				<td class="row_1"></td>
				<td class="row_2"></td>
				<td class="row_3"></td>
				<td class="row_4"></td>
				<td class="row_5"></td>
				<td class="row_6"></td>
				<td class="row_7"></td>
				<td class="row_8"></td>
				<td class="row_9"></td>
				<td class="row_10"></td>
				<td class="row_11"></td>
				<td class="row_12"></td>
				<td class="row_13"></td>
			</tr>
			<tr class="col_7">
				<td class="row_0"></td>
				<td class="row_1"></td>
				<td class="row_2"></td>
				<td class="row_3"></td>
				<td class="row_4"></td>
				<td class="row_5"></td>
				<td class="row_6"></td>
				<td class="row_7"></td>
				<td class="row_8"></td>
				<td class="row_9"></td>
				<td class="row_10"></td>
				<td class="row_11"></td>
				<td class="row_12"></td>
				<td class="row_13"></td>
			</tr>
			<tr class="col_8">
				<td class="row_0"></td>
				<td class="row_1"></td>
				<td class="row_2"></td>
				<td class="row_3"></td>
				<td class="row_4"></td>
				<td class="row_5"></td>
				<td class="row_6"></td>
				<td class="row_7"></td>
				<td class="row_8"></td>
				<td class="row_9"></td>
				<td class="row_10"></td>
				<td class="row_11"></td>
				<td class="row_12"></td>
				<td class="row_13"></td>
			</tr>
			<tr class="col_9">
				<td class="row_0"></td>
				<td class="row_1"></td>
				<td class="row_2"></td>
				<td class="row_3"></td>
				<td class="row_4"></td>
				<td class="row_5"></td>
				<td class="row_6"></td>
				<td class="row_7"></td>
				<td class="row_8"></td>
				<td class="row_9"></td>
				<td class="row_10"></td>
				<td class="row_11"></td>
				<td class="row_12"></td>
				<td class="row_13"></td>
			</tr>
			<tr class="col_10">
				<td class="row_0"></td>
				<td class="row_1"></td>
				<td class="row_2"></td>
				<td class="row_3"></td>
				<td class="row_4"></td>
				<td class="row_5"></td>
				<td class="row_6"></td>
				<td class="row_7"></td>
				<td class="row_8"></td>
				<td class="row_9"></td>
				<td class="row_10"></td>
				<td class="row_11"></td>
				<td class="row_12"></td>
				<td class="row_13"></td>
			</tr>
			<tr class="col_11">
				<td class="row_0"></td>
				<td class="row_1"></td>
				<td class="row_2"></td>
				<td class="row_3"></td>
				<td class="row_4"></td>
				<td class="row_5"></td>
				<td class="row_6"></td>
				<td class="row_7"></td>
				<td class="row_8"></td>
				<td class="row_9"></td>
				<td class="row_10"></td>
				<td class="row_11"></td>
				<td class="row_12"></td>
				<td class="row_13"></td>
			</tr>
		</table>
	</div>
	
	<div class="completed"></div>




<script src="/resources/jquery/jquery-3.1.1.min.js"></script>
<script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
<script src="/resources/js/calendar.js"></script>
<script src="/resources/momentjs/moment.min.js"></script>
<script src="/resources/datetimepicker/bootstrap-datetimepicker.min.js"></script>

</body>
</html>