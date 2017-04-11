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
public class ListDAOImpl implements ListDAO {

	@Inject 
	private SqlSession session;
	
	private static final String namespace = "com.berlizz.mapper.ListMapper";
	
	@Override
	public List<ListVO> listAll() throws Exception {
		return session.selectList(namespace + ".listAll");
	}
	
	@Override
	public List<ListVO> listSelect(String regDate, UserVO vo) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("regDate", regDate);
		map.put("vo", vo);
		
		return session.selectList(namespace + ".listSelect", map);
	}
	
	@Override
	public ListVO listSelectOne(Integer listNumber) throws Exception {
		return session.selectOne(namespace + ".listSelectOne", listNumber);
	}
	
	@Override
	public List<ListVO> uncompletedSelect(UserVO vo) throws Exception {
		return session.selectList(namespace + ".uncompletedSelect", vo);
	}
	
	@Override
	public List<ListVO> completedSelect(UserVO vo) throws Exception {
		return session.selectList(namespace + ".completedSelect", vo);
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
	
	@Override
	public List<String> getAttach(Integer listNumber) throws Exception {
		return session.selectList(namespace + ".getAttach", listNumber);
	}
	
	@Override
	public void deleteAttach(String fullName) throws Exception {
		session.delete(namespace + ".deleteAttach", fullName);
	}
	
	@Override
	public void updateAttachCount(Integer variation, Integer listNumber) throws Exception {
		Map<String, Integer> map = new HashMap<>();
		map.put("variation", variation);
		map.put("listNumber", listNumber);
		
		session.update(namespace + ".updateAttachCount", map);
	}
	
	@Override
	public void updateReplyCount(Integer variation, Integer listNumber) throws Exception {
		Map<String, Integer> map = new HashMap<>();
		map.put("variation", variation);
		map.put("listNumber", listNumber);
		
		session.update(namespace + ".updateReplyCount", map);
	}
}
