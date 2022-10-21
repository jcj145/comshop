<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>컴샵</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="resources/css/join.css?ㅌ2ss2ㄴs" rel="stylesheet" />
    </head>
    <body>
    	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">회원가입</h1>
                    <p class="lead fw-normal text-white-50 mb-0">회원가입</p>
                </div>
            </div>
        </header>
            <div class='wrap'>
            <div class="data"></div>
               		<h1>회원가입</h1>
				    <form>
					    <div class="front">
					    	<input class="info" type='email' id='email' placeholder='이메일' required/>
					    	<input type='text' class="certify" id='code' placeholder='인증번호'/>
							<input type="button" id="sendmail" value="메일전송"/>
							<input type="button" class="certify" id="check" value="인증하기"/>
					    </div>
					    <div class="back">
					    <label class="idcheck">사용중인 아이디 입니다.</label>
					    <input class="info" type='text' id='id' oninput="checkid()" placeholder='아이디' required/>
					    <label class="a">특수문자/문자/숫자 포함 8~15자</label><label class="b">비밀번호 형식에 맞게 입력하세요.</label>
						<input class="info" type='password' id='pw' oninput="pwrulecheck()" placeholder='비밀번호' required/>
						<label class="pwcheck">비밀번호가 일치하지 않습니다.</label>	
						<input class="info" type='password' id='pwcheck' oninput="passwordcheck()" placeholder='비밀번호확인' required/>	
						<input class="info" type='text' id='name' placeholder='이름' required/>	
						<input class="info" type='text' id='phon' placeholder='연락처' required/>	
						<input class="info" type='text' id='addr' placeholder='주소' required/>
						<input class="info" type="button" id="register" value="회원가입" required/> 			  
					    </div>
				    </form>
				     
            </div>
        <!-- Section-->
        <section class="py-5">
        </section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var pwrule = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; //특수문자/문자/숫자 포함 8~15
   	var code = "";
   	$(".back").hide();
   	$("#sendmail").on("click", sendmail);
   	$("#check").on("click", check);
   	$("#register").on("click", register);
   	
	// 이메일 보내기
	function sendmail() {
		var email = $("#email").val();
	
		if(code != ""){
			alert("이미 인증메일이 전송되었습니다.")
		} else{
			$.ajax({
				url : "sendMail",
				type : "post",
				dataType : "json",
				data : {"email" : $("#email").val()},
				success : function(data) {
						alert("인증메일을 발송하였습니다.");
						$(".certify").show();
						$("#sendmail").hide();
						code = data;					
				},
				error : function() {
					alert("이메일을 정확히 입력해 주세요.");	
				}
			});
		}
		
	};
	
	// 인증 확인
	function check() {
		if($("#code").val() == code){
			alert("인증성공");
			$(".front").hide();
			$(".back").show();
		} else {
			alert("인증번호가 틀립니다.");
		}
	}
	
	// 아이디 중복확인
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
	
	// 비밀번호 정규식 확인
	function pwrulecheck() {
		if($("#pw").val() != "" && !pwrule.test($("#pw").val())){
			$(".a").hide();
			$(".b").show();			
		} else{		
			$(".b").hide();	
			$(".a").show();
		}
	}
	
	// 비밀번호 일치확인
	function passwordcheck() {
		if($("#pw").val() != $("#pwcheck").val()){
			$(".pwcheck").show();
		} else{
			$(".pwcheck").hide();
		}
	}
	
	// 회원가입
	function register() {
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
	

	


</script>
</body>
</html>