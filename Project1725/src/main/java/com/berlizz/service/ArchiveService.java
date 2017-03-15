package com.berlizz.service;

import java.util.List;

import com.berlizz.domain.ListVO;

public interface ArchiveService {

	public List<ListVO> selectList() throws Exception;
	
	public List<ListVO> selectListPage(Integer page, Integer perPageNum) throws Exception;
	
	public int listTotalNumber() throws Exception;
	
	public List<ListVO> searchList(String keyword) throws Exception;
}
