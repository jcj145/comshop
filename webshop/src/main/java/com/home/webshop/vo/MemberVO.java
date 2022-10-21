package com.home.webshop.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	
	private String id;
	private String pw;
	private String name;
	private String phon;
	private String addr;
	private String email;
	private Date regdate;
	private int verify;

}
