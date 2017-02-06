package com.berlizz.persistence;

import java.util.List;

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
	public void createList(ListVO vo) throws Exception {
		session.insert(namespace + ".createList", vo);
	}
	
	@Override
	public void updateList(ListVO vo) throws Exception {
		session.update(namespace + ".updateList", vo);
	}
	
	@Override
	public void deleteList(Integer listNumber) throws Exception {
		session.delete(namespace + ".deleteList", listNumber);
	}
}
