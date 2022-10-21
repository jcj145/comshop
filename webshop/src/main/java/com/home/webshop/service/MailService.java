package com.home.webshop.service;


public interface MailService {	
	

	public String send(String subject, String text, String from, String to, String code) throws Exception;
}
