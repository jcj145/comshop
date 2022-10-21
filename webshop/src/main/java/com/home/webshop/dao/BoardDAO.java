package com.home.webshop.dao;

import java.util.List;

import com.home.webshop.util.Criteria;
import com.home.webshop.vo.BoardVO;
import com.home.webshop.vo.ReplyVO;

public interface BoardDAO {
	
	public int write(BoardVO vo);

	public int boardCount();
	
	List<BoardVO> boardCriteria(Criteria cri);
	
	public BoardVO detail(int bno);
	
	List<ReplyVO> replylist(int bno);
	
	public int createReply(ReplyVO vo);
	
	public int deleteBoard(int bno);
	
	public int updateBoard(BoardVO vo);
	
	public int deleteReply(int rno);
}
