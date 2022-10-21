package com.home.webshop.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.home.webshop.service.AdminService;
import com.home.webshop.service.ShopService;
import com.home.webshop.vo.CartListVO;



@Controller
public class ShopController {
	
	@Inject
	AdminService as;
	@Inject
	ShopService ss;
	
	@GetMapping("/")
	public String home(Model model) {
		model.addAttribute("itemlist", as.catelist(100));
		return "mainparts/cpu";
	}
	
	// 홈 페이지 이동
	@GetMapping("main")
	public String main(Model model) {
		model.addAttribute("itemlist", as.catelist(100));
		return "mainparts/cpu";
	}
	
	// 회원가입 페이지 이동
	@GetMapping("join")
	public String join() {
		return "login/join";
	}
	
	// 로그인 페이지 이동
	@GetMapping("login")
	public String login() {
		return "login/login";
	}
	
	// 구매 페이지 이동
	@GetMapping("purchase")
	public String purchase(int num, Model model) {
		model.addAttribute("item", as.itemdetail(num));
		return "detail/purchase";
	}
	
	// 장바구니 담기
	@ResponseBody
	@PostMapping("cart")
	public HashMap<String, String> cart(CartListVO vo, HttpServletRequest req){
		HttpSession session = req.getSession();
		HashMap<String, String> msg = new HashMap<String, String>();
		String message = ss.addcart(vo);
		session.setAttribute("cart", ss.countCart(vo.getId()));
		msg.put("msg", message); 
		return msg;
	}
	
	// 장바구니 페이지 이동
	@GetMapping("cartlist")
	public String cartlist(Model model, String id) {
		model.addAttribute("cartlist", ss.cartlist(id));
		return "cartlist";
	}
	
	
	
//--------- 주요 부품 페이지 -----------	
	
	// 메인보드 페이지 이동
	@GetMapping("mainboard")
	public String mainboard(Model model) {
		model.addAttribute("itemlist", as.catelist(300));
		return "mainparts/mainboard";
	}
	
	// RAM 페이지 이동
	@GetMapping("ram")
	public String ram(Model model) {
		model.addAttribute("itemlist", as.catelist(400));
		return "mainparts/ram";
	}
	
	// 파워 페이지 이동
	@GetMapping("power")
	public String power(Model model) {
		model.addAttribute("itemlist", as.catelist(600));
		return "mainparts/power";
	}
	
	// SSD 페이지 이동
	@GetMapping("ssd")
	public String ssd(Model model) {
		model.addAttribute("itemlist", as.catelist(500));
		return "mainparts/ssd";
	}
	
	// 그래픽카드 페이지 이동
	@GetMapping("vga")
	public String vga(Model model) {
		model.addAttribute("itemlist", as.catelist(200));
		return "mainparts/vga";
	}
	
// ----------- 주변 기기 페이지 -------------
	
	// 모니터 페이지 이동
	@GetMapping("monitor")
	public String monitor() {
		return "peripherals/monitor";
	}
	
	// 케이스 페이지 이동
	@GetMapping("case")
	public String cases() {
		return "peripherals/case";
	}
	
	// 키보드 페이지 이동
	@GetMapping("keyboard")
	public String keyboard() {
		return "peripherals/keyboard";
	}
	
	// 마우스 페이지 이동
	@GetMapping("mouse")
	public String mouse() {
		return "peripherals/mouse";
	}
	
	// 헤드셋 페이지 이동
	@GetMapping("headset")
	public String headset() {
		return "peripherals/headset";
	}
	
	// 스피커 페이지 이동
	@GetMapping("speaker")
	public String speaker() {
		return "peripherals/speaker";
	}
	
}
