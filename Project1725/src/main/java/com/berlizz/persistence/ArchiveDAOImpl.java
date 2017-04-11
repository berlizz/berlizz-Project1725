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
public class ArchiveDAOImpl implements ArchiveDAO {

	@Inject
	private SqlSession session;
	
	private String namespace = "com.berlizz.mapper.ArchiveMapper";
	
	@Override
	public List<ListVO> selectList() throws Exception {
		return session.selectList(namespace + ".selectList");
	}
	
	@Override
	public List<ListVO> selectListPage(Integer page, Integer perPageNum, String keyword, UserVO vo) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("page", page);
		map.put("perPageNum", perPageNum);
		map.put("keyword", keyword);
		map.put("vo", vo);
		
		return session.selectList(namespace + ".selectListPage", map);
	}
	
	@Override
	public int listTotalNumber(String keyword, UserVO vo) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("vo", vo);
		
		return session.selectOne(namespace + ".listTotalNumber", map);
	}

}
