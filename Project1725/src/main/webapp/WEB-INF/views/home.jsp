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
	<title>berlizz | Home</title>
	
	<link href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	
	<link href="/resources/css/home.css" rel="stylesheet" type="text/css" />

</head>
<body>
	
	<div class="home">
		
		<div class="intro">
			
			<div class="intro-header">
				<h1>Personal Project</h1>
				<p>개인 프로젝트</p>
				<p>리스트를 작성하여 관리하세요</p>
				<p>시작하기 버튼을 누르시면 로그인 합니다</p>
			</div>
			
			<%-- <c:if test="${signIn.userId ne null}">
				<button type="button" class="btn btn-default btn-lg startBtn" onClick="javascript:enter()">시작하기</button>	
			</c:if>
			<c:if test="${signIn.userId eq null}">
				<button type="button" id="startBtn" class="btn btn-default btn-lg">시작하기</button>	
			</c:if> --%>
			
			<div class="intro-body">
				<sec:authorize access="isAnonymous()">
					<button type="button" id="startBtn" class="btn btn-default btn-lg">시작하기</button>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<button type="button" class="btn btn-default btn-lg startBtn" onClick="javascript:enter()">시작하기</button>
				</sec:authorize>
				<a href="https://github.com/berlizz/berlizz-Project1725" type="button" class="btn btn-default btn-lg">Git Hub</a>
			</div>

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
								<input type="checkbox" name="rememberMe"> 로그인 상태 유지하기
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
	
	<script src="/resources/jquery/jquery-3.1.1.min.js"></script>
	<script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
	<script src="/resources/js/home.js"></script>
	<c:if test="${signInId ne null}">
		<input type="hidden" id="signInFail" value="${signInId}" />
		<%
			session.removeAttribute("signInId");
		%>
		<script>signInFail($("#signInFail").val())</script>
	</c:if>
</body>

</html>

