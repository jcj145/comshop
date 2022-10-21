<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <link href="resources/css/goodslist.css?sssdw" rel="stylesheet" />
        <link href="resources/css/sideKategorie.css" rel="stylesheet" />
    </head>
    <body>
    	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    	        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">장바구니</h1>
                </div>
            </div>
        </header>
        <section class="py-5">
		<table class="type11">
            <thead>
                <tr>
                    <th scope="col">체크</th>
                    <th scope="col">상품이름</th>
                    <th scope="col">가격</th>
                    <th scope="col">수량</th>
                </tr>
            </thead>
            <tbody>
                <tr>
               	 <c:set var="sum" value="0" />
    				<c:forEach var="cartlist" items="${cartlist}">
					<tr>
						<td><input type="checkbox" class="checkbox" value="${cartlist.cartnum}"></td>
						<td>${cartlist.name}</td>
						<td>${cartlist.price}</td>
						<td>${cartlist.cartstock}</td>
					</tr>
					<c:set var="sum" value="${sum + (cartlist.price * cartlist.cartstock)}" />
			</c:forEach>			
            </tbody> 
        </table>        
        	<div class="btm">
        		<button type="button" class="delete">상품 삭제</button>
        		<button type="button" class=purchase>상품 구매</button>
        		<h1>총 합계 : <fmt:formatNumber pattern="###,###,###" value="${sum}" />원</h1>
        		
        		
        	</div>
    	</section>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
            <script src="http://code.jquery.com/jquery-latest.min.js"></script>    
	<script>
	
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
		</script>
    </body>
</html>