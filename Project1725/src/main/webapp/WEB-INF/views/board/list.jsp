<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

<!-- 파일 업로드 창 스타일 -->
<style>
	.fileDrop {
		width: 80%;
		height: 100px;
		border: 1px dotted gray;
		background-color: lightslategrey;
		margin: auto;
	}
</style>

</head>
<body>

	<div class="col-md-3">
		<ul class="uncompletedList">
		</ul>
	</div>

	<div class="col-md-3">
			<ul class="totalList">				
			</ul>
			
			<input type="text" id="title">
			<button type="button" id="listAddBtn">ADD</button>
	</div>
	
	<div class="col-md-3">
		<ul class="completedList">
		</ul>
	</div>
	
	
	<!-- uncompleted list modal -->
	<div class="modal" id="uncompletedModal" tabindex="-1" role="dialog" aria-labelledby="uncompletedModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				
				<div class="form-inline">
					<div class="modal-header" data-ln="">
						<div class="form-gorup">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="form-group">
							<h3 class="modal-title" id="uncompletedModalLabel">uncompleted list modal title</h3>
						</div>
						<div class="form-group">
							<span class="regTimestamp">regTimestamp</span>
						</div>
					</div>
				</div>
				
				<div class="modal-body">
					
					<h4>Description <button type="button" class="btn btn-default btn-xs descriptionEdit">Edit</button></h4>
						
					<div class="form-inline">	
						<div class="form-group col-md-8">
							<p class="description"></p>
						
							<div class="EditWindow" style="display:none">
								<textarea name="description" id="editText" rows="10" style="resize:none; width:100%;">description</textarea>
								<button type="button" class="btn btn-primary btn-xs editBtn">Save</button>
							</div>
						</div>
					
					
						<div class="form-group col-md-4">
							<div class="list-group">
								<a class="list-group-item" data-toggle="modal" href="#attachmentModal">hahaha</a>
							</div>
						</div>
					</div>
					
					<ul class="attachList">
					</ul>
					
				</div>
				
				
				<div class="modal-footer">
					<button type="button" id="completeChkBtn" class="btn btn-primary">Complete</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
				
			</div>
		</div>
	</div>
	
	<!-- complete check modal -->
	<div class="modal fade bs-example-modal-sm" id="completeChkModal" tabindex="-1" role="dialog" aria-labelledly="completeChkModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					You done?
				</div>
				<div class="modal-footer">
					<button type="button" id="completeBtn" class="btn btn-primary">Yes</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- completed list modal -->
	<div class="modal fade" id="completedModal" tabindex="-1" role="dialog" aria-labelledly="completedModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h3 class="modal-title">completed list modal title</h3>
					<span class="regTimestamp"></span>
				</div>
				
				<div class="modal-body">
					<p class="description"></p>
					
					<ul class="attachList">
					</ul>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- file attachment modal -->
	<div class="modal" id="attachmentModal" tabindex="-1" role="dialog" aria-labelledly="attachmentModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h3 class="modal-title">Attachment Modal</h3>
					<p>Attachment</p>
				</div>
				<div class="modal-body">
					<div style="text-align:center;">
						<label>File Drop Here</label>
						<div class="fileDrop">
						
						</div>
						<ul class="uploadList">
							
						</ul>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="attachedSubmitBtn" class="btn btn-primary">Submit</button>
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
	<li data-ln={{listNumber}} class="eachList" data-toggle="modal" data-target="#uncompletedModal">{{title}}
	</li>
{{/each}}
</script>

<!-- 미완료 리스트 템플릿 -->
<script id="uncompletedListTemplate" type="text/x-handlebars-template">
{{#each .}}
	<li data-ln={{listNumber}} class="uncompletedEachList" data-toggle="modal" data-target="#uncompletedModal">{{title}}
	</li>
{{/each}}
</script>

<!-- 완료된 리스트 템플릿 -->
<script id="completedListTemplate" type="text/x-handlebars-template">
{{#each .}}
	<li data-ln={{listNumber}} class="completedEachList" data-toggle="modal" data-target="#completedModal">{{title}}
	</li>
{{/each}}
</script>

<!-- 첨부파일 리스트 템플릿 -->
<script id="attachTemplate" type="text/x-handlebars-template">
	<li data-src="{{fullName}}" class="attachment">
		<span class=""><img src="{{imgsrc}}" alt="attachment"></span>
		<div class="">
			<a href="{{getLink}}" class="">{{fileName}}</a>
			<a href="{{fullName}}" class="btn btn-default btn-xs pull-right delBtn">X</a>
		</div>
	</li>
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
		getUncompletedList();
		getCompletedList();
	});
	
	/* regTimestamp 포매팅 */
	function timeFormat(milliseconds) {
		var time = new Date(milliseconds);
		var year = time.getFullYear();
		var month = (time.getMonth() + 1).toString();
		var date = time.getDate().toString();
		var hours = time.getHours().toString();
		var minutes = time.getMinutes().toString();
		
		return year + "-" + (month[1]? month:"0"+month[0]) + "-" + (date[1]? date:"0"+date[0]) 
					+ " " + (hours[1]? hours:"0"+hours[1]) + ":" + (minutes[1]? minutes:"0"+minutes[0]);
	}

	/* 리스트 추가 처리 */
	$("#listAddBtn").on("click", function(event) {
		event.preventDefault();
		var title = $("#title").val();
		
		if(title == "") {
			alert("input");
			$("#title").focus();
			
			return;
		}
		
		if(title.length > 50) {
			alert("Put it under 50 characters");
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
	
	/* 당일 추가된 리스트 조회 */
	function getList() {		
		$.getJSON("/list/" + regDate, function(list) {
			var template = Handlebars.compile($("#listTemplate").html());
			var html = template(list);
			$(".eachList").remove();
			$(".totalList").after(html);
		});

		$("#title").val("");
	}
	
	/* 미완료 리스트 조회 */
	function getUncompletedList() {
		$.getJSON("/list/uncompleted", function(list) {
			var template = Handlebars.compile($("#uncompletedListTemplate").html());
			var html = template(list);
			$(".uncompletedEachList").remove();
			$(".uncompletedList").after(html);
		});
	}
	
	/* 완료된 리스트 조회 */
	function getCompletedList() {
		$.getJSON("/list/completed", function(list) {
			var template = Handlebars.compile($("#completedListTemplate").html());
			var html = template(list);
			$(".completedEachList").remove();
			$(".completedList").after(html);
		});
	}
	$("#completedModal").on("hidden.bs.modal", function() {
		$(".attachment").remove();
	});


	/*당일 추가된 리스트 모달 창 처리 */	
	$(document).on("click", ".eachList", function() {
		var listNumber = $(this).attr("data-ln");
		
		$.getJSON("/list/read/" + listNumber, function(data) {
			$(".modal-header").attr("data-ln", data.listNumber);
			$(".modal-title").html(data.title);
			$(".description").html(data.description);
			$(".regTimestamp").html(timeFormat(data.regTimestamp));
		});
		
		getAttach(listNumber);
	});
	$("#uncompletedModal").on("hidden.bs.modal", function() {
		$(".description").show();
		$(".EditWindow").hide();
		$(".attachment").remove();
	});
	
	/* 미완료 리스트 모달 창 처리 */
	$(document).on("click", ".uncompletedEachList", function() {
		var listNumber = $(this).attr("data-ln");
		
		$.getJSON("/list/read/" + listNumber, function(data) {
			$(".modal-header").attr("data-ln", data.listNumber);
			$(".modal-title").html(data.title);
			$(".description").html(data.description);
			$(".regTimestamp").html(timeFormat(data.regTimestamp));
		});
		
		getAttach(listNumber);
	});
	
	/* 당일 완료된 리스트 모달창 처리 */
	$(document).on("click", ".completedEachList", function() {
		var listNumber = $(this).attr("data-ln");
		var displayDate = "";
		
		$.getJSON("/list/read/" + listNumber, function(data) {
			$(".modal-header").attr("data-ln", data.listNumber);
			$(".modal_title").html(data.title);
			$(".description").html(data.description);
			displayDate = "Registered date " + timeFormat(data.regTimestamp) 
							+ "<br>Completed date " + timeFormat(data.completedTimestamp);
			$(".regTimestamp").html(displayDate);
		});
		
		getAttach(listNumber);
	});
	
	/* 첨부파일 조회 */
	function getAttach(listNumber) {
		$.getJSON("/list/getAttach/" + listNumber, function(list) {
			if(list.length == 0) {
				return;
			}
			
			var template = Handlebars.compile($("#attachTemplate").html());
			$(list).each(function() {
				var fileInfo = getFileInfo(this);
				var html = template(fileInfo);
				$(".attachList").append(html);
			});
		});
	}

	
	/* 모달 내 Edit 버튼 이벤트 처리 */
	$(".descriptionEdit").on("click", function() {
		$("#editText").val($(".description").html().replace(/<br>/gi, "\n"));
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
	
	/* 개별 리스트 완료 처리 */
	$("#completeChkBtn").on("click", function() {
		$("#completeChkModal").modal("show");
	});
	$("#completeBtn").on("click", function() {
		var listNumber = $(".modal-header").attr("data-ln");
		
		$.ajax({
			type : "patch",
			url : "/list/" + listNumber,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "patch"
			},
			dataType : "text",
			data : JSON.stringify({
				listNumber : listNumber
			}),
			success : function(data) {
				if(data == "success") {
					getList();
					getUncompletedList();
					getCompletedList();
					$("#completeChkModal").modal("hide");
					$("#uncompletedModal").modal("hide");
				}
			}
		});
	});
	
	
</script>

<!-- 업로드 리스트 템플릿 -->
<script id="uploadTemplate" type="text/x-handlebars-template">
<li>
	<span class="mailbox-attchment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
	<div class="mailbox-attchment-info">
		<a href="{{getLink}}" class="mailbox-attchment-name">{{fileName}}</a>
		<a href="{{fullName}}" class="btn btn-default btn-xs pull-right delBtn">X</a>
	</div>
</li>
</script>
<script src="/resources/js/upload.js"></script>
<script>
	var template = Handlebars.compile($("#uploadTemplate").html());
	
	/* 업로드 창 이벤트 처리 */
	$(".fileDrop").on("dragenter dragover", function(event) {
		event.preventDefault();
		
	});
	$(".fileDrop").on("drop", function(event) {
		event.preventDefault();
		
		var files = event.originalEvent.dataTransfer.files;
		var file = files[0];
		
		var formData = new FormData();
		formData.append("file", file);
		
		$.ajax({
			type : "post",
			dataType : "text",
			url : "/upload/uploadAjax",
			processData : false,
			contentType : false,
			data : formData,
			success : function(data) {
				var fileInfo = getFileInfo(data);
				var html = template(fileInfo);
				
				$(".uploadList").append(html);
			}
			
			
		});
		
	});
	
	$(".uploadList").on("click", ".delBtn", function(event) {
		event.preventDefault();
		
		var that = $(this);
		
		$.ajax({
			type : "post",
			dataType : "text",
			url : "/upload/deleteFile",
			data : {
				fileName : that.attr("href")
			},
			success : function(result) {
				if(result == "success") {
					that.closest("li").remove();
				}
			}
		});
	});
	
	$("#uncompletedModal").on("click", ".delBtn", function(event) {
		event.preventDefault();
		
		var that = $(this);
		
		$.ajax({
			type : "post",
			dataType : "text",
			url : "/upload/deleteFile",
			data : {
				fileName : that.attr("href")
			},
			success : function(result) {
				if(result == "success") {
					that.closest("li").remove();
				}
			}
		});
	});
	
	/* 첨부파일 submit 버튼 이벤트 처리 */
	$("#attachedSubmitBtn").on("click", function() {
		var files = new Array();
		var listNumber = $("#uncompletedModal .modal-header").attr("data-ln");
		
		$(".uploadList .delBtn").each(function() {
			files.push($(this).attr("href"));
		});
		
		$.ajax({
			type : "post",
			dataType : "text",
			url : "/upload/register/" + listNumber,
			data : {
				files : files
			},
			success : function(result) {
				if(result == "success") {
					$("#attachmentModal").modal("hide");
					$(".uploadList li").remove();
					$(".attachment").remove();
					getAttach(listNumber);
				}
			}
		});
	});

</script>























