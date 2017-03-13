package com.berlizz.persistence;

import java.util.List;

import com.berlizz.domain.ListVO;

public interface ArchiveDAO {
	
	public List<ListVO> selectList() throws Exception;
}
