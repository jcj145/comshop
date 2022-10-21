package com.home.webshop.dao;


import java.util.List;

import com.home.webshop.util.Criteria;
import com.home.webshop.vo.MemberVO;

public interface MemberDAO {
	
	// 아이디 중복검사
	int idCheck(String id);
	
	// 회원가입
	int join(MemberVO vo);
	
	// 로그인
	MemberVO login(String id);
	
	int memberCount();
	
	List<MemberVO> memberlist();
	
	List<MemberVO> memberCriteria(Criteria cri);
	
	int deletecart(List<Integer> cartnum);
	
}
