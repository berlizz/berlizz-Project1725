<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<p> 한글 테스트 </p>
	
	<div>
		<h1><a id="enter" href="">Enter</a></h1>
	</div>
	
</body>
<script src="/resources/jquery/jquery-3.1.1.min.js"></script>
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
</script>
