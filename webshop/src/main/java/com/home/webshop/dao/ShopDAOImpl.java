package com.home.webshop.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;

import com.home.webshop.util.Criteria;
import com.home.webshop.vo.CartListVO;
import com.home.webshop.vo.ItemVO;

public class ShopDAOImpl implements ShopDAO {
	@Inject
	SqlSession sql;
	
	public String namespace = "com.home.webshop.dao.ShopDAO";
	
	@Override
	public List<ItemVO> itemlist() {
		List<ItemVO> list = sql.selectList(namespace+".itemList");
		return list;
	}

	@Override
	public int itemCount() {
		return sql.selectOne(namespace+".itemCount");
	}

	@Override
	public List<ItemVO> itemCriteria(Criteria cri) {
		List<ItemVO> list = sql.selectList(namespace+".itemCriteria");
		return list;
	}

	@Override
	public int addcart(CartListVO vo) {
		return sql.insert(namespace+".addcart");
	}

	@Override
	public int countCart(String id) {
		return sql.selectOne(namespace+".countCart");
	}

	@Override
	public List<CartListVO> cartlist(String id) {
		List<CartListVO> list = sql.selectList(namespace+".cartlist");
		return list;
	}

}
