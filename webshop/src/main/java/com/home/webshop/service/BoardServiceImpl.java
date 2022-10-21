package com.home.webshop.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.home.webshop.dao.BoardDAO;
import com.home.webshop.util.Criteria;
import com.home.webshop.util.PageMaker;
import com.home.webshop.vo.BoardVO;
import com.home.webshop.vo.ReplyVO;

@Service
public class BoardServiceImpl implements BoardService {
	@Inject
	BoardDAO dao;

	@Override
	public String write(BoardVO vo) {
		int result = dao.write(vo);
		String message = (result != 0) ? "게시글 작성 성공" : "게시글 작성 실패";
		return message;
	}

	@Override
	public PageMaker getPageMaker(Criteria cri) {
		int boardCount = dao.boardCount();
		PageMaker pm = new PageMaker(boardCount, cri);
		return pm;
	}

	@Override
	public List<BoardVO> boardCriteria(Criteria cri) {
		return dao.boardCriteria(cri);
	}

	@Override
	public BoardVO detail(int bno) {
		return dao.detail(bno);
	}

	@Override
	public List<ReplyVO> replylist(int bno) {
		return dao.replylist(bno);
	}

	@Override
	public String createReply(ReplyVO vo) {	
		int result = dao.createReply(vo);
		String message = (result != 0) ? "댓글 작성 완료" : "댓글 작성 실패";
		return message;	
	}

	@Override
	public String deleteBoard(int bno) {
		int result = dao.deleteBoard(bno);
		String message = (result != 0) ? "문의글 삭제 완료" : "문의글 삭제 실패";
		return message;	
	}

	@Override
	public String updateBoard(BoardVO vo) {
		int result = dao.updateBoard(vo);
		String message = (result != 0) ? "문의글 수정 완료" : "문의글 수정 실패";
		return message;	
	}

	@Override
	public String deleteReply(int rno) {
		int result = dao.deleteReply(rno);
		String message = (result != 0) ? "댓글 삭제 완료" : "댓글 삭제 실패";
		return message;
	}

}
