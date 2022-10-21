package com.home.webshop.dao;

import java.util.List;

import com.home.webshop.util.Criteria;
import com.home.webshop.vo.CartListVO;
import com.home.webshop.vo.ItemVO;

public interface ShopDAO {
	
	List<ItemVO> itemlist();
	
	List<ItemVO> itemCriteria(Criteria cri);
	
	int itemCount();
	
	int addcart(CartListVO vo);
	
	int countCart(String id);
	
	List<CartListVO> cartlist(String id);
	
	

}
