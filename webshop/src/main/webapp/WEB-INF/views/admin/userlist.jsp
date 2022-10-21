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
        <link href="resources/css/styles.css" rel="stylesheet" />
        <link href="resources/css/goodslist.css?assdw" rel="stylesheet" />
        <link href="resources/css/sideKategorie.css" rel="stylesheet" />
    </head>
    <body>
    	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    	        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">관리자 페이지</h1>
                </div>
            </div>
        </header>
                <!-- Section-->
        <div class="container px-4 px-lg-5 mt-5">
            <ul class="side">
	            <li class="side"><a href="product">상품 등록</a></li>
	            <li class="side"><a href="goodslist">상품 관리</a></li>
	            <li class="side"><a class="active" href="userlist">유저 목록</a></li>  	      	
            </ul>
        </div>
        <section class="py-5">
		<table class="type11">
            <thead>
                <tr>
                    <th scope="col">이름</th>
                    <th scope="col">아이디</th>
                    <th scope="col">전화번호</th>
                    <th scope="col">주소</th>
                    <th scope="col">이메일</th>
                    <th scope="col">가입일</th>
                    <th scope="col">회원탈퇴</th>
                </tr>
            </thead>
            <tbody>
                <tr>
    				<c:forEach var="userlist" items="${userlist}">
					<tr>
						<td>${userlist.name}</td>
						<td>${userlist.id}</td>
						<td>${userlist.phon}</td>
						<td>${userlist.addr}</td>
						<td>${userlist.email}</td>
						<td><f:formatDate pattern="yyyy-MM-dd HH:mm" value="${userlist.regdate}"/></td>
						<td><input type="button" name="deleteBtn" id="${userlist.id}" value="회원탈퇴"/></td>
					</tr>
			</c:forEach>
            </tbody>
        </table>        
         <div class="pm">
            <table class="type12"  style="margin-left: auto; margin-right: auto;">
            	<tr>
					<!-- pm -->
					<th colspan="10">
						<c:if test="${pm.first}">
							<a href="userlist?page=1">[<<]</a>
						</c:if>
						<c:if test="${pm.prev}">
							<a href="userlist?page=${pm.startPage-1}">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
							<a href="userlist?page=${i}">[${i}]</a>
						</c:forEach>
						<c:if test="${pm.next}">
							<a href="userlist?page=${pm.endPage+1}">[다음]</a>
						</c:if>
						<c:if test="${pm.last}">
							<a href="userlist?page=${pm.maxPage}">[>>]</a>
						</c:if>
					</th>
				</tr>
            </table>
            </div>
    	</section>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
            <script src="http://code.jquery.com/jquery-latest.min.js"></script>    
	<script>
			$("[name=deleteBtn]").on("click", deleteUser);
			
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
		</script>
    </body>
</html>