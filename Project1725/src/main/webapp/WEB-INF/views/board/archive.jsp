<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>project1725</title>

<link href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

<link href="/resources/datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
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
				<a class="navbar-brand"></a>
			</div>
			
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="/board/list">List</a></li>
					<li><a href="/board/calendar">Calendar</a></li>
					<li class="active"><a href="/board/archive">Archive</a></li>
					<li><a href="#">Link4</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><span class="glyphicon glyphicon-user"></span> user name<span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#">Link1</a></li>
							<li><a href="#">Link2</a></li>
							<li><a href="#">Link3</a></li>
							<li class="divider"></li>
							<li><a href="#">Sign out</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	
	<div class="archive">
		<div class="form-inline">
			<div class="form-group">
				<div class="input-group">
					<input type="text" id="keyword" placeholder="keyword">
				</div>
				<button type="button" class="btn btn-primary" id="searchBtn"><span class="glyphicon glyphicon-search"></span> search</button>
			</div>
			<div class="form-group pull-right">
				<select>
					<option>10 per page</option>
					<option>20 per page</option>
					<option>50 per page</option>
				</select>
			</div>
		</div>
		
		<div class="table-responsive">
			<table class="table table-hover">
				<tr>
					<th>number</th>
					<th>title</th>
					<th>reg timestamp</th>
					<th>com timestamp</th>
					<th>completed</th>
					<th>etc</th>
				</tr>
			</table>
		</div>
	</div>
	


<style>
	.archive {
		padding-left : 2%;
		padding-right : 2%;
	}
</style>

<script src="/resources/jquery/jquery-3.1.1.min.js"></script>
<script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
<script src="/resources/js/archive.js"></script>
</body>
</html>