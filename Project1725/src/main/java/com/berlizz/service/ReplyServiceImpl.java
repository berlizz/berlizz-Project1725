package com.berlizz.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.berlizz.domain.ReplyVO;
import com.berlizz.persistence.ReplyDAO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO dao;
	
	@Override
	public void addReply(ReplyVO vo) throws Exception {
		dao.addReply(vo);
	}

	@Override
	public void updateReply(ReplyVO vo) throws Exception {
		dao.updateReply(vo);
	}

	@Override
	public List<ReplyVO> selectReply(Integer listNumber) throws Exception {
		return dao.selectReply(listNumber);
	}

	@Override
	public void deleteReply(Integer replyNumber) throws Exception {
		dao.deleteReply(replyNumber);
	}

}
