package com.berlizz.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.berlizz.domain.ListVO;
import com.berlizz.service.ListService;

@RestController
@RequestMapping("/list")
public class ListController {

	@Inject
	private ListService service;
	
	private static final Logger logger = LoggerFactory.getLogger(ListController.class);
	
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> registerList(@RequestBody ListVO vo) {
		logger.info("registerList()");
		ResponseEntity<String> entity = null;
		
		try {
			service.createList(vo);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/{listNumber}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> modifyList(@PathVariable("listNumber") int listNumber, @RequestBody ListVO vo) {
		logger.info("modifyList()");
		ResponseEntity<String> entity = null;
		
		vo.setListNumber(listNumber);
		try {
			service.updateList(vo);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/{listNumber}", method = RequestMethod.DELETE)
	public ResponseEntity<String> removeList(@PathVariable("listNumber") int listNumber) {
		logger.info("removeList()");
		ResponseEntity<String> entity = null;
		
		try {
			service.deleteList(listNumber);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/{regDate}", method = RequestMethod.GET)
	public ResponseEntity<List<ListVO>> listSelect(@PathVariable("regDate") String regDate) {
		logger.info("listSelect()");
		ResponseEntity<List<ListVO>> entity = null;
		
		try {
			List<ListVO> list = service.listSelect(regDate);
			entity = new ResponseEntity<>(list, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/read/{listNumber}", method = RequestMethod.GET)
	public ResponseEntity<ListVO> listSelectOne(@PathVariable("listNumber") int listNumber) {
		logger.info("listSelectOne()");
		ResponseEntity<ListVO> entity = null;
		
		try {
			ListVO vo = service.listSelectOne(listNumber);
			entity = new ResponseEntity<>(vo, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			
		}
		
		return entity;
	}
	
}
