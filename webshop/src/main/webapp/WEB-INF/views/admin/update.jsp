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
					    <form class="st" method="post" action="update" enctype="multipart/form-data">
					        <h2>이름 : <input class="underline" type="text" name="name" value="${item.name}"></h2>
					        <h4>카테고리 : <input class="underline" type="number" name="cateCode" value="${item.cateCode}"></h4>
					        <h4>가격 : <input class="underline" type="number" name="price" value="${item.price}"></h4>
					        <h4>수량 : <input class="underline" type="number" name="stock" value="${item.stock}"></h4>
					        <h4>상품설명 : <textArea rows="10" cols="25" name="memo" class="underline">${item.memo}</textArea></h4><br/>
					        <h4>상품이미지</h4>
					        <img class="card-img-top" name="image" src="${pageContext.request.contextPath}${item.thumbimg}"/>
					        <input type="file" name="file" id="image"/>
					        <input class="underline" type="hidden" name="num" value="${item.num}">
					        <button class="update">수정 완료</button>
					    </form>
					    
		</section>
   <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>    
	<script>
	
		var result = '${msg}';
		if(result != null && result != ''){
			alert(result);
			location.href="update?num=${goodslist.num}";
		}
		
  	  $("#image").change(function(){
		   if(this.files && this.files[0]) {
		    var reader = new FileReader;
		    reader.onload = function(data) {
		     $(".card-img-top").attr("src", data.target.result).width(200);        
		    }
		    reader.readAsDataURL(this.files[0]);
		   }
		  });
	  
	$("#image").change(function() {
		if(this.files && this.files[0]) {
			var reader = new FileReader;
			reader.onload = function(data) {
				$(".card-img-top").attr("src", data.target.result).width(500);
			}
			reader.readAsDataURL(this.files[0]);
		}				
	});
	</script>
    </body>
</html>