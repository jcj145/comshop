<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
   		<c:set var="id" value="${member.id}"/>
		<c:set var="writer" value="${detail.writer}"/>
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
        <link href="resources/css/board.css?sssdw" rel="stylesheet" />
        <link href="resources/css/sideKategorie.css" rel="stylesheet" />
        <link href="resources/css/reply.css?ssss" rel="stylesheet" />
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
                <section class="article-detail table-common con row">
        <table class="board-table" border="1">
            <colgroup>
                <col width="100px">
            </colgroup>
            <tbody>
                <tr class="article-title">
                    <th>제목</th>
                    <td colspan="1">${detail.title}</td>
                </tr>
                <tr>
                	<th>작성자</th>
                	<td>${detail.writer}</td>
                    <th>날짜</th>
                    <td><f:formatDate value="${detail.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr class="article-body">
                    <td colspan="4">${detail.content}<br/><br/><br/><br/><br/><br/><br/><br/>
         	            <input type="text" id="bno" value="${detail.bno}" hidden="true">
						<c:if test="${id eq writer}">			
							<input type="button" id="board_deleteBtn" value="삭제"/>
							<input type="submit" id="board_updateBtn" onclick="location.href='qnaupdate?bno=${detail.bno}'" value="수정"/>
						</c:if>
						<c:if test="${member.verify == 1}">
						<input type="button" id="deleteBtn" value="삭제"/>
						</c:if>
                    </td> 
       			 </table>
     			    <hr/>   
    <h4>댓글 작성</h4>
    	<div>
    		<input type="text" id="contents_reply">
    		<input type="text" id="writer_reply" hidden="ture" value="${member.id}">
    		<button id="create_reply">작성</button>
    	</div>
    <h4>댓글 목록</h4>
    <section class="reply-list table-common">
        <table border="1">
        	<c:forEach var="reply" items="${reply}">
				<tr>
					<td>${reply.rwriter}</td>
					<td>${reply.rcontent}</td>
					<td><f:formatDate value="${reply.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<!-- 댓글 삭제 & 수정 -->
					<td>    		
				     <div>
						<c:if test="${id eq writer}">
							<Button type="button" name="delete_reply" value="${reply.rno}">삭제</Button>
						</c:if>
					</div>
					</td>
		<!-- END 댓글 삭제 & 수정 -->	
				</tr>
			</c:forEach>
        </table>
    </section>
        </section>
        </div>
    </div>
	</section>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
            <script src="http://code.jquery.com/jquery-latest.min.js"></script>    
		<script>
		$("#create_reply").on("click", create_reply)
		$("Button[name=delete_reply]").on("click", delete_reply)
		$("#board_deleteBtn").on("click", delete_board)
		
		function create_reply() {
			if($("#contents_reply").val() == ""){
				alert("내용을 입력해 주세요.")
			} else{
				$.ajax({
					url : "createReply",
					type : "post",
					dataType : "json",
					data : {"rcontent" : $("#contents_reply").val(),
							"rwriter" : $("#writer_reply").val(),
							"bno" : $("#bno").val()},
					success : function(data) {
							alert(data.msg);
							location.reload();	
					},
					error : function() {
						alert(data.msg);	
					}
				});
			}
		}
		
		function delete_reply() {
				$.ajax({
					url : "deleteReply",
					type : "post",
					dataType : "json",
					data : {"rno" : $(this).val()},
					success : function(data) {
							alert(data.msg);
							location.reload();	
					},
					error : function(data) {
						alert(data.msg);	
					}
				});			
		}
		
		function delete_board() {			
				$.ajax({
					url : "deleteBoard",
					type : "post",
					dataType : "json",
					data : {"bno" : $("#bno").val()},
					success : function(data) {
						alert(data.msg);
						location.replace("qna");
					},
					error : function(data) {
						alert(data.msg);	
					}
				});			
		}
			
		</script>
    </body>
</html>