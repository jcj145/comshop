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
Thumbnailator 와 Commons-Fileupload 라이브러리를 사용한 상품 이미지 등록   
```c
	<!-- 업로드 패스 설정 --> 
	<beans:bean class="java.lang.String" id="uploadPath">
	 <beans:constructor-arg value="C:\coding\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\webshop\resources" />
	</beans:bean>
	
	<!-- 일반 파일 업로드 경로 -->
	<resources mapping="/img/**" location="/resources/img/" />
	
	<!-- 파일 크기 제한 -->
	<beans:bean class="org.springframework.web.multipart.commons.CommonsMultipartResolver" id="multipartResolver">
	 <beans:property name="maxUploadSize" value="10485760"/>
	</beans:bean>
```   
* FileUpload 폴더 생성과 파일 저장, 썸내일 생성
```c
//날짜(연/월/일)로 구성된 폴더를 생성 같은 파일명이라도 중복되지 않도록 랜덤문자와 파일명을 조합한 뒤 생성된 폴더에 저장, 썸네일을 생성하여 별도의 폴더에 저장
static final int THUMB_WIDTH = 300;
	 static final int THUMB_HEIGHT = 300;
	 
	 public static String fileUpload(String uploadPath,
	         String fileName,
	         byte[] fileData, String ymdPath) throws Exception {

	  UUID uid = UUID.randomUUID();
	  
	  String newFileName = uid + "_" + fileName;
	  String imgPath = uploadPath + ymdPath;

	  File target = new File(imgPath, newFileName);
	  FileCopyUtils.copy(fileData, target);
	  
	  String thumbFileName = "s_" + newFileName;
	  File image = new File(imgPath + File.separator + newFileName);

	  File thumbnail = new File(imgPath + File.separator + "s" + File.separator + thumbFileName);

	  if (image.exists()) {
	   thumbnail.getParentFile().mkdirs();
	   Thumbnails.of(image).size(THUMB_WIDTH, THUMB_HEIGHT).toFile(thumbnail);
	  }
	  return newFileName;
	 }

	 public static String calcPath(String uploadPath) {
	  Calendar cal = Calendar.getInstance();
	  String yearPath = File.separator + cal.get(Calendar.YEAR);
	  String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
	  String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));

	  makeDir(uploadPath, yearPath, monthPath, datePath);
	  makeDir(uploadPath, yearPath, monthPath, datePath + "\\s");

	  return datePath;
	 }

	 private static void makeDir(String uploadPath, String... paths) {

	  if (new File(paths[paths.length - 1]).exists()) { return; }

	  for (String path : paths) {
	   File dirPath = new File(uploadPath + path);

	   if (!dirPath.exists()) {
	    dirPath.mkdir();
	   }
	  }
	 }
```   
* PageCriteria QnA 게시판 페이징 기준
```c
	private int page;	// 요청(현재) 페이지 정보
	private int perPageNum; // 페이지당 표시할 게시글의 수
	private String searchType;
	private String searchName;
	
	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchName() {
		return searchName;
	}

	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}

	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int page, int perPageNum) {
		this.page = page;
		this.perPageNum = perPageNum;
	}
	// 게시글 검색 시 limit 시작 인덱스 번호
	public int getStartRow() {
		return (this.page-1) * this.perPageNum;
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPerPageNum() {
		return perPageNum;
	}
	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}
	
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + " startRow="+getStartRow()+" ]";
	}
```   
* PageMaker 게시판 페이징   
```c
	private int totalCount;	// 전체 게시물의 수
	private int startPage;	// 게시물의 화면에 보여질 시작페이지 번호
	private int endPage;	// 게시물의 화면에 보여질 마지막페이지 번호
	private int displayPageNum;	// 보여줄 페이지 개수
	private int maxPage;		// 전체 페이지 개수
	private boolean first;		// 첫페이지 버튼 활성화 여부
	private boolean last;		// 마지막페이지 버튼 활성화 여부
	private boolean prev;		// 이전 페이지 버튼 활성화 여부
	private boolean next;		// 다음 페이지 버튼 활성화 여부
	
	private Criteria cri;		// 요청 페이지 정보
	
	public PageMaker() {
		this(0);
	}

	public PageMaker(int totalCount) {
		this(totalCount,new Criteria());
	}

	public PageMaker(int totalCount, Criteria cri) {
		this(totalCount, 5, cri);
	}

	public PageMaker(int totalCount, int displayPageNum, Criteria cri) {
		this.totalCount = totalCount;
		this.displayPageNum = displayPageNum;
		this.cri = cri;
		calcPaging();
	}

	private void calcPaging() {
		// displayPageNum = 5
		// 1 ~ 5 == [1][2][3][4][5]
		// 6 ~ 10 ==[6][7][8][9][10]
		endPage = (int)Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum;
		startPage = (endPage - displayPageNum)+1;
		// totalCount = 138 , perPageNum = 10
		// 138/10.0 == 13.8 == 14
		maxPage = (int)(Math.ceil(totalCount/(double)cri.getPerPageNum()));
		// [11][12][13][14][15]
		// endPage = 15; 
		if(endPage > maxPage) endPage = maxPage;
		// endPage = 14;
		first = cri.getPage() != 1 ? true : false;
		last = cri.getPage() < maxPage ? true : false;
		// [1][2][3][4][5] = false
		// [6][7][8][9][10] = true
		prev = (startPage != 1) ? true : false;
		// [11][12][13][14] == false
		// [6][7][8][9][10] == true
		next = (endPage == maxPage) ? false : true;
	}
```   
# 요청 처리 과정   
요청 > 컨트롤러 > 서비스 > 서비스 구현 > DAO > DAO 구현 > Mybatis > DB > 컨트롤러 - DB 반환   
# 세부 기능   
* register() 회원가입   
```c
	function register() {
		// 입력칸이 비어 있을시 알림창을 띄워줌
		if($(".info").val() == ""){
			alert("회원가입 정보를 모두 입력해주세요.");
		}else{
			$.ajax({
				url : "join",
				type : "post",
				dataType : "json",
				data : {"id" : $("#id").val(),
						"pw" : $("#pw").val(),
						"name" : $("#name").val(),
						"addr" : $("#addr").val(),
						"phon" : $("#phon").val(),
						"email" : $("#email").val()},
				success : function(data) {
					alert(data.msg);
					location.href="login";
				},
				error : function (data) {
					alert(data.msg);
					location.reload();
				}
			});
		}

	}
```   
* memberMapper   
```c
	<insert id="join" parameterType="com.home.webshop.vo.MemberVO">		
		INSERT INTO member(id, pw, name, phon, addr, email) 
		VALUES(#{id},#{pw},#{name},#{phon},#{addr},#{email})
	</insert>
```
* MemberDAOImpl 쿼리가 정상적으로 실행됬는지 아닌지 결과 리턴
```c
	@Override
	public int join(MemberVO vo) {
		int result = sql.insert(namespace+".join",vo);
		return result;
	}
```
* MemberServiceImpl 메세지를 저장해서 리턴
```c
	@Override
	public String join(MemberVO vo) {
		int result = dao.join(vo);
		String message = (result != 0) ? "회원가입 성공" : "회원가입 실패";
		return message;
	}
```
* MemberController 해시맵으로 메세지를 담아서 넘김
```c
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
* 아이디 중복체크 및 비밀번호 정규식
```c
var pwrule = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; //특수문자/문자/숫자 포함 8~15
	function checkid() {
		$.ajax({
			url : "idcheck",
			type : "post",
			dataType : "json",
			data : {"id" : $("#id").val()},
			success : function (result) {
				if(result != 0){
					$(".idcheck").show();	
				} else {
					$(".idcheck").hide();
				}		
			}
		});
	}
```   
![image](https://user-images.githubusercontent.com/66048544/197311800-87f37086-0774-454c-9207-2ac999dc1ae2.png)
* 상품 목록 페이지   
item테이블의 정보를 리스트 형태로 가져와서 반복문으로 생성
```c
         <c:forEach var="itemlist" items="${itemlist}">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="${pageContext.request.contextPath}${itemlist.thumbimg}"/>
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">${itemlist.name}</h5>
                                    <!-- Product price-->
                                    ${itemlist.price}\
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center">
                                	<a class="btn btn-outline-dark mt-auto" href="purchase?num=${itemlist.num}">상세정보</a>
                                </div>
                            </div>
                        </div>
                    </div>
			</c:forEach>  
```   
![image](https://user-images.githubusercontent.com/66048544/197313046-35650660-85e9-4d67-b1d7-d2ae5fd12543.png)
* 상품 상세보기 페이지   
![image](https://user-images.githubusercontent.com/66048544/197314645-c18b5d93-02e3-4b0c-b751-58f701e0f8c4.png)   
* 장바구니에 담기
```c
			function cart() {
				$.ajax({
					url : "cart",
					type : "post",
					dataType : "json",
					data : {"id" : "${sessionScope.member.id}",
							"itemnum" : ${item.num},
							"cartstock" : $("#stock").val()},
					success : function(data) {
						alert(data.msg);
						location.reload();
					},
					error : function (data) {
						alert(data.msg);
						location.reload();
					}
				});
			}
```   
* 장바구니 목록   
![image](https://user-images.githubusercontent.com/66048544/197314792-4c29f425-a994-43d4-b00a-9581d7d4c35b.png)
* 장바구니 상품 삭제
```c
	 $(".delete").click(function(){
		  var confirm_val = confirm("정말 삭제하시겠습니까?");
		  
		  if(confirm_val) {
		   var checkArr = new Array();
		   
		   $("input[class='checkbox']:checked").each(function(){
		    checkArr.push($(this).val());
		   });
		    
		   $.ajax({
		    url : "deletecart",
		    type : "post",
		    data : { cartnum : checkArr },
		    success : function(){
		    	location.reload();
		    }
		   });
		  } 
		 });
```   
Controller
```c
	@ResponseBody
	@PostMapping("deletecart")
	public void deleteCart(@RequestParam(value="cartnum[]") List<Integer> chbox) {	
		member.deletecart(chbox);
	}
```   
Mapper - 체크가 여러개 됬을시 한번에 처리하기 위해 동적쿼리를 사용
```c
	<delete id="deletecart" parameterType="List">
		DELETE from cart WHERE cartnum in     
			<foreach collection="list" item="cartnum" index="i" open="(" separator="," close=")">
	      		#{cartnum}
	    	</foreach>
	</delete>	
```   
* 관리자 상품 등록 페이지    
![image](https://user-images.githubusercontent.com/66048544/197314994-ed6f7d71-aa3f-451a-aeff-182d02d5b5b6.png)
* 관리자 상품 목록 및 상품 수정 페이지   
![image](https://user-images.githubusercontent.com/66048544/197315084-2f7e7f55-2d3d-45a8-ac2f-8041f81aec1b.png)
![image](https://user-images.githubusercontent.com/66048544/197315097-9384d938-cfd2-43ff-b9c0-67e5cc2fb663.png)   
상품수정   
```c
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
```   
* 유저 관리 페이지
![image](https://user-images.githubusercontent.com/66048544/197315230-4e793b30-76a5-4734-95fa-e8e810fd3002.png)  
* 회원탈퇴
```c
			function deleteUser() {
				$.ajax({
					type:"POST",
					url:"deleteUser",
					dataType:"json",
					data:{"id" : $(this).attr("id")},
					success: function(data) {
						alert(data.msg);
						 location.reload();
			}
				});
			}
```   
Mapper
```c
	<delete id="deleteuser">
		DELETE from member WHERE id = #{id}
	</delete>	
```   
* Qna 게시판 페이지   
![image](https://user-images.githubusercontent.com/66048544/197315311-65e3ed57-5793-4a12-97e0-fe9c8dce996c.png)   
* 게시글 상세보기 페이지   
글/삭제는 관리자, 작성자만 가능하며 수정은 작성자만 가능합니다    
댓글은 작성자만 삭제 가능합니다.
![image](https://user-images.githubusercontent.com/66048544/197315357-ac930b88-d9e5-4524-ad6d-74366a5e6993.png)
 * 헤더
 ![image](https://user-images.githubusercontent.com/66048544/197315522-31f8bccb-2917-48b6-b03e-d40195531ede.png)   
 장바구니 수량은 장바구니에 담길때, 삭제할때 갱신 됩니다.   
 관리자 페이지는 관리자 권한이 있는 아이디로 로그인 했을 경우만 보이게 됩니다.   
 * 홈페이지 사진   
 ![image](https://user-images.githubusercontent.com/66048544/197315617-42f1869c-67e8-4a9b-b681-887143f19c60.png)







