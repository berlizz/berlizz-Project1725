package com.berlizz.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.berlizz.domain.ListVO;

@RestController
@RequestMapping("/calendar")
public class CalendarController {

	private static final Logger logger = LoggerFactory.getLogger(CalendarController.class);
	
	
	@RequestMapping(value = "/{year}/{month}", method = RequestMethod.GET)
	public ResponseEntity<List<ListVO>> listPerMonth(@PathVariable("year") Integer year, @PathVariable("month") Integer month) {
		logger.info("");
		ResponseEntity<List<ListVO>> entity = null;
		
		
		
		return entity;
	}
}
