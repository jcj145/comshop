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
        <title>컴샵 - 제품보기</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="resources/css/styles.css" rel="stylesheet" />
        <link href="resources/css/sideKategorie.css" rel="stylesheet" />
        <link href="resources/css/purchase.css?s" rel="stylesheet" />
    </head>
    <body>
    	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">주요 부품</h1>
                    <p class="lead fw-normal text-white-50 mb-0">CPU</p>
                </div>
            </div>
        </header>
                <div class="container px-4 px-lg-5 mt-5">
            <ul class="side">
	            <li class="side"><a href="cpu">CPU</a></li>
	            <li class="side"><a href="vga">그래픽카드</a></li>
	            <li class="side"><a href="mainboard">메인보드</a></li>  	  
	            <li class="side"><a href="ram">RAM</a></li>
	            <li class="side"><a href="ssd">SSD</a></li>
	            <li class="side"><a href="power">파워</a></li>           	
            </ul>
        </div>
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <div class="col mb-5">
                    	<div class = "card-wrapper">
    <!-- card left -->
    <div class = "product-imgs">
      <div class = "img-display">
        <div class = "img-showcase">
          <img class="card-img-top" src="${pageContext.request.contextPath}${item.thumbimg}"/>
        </div>
      </div>
    <!-- card right -->
    <div class = "product-content">
      <h2 class = "product-title">${item.name}</h2>
      </div>

      <div class = "product-price">
        <p class = "new-price">가격: <span>${item.price}\</span></p>
      </div>

      <div class = "product-detail">
        <h2>상품 설명: </h2>
		<p>${item.memo}</p>
      </div>

      <div class = "purchase-info">
        <input type = "number" min = "0" id="stock" value = "1">
        <button type = "button" class = "btn" onclick="cart();">
          장바구니에 담기 <i class = "fas fa-shopping-cart"></i>
        </button>
        <button class ="btn">구매하기</button>
      </div>
 
    </div>
  </div>
</div>
                    </div> 
                </div>
        </section>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script>
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
		
		</script>
    </body>
</html>