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
          <link href="resources/css/board.css?ws" rel="stylesheet" />
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
            <table class="board-table">
                <thead>
                <tr>
                    <th scope="col" class="th-num">번호</th>
                    <th scope="col" class="th-title">제목</th>
                    <th scope="col" class="th-name">작성자</th>
                    <th scope="col" class="th-date">등록일</th>
                </tr>
                </thead>
                <tbody>
    				<c:forEach var="boardlist" items="${boardlist}">
					<tr>
						<td>${boardlist.bno}</td>
						<td><a href="detail?bno=${boardlist.bno}">${boardlist.title}</a></td>
						<td>${boardlist.writer}</td>
						<td><f:formatDate value="${boardlist.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
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
							<a href="qna?page=1">[<<]</a>
						</c:if>
						<c:if test="${pm.prev}">
							<a href="qna?page=${pm.startPage-1}">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
							<a href="qna?page=${i}">[${i}]</a>
						</c:forEach>
						<c:if test="${pm.next}">
							<a href="qna?page=${pm.endPage+1}">[다음]</a>
						</c:if>
						<c:if test="${pm.last}">
							<a href="qna?page=${pm.maxPage}">[>>]</a>
						</c:if>
					</th>
				</tr>
				<tr>
					<td><input class="boardbtn" type="button" onclick="location.href='qnawrite'" value="게시글 작성"/></td>
				</tr>
            </table>
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