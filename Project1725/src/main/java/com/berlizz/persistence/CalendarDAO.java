package com.berlizz.persistence;

import java.util.List;

import com.berlizz.domain.ListVO;

public interface CalendarDAO {

	public List<ListVO> selectMonthlyList(String firstDate, String lastDate) throws Exception;
}
