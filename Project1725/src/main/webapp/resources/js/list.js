/**
 *	list.js 
 */

Handlebars.registerHelper("editDescription", function(description) {
	if(description.length > 35) {
		return description.substring(0, 35).replace(/<br>/gi, " ") + "...";	
	}
	
	return description.replace(/<br>/gi, " ");
});

Handlebars.registerHelper("isAttach", function(attachCount) {
	if(attachCount > 0) {
		return new Handlebars.SafeString(
				"<span class='glyphicon glyphicon-paperclip' aria-hidden='true'>" + attachCount + "</span>&nbsp;&nbsp;");
	}
	
	return;
});

var now = new Date();
var year = now.getFullYear();
var month = now.getMonth() + 1;
var date = now.getDate();
var regDate = year + "-" + month + "-" + date;

var writer = "tester";

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

/* 리스트 인풋텍스트 보이기 */
$(".showInputBtn").on("click", function() {	
	$(this).hide();
	$(".listInput").show();
});
/* 리스트 인풋텍스트  감추기 */
$(".hideInputBtn").on("click", function() {
	$(this).parent().hide();
	$(".showInputBtn").show();
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

/* 모달창 닫기 옵션 */
$("#uncompletedModal").on("hidden.bs.modal", function() {
	$(".description").show();
	$(".EditWindow").hide();
	$(".attachment").remove();
	getList();
	getUncompletedList();
});

/*당일 추가된 리스트 모달 창 클릭 이벤트 처리 */	
$(document).on("click", ".eachList", function() {
	var listNumber = $(this).attr("data-ln");

	makeUncompletedModal(listNumber);
	getAttach(listNumber);
	getReply(listNumber);
});

/* 미완료 리스트 모달 창 클릭 이벤트 처리 */
$(document).on("click", ".uncompletedEachList", function() {
	var listNumber = $(this).attr("data-ln");
	
	makeUncompletedModal(listNumber);
	getAttach(listNumber);
	getReply(listNumber);
});

/* 미완료 리스트 모달 창 처리 */
function makeUncompletedModal(listNumber) {
	$.getJSON("/list/read/" + listNumber, function(data) {
		$(".modal-header").attr("data-ln", data.listNumber);
		$(".modal-title").html(data.title);
		$(".description").html(data.description);
		$(".regTimestamp").html(timeFormat(data.regTimestamp));
	});
}

/* 당일 완료된 리스트 모달창 클릭 이벤트 처리 */
$(document).on("click", ".completedEachList", function() {
	var listNumber = $(this).attr("data-ln");
	
	makeCompletedModal(listNumber);
	getAttach(listNumber);
	getReply(listNumber);
});

/* 당일 완료된 리스트 모달창 처리 */
function makeCompletedModal(listNumber) {
	var displayDate = "";
	
	$.getJSON("/list/read/" + listNumber, function(data) {
		$(".modal-header").attr("data-ln", data.listNumber);
		$(".modal-title").html(data.title);
		$(".description").html(data.description);
		displayDate = "Registered date " + timeFormat(data.regTimestamp) 
						+ "<br>Completed date " + timeFormat(data.completedTimestamp);
		$(".regTimestamp").html(displayDate);
	});
}


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
/* description Cancel 버튼 */
$(".cancelBtn").on("click", function() {
	$(".description").show();
	$(".EditWindow").hide();
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