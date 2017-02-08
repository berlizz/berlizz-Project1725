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
		
			<ul class="totalList">				
			</ul>
			
			<input type="text" id="title">
			<button type="button" id="listAddBtn">ADD</button>
		
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
					<h4>Description <button type="button" class="btn btn-default btn-xs descriptionEdit">Edit</button></h4>
					
					<p class="description"></p>
					
					<div class="EditWindow" style="display:none">
						<textarea name="description" id="editText" rows="10" style="resize:none; width:100%;">description</textarea>
						<button type="button" class="btn btn-primary btn-xs editBtn">Save</button>
					</div>
					
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
				
			</div>
		</div>
	</div>
	
	
<script src="/resources/jquery/jquery-3.1.1.min.js"></script>
<script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
<!-- handlebars.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.6/handlebars.min.js"></script>




</body>
</html>

<!-- 리스트 템플릿 -->
<script id="listTemplate" type="text/x-handlebars-template">
{{#each .}}
	<li data-ln={{listNumber}} class="eachList" data-toggle="modal" data-target="#myModal">{{title}}
		<button type="button" class="btn btn-default viewBtn">view</button>
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
	
	$(document).ready(function() {
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
				if(data == "success") {
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
			$(".totalList").after(html);
		});

		$("#title").val("");
	}


	/* 모달 창 처리 */	
	$(document).on("click", ".eachList", function() {
		var listNumber = $(this).attr("data-ln");
		
		$.getJSON("/list/read/" + listNumber, function(list) {
			$(".modal-header").attr("data-ln", list.listNumber);
			$(".modal-title").html(list.title);
			$(".description").html(list.description);
		});
	});
	$("#myModal").on("hidden.bs.modal", function() {
		$(".description").show();
		$(".EditWindow").hide();
	})
	
	/* 모달 내 Edit 버튼 이벤트 처리 */
	$(".descriptionEdit").on("click", function() {
		$("#editText").html($(".description").html().replace(/<br>/gi, "\n"));
		$(".description").hide();
		$(".EditWindow").show();
	});
	

	/* 모달 description save 버튼 이벤트 처리 */
	$(".editBtn").on("click", function() {
		var listNumber = $(".modal-header").attr("data-ln");
		var title = $(".modal-title").html();
		var description = $("#editText").val().replace(/\n/gi, "<br>");
		
		$.ajax({
			type : "put",
			url : "/list/" + listNumber,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "put"
			},
			dataType : "text",
			data : JSON.stringify({
				listNumber : listNumber,
				title : title,
				description : description
			}),
			success : function(data) {
				if(data == "success") {
					$(".description").html(description);
					$(".description").show();
					$(".EditWindow").hide();
				}
			}
		});
		
	});

</script>























