package com.home.webshop.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.home.webshop.util.Criteria;
import com.home.webshop.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	public String namespace = "com.home.webshop.dao.MemberDAO";
	
	@Inject
	SqlSession sql;

	// 아이디 중복검사
	@Override
	public int idCheck(String id) {
		return sql.selectOne(namespace+".idCheck", id);
	}
	
	// 회원가입
	@Override
	public int join(MemberVO vo) {
		int result = sql.insert(namespace+".join",vo);
		return result;
	}

	// 로그인
	@Override
	public MemberVO login(String id) {
		return sql.selectOne(namespace+".login", id);
	}

	@Override
	public List<MemberVO> memberlist() {
		List<MemberVO> list = sql.selectList(namespace+".memberList");
		return list;
	}

	@Override
	public List<MemberVO> memberCriteria(Criteria cri) {
		List<MemberVO> list = sql.selectList(namespace+".memberCriteria");
		return list;
	}

	@Override
	public int memberCount() {
		return sql.selectOne(namespace+".memberCount");
	}

	@Override
	public int deletecart(List<Integer> cartnum) {
		return sql.delete(namespace+".deletecart");
	}

}
