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

/* 달력 날짜 입력 */
function insertDate(year, month) {
	$("td").html("");
	
	var selectedDate = new Date(year, month - 1, 1);
	var firstDay = selectedDate.getDay() * 2;
	
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
	
	var col = 0;
	for(var i=1; i<=lastDate; i++) {
		$(".col_" + col + " .row_" + firstDay).html("&nbsp;" + i);
		
		if(firstDay == 12) {
			firstDay = 0;
			col += 2;
		} else {
			firstDay += 2;
		}
		
	}
}

