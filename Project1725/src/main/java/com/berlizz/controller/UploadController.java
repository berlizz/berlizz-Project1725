package com.berlizz.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.berlizz.util.MediaUtils;
import com.berlizz.util.UploadFileUtils;

@RestController
@RequestMapping("/upload")
public class UploadController {

	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	
	@RequestMapping(value = "uploadAjax", method = RequestMethod.POST)
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
		logger.info("uploadAjax()");
		
		return new ResponseEntity<>(
				UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.CREATED);
	}
	
	@RequestMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) {
		logger.info("displayFile()");
		
		InputStream inputStream = null;
		ResponseEntity<byte[]> entity = null;
			
		try {
			String formatName = fileName.substring(fileName.lastIndexOf('.') + 1);
			MediaType mediaType = MediaUtils.getMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			
			inputStream = new FileInputStream(uploadPath + fileName);
			if(mediaType != null) {
				headers.setContentType(mediaType);
			} else {
				fileName = fileName.substring(fileName.indexOf("_") + 1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\"" 
						+ new String(fileName.getBytes("UTF-8"), "ISO-8859-1")+ "\""); 
			}
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(inputStream), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			try {
				inputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return entity;
		
	}
	
	@RequestMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName) {
		logger.info("deleteFile()");
		
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		MediaType mediaType = MediaUtils.getMediaType(formatName);
		
		if(mediaType != null) {
			String front = fileName.substring(0, 12);
			String end = fileName.substring(14);
			
			new File(uploadPath + (front + end).replace('/', File.separatorChar)).delete();
		}
		
		new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
}
