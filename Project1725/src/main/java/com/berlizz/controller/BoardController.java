package com.berlizz.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void list(@RequestParam(value = "year", required = false) Integer year, @RequestParam(value = "month", required = false) Integer month, @RequestParam(value = "date", required = false) Integer date, Model model) throws Exception {
		logger.info("list()");
		
	}
	
	@RequestMapping(value = "/calendar", method = RequestMethod.GET)
	public void calendar() throws Exception {
		logger.info("calendar()");
		
	}
	
	@RequestMapping(value = "/archive", method = RequestMethod.GET)
	public void archive() throws Exception {
		logger.info("archive()");
		
	}
	
	
}
