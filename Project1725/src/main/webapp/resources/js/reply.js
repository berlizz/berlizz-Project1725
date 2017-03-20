/**
 *	reply.js 
 */


/* 리플라이 들록 버튼 이벤트 처리 */
$(".addReplyBtn").on("click", function() {
	var listNumber = $("#uncompletedModal .modal-header").attr("data-ln");
	var replyText = $("#replyText").val();
	
	$.ajax({
		type : "post",
		url : "/replies",
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "post"
		},
		dataType : "text",
		data : JSON.stringify({
			listNumber : listNumber,
			replytext : replyText,
			replyWriter : "tester"
		}),
		success : function(data) {
			if(data == "success") {
				getReply(listNumber);
				$("#replyText").val("");
			}
		}
	});
});

/* 리플라이 조회 */
function getReply(listNumber) {
	var template = Handlebars.compile($("#replyTemplate").html());
	$.getJSON("/replies/" + listNumber, function(data) {
		var html = template(data);
		$(".replyList").html(html);
	});
}

/* 리플라이 등록 시간 포맷 */
Handlebars.registerHelper("replyTimeFormat", function(regDate) {
	if(regDate == null) {
		return;
	}
	
	var time = new Date(regDate);
	var year = time.getFullYear();
	var month = (time.getMonth() + 1).toString();
	var date = time.getDate().toString();
	var hours = time.getHours().toString();
	var minutes = time.getMinutes().toString();
	
	return year + "-" + (month[1]? month:"0"+month[0]) + "-" + (date[1]? date:"0"+date[0]) 
				+ " " + (hours[1]? hours:"0"+hours[1]) + ":" + (minutes[1]? minutes:"0"+minutes[0]);
});

/* 리플라이 조회 후 아이콘 설정 */
Handlebars.registerHelper("isReply", function(replyCount) {
	if(replyCount > 0) {
		return new Handlebars.SafeString(
				"<span class='glyphicon glyphicon-comment' aria-hidden='true'>" + replyCount + "</span>");
	}
	
	return;
});

/* 리플라이 삭제 */
function deleteReply(replyNumber, listNumber) {
	$.ajax({
		type : "delete",
		url : "/replies/" + replyNumber + "/" + listNumber,
		dataType : "text",
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "delete"
		},
		success : function(data) {
			if(data == "success") {
				getReply(listNumber);
			}
		}
	});
}

/* edit 버튼 이벤트 처리 */
var replyText;
function openEditor(replyNumber) {
	replyText = $(".reply-" + replyNumber).html().trim();
	
	var html = "<textarea name='editReplyText' id='editReplyText' rows='1' style='resize:none; width:80%;'>" 
			 + $(".reply-" + replyNumber).html().trim() + "</textarea>"
			 + "<button type='button' id='closeEditorBtn' class='btn btn-default btn-xs'> X </button>"
			 + "<button type='button' id='editReplyBtn' class='btn btn-primary btn-xs pull-right' data-rn='" + replyNumber + "'>Edit</button>";
	
	$(".reply-" + replyNumber).html(html);
}

$(".replyList").on("click", "#closeEditorBtn", function() {
	$(this).parent().html(replyText);
});

/* 리플라이 수정 처리 */
$(".replyList").on("click", "#editReplyBtn", function() {
	var that = $(this)
	var replyText = $("#editReplyText").val();
	var replyNumber = that.attr("data-rn");
	
	$.ajax({
		type : "put",
		url : "/replies/" + replyNumber,
		dataType : "text",
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "put"
		},
		data : JSON.stringify({
			replyNumber : replyNumber,
			replytext : replyText
		}),
		success : function(data) {
			if(data == "success") {
				that.parent().html(replyText);
			}
		}
	});
});


