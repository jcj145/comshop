package com.home.webshop.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.home.webshop.util.Criteria;
import com.home.webshop.vo.BoardVO;
import com.home.webshop.vo.ReplyVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Inject
	SqlSession sql;
	
	public String namespace = "com.home.webshop.dao.BoardDAO";

	@Override
	public int write(BoardVO vo) {
		int result = sql.insert(namespace+".write", vo);
		return result;
	}

	@Override
	public int boardCount() {
		return sql.selectOne(namespace+".boardCount");
	}

	@Override
	public List<BoardVO> boardCriteria(Criteria cri) {
		List<BoardVO> list = sql.selectList(namespace+".boardCriteria");
		return list;
	}

	@Override
	public BoardVO detail(int bno) {
		return sql.selectOne(namespace+".detail");
	}

	@Override
	public List<ReplyVO> replylist(int bno) {
		List<ReplyVO> list = sql.selectList(namespace+".replylist", bno);
		return list;
	}

	@Override
	public int createReply(ReplyVO vo) {
		return sql.insert(namespace+".createReply", vo);	
	}

	@Override
	public int deleteBoard(int bno) {
		return sql.delete(namespace+".deleteBoard", bno);
	}

	@Override
	public int updateBoard(BoardVO vo) {
		return sql.update(namespace+".updateBoard", vo);
	}

	@Override
	public int deleteReply(int rno) {
		return sql.delete(namespace+".deleteReply", rno);
	}

}
