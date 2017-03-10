package com.berlizz.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.berlizz.domain.ListVO;

@Repository
public class CalendarDAOImpl implements CalendarDAO {

	@Inject
	private SqlSession session;
	
	private static final String namespace = "com.berlizz.mapper.CalendarMapper";
	
	@Override
	public List<ListVO> selectMonthlyList(String firstDate, String lastDate) throws Exception {
		Map<String, String> map = new HashMap<>();
		
		map.put("firstDate", firstDate);
		map.put("lastDate", lastDate);
		
		return session.selectList(namespace + ".monthlyList", map);
	}

}
