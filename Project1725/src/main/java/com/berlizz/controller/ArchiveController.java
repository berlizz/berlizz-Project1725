package com.berlizz.controller;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.berlizz.domain.ListVO;
import com.berlizz.service.ArchiveService;

@RestController
@RequestMapping("/archive")
public class ArchiveController {

	@Inject
	private ArchiveService service;
	
	private static final Logger logger = LoggerFactory.getLogger(ArchiveController.class);
	
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ResponseEntity<List<ListVO>> selectList() throws Exception {
		logger.info("selectList()");
		ResponseEntity<List<ListVO>> entity = null;
		
		try {
			List<ListVO> list = service.selectList();
			entity = new ResponseEntity<>(list, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/{page}/{perPageNum}", method = RequestMethod.GET)
	public ResponseEntity<List<ListVO>> selectListPage(
			@PathVariable("page") Integer page, 
			@PathVariable("perPageNum") Integer perPageNum,
			@RequestParam(value = "keyword", required = false) String keyword) throws Exception {
		logger.info("selectListPage()");
		ResponseEntity<List<ListVO>> entity = null;
		
		try {
			List<ListVO> list = service.selectListPage(page, perPageNum, keyword);
			entity = new ResponseEntity<>(list, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/listTotalNumber", method = RequestMethod.GET)
	public ResponseEntity<String> listTotalNumber(
			@RequestParam(value = "keyword", required = false) String keyword) throws Exception {
		logger.info("listTotalNumber()");
		ResponseEntity<String> entity = null;
		
		logger.info("keyword : " + keyword);
		if(keyword.equals("")) {
			keyword = null;
		}
		
		try {
			int listTotalNumber = service.listTotalNumber(keyword);
			
			logger.info("number : " + listTotalNumber);
			
			entity = new ResponseEntity<>(String.valueOf(listTotalNumber), HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
