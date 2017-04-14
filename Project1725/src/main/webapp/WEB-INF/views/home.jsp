<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
			
			<c:if test="${signIn.userId ne null}">
				<button type="button" class="btn btn-default btn-lg startBtn" onClick="javascript:enter()">시작하기</button>	
			</c:if>
			<c:if test="${signIn.userId eq null}">
				<button type="button" id="startBtn" class="btn btn-default btn-lg">시작하기</button>	
			</c:if>

		</div>
		
		<div class="content1">
			rororo2
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
					<form action="/user/signIn" method="post">
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
</html>


<script>
	$("#enter").on("click", function(event) {
		event.preventDefault();
		var now = new Date();
		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		var date = now.getDate();
		
		self.location = "/board/list?year=" + year + "&month=" + month + "&date=" + date;
	});
	
	/*  로그인 버튼 클릭 이벤트 처리  */
	$("#signInBtn").click(function(event) {
		if($("#userId").val() == "") {
			alert("아이디를 입력하세요");
			$("#userId").focus();
			event.preventDefault();
			
			return;
		}
		if($("#userPw").val() == "") {
			alert("비밀번호를 입력하세요");
			$("#userPw").focus();
			event.preventDefault();
			
			return;
		}
	});
	
	/*  로그인 하지 않은 상태로 시작하기 버튼 누를 시 이벤트 처리  */
	$("#startBtn").on("click", function() {
		$("#signInModal").modal("show");
	});
	
	/*  로그인 한 상태로 시작하기 버튼 누를 시 이벤트 처리  */
	function enter() {
		window.location = "/board/list";
	}
	
	/*  계정 만들기 모달 이벤트 처리  */
	$("#signUpModalBtn").on("click", function() {
		$("#signInModal").modal("hide");
		$("#signUpModal").modal("show");
	});
	
	/*  계정 만들기 버튼 클릭 시 폼 이벤트 처리  */
	$("#signUpBtn").on("click", function() {
		if($("#signUpUserId").val() == "") {
			alert("아이디를 입력하세요");
			$("#signUpUserId").focus();
			event.preventDefault();
			
			return;
		}
		if($("#signUpUserName").val() == "") {
			alert("사용자 이름을 입력하세요");
			$("#signUpUserName").focus();
			event.preventDefault();
			
			return;
		}
		if($("#signUpUserPw").val() == "") {
			alert("비밀번호를 입력하세요");
			$("#signUpUserPw").focus();
			event.preventDefault();
			
			return;
		}
		if($("#signUpUserPwCheck").val() == "") {
			alert("비밀번호 확인을 입력하세요");
			$("#signUpUserPwCheck").focus();
			event.preventDefault();
			
			return;
		}
		if($("#signUpUserPw").val() != $("#signUpUserPwCheck").val()) {
			alert("입력하신 비밀번호가 일치하지 않습니다");
			$("#signUpUserPwCheck").focus();
			event.preventDefault();
			
			return;
		}
	});
	
	/*  모달이 닫힐 때 이벤트 처리  */
	$("#signInModal").on("hidden.bs.modal", function() {
		$("#userId").val("");
		$("#userPw").val("");
	});
	$("#signUpModal").on("hidden.bs.modal", function() {
		$("#signUpUserId").val("");
		$("#signUpUserName").val("");
		$("#signUpUserPw").val("");
		$("#signUpUserPwCheck").val("");
	});

</script>
