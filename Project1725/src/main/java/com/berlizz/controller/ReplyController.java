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

import com.berlizz.domain.ReplyVO;
import com.berlizz.service.ReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {

	@Inject
	private ReplyService service;
	
	private Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> addReply(@RequestBody ReplyVO vo) {
		logger.info("addReply()");
		
		ResponseEntity<String> entity = null;
		try {
			service.addReply(vo);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/{replyNumber}", method = RequestMethod.PUT)
	public ResponseEntity<String> updateReply(@PathVariable("replyNumber") Integer replyNumber, @RequestBody ReplyVO vo) {
		logger.info("updateReply()");
		
		ResponseEntity<String> entity = null;
		try {
			service.updateReply(vo);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/{listNumber}", method = RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> selectReply(@PathVariable("listNumber") Integer listNumber) {
		logger.info("selectReply()");
		
		ResponseEntity<List<ReplyVO>> entity = null;
		try {
			List<ReplyVO> list = service.selectReply(listNumber);
			entity = new ResponseEntity<>(list, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
