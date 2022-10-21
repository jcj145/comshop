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
        <link href="resources/css/itemdetail.css" rel="stylesheet" />
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
	            <li class="side"><a class="active" href="goodslist">상품 관리</a></li>
	            <li class="side"><a href="userlist">유저 목록</a></li>  	     	
            </ul>
        </div>
        <section class="py-5">
					    <div class="st">
					        <h2>${item.name}</h2>
					        <h4>카테고리 : ${item.cateCode}</h4>
					        <h4>가격 : ${item.price}</h4>
					        <h4>수량 : ${item.stock}</h4>
					        <h4>상품설명 : ${item.memo}</h4><br/>
					        <h4>상품이미지</h4>
					        <img class="card-img-top" src="${pageContext.request.contextPath}${item.thumbimg}"/>
					        <button class="update">상품 수정</button>
					        <form action="deleteitem" method="post">
					        	<input type="hidden" value="${item.num}" name="num">
					        	<button class="delete">상품 삭제</button>
					        </form>
					    </div>
					    
		</section>
   <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>    
	<script>
	
		$(".update").on("click", update);
		
		function update() {
			location.href="update?num=${item.num}";
		};
		
	</script>
    </body>
</html>