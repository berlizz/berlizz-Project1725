package com.berlizz.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.berlizz.domain.ReplyVO;
import com.berlizz.persistence.ListDAO;
import com.berlizz.persistence.ReplyDAO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO replyDAO;
	
	@Inject
	private ListDAO listDAO;
	
	@Override
	@Transactional
	public void addReply(ReplyVO vo) throws Exception {
		replyDAO.addReply(vo);
		
		listDAO.updateReplyCount(1, vo.getListNumber());
	}

	@Override
	public void updateReply(ReplyVO vo) throws Exception {
		replyDAO.updateReply(vo);
	}

	@Override
	public List<ReplyVO> selectReply(Integer listNumber) throws Exception {
		return replyDAO.selectReply(listNumber);
	}

	@Override
	@Transactional
	public void deleteReply(Integer replyNumber, Integer listNumber) throws Exception {
		replyDAO.deleteReply(replyNumber);
		
		listDAO.updateReplyCount((-1), listNumber);
	}

}
