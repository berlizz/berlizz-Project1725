package com.berlizz.service;

import java.util.List;

import com.berlizz.domain.ListVO;

public interface CalendarService {

	public List<ListVO> selectMonthlyList(Integer year, Integer month) throws Exception;
}
