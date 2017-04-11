package com.berlizz.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.berlizz.domain.ListVO;
import com.berlizz.domain.UserVO;
import com.berlizz.persistence.ArchiveDAO;

@Service
public class ArchiveServiceImpl implements ArchiveService {

	@Inject
	private ArchiveDAO dao;
	
	@Override
	public List<ListVO> selectList() throws Exception {
		return dao.selectList();
	}
	
	@Override
	public List<ListVO> selectListPage(Integer page, Integer perPageNum, String keyword, UserVO vo) throws Exception {
		page = (page - 1) * perPageNum;
		
		return dao.selectListPage(page, perPageNum, keyword, vo);
	}
	
	@Override
	public int listTotalNumber(String keyword, UserVO vo) throws Exception {
		return dao.listTotalNumber(keyword, vo);
	}

}
