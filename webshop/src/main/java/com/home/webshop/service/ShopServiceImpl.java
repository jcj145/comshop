package com.home.webshop.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.home.webshop.dao.ShopDAO;
import com.home.webshop.util.Criteria;
import com.home.webshop.util.PageMaker;
import com.home.webshop.vo.CartListVO;
import com.home.webshop.vo.ItemVO;

@Service
public class ShopServiceImpl implements ShopService {
	
	@Inject
	ShopDAO dao;

	@Override
	public List<ItemVO> itemlist() {	
		return dao.itemlist();
	}

	@Override
	public PageMaker getPageMaker(Criteria cri) {
		int itemCount = dao.itemCount();
		PageMaker pm = new PageMaker(itemCount, cri);
		return pm;
	}

	@Override
	public List<ItemVO> itemCriteria(Criteria cri) {
		return dao.itemCriteria(cri);
	}

	@Override
	public String addcart(CartListVO vo) {
		int result = dao.addcart(vo);
		String msg = (result != 0) ? "장바구니에 추가 되었습니다." : "에러";
		return msg;
	}

	@Override
	public int countCart(String id) {
		return dao.countCart(id);
	}

	@Override
	public List<CartListVO> cartlist(String id) {
		return dao.cartlist(id);
	}

}
