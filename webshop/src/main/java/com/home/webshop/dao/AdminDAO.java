package com.home.webshop.dao;

import java.util.List;

import com.home.webshop.vo.CategoryVO;
import com.home.webshop.vo.ItemVO;
import com.home.webshop.vo.MemberVO;

public interface AdminDAO {
	
	List<MemberVO> userList();
	
	List<CategoryVO> categoryList();
	
	List<ItemVO> goodsList();
	
	List<ItemVO> catelist(int cateCode);
	
	int register(ItemVO vo);
	
	ItemVO itemdetail(int num);
	
	int updateitem(ItemVO vo);
	
	int deleteitem(int num);
	
	int deleteuser(String id);

}
