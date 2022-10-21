package com.home.webshop.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.home.webshop.dao.MemberDAO;
import com.home.webshop.util.Criteria;
import com.home.webshop.util.PageMaker;
import com.home.webshop.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject MemberDAO dao;
	
	// 아이디 중복 체크
	@Override
	public int idCheck(String id) {
		int result = dao.idCheck(id);
		if(result == 0) {
			return 0;
		} else {
			return 1;
		}
	}
	
	// 회원가입
	@Override
	public String join(MemberVO vo) {
		int result = dao.join(vo);
		String message = (result != 0) ? "회원가입 성공" : "회원가입 실패";
		return message;
	}

	// 로그인
	@Override
	public MemberVO login(String id) {		
		return dao.login(id);
	}

	@Override
	public PageMaker getPageMaker(Criteria cri) {
		int memberCount = dao.memberCount();
		PageMaker pm = new PageMaker(memberCount, cri);
		return pm;
	}

	@Override
	public List<MemberVO> memberCriteria(Criteria cri) {
		return dao.memberCriteria(cri);
	}

	@Override
	public void deletecart(List<Integer> cartnum) {
		dao.deletecart(cartnum);
	}


}
