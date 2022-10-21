package com.home.webshop.service;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailServiceImpl implements MailService {
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	public void setJavaMailSender(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}
	
	@Override
	public String send(String subject, String text, String from, String to, String code) throws Exception {
		
		MimeMessage message = javaMailSender.createMimeMessage();
		
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		helper.setSubject(subject);
		helper.setText(text);
		helper.setFrom(from);
		helper.setTo(to);
		javaMailSender.send(message);		
		return code;
	}

}
