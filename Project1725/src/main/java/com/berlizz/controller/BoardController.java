package com.berlizz.controller;

import java.time.LocalDate;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.berlizz.domain.ListVO;
import com.berlizz.service.ListService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Inject
	private ListService service;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void board(@RequestParam("year") int year, @RequestParam("month") int month, @RequestParam("date") int date, Model model) throws Exception {
		logger.info("board()");
		
		String regDate = LocalDate.of(year, month, date).toString();
		
		List<ListVO> listVO = service.listSelect(regDate);
		model.addAttribute("listVO", listVO);
		
	}
}
