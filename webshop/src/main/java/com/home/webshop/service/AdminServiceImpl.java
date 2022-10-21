package com.home.webshop.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.home.webshop.dao.AdminDAO;
import com.home.webshop.vo.CategoryVO;
import com.home.webshop.vo.ItemVO;
import com.home.webshop.vo.MemberVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Inject
	AdminDAO dao;
	
	// 사용자 목록
	@Override
	public List<MemberVO> userlist() {
		return dao.userList();
	}

	// 카테고리 목록
	@Override
	public List<CategoryVO> categorylist() {
		return dao.categoryList();
	}

	// 상품 등록
	@Override
	public String register(ItemVO vo) {
		int result = dao.register(vo);
		String msg = (result != 0) ? "등록 완료" : "등록 실패";
		return msg;
	}

	// 상품 목록
	@Override
	public List<ItemVO> goodslist() {
		return dao.goodsList();
	}

	// CPU 상품 목록
	@Override
	public List<ItemVO> catelist(int cateCode) {
		return dao.catelist(cateCode);
	}

	@Override
	public ItemVO itemdetail(int num) {
		return dao.itemdetail(num);
	}

	@Override
	public String updateitem(ItemVO vo) {
		int result = dao.updateitem(vo);
		String msg = (result != 0) ? "수정 완료" : "수정 실패";
		return msg;
	}

	@Override
	public String deleteitem(int num) {
		int result = dao.deleteitem(num);
		String msg = (result != 0) ? "삭제 완료" : "삭제 실패";
		return msg;
	}

	@Override
	public String deleteuser(String id) {
		int result = dao.deleteuser(id);
		String msg = (result != 0) ? "탈퇴 완료" : "탈퇴 실패";
		return msg;
	}

}
