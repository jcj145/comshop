package com.home.webshop.service;

import java.util.List;

import com.home.webshop.util.Criteria;
import com.home.webshop.util.PageMaker;
import com.home.webshop.vo.CartListVO;
import com.home.webshop.vo.ItemVO;

public interface ShopService {
	
	// 전체 상품 목록
	public List<ItemVO> itemlist();
	
	// 페이징
	PageMaker getPageMaker(Criteria cri);
	
	// 페이징 상품 목록
	List<ItemVO> itemCriteria(Criteria cri);
	
	// 장바구니 담기
	public String addcart(CartListVO vo);
	
	// 장바구니 상품 개수
	public int countCart(String id);
	
	// 장바구니 목록
	public List<CartListVO> cartlist(String id);

}
