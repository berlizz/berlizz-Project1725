package com.berlizz.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.berlizz.domain.ListVO;

@Repository
public class ArchiveDAOImpl implements ArchiveDAO {

	@Inject
	private SqlSession session;
	
	private String namespace = "com.berlizz.mapper.ArchiveMapper";
	
	@Override
	public List<ListVO> selectList() throws Exception {
		return session.selectList(namespace + ".selectList");
	}
	
	@Override
	public List<ListVO> selectListPage(Integer page, Integer perPageNum, String keyword) throws Exception {
		Map<String, Integer> pageMap = new HashMap<>();
		pageMap.put("page", page);
		pageMap.put("perPageNum", perPageNum);
		
		Map<String, Map> map = new HashMap<>();
		map.put("pageMap", pageMap);
		if(keyword != null) {
			Map<String, String> keywordMap = new HashMap<>();
			keywordMap.put("keyword", keyword);
			map.put("keywordMap", keywordMap);
		} else {
			map.put("keywordMap", null);
		}
		
		return session.selectList(namespace + ".selectListPage", map);
	}
	
	@Override
	public int listTotalNumber() throws Exception {
		return session.selectOne(namespace + ".listTotalNumber");
	}
	
	@Override
	public List<ListVO> searchList(String keyword) throws Exception {
		return session.selectList(namespace + ".searchList", keyword);
	}

}
