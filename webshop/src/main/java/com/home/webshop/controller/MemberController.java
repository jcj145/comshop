package com.home.webshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.home.webshop.service.AdminService;
import com.home.webshop.service.MailService;
import com.home.webshop.service.MemberService;
import com.home.webshop.service.ShopService;
import com.home.webshop.vo.MemberVO;


@Controller
public class MemberController {
	
	@Inject ShopService ss;
	@Inject MemberService member;
	@Inject MailService ms;
	@Inject AdminService as;
	@Autowired BCryptPasswordEncoder passEncoder;

	// 이메일 인증
	@ResponseBody
	@PostMapping("sendMail")
	public String sendMail(HttpSession session, String email) throws Exception {
			int random = new Random().nextInt(10000) + 10000;
			String code = String.valueOf(random);	
			String subject="컴샵 회원가입 인증 코드 발급 안내 입니다.";
			StringBuilder sb = new StringBuilder();
			sb.append("회원가입 인증 코드는 " + code + " 입니다.");
			return ms.send(subject, sb.toString(), "JCJ", email, code);		
	}
	
	// 아이디 중복검사
	@ResponseBody
	@PostMapping("idcheck")
	public int idcheck(String id) {
		return member.idCheck(id);
	}
	
	// 회원가입 처리
	@ResponseBody
	@PostMapping("join")
	public HashMap<String,String> join(MemberVO vo) { 	
		HashMap<String,String> msg = new HashMap<String,String>();
		String pw = passEncoder.encode(vo.getPw());
		vo.setPw(pw);
		String message = member.join(vo);
		msg.put("msg", message);
		return msg;
	}
	
	// 로그인 처리
	@ResponseBody
	@PostMapping("login") 
	public int login(String id, String pw, HttpServletRequest req) {
		int result;
		MemberVO login = member.login(id);
		HttpSession session = req.getSession();
		boolean pwMatch = passEncoder.matches(pw, login.getPw());
		if(login != null && pwMatch) {
			session.setAttribute("member", login);
			session.setAttribute("cart", ss.countCart(id));
			result = 1;
		} else {
			session.setAttribute("member", null);
			session.setAttribute("cart", 0);
			result = 0;
		}
		return result; 
	 }
	
	// 로그아웃
	@GetMapping("logout")
	public String logout(HttpSession session, Model model) {
		if(session.getAttribute("member") != null) {
			session.removeAttribute("member");
		}
		model.addAttribute("itemlist", as.catelist(100));
		return "mainparts/cpu";
	}
	
	// 장바구니 삭제
	@ResponseBody
	@PostMapping("deletecart")
	public void deleteCart(@RequestParam(value="cartnum[]") List<Integer> chbox) {	
		member.deletecart(chbox);
	}
		
}
