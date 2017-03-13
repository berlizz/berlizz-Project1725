package com.berlizz.persistence;

import java.util.List;

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

}
