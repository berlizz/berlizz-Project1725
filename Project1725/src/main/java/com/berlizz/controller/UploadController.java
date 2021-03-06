package com.berlizz.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.berlizz.service.ListService;
import com.berlizz.util.MediaUtils;
import com.berlizz.util.UploadFileUtils;

@RestController
@RequestMapping("/upload")
public class UploadController {

	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@Inject
	private ListService service;
	
	
	@RequestMapping(value = "uploadAjax", method = RequestMethod.POST)
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
		logger.info("uploadAjax()");
		
		return new ResponseEntity<>(
				UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.CREATED);
	}
	
	@RequestMapping(value = "/displayFile", method = RequestMethod.GET)
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
	
	@RequestMapping(value = "/deleteFile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName, Integer listNumber) {
		logger.info("deleteFile()");
		
		ResponseEntity<String> entity = null;
		try {
			service.deleteAttach(fileName, listNumber);
			
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			MediaType mediaType = MediaUtils.getMediaType(formatName);
			
			if(mediaType != null) {
				String front = fileName.substring(0, 12);
				String end = fileName.substring(14);
				
				new File(uploadPath + (front + end).replace('/', File.separatorChar)).delete();
			}
			
			new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
			
			entity = new ResponseEntity<>("success", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/register/{listNumber}", method = RequestMethod.POST)
	public ResponseEntity<String> registerFile(@RequestParam("files[]") String[] files, @PathVariable Integer listNumber) {
		logger.info("registerFile()");
		
		ResponseEntity<String> entity = null;
		try {
			for(String fullName : files) {
				service.addAttach(fullName, listNumber);
			}
			entity = new ResponseEntity<>("success", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
