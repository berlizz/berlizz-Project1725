package com.berlizz.service;

import java.util.List;

import com.berlizz.domain.ListVO;
import com.berlizz.domain.UserVO;

public interface CalendarService {

	public List<ListVO> selectMonthlyList(Integer year, Integer month, UserVO vo) throws Exception;
}
