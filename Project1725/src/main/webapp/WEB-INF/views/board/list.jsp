<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

</head>
<body>

	<div class="col-md-4">
		<form id="form">
			<ul id="totalList">				
			</ul>
			
			<input type="text" id="title">
			<button type="button" id="listAddBtn">ADD</button>
		</form>
	</div>
	
	<!-- modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				
				<div class="modal-header" data-ln="">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Modal Title</h4>
				</div>				
				
				<div class="modal-body">
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
				
			</div>
		</div>
	</div>
	
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">Modal</button>
	
<script src="/resources/jquery/jquery-3.1.1.min.js"></script>
<script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
<!-- handlebars.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.6/handlebars.min.js"></script>




</body>
</html>

<!-- 리스트 템플릿 -->
<script id="listTemplate" type="text/x-handlebars-template">
{{#each .}}
	<li data-ln={{listNumber}} class="eachList">{{title}}
		<button type="button" id="viewBtn" class=btn btn-default>view</button>
	</li>
{{/each}}
</script>

<script>
	var now = new Date();
	var year = now.getFullYear();
	var month = now.getMonth() + 1;
	var date = now.getDate();
	var regDate = year + "-" + month + "-" + date;
	
	var writer = "tester";
	
	$("document").ready(function() {
		getList();
	});

	/* 리스트 추가 처리 */
	$("#listAddBtn").on("click", function(event) {
		event.preventDefault();
		var title = $("#title").val();
		
		if(title == "") {
			alert("input");
			$("#title").focus();
			
			return;
		}
		
		$.ajax({
			type : "post",
			url : "/list/",
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "post"
			},
			dataType : "text",
			data : JSON.stringify ({
				title : title,
				writer : writer,
				description : " ",
				regDate : regDate
			}),
			success : function(data) {
				if(data = "success") {
					getList();
				}
			}
		
		});
	});
	
	/* 리스트 조회 */
	function getList() {
		var str = "";
		
		$.getJSON("/list/" + regDate, function(list) {
			var template = Handlebars.compile($("#listTemplate").html());
			var html = template(list);
			$(".eachList").remove();
			$("#totalList").after(html);
		});
		
		$("#title").val("");
	}


	/* 모달 창 처리 */
	$("#viewBtn").on("click", function() {
		var that = $(this).parent();
		var listNumber = that.attr("data-ln");
		console.log("----" + listNumber);
		
		$.getJSON("/list/read/" + listNumber, function(list) {
			$(".modal-header").attr("data-ln", list.listNumber);
			$(".modal-title").html(list.title);
			$(".modal-body").html(list.description);
			
		});
	});
	
	
</script>























