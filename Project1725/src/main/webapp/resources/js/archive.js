/**
 *	archive.js 
 */



var page = 1, perPageNum = 10;	// 현재 페이지, 페이지당 갯수
var listTotalNumber;			// 전체 리스트 총 갯수
var keyword = "";				// 검색 키워드

$(document).ready(function() {
	
	/* csrf값을 가지고 ajax통신하기 위해 token 값과 csrf header로 berforeSend에서 설정한 후 데이터 전송 및 받음 */
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$.ajaxSetup({
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		}
	});
	
	getArchiveList(page, perPageNum, keyword);
});

/* 리스트 가져오기 */
function getArchiveList(page, perPageNum, keyword) {
	
	var userId = $("#userId").val();
	
	/* 리스트 총 갯수 가져오기 */
	$.ajax({
		type : "post",
		url : "/archive/listTotalNumber?keyword=" + keyword,
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "post"
		},
		dataType : "text",
		data : JSON.stringify({
			userId : userId
		}),
		success : function(data) {
			listTotalNumber = data;
		}
	});
	
	/* 리스트 가져와서 테이블에 삽입 */
	$.ajax({
		type : "post",
		url : "/archive/" + page + "/" + perPageNum + "?keyword=" + keyword,
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "post"
		},
		dataType : "text",
		data : JSON.stringify({
			userId : userId
		}),
		success : function(list) {
			list = JSON.parse(list);
			
			var template = Handlebars.compile($("#archiveTemplate").html());
			var html = template(list);
			$(".appended").remove();
			$(".tableBody").append(html);
			
			pagination(page);
		} 
	});
}

/* 페이징 처리 */
function pagination(page) {
	var endPage = Math.ceil(page / perPageNum) * 10;
	var	startPage = (endPage - 10) + 1;
	
	var tempEndPage = Math.ceil(listTotalNumber / perPageNum);
	if(endPage > tempEndPage) {
		endPage = tempEndPage;
	}
	
	var html = "";
	
	if(startPage != 1) {
		html += "<li class='page'><a href='1' aria-label='Previous'><span aria-hidden='true'>Prev</span></a></li>";
	}
	
	var i = startPage;
		len = endPage - startPage + 1;
	for(; i<=len; i++) {
		if(i == page) {
			html += "<li class='active page'><a>" + i + "<span class='sr-only'>(current)</span></a></li>";
		} else {
			html += "<li class='page'><a href='" + i + "'>" + i + "</a></li>";
		}
	}
	
	if(endPage * perPageNum <= listTotalNumber) {
		html += "<li class='page'><a href='endPage + 1' aria-label='Next'><span aria-hidden='true'>Next</span></a></li>";
	}
	
	$(".pagination").html(html);
}

/* 페이징 ul태그 클릭 이벤트 처리 */
$(document).on("click", ".pagination li a", function(event) {
	event.preventDefault();
	
	page = $(this).attr("href");
	
	getArchiveList(page, perPageNum, keyword);
});

/* 페이지 당 목록 갯수 select list 변경 이벤트 처리 */
$(".perPageNum").change(function() {
	perPageNum = $(".perPageNum option:selected").val();
	
	getArchiveList(page, perPageNum, keyword);
});

/* 검색 버튼 이벤트 처리 */
$("#searchBtn").on("click", function() {
	keyword = $("#keyword").val();
	page = 1;
	perPageNum = 10;
	
	getArchiveList(page, perPageNum, keyword);
});

/* 리스트 클릭 이벤트 처리 */
$(document).on("click", ".appended", function() {
	var listNumber = $(this).attr("id");
	
	var isCompleted = $(this).children(".isCompleted").html();
	if(isCompleted == "false") {
		makeUncompletedModal(listNumber);
		$("#uncompletedModal").modal("show");
	} else {
		makeCompletedModal(listNumber);
		$("#completedModal").modal("show");
	}
	
	getAttach(listNumber);
	getReply(listNumber);
});

/* 모달창 닫을 시 이벤트 처리 */
$(".modal").on("hidden.bs.modal", function() {
	getArchiveList(page, perPageNum, keyword);
});


function signOut() {
	$.post("/signOut", {
		success : function() {
			window.location = "/";
		}
	});
}
