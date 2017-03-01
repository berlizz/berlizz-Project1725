/**
 * upload.js
 */

function checkImageType(fileName) {
	var pattern = /jpg|gif|png|jpeg/i;

	return fileName.match(pattern);
}



function getFileInfo(fullName) {
	console.log("getFileInfo==" + fullName);
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