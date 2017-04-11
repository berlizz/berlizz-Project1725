package com.berlizz.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.berlizz.domain.ListVO;
import com.berlizz.domain.UserVO;

@Repository
public class CalendarDAOImpl implements CalendarDAO {

	@Inject
	private SqlSession session;
	
	private static final String namespace = "com.berlizz.mapper.CalendarMapper";
	
	@Override
	public List<ListVO> selectMonthlyList(String firstDate, String lastDate, UserVO vo) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		map.put("firstDate", firstDate);
		map.put("lastDate", lastDate);
		map.put("vo", vo);
		
		return session.selectList(namespace + ".monthlyList", map);
	}

}
