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
        <link href="resources/css/login.css" rel="stylesheet" />
    </head>
    <body>
    	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">로그인</h1>
                    <p class="lead fw-normal text-white-50 mb-0">로그인</p>
                </div>
            </div>
        </header>
            <div class='wrap'>
               		<h1>login</h1>
				    <form>
				        <input type='text' id='id' placeholder='id'>
				        <input type='password' id='pw' placeholder='password'>
				    </form>
				  <button class='forgot' onclick="location.href='join';">회원가입</button>
				  <button class='login' id="login">로그인</button>                    
            </div>
        <!-- Section-->
        <section class="py-5">

        </section>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	
		$("#login").on("click", login);
		
		function login() {
			
			$.ajax({
				url : "login",
				type : "post",
				dataType : "json",
				data : {"id" : $("#id").val(),
						"pw" : $("#pw").val()},
				success : function(data) {
					if(data == 1){
						alert("로그인 성공");
						location.href="main";
					} else{
						alert("아이디 혹은 패스워드가 일치하지 않습니다.");
						location.reload();
					}
					
				},
				error : function() {
					alert("아이디 혹은 비밀번호가 잘못 입력되었습니다.");
				}
			});
		}
	</script>
    </body>
</html>