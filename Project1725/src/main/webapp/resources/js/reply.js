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
			}
		}
	});
});

/* 리플라이 조회 */
function getReply(listNumber) {
	$.getJSON("/replies/" + listNumber, function(data) {
		alert(data.toString());
	});
}


