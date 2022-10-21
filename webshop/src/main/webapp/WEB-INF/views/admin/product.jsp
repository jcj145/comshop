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
	            <li class="side"><a class="active" href="product">상품 등록</a></li>
	            <li class="side"><a href="goodslist">상품 관리</a></li>
	            <li class="side"><a href="userlist">유저 목록</a></li>  	      	
            </ul>
        </div>
        <section class="py-5">
	        <div class="container px-4 px-lg-5 mt-5">
	       		<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4">
	       			<div class="col mb-5">
	       				<form action="register" method="post" enctype="multipart/form-data">
						 	<label>상품 카테고리</label>
							 <select id="category" name="cateCode"></select>
							 <div>
								 <label for="name">상품명</label>
								 <input type="text" name="name"/>
							</div>
							<div>
								 <label for="price">상품가격</label>
								 <input type="text" name="price"/>
							</div>
							<div>
								 <label for="stock">상품수량</label>
								 <input type="text" name="stock"/>
							</div>						
							<div>
								 <label for="memo">상품소개</label>
								 <textarea rows="5" cols="50" name="memo"></textarea>
							</div>		
							<div>
								 <label for="img">이미지</label>
								 <input type="file" name="file" id="image"/>
								 <div class="select_img"><img src="" /></div>
								 
							</div>				
							<div>
								 <button type="submit" name="register">등록</button>
							</div>
						</form>
	       			</div>
	       		</div>
	   		</div>
    	</section>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
			var result = '${msg}';
			if(result != null && result != ''){
				alert(result);
			}
        
        	var jsonData = JSON.parse('${categorylist}');
        	
        	var cateArr = new Array();
        	var cateObj = new Object();
        	
        	for(var i = 0; i < jsonData.length; i++) {   		 
        		 if(jsonData[i].cateCodeRef == null || jsonData[i].cateCodeRef == "") {
        		  cateObj = new Object();
        		  cateObj.cateCode = jsonData[i].cateCode;
        		  cateObj.cateName = jsonData[i].cateName;
        		  cateArr.push(cateObj);
        		 }
        		}
        	
        	for(var i = 0; i < cateArr.length; i++) {
        	$("#category").append("<option value='" + cateArr[i].cateCode + "'>"
        	      + cateArr[i].cateName + "</option>"); 
        	}
        	
        	  $("#image").change(function(){
        		   if(this.files && this.files[0]) {
        		    var reader = new FileReader;
        		    reader.onload = function(data) {
        		     $(".select_img img").attr("src", data.target.result).width(200);        
        		    }
        		    reader.readAsDataURL(this.files[0]);
        		   }
        		  });
        	  
        	$("#image").change(function() {
				if(this.files && this.files[0]) {
					var reader = new FileReader;
					reader.onload = function(data) {
						$(".select_img img").attr("src", data.target.result).width(500);
					}
					reader.readAsDataURL(this.files[0]);
				}				
			});
        	
        </script>
    </body>
</html>