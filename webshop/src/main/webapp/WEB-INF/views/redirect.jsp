<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8" />
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript"> 

	var message = '${msg}'; 
	
	var url = '${url}'; 
	
	alert(message); 
	document.location.href = url; 
</script>
</body>
</html>