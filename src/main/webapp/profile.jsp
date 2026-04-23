<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h5>👤 My Profile</h5>

<p><strong>Name:</strong> ${sessionScope.user.getUsername()}</p>
<p><strong>Email:</strong> ${sessionScope.email}</p>
<p><strong>Phone:</strong> ${sessionScope.user.getPhone()}</p>
</body>
</html>