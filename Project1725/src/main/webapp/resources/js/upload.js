/**
 * upload.js
 */

function checkImageType(fileName) {
	var pattern = /jpg|gif|png|jpeg/i;

	return fileName.match(pattern);
}



function getFileInfo(fullName) {
	var fileName, imgsrc, getLink, fileLink;
	
	if(checkImageType(fullName)) {
		imgsrc = "/upload/displayFile?fileName=" + fullName;
		fileLink = fullName.substr(14);

		var front = fullName.substr(0, 12);
		var end = fullName.substr(14);

		getLink = "/upload/displayFile?fileName=" + front + end;
	} else {
		imgsrc = "/resources/images/file-icon.png";
		fileLink = fullName.substr(12);
		getLink = "/upload/displayFile?fileName=" + fullName;
	}

	fileName = fileLink.substr(fileLink.indexOf("_") + 1);
	
	return {
				fileName : fileName,
				imgsrc : imgsrc,
				getLink : getLink,
				fullName : fullName
			}
}




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

/* 업로드모달창 삭제버튼 이벤트 처리 */
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
				that.closest(".attachment").remove();
			}
		}
	});
});

/* 리스트 모달창 첨부파일 삭제버튼 이벤트 처리 */
$("#uncompletedModal").on("click", ".delBtn", function(event) {
	event.preventDefault();
	
	var listNumber = $("#uncompletedModal .modal-header").attr("data-ln");
	var that = $(this);
	
	$.ajax({
		type : "post",
		dataType : "text",
		url : "/upload/deleteFile",
		data : {
			fileName : that.attr("href"),
			listNumber : listNumber			// 첨부파일 카운트 업데이트용
		},
		success : function(result) {
			if(result == "success") {
				that.closest(".attachment").remove();
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