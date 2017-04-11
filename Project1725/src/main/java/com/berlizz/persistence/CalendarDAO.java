package com.berlizz.persistence;

import java.util.List;

import com.berlizz.domain.ListVO;
import com.berlizz.domain.UserVO;

public interface CalendarDAO {

	public List<ListVO> selectMonthlyList(String firstDate, String lastDate, UserVO vo) throws Exception;
}
