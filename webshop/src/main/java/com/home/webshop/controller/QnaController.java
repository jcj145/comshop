package com.home.webshop.controller;

import java.util.HashMap;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.home.webshop.service.BoardService;
import com.home.webshop.util.Criteria;
import com.home.webshop.vo.BoardVO;
import com.home.webshop.vo.ReplyVO;

@Controller
public class QnaController {
	@Inject
	BoardService bs;
	
	// 문의하기 페이지 이동
	@GetMapping("qna")
	public String qna(Criteria cri, Model model) {
		model.addAttribute("boardlist", bs.boardCriteria(cri));
		model.addAttribute("pm", bs.getPageMaker(cri));
		return "qna/qna";
	}
	
	// 문의글 작성페이지 이동
	@GetMapping("qnawrite")
	public String qnawrite() {
		return "qna/qnawrite";
	}
	
	// 문의글 수정페이지 이동
	@GetMapping("qnaupdate")
	public String qnaupdate(int bno, Model model) {
		model.addAttribute("update", bs.detail(bno));
		return "qna/qnaupdate";
	}
	
	// 상세보기 페이지 이동
	@GetMapping("detail")
	public String detail(int bno, Model model) {
		model.addAttribute("detail", bs.detail(bno));
		model.addAttribute("reply", bs.replylist(bno));
		return "qna/detail";
	}
	
	// 문의글 작성하기
	@PostMapping("create")
	public String createBoard(BoardVO vo, Model model) {
		model.addAttribute("msg", bs.write(vo));
		model.addAttribute("url", "qna");
		return "redirect";
	}
	
	// 문의글 삭제
	@ResponseBody
	@PostMapping("deleteBoard")
	public HashMap<String,String> deleteBoard(int bno) {
		HashMap<String,String> msg = new HashMap<String,String>();
		String message = bs.deleteBoard(bno);
		msg.put("msg", message);
		return msg;
	}
	
	@PostMapping("updateBoard")
	public String updateBoard(BoardVO vo, Model model) {
		model.addAttribute("msg", bs.updateBoard(vo));
		model.addAttribute("url", "qna");
		return "redirect";
	}
	
	// 댓글 작성
	@ResponseBody
	@PostMapping("createReply")
	public HashMap<String,String> createReply(ReplyVO vo) {
		HashMap<String,String> msg = new HashMap<String,String>();
		String message = bs.createReply(vo);
		msg.put("msg", message);
		return msg;
	}
	
	// 댓글 삭제
	@ResponseBody
	@PostMapping("deleteReply")
	public HashMap<String,String> deleteReply(int rno) {
		HashMap<String,String> msg = new HashMap<String,String>();
		String message = bs.deleteReply(rno);
		msg.put("msg", message);
		return msg;
	}
	


}
