# 컴퓨터 부품 구매 사이트(COMSHOP) - 개인 프로젝트
* * *
## 개발 환경
Spring     
HTML5   
CSS3   
JQUERY   
Bootstrap   
AJAX   
MYSQL   
Apache Tomcat   
##
## COMSHOP 패키지 구조
![구조1](https://user-images.githubusercontent.com/66048544/197149684-2992826d-ab77-4dce-8763-5d0e109954ce.PNG)
![구조2](https://user-images.githubusercontent.com/66048544/197149893-8f0094a2-c67f-4c02-96b9-4d40782160e6.PNG)
![구조3](https://user-images.githubusercontent.com/66048544/197149894-91d682f3-3a8c-4efc-bd97-10c190579f7a.PNG)
![구조4](https://user-images.githubusercontent.com/66048544/197149897-61aff78e-9bed-4aa3-b039-f845583d397f.PNG)
## DB 모델링
![DB](https://user-images.githubusercontent.com/66048544/197151010-6f1e19e2-1a99-4ab5-aadf-518389f0ef00.PNG)
## 주요 기능
* 메일 인증   
Javax Mail API 사용    
```c
	// 이메일 인증
	@ResponseBody
	@PostMapping("sendMail")
	public String sendMail(HttpSession session, String email) throws Exception {
		// 5자리 랜덤 숫자 인증코드 생성 및 메일 제목, 내용, 작성자 전달
		int random = new Random().nextInt(10000) + 10000;
		String code = String.valueOf(random);	
		String subject="컴샵 회원가입 인증 코드 발급 안내 입니다.";
		StringBuilder sb = new StringBuilder();
		sb.append("회원가입 인증 코드는 " + code + " 입니다.");
		return ms.send(subject, sb.toString(), "JCJ", email, code);		
	}
```   
Gmail 계정 연동 및 메일 전송
```c

    <bean id="mailSender" class="org.springframework.mail.javamail.JavaMailSenderImpl">
        <property name="host" value="smtp.gmail.com" />
        <property name="port" value="587" />
        <property name="username" value="구글아이디"/>
        <property name="password" value="비밀번호" />
        <property name="javaMailProperties">
            <props>
                <prop key="mail.transport.protocol">smtp</prop>
                <prop key="mail.smtp.auth">true</prop>
                <prop key="mail.smtp.starttls.enable">true</prop>
                <prop key="mail.debug">true</prop>
                <prop key="mail.smtp.ssl.trust">smtp.gmail.com</prop>
                <prop key="mail.smtp.ssl.protocols">TLSv1.2</prop>
            </props>
        </property>
    </bean>
```   
```c
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
```   
* 비밀번호 암호화   
스프링 시큐리티 Bcrypt 사용   
```c
	// 회원가입 처리
	@ResponseBody
	@PostMapping("join")
	public HashMap<String,String> join(MemberVO vo) { 	
		HashMap<String,String> msg = new HashMap<String,String>();
		// 비밀번호 암호화 
		String pw = passEncoder.encode(vo.getPw());
		vo.setPw(pw);
		String message = member.join(vo);
		msg.put("msg", message);
		return msg;
	}
```   
```c
	// 로그인 처리
	@ResponseBody
	@PostMapping("login") 
	public int login(String id, String pw, HttpServletRequest req) {
		int result;
		MemberVO login = member.login(id);
		HttpSession session = req.getSession();
    // 암호화된 비밀번호와 입력한 비밀번호가 일치하는지 비교
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
```   
DB에 암호화 되어 저장
![image](https://user-images.githubusercontent.com/66048544/197167721-6139e445-fc5a-47ba-b68f-a71ae83816f5.png)   
* AdminInterceptor 관리자 인터셉터   
```c
  // 관리자 인터셉터 객체 생성
	<beans:bean id="AdminInterceptor" class="com.home.webshop.interceptor.AdminInterceptor"/>
	
  // 로그인 인터셉터 설정
  // 특정 URI 요청시 컨트롤러로 가는 요청을 가로채는 역할을 한다 
 	<interceptors>
		<interceptor>
			<mapping path="/goodslist"/>
			<mapping path="/userlist"/>
			<mapping path="/product"/>
			<mapping path="/itemdetail"/>
			<mapping path="/update"/>
			<beans:ref bean="AdminInterceptor"/>
		</interceptor>
	</interceptors> 
```   
```c
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
    // session 객체를 가져온다
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");
		if(member == null || member.getVerify() != 1) {
     //권한값이 1이 아닌 경우 로그인 페이지로 이동
			response.sendRedirect("login");
     // 더 이상 컨트롤러 요청으로 가지 않도록 false 반환
     // 로그인이 안된 상태에서 기능 요청으로 보내지 않기 위함
			return false;
		}
		return true;
	}
```   
* 상품 등록







