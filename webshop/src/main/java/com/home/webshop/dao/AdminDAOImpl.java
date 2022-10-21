package com.home.webshop.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.home.webshop.vo.CategoryVO;
import com.home.webshop.vo.ItemVO;
import com.home.webshop.vo.MemberVO;

@Repository
public class AdminDAOImpl implements AdminDAO {
	
	@Inject
	SqlSession sql;
	
	public String namespace = "com.home.webshop.dao.AdminDAO";

	@Override
	public List<MemberVO> userList() {
		List<MemberVO> list = sql.selectList(namespace+".userList");
		System.out.println(list);
		return list;
	}

	@Override
	public List<CategoryVO> categoryList() {
		List<CategoryVO> list = sql.selectList(namespace+".categoryList");
		return list;
	}

	@Override
	public int register(ItemVO vo) {
		return sql.selectOne(namespace+".register");
	}

	@Override
	public List<ItemVO> goodsList() {
		List<ItemVO> list = sql.selectList(namespace+".goodsList");
		return list;
	}

	@Override
	public List<ItemVO> catelist(int cateCode) {
		List<ItemVO> list = sql.selectList(namespace+".catelist", cateCode);
		return list;
	}

	@Override
	public ItemVO itemdetail(int num) {
		return sql.selectOne(namespace+".itemdetail");
	}

	@Override
	public int updateitem(ItemVO vo) {
		return sql.update(namespace+".updateitem");
		
	}

	@Override
	public int deleteitem(int num) {
		return sql.delete(namespace+".deleteitem");
	}

	@Override
	public int deleteuser(String id) {
		return sql.delete(namespace+".deleteuser");
	}

}
