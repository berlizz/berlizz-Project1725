/**
 *	archive.js 
 */




$(document).ready(function() {
	getList();
});


function getList() {
	$.getJSON("/archive", function(list) {
		var html = "";
		for(var i=0; i<list.length; i++) {
			html += "<tr>"
					+ "<td>" + list[i].listNumber + "</td>"
					+ "<td>" + list[i].title + "</td>"
					+ "<td>" + list[i].regTimestamp + "</td>"
					+ "<td>" + list[i].completedTimestamp + "</td>"
					+ "<td>" + list[i].completed + "</td>"
					+ "<td>" + list[i].replyCount + "</td>"
					+ "</tr>"
		}
		
		$(".table").append(html);
		
	});
}