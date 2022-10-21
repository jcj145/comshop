package com.home.webshop.service;

import java.util.List;

import com.home.webshop.util.Criteria;
import com.home.webshop.util.PageMaker;
import com.home.webshop.vo.BoardVO;
import com.home.webshop.vo.ReplyVO;

public interface BoardService {

	//게시글 작성
	public String write(BoardVO vo);
	
	// 페이징
	PageMaker getPageMaker(Criteria cri);
	
	// 페이징 게시글 목록
	List<BoardVO> boardCriteria(Criteria cri);
	
	// 문의글 상세보기
	public BoardVO detail(int bno);
	
	// 문의글 삭제하기
	public String deleteBoard(int bno);
	
	// 문의글 수정하기
	public String updateBoard(BoardVO vo);
	
	// 댓글 목록
	List<ReplyVO> replylist(int bno);
	
	// 댓글 작성
	public String createReply(ReplyVO vo);
	
	// 댓글 삭제
	public String deleteReply(int rno);
}
