package com.berlizz.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.berlizz.domain.ListVO;
import com.berlizz.persistence.ArchiveDAO;

@Service
public class ArchiveServiceImpl implements ArchiveService {

	@Inject
	private ArchiveDAO dao;
	
	@Override
	public List<ListVO> selectList() throws Exception {
		return dao.selectList();
	}

}
