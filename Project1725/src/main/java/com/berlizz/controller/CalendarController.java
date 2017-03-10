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
import org.springframework.web.bind.annotation.RestController;

import com.berlizz.domain.ListVO;
import com.berlizz.service.CalendarService;

@RestController
@RequestMapping("/calendar")
public class CalendarController {

	@Inject
	private CalendarService service;
	
	private static final Logger logger = LoggerFactory.getLogger(CalendarController.class);
	
	
	@RequestMapping(value = "/{year}/{month}", method = RequestMethod.GET)
	public ResponseEntity<List<ListVO>> selectMonthlyList(@PathVariable("year") Integer year, @PathVariable("month") Integer month) {
		logger.info("selectMonthlyList()");
		ResponseEntity<List<ListVO>> entity = null;
		
		try {
			List<ListVO> list = service.selectMonthlyList(year, month);
			entity = new ResponseEntity<>(list, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
