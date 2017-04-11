/**
 *	calendar.js 
 */



$(document).ready(function() {

	var now = new Date();
	var year = now.getFullYear();
	var month = now.getMonth() + 1;
	var date = now.getDate();
	var today = year + "-" + month + "-" + date;

	$("#dateInput").val(year + "-" + month);
	
	$("#datetimepicker10").datetimepicker({
		viewMode: "months",
		format : "YYYY-M"
	});
	
	insertDate(year, month);
	
});

/* date picker go 버튼 이벤트 처리 */
$("#makeCalendar").on("click", function() {
	var date = $("#dateInput").val();
	var year = date.substring(0, 4);
	var month = date.substring(5);
	
	insertDate(year, month);
});


var startingPoint;


/* 달력 날짜 입력 */
function insertDate(year, month) {
	$("td").html("");
	
	var selectedDate = new Date(year, month - 1, 1);
	var firstDay = selectedDate.getDay() * 2;
	startingPoint = firstDay;
	
	var lastDate;
	if(month == 4 || month == 6 || month == 9 || month == 11) {
		lastDate = 30;
	} else {
		if(month == 2) {
			if(year % 400 == 0 || (year % 4  == 0 && year % 100 != 0)) {
				lastDate = 29;
			} else {
				lastDate = 28;
			}
		} else {
			lastDate = 31;
		}
	}
	
	getMonthlyList(year, month, lastDate); 
	
	var col = 0;
	for(var i=1; i<=lastDate; i++) {
		$(".col_" + col + " .row_" + firstDay).html("&nbsp;<font color='blue'>" + i + "</font>");
		
		if(firstDay == 12) {
			firstDay = 0;
			col += 2;
		} else {
			firstDay += 2;
		}
		
	}
	
}


/* 월단위 리스트 조회 */
function getMonthlyList(year, month, lastDate) {
	
	var userId = $("#userId").val();
	
	$.ajax({
		type : "post",
		url : "/calendar/" + year + "/" + month,
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "post"
		},
		dataType : "text",
		data : JSON.stringify({
			userId : userId
		}),
		success : function(list) {
			
			console.log(list);
			
			list = JSON.parse(list);
			
			countCompleted(list, lastDate);
			countRegistered(list, month, lastDate);
		}
	});
}

/* 완료한 리스트만 뽑아 캘린더 페이지에 카운트 표시 */
function countCompleted(list, lastDate) {
	var completedArr = Array.apply(null, new Array(lastDate)).map(Number.prototype.valueOf, 0);
	
	for(var i=0; i<list.length; i++) {
		if(list[i].completed == true && list[i].completedDate != null) {
			completedArr[list[i].completedDate.substring(8) - 1] += 1 
		}
	}
	
	var col = 0, row = startingPoint;
	for(var i=0; i<completedArr.length; i++) {
		if(completedArr[i] > 0) {
			$(".col_" + col + " .row_" + (row + 1))
				.html("<span class='completed'>&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;<font color='green'>" + completedArr[i] + "</font>");
		}
		if(row == 12) {
			row = 0;
			col += 2;
		} else {
			row += 2;
		}
		
	}
	
}

/* 등록되었던 날만 뽑아 캘린더 페이지에 카운트 표시 */
function countRegistered(list, month, lastDate) {
	var registeredArr = Array.apply(null, new Array(lastDate)).map(Number.prototype.valueOf, 0);
	
	for(var i=0; i<list.length; i++) {
		if(list[i].regDate.substring(5, 7) > month - 1) {
			registeredArr[list[i].regDate.substring(8) - 1] += 1
		}
	}
	
	var col = 0, row = startingPoint;
	for(var i=0; i<registeredArr.length; i++) {
		if(registeredArr[i] > 0) {
			$(".col_" + (col + 1) + " .row_" + (row + 1))
				.html("<span class='registered'>&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;<font color='red'>" + registeredArr[i] + "</font>");
		}
		if(row == 12) {
			row = 0;
			col += 2;
		} else {
			row += 2;
		}
		
	}
}


