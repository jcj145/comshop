package com.home.webshop.service;

import java.util.List;

import com.home.webshop.vo.CategoryVO;
import com.home.webshop.vo.ItemVO;
import com.home.webshop.vo.MemberVO;

public interface AdminService {
	
	// 유저 목록
	public List<MemberVO> userlist();
	
	//카테고리 목록
	public List<CategoryVO> categorylist();
	
	// 전체 상품 목록
	public List<ItemVO> goodslist();
	
	// 카테고리 상품 목록
	public List<ItemVO> catelist(int cateCode);
	
	// 상품 등록
	public String register(ItemVO vo);
	
	// 상품 상세정보
	public ItemVO itemdetail(int num);
	
	// 상품 수정
	public String updateitem(ItemVO vo);
	
	// 상품 삭제
	public String deleteitem(int num);
	
	// 회원 탈퇴
	public String deleteuser(String id);

}
