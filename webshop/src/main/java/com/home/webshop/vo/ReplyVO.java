package com.home.webshop.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private int rno;
	private int bno;
	private String rcontent;
	private String rwriter;
	private Date regdate;

}
