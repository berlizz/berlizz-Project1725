<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="com.berlizz.domain.SecurityUserVO" %>

<%
	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	Object principal = auth.getPrincipal();

	String name = "";
	String authority = "";

	if(principal != null && principal instanceof SecurityUserVO) {		
		name = ((SecurityUserVO)principal).getName();
		authority = ((SecurityUserVO)principal).getAuthorities().iterator().next().toString();
	}
%>


<html>
<head>
	<title>Home</title>
	
	<link href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	
	<link href="/resources/css/home.css" rel="stylesheet" type="text/css" />

</head>
<body>
	
	<div class="home">
		
		<div class="intro">
			
			<div class="intro-header">
				<h1>Hello world!</h1>
			</div>
			
			<P>  The time on the server is ${serverTime}. </P>
			<p> 한글 테스트 </p>
			
			<div>
				<h1><a id="enter" href="">Enter</a></h1>
			</div>
			
			<%-- <c:if test="${signIn.userId ne null}">
				<button type="button" class="btn btn-default btn-lg startBtn" onClick="javascript:enter()">시작하기</button>	
			</c:if>
			<c:if test="${signIn.userId eq null}">
				<button type="button" id="startBtn" class="btn btn-default btn-lg">시작하기</button>	
			</c:if> --%>
			
			<sec:authorize access="isAnonymous()">
				<button type="button" id="startBtn" class="btn btn-default btn-lg">시작하기</button>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<button type="button" class="btn btn-default btn-lg startBtn" onClick="javascript:enter()">시작하기</button>
			</sec:authorize>

		</div>
		
		
		<div class="content1">
			<div style="width:30%; height:100%; float:left; background-color:#3498db;">
				rororo
			</div>
			<div style="width:70%; float:right;">
				rororo2
			</div>
		</div>
		<div class="content2">
			rororo3
		</div>
	</div>
	
	
	<%-- sign in modal --%>
	<div class="modal fade" id="signInModal" tabindex="-1" role="dialog" aria-labelledby="signInModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
			
				<div class="modal-header">
					<h4>로그인</h4>
				</div>
				
				<div class="modal-body" style="padding-bottom : 0px;">
					<form action="/signInCheck" method="post">
					
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						
						<div class="form-group">
							<input type="text" class="form-control" name="userId" id="userId" placeholder="아이디">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" name="userPw" id="userPw" placeholder="비밀번호">
						</div>
						<div class="form-group">
							<label>
								<input type="checkbox" name="useCookie"> 로그인 상태 유지하기
							</label>
						</div>
						<div class="form-group">
							<button type="submit" id="signInBtn" class="btn btn-danger btn-lg btn-block">로그인</button>
						</div>
					</form>
				</div>
				
				<div class="modal-footer">
					<button type="button" id="signUpModalBtn" class="btn btn-warning btn-lg btn-block">계정 만들기</button>
				</div>
				
			</div>
		</div>
	
	</div>
	
	
	<%-- sign up modal --%>
	<div class="modal fade" id="signUpModal" tabindex="-1" role="dialog" aria-labelledby="signUpModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
			
				<div class="modal-header">
					<h4>계정 만들기</h4>
				</div>
				
				<div class="modal-body" style="padding-bottom : 0px;">
				
					<form action="/user/signUp" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						<div class="form-group">
							<input type="text" class="form-control" name="signUpUserId" id="signUpUserId" placeholder="아이디">
						</div>
						<div class="form-group">
							<input type="text" class="form-control" name="signUpUserName" id="signUpUserName" placeholder="사용자 이름">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" name="signUpUserPw" id="signUpUserPw" placeholder="비밀번호">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" name="signUpUserPwCheck" id="signUpUserPwCheck" placeholder="비밀번호 확인">
						</div>
						<div class="form-group">
							<button type="submit" id="signUpBtn" class="btn btn-danger btn-lg btn-block">계정 만들기</button>
						</div>
					</form>
					
				</div>
				
				<div class="modal-footer">
				</div>
				
			</div>
		</div>
	
	</div>
	
	
</body>
<script src="/resources/jquery/jquery-3.1.1.min.js"></script>
<script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
<script src="/resources/js/home.js"></script>
</html>

