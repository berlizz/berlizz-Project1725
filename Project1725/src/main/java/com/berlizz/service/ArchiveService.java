package com.berlizz.service;

import java.util.List;

import com.berlizz.domain.ListVO;

public interface ArchiveService {

	public List<ListVO> selectList() throws Exception;
}
