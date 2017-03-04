package com.berlizz.service;

import java.util.List;

import com.berlizz.domain.ReplyVO;

public interface ReplyService {

	public void addReply(ReplyVO vo) throws Exception;
	
	public void updateReply(ReplyVO vo) throws Exception;
	
	public List<ReplyVO> selectReply(Integer listNumber) throws Exception;
	
	public void deleteReply(Integer replyNumber) throws Exception;
	
}
