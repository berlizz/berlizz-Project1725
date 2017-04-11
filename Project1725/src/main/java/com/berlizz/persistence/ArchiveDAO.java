package com.berlizz.persistence;

import java.util.List;

import com.berlizz.domain.ListVO;
import com.berlizz.domain.UserVO;

public interface ArchiveDAO {
	
	public List<ListVO> selectList() throws Exception;
	
	public List<ListVO> selectListPage(Integer page, Integer perPageNum, String keyword, UserVO vo) throws Exception;
	
	public int listTotalNumber(String keyword, UserVO vo) throws Exception;
	
}
