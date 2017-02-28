package com.berlizz.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.berlizz.domain.ListVO;

@Repository
public class ListDAOImpl implements ListDAO {

	@Inject 
	private SqlSession session;
	
	private static final String namespace = "com.berlizz.mapper.ListMapper";
	
	@Override
	public List<ListVO> listAll() throws Exception {
		return session.selectList(namespace + ".listAll");
	}
	
	@Override
	public List<ListVO> listSelect(String regDate) throws Exception {
		return session.selectList(namespace + ".listSelect", regDate);
	}
	
	@Override
	public ListVO listSelectOne(Integer listNumber) throws Exception {
		return session.selectOne(namespace + ".listSelectOne", listNumber);
	}
	
	@Override
	public List<ListVO> uncompletedSelect() throws Exception {
		return session.selectList(namespace + ".uncompletedSelect");
	}
	
	@Override
	public List<ListVO> completedSelect() throws Exception {
		return session.selectList(namespace + ".completedSelect");
	}
	
	@Override
	public void createList(ListVO vo) throws Exception {
		session.insert(namespace + ".createList", vo);
	}
	
	@Override
	public void updateList(ListVO vo) throws Exception {
		session.update(namespace + ".updateList", vo);
	}
	
	@Override
	public void completionUpdate(Integer listNumber) throws Exception {
		session.update(namespace + ".completionUpdate", listNumber);
	}
	
	@Override
	public void deleteList(Integer listNumber) throws Exception {
		session.delete(namespace + ".deleteList", listNumber);
	}
	
	@Override
	public void addAttach(String fullName, Integer listNumber) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("fullName", fullName);
		map.put("listNumber", String.valueOf(listNumber));
		
		session.insert(namespace + ".addAttach", map);
	}
}
