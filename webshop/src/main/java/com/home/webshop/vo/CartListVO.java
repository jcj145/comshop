package com.home.webshop.vo;


import lombok.Data;

@Data
public class CartListVO {
	
	private int cartnum;
	private String id;
	private int itemnum;
	private int cartstock;
	
	private String name;
	private String price;
	

}
