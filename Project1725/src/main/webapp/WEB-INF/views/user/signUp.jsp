<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<form id="signInForm" action="<%=request.getContextPath()%>/signInCheck" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	<input type="hidden" name="userId" value="${userId}">
	<input type="hidden" name="userPw" value="${userPw}">
</form>

<script>
	window.onload = function() {
		document.getElementById("signInForm").submit();
	}
</script>

</body>
</html>