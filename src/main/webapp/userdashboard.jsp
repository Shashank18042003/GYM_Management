<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body { margin: 0; }

.sidebar {
    height: 100vh;
    background-color: #212529;
    color: white;
    padding-top: 20px;
}

.sidebar a {
    color: #adb5bd;
    text-decoration: none;
    display: block;
    padding: 12px 20px;
}

.sidebar a:hover {
    background-color: #343a40;
    color: white;
}

.content {
    padding: 20px;
}

.card-box {
    border-radius: 10px;
}
</style>
</head>

<body>

<div class="container-fluid">
<div class="row">

<!-- SIDEBAR -->
<div class="col-md-3 col-lg-2 sidebar">

    <h4 class="text-center mb-4">User Panel</h4>

    <a href="userdashboard.jsp?page=profile.jsp">👤 My Profile</a>
    <a href="userdashboard.jsp?page=membership.jsp">🏋️ Membership</a>
    <a href="userdashboard.jsp?page=payments.jsp">💸 Payments</a>
    <a href="Logout">Logout</a>

</div>

<!-- MAIN CONTENT -->
<div class="col-md-9 col-lg-10 content">

    <h2>Welcome ${sessionScope.user.getUsername()}</h2>
    <p class="text-muted">Your dashboard</p>

    <!-- SUMMARY CARDS -->
    <div class="row mt-4">

        <div class="col-md-4">
            <div class="card shadow p-3 card-box">
                <h5>Status</h5>
                <h4 class="text-success">${sessionScope.status}</h4>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow p-3 card-box">
                <h5>Expiry Date</h5>
                <h4>${sessionScope.expiryDate}</h4>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow p-3 card-box">
                <h5>Remaining Days</h5>
                <h4>${sessionScope.remainingDays} Days</h4>
            </div>
        </div>

    </div>

    <!-- 🔥 DYNAMIC CONTENT -->
    <div class="card shadow p-4 mt-4">

        <jsp:include page="${param.page != null ? param.page : 'profile.jsp'}" />

    </div>

</div>

</div>
</div>

</body>
</html>