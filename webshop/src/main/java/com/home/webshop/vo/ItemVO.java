package com.home.webshop.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ItemVO {
	
	private int num;
	private String name;
	private String cateCode;
	private String price;
	private String stock;
	private String memo;
	private String image;
	private Date upload;
	private String thumbimg;
	

}
