package com.berlizz.service;

import java.time.LocalDate;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.berlizz.domain.ListVO;
import com.berlizz.persistence.CalendarDAO;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Inject
	private CalendarDAO dao;
	
	@Override
	public List<ListVO> selectMonthlyList(Integer year, Integer month) throws Exception {
		
		LocalDate date = LocalDate.of(year, month, 1);
		String firstDate = date.toString();
		
		date = LocalDate.of(year, month + 1, 1);
		String lastDate = date.toString();
		
		return dao.selectMonthlyList(firstDate, lastDate);
	}

}
