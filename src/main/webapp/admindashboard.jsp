<%@ page language="java" contentType="text/html;charset=UTF-8" %>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

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

        .content { padding: 20px; }
        .card-box { border-radius: 10px; }
    </style>
</head>

<body>

<div class="container-fluid">
    <div class="row">

        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 sidebar">

            <h4 class="text-center mb-4">Admin Panel</h4>

            <a href="admindashboard.jsp?page=userregister.jsp">
                <i class="bi bi-person-plus"></i> User Register
            </a>

            <!-- 🔥 Calls servlet -->
            <a href="Fetch?page=userdetails.jsp">
                <i class="bi bi-people"></i> User Details
            </a>

            <a href="#">
                <i class="bi bi-calendar-event"></i> Add Events
            </a>

            <a href="Logout">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>

        </div>

        <!-- Main Content -->
        <div class="col-md-9 col-lg-10 content">

            <h2>Welcome ${sessionScope.user.getUsername()}</h2>
            <p class="text-muted">Manage your gym system here</p>

            <!-- Cards -->
            <div class="row mt-4">

                <div class="col-md-4">
                    <div class="card shadow p-3 card-box">
                        <h5>Total Users</h5>
                        <h3>${sessionScope.totalUsers}</h3>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card shadow p-3 card-box">
                        <h5>Active Members</h5>
                        <h3>${activeMembers}</h3>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card shadow p-3 card-box">
                        <h5>Events</h5>
                        <h3>${eventsCount}</h3>
                    </div>
                </div>

            </div>

            <!-- 🔥 Dynamic Include -->
            <div class="mt-4" style="max-height: 500px; overflow-y: auto;">
    <jsp:include page="${param.page}" />
</div>

        </div>

    </div>
</div>

</body>
</html>