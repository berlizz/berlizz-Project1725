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
	//$("td").html("");
	
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
	
	var completedArr = getMonthlyList(year, month, lastDate); 
	
	var col = 0;
	for(var i=1; i<=lastDate; i++) {
		$(".col_" + col + " .row_" + firstDay).append("&nbsp;<font color='red'>" + i + "</font>");
		if(completedArr[i-1] > 0) {
			$(".col_" + col + " .row_" + (firstDay+1)).append("&nbsp;<font color='red'>" + completedArr[i] + "</font>");
			console.log("inner=" + completedArr[i-1]);
		}
		
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
	$.getJSON("/calendar/" + year +"/" + month, function(list) {
		return makeCompletedArr(list, lastDate);
	});
}

/* 완료한 리스트만 뽑아 배열의 날짜에 맞게 건수 카운트 */
function makeCompletedArr(list, lastDate) {
	var completedArr = new Array(lastDate);
	for(var i=0; i<completedArr.length; i++) {
		completedArr[i] = 0;
	}
	
	for(var i=0; i<list.length; i++) {
		if(list[i].completed == true && list[i].completedDate != null) {
			completedArr[list[i].completedDate.substring(8) - 1] += 1 
			console.log("func2=" + completedArr[9]);
		}
	}
	
	console.log("func1=" + completedArr[9]);
	
	return completedArr;
}




