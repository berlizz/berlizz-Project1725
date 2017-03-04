package com.berlizz.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.berlizz.domain.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
	
	@Inject
	private SqlSession session;
	
	private String namespace = "com.berlizz.mapper.replyMapper";
	
	
	@Override
	public void addReply(ReplyVO vo) throws Exception {
		session.insert(namespace + ".addReply", vo);
	}

	@Override
	public void updateReply(ReplyVO vo) throws Exception {
		session.update(namespace + ".updateReply", vo);
	}

	@Override
	public List<ReplyVO> selectReply(Integer listNumber) throws Exception {
		return session.selectList(namespace + ".selectReply", listNumber);
	}

	@Override
	public void deleteReply(Integer replyNumber) throws Exception {
		session.delete(namespace + ".deleteReply", replyNumber);
	}

}
