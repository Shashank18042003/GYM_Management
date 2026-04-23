<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
String currentPage = request.getParameter("page");
if(currentPage == null) currentPage = "profile.jsp";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>User Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/user.css">
<style>
    .sidebar a.active-nav {
        background: rgba(0,0,0,0.28);
        color: #ffffff;
        font-weight: 600;
        box-shadow: inset 0 0 0 1px rgba(255,255,255,0.15);
    }
</style>

</head>

<body>

<div class="container-fluid py-3 py-md-4">
    <div class="row g-3 g-md-4">

        <!-- SIDEBAR -->
        <div class="col-12 col-md-3 col-lg-2">
            <aside class="sidebar rounded-4 shadow-sm p-3 p-lg-4">
                <div class="text-center mb-3 mb-lg-4">
                    <h5 class="mb-1">User Panel</h5>
                    <small class="text-muted">Quick navigation</small>
                </div>

                <nav class="d-grid gap-2">
                    <a class="<%= currentPage.equals("profile.jsp") ? "active-nav" : "" %>" href="userdashboard.jsp?page=profile.jsp">👤 Profile</a>
                    <a class="<%= currentPage.equals("membership.jsp") ? "active-nav" : "" %>" href="userdashboard.jsp?page=membership.jsp">🏋️ Membership</a>
                    <a class="<%= currentPage.equals("payments.jsp") ? "active-nav" : "" %>" href="userdashboard.jsp?page=payments.jsp">💸 Payments</a>
                    <a class="<%= currentPage.equals("rechargeplan.jsp") ? "active-nav" : "" %>" href="userdashboard.jsp?page=rechargeplan.jsp">💳 Recharge</a>
                </nav>

                <hr class="my-3">
                <a href="Logout">Logout</a>
            </aside>
        </div>

        <!-- MAIN -->
        <div class="col-12 col-md-9 col-lg-10">
            <main class="content">
                <div class="d-flex flex-column flex-lg-row justify-content-between align-items-start align-items-lg-center gap-2 mb-3">
                    <div>
                        <h5 class="dashboard-title mb-1">👋 Welcome back, ${sessionScope.user.username}</h5>
                        <p class="text-muted mb-0">Your fitness journey dashboard</p>
                    </div>
                </div>

                <!-- TOP CARDS -->
                <div class="row g-3">
                    <% if(currentPage.equals("membership.jsp")) { %>

                        <div class="col-12 col-md-6 col-xl-4">
                            <div class="card-box small-card h-100 rounded-4 shadow-sm p-3">
                                <h6 class="text-muted mb-2">Status</h6>
                                <h5 class="text-success mb-0">${sessionScope.status}</h5>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-xl-4">
                            <div class="card-box small-card h-100 rounded-4 shadow-sm p-3">
                                <h6 class="text-muted mb-2">Days Left</h6>
                                <h5 class="mb-0">${sessionScope.remainingDays}</h5>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-xl-4">
                            <div class="card-box small-card h-100 rounded-4 shadow-sm p-3">
                                <h6 class="text-muted mb-2">Plan</h6>
                                <h5 class="mb-0">${sessionScope.plan}</h5>
                            </div>
                        </div>

                    <% } else { %>

                        <div class="col-12 col-md-6 col-xl-4">
                            <div class="card-box small-card h-100 rounded-4 shadow-sm p-3">
                                <h6 class="text-muted mb-2">Name</h6>
                                <h5 class="mb-0">${sessionScope.user.username}</h5>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-xl-4">
                            <div class="card-box small-card h-100 rounded-4 shadow-sm p-3">
                                <h6 class="text-muted mb-2">Email</h6>
                                <h5 class="mb-0">${sessionScope.email}</h5>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-xl-4">
                            <div class="card-box small-card h-100 rounded-4 shadow-sm p-3">
                                <h6 class="text-muted mb-2">Phone</h6>
                                <h5 class="mb-0">${sessionScope.user.phone}</h5>
                            </div>
                        </div>

                    <% } %>
                </div>

                <!-- MAIN CONTENT -->
                <section class="main-card mt-3 mt-lg-4 rounded-4 shadow-sm p-3 p-lg-4 bg-white">
                    <jsp:include page="<%= currentPage %>" />
                </section>
            </main>
        </div>
    </div>
</div>

</body>
</html>