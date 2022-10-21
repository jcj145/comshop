package com.home.webshop.controller;

import java.io.File;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.home.webshop.service.AdminService;
import com.home.webshop.service.MemberService;
import com.home.webshop.service.ShopService;
import com.home.webshop.util.Criteria;
import com.home.webshop.util.FileUpload;
import com.home.webshop.vo.ItemVO;

import net.sf.json.JSONArray;

@Controller
public class AdminController {
	@Inject
	AdminService as;
	
	@Inject
	ShopService ss;
	
	@Inject
	MemberService ms;
	
	@Resource(name="uploadPath")
	private String uploadPath;

	
	
	// 사용자 목록 페이지
	@GetMapping("userlist")
	public String test(Model model, Criteria cri) {
		model.addAttribute("userlist", ms.memberCriteria(cri));
		model.addAttribute("pm", ms.getPageMaker(cri));
		return "admin/userlist";
	}
	
	// 상품 등록 페이지
	@GetMapping("product")
	public String product(Model model) {
		model.addAttribute("categorylist", JSONArray.fromObject(as.categorylist()));	
		return "admin/product";
	}
	
	// 상품 등록
	@PostMapping("register")
	public String register(ItemVO vo, HttpServletRequest req, MultipartFile file) throws Exception {
		
		String imgUploadPath = uploadPath + File.separator + "img";
		String ymdPath = FileUpload.calcPath(imgUploadPath);
		String fileName = null;

		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
		 fileName =  FileUpload.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
		} else {
		 fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		vo.setImage(File.separator + "img" + ymdPath + File.separator + fileName);
		vo.setThumbimg(File.separator + "img" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		
		req.setAttribute("msg", as.register(vo));
		return "admin/product";
	}
	
	// 상품 목록 페이지
	@GetMapping("goodslist")
	public String goodslist(Model model, Criteria cri) {
		model.addAttribute("goodslist", ss.itemCriteria(cri));
		model.addAttribute("pm", ss.getPageMaker(cri));
		return "admin/goodslist";
	};
	
	//상품 이미지 업로드
	@PostMapping("upload")
	public void uploadImage(MultipartFile[] uploadFile) {
		String Folder = "C:\\upload";
	}
	
	// 상품 상세정보
	@GetMapping("itemdetail")
	public String itemdetail(int num, Model model) {
		model.addAttribute("item", as.itemdetail(num));
		return "admin/itemdetail";
	}
	
	// 상품 수정 페이지 이동
	@GetMapping("update")
	public String update(int num, Model model) {
		model.addAttribute("item", as.itemdetail(num));
		return "admin/update";
	}
	
	// 상품 수정
	@PostMapping("update")
	public String updateitem(ItemVO vo, HttpServletRequest req, MultipartFile file) throws Exception {
		String imgUploadPath = uploadPath + File.separator + "img";
		String ymdPath = FileUpload.calcPath(imgUploadPath);
		String fileName = null;

		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
		 fileName =  FileUpload.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
		} else {
		 fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		vo.setImage(File.separator + "img" + ymdPath + File.separator + fileName);
		vo.setThumbimg(File.separator + "img" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		
		req.setAttribute("msg", as.updateitem(vo));
		return "admin/product";
	}
	
	// 상품 삭제
	@PostMapping("deleteitem")
	public String deleteitem(int num, Model model) {
		model.addAttribute("msg", as.deleteitem(num));
		model.addAttribute("url", "goodslist");
		return "redirect";
	}
	
	// 회원 탈퇴
	@ResponseBody
	@PostMapping("deleteUser")
	public HashMap<String, String> deleteUser(String id, Model model) {
		HashMap<String, String> msg = new HashMap<String, String>();
		String message = as.deleteuser(id);
		msg.put("msg", message);
		return msg;
	}
	

}
