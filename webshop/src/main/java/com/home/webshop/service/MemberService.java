package com.home.webshop.service;

import java.util.List;

import com.home.webshop.util.Criteria;
import com.home.webshop.util.PageMaker;
import com.home.webshop.vo.MemberVO;

public interface MemberService {
	
	// 아이디 중복검사
	public int idCheck(String id);
	
	// 회원등록
	public String join(MemberVO vo);
	
	// 로그인
	public MemberVO login(String id);
	
	// 페이징
	PageMaker getPageMaker(Criteria cri);
	
	// 페이징 유저 목록
	List<MemberVO> memberCriteria(Criteria cri);
	
	public void deletecart(List<Integer> cartnum);

}
