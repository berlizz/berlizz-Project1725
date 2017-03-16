package com.berlizz.persistence;

import java.util.List;

import com.berlizz.domain.ListVO;

public interface ArchiveDAO {
	
	public List<ListVO> selectList() throws Exception;
	
	public List<ListVO> selectListPage(Integer page, Integer perPageNum, String keyword) throws Exception;
	
	public int listTotalNumber() throws Exception;
	
	public List<ListVO> searchList(String keyword) throws Exception;
}
