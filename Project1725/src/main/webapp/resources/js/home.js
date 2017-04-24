/**
 *	home.js 
 */


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