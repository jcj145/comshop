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
                    <h1 class="display-4 fw-bolder">문의하기</h1>
                </div>
            </div>
        </header>
        <section class="py-5">
		<div id="board-list">
        <div class="container">
            <div class="pm">
            	<form action="create" method="post">
			<table>
				<tr>
					<td>제목</td>
					<td><input type="text" name="title" style="width: 860px" required/></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input type="text" name="writer" value="${member.id}" style="width: 200px" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="content" rows=20 cols=100></textarea></td>
				</tr>
				<tr>
					<td><input type="submit" value="작성완료"/></td>
				</tr>
			</table>
		</form>
            </div>
        </div>
    </div>
	</section>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
            <script src="http://code.jquery.com/jquery-latest.min.js"></script>    
	<script>
		</script>
    </body>
</html>