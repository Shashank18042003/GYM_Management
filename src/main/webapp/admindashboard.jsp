<%@ page language="java" contentType="text/html;charset=UTF-8" %>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
String currentPage = request.getParameter("page");
if (currentPage == null || currentPage.trim().isEmpty()) {
    Object pageAttr = request.getAttribute("page");
    if (pageAttr != null) currentPage = pageAttr.toString();
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body { margin: 0; background: #0b1220; }

        .sidebar {
            height: 100vh;
            background: linear-gradient(180deg, #0f172a, #111827 45%, #0b1220);
            color: #e5e7eb;
            padding: 18px 14px;
            border-right: 1px solid rgba(148, 163, 184, 0.18);
        }

        .sidebar h4 {
            font-weight: 800;
            letter-spacing: 0.02em;
            margin-bottom: 18px;
            color: #ffffff;
        }

        .sidebar a {
            color: rgba(226, 232, 240, 0.82);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 12px;
            border-radius: 12px;
            margin: 6px 0;
            border: 1px solid transparent;
        }

        .sidebar a:hover {
            background: rgba(59, 130, 246, 0.18);
            color: #ffffff !important;
            border-color: rgba(147, 197, 253, 0.25);
            text-decoration: none;
        }
        .sidebar a.active-link {
            background: linear-gradient(120deg, rgba(37, 99, 235, .30), rgba(16, 185, 129, .24));
            color: #ffffff !important;
            border-color: rgba(191, 219, 254, .52);
            font-weight: 600;
        }
        .sidebar a:hover i,
        .sidebar a.active-link i {
            color: #ffffff !important;
        }

        .content {
            padding: 22px 24px;
            background: radial-gradient(circle at 20% 0%, rgba(59, 130, 246, 0.14), transparent 30%),
                        radial-gradient(circle at 90% 10%, rgba(167, 139, 250, 0.12), transparent 28%),
                        linear-gradient(145deg, #0b1220, #0f172a 55%, #111827);
            min-height: 100vh;
            color: #e2e8f0;
        }

        .content h2 { font-weight: 800; margin-bottom: 4px; font-size: 22px; }
        .content .text-muted { color: rgba(148, 163, 184, 0.9) !important; }

        .card-box { border-radius: 16px; }
        .stat-card {
            border-radius: 16px;
            border: 1px solid rgba(148, 163, 184, 0.22);
            background: linear-gradient(160deg, rgba(30, 41, 59, 0.74), rgba(15, 23, 42, 0.64));
            box-shadow: 0 14px 30px rgba(2, 6, 23, 0.35);
        }
        .stat-card h5 { color: #cbd5e1; font-weight: 700; font-size: 14px; margin-bottom: 6px; }
        .stat-card h3 { color: #ffffff; font-weight: 800; font-size: 22px; margin-bottom: 0; }

        .panel {
            border: 1px solid rgba(148, 163, 184, 0.22);
            background: linear-gradient(160deg, rgba(30, 41, 59, 0.72), rgba(15, 23, 42, 0.64));
            border-radius: 16px;
            padding: 14px;
        }

        .empty-panel {
            min-height: 260px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: rgba(148, 163, 184, 0.92);
            border: 1px dashed rgba(148, 163, 184, 0.35);
            border-radius: 12px;
        }

        /* Keep inner includes readable in dark admin UI */
        .panel .table {
            --bs-table-bg: transparent;
            --bs-table-color: #e2e8f0;
            --bs-table-hover-bg: rgba(59, 130, 246, 0.10);
            --bs-table-hover-color: #e2e8f0;
            --bs-table-striped-color: #e2e8f0;
        }
        .panel .table th { color: #bfdbfe; border-bottom-color: rgba(148, 163, 184, 0.32); }
        .panel .table td { border-bottom-color: rgba(148, 163, 184, 0.2); }
        .panel .table-hover tbody tr:hover td,
        .panel .table-hover tbody tr:hover th {
            color: #e2e8f0 !important;
        }
    </style>
</head>

<body>

<div class="container-fluid">
    <div class="row">

        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 sidebar">

            <h4 class="text-center mb-4">Admin Panel</h4>

            <a class="<%= "userregister.jsp".equals(currentPage) ? "active-link" : "" %>" href="Admindashboard?page=userregister.jsp">
                <i class="bi bi-person-plus"></i> User Register
            </a>

            <!-- 🔥 Calls servlet -->
            <a class="<%= "userdetails.jsp".equals(currentPage) ? "active-link" : "" %>" href="Fetch?page=userdetails.jsp">
                <i class="bi bi-people"></i> User Details
            </a>

          <a class="<%= "viewevents.jsp".equals(currentPage) ? "active-link" : "" %>" 
   href="ViewEventsAdmin">
    <i class="bi bi-calendar-event"></i> Add Events
</a>
			<a class="<%= "adminpayments.jsp".equals(currentPage) ? "active-link" : "" %>" href="Admindashboard?page=adminpayments.jsp">
				<i class="bi bi-clock-history"></i> Payment Received</a>			
            <a href="Logout">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
        </div>

        <!-- Main Content -->
        <div class="col-md-9 col-lg-10 content">

            <h2>Welcome ${sessionScope.user.getUsername()}</h2>
            <p class="text-muted">Manage your gym system here</p>

            <!-- Cards -->
            <div class="row mt-3 g-3">

                <div class="col-md-4">
                    <div class="stat-card p-3 card-box">
                        <h5>Total Users</h5>
                        <h3>${sessionScope.totalUsers != null ? sessionScope.totalUsers : 0}</h3>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="stat-card p-3 card-box">
                        <h5>Active Members</h5>
                        <h3>${sessionScope.activeMembers != null ? sessionScope.activeMembers : 0}</h3>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="stat-card p-3 card-box">
                        <h5>Events</h5>
                        <h3>${sessionScope.eventsCount != null ? sessionScope.eventsCount : 0}</h3>
                    </div>
                </div>

            </div>

            <!-- 🔥 Dynamic Include -->
            <div class="panel mt-3" style="height: calc(100vh - 210px); overflow-y: auto;">
                <%
                    if(currentPage != null && !currentPage.trim().isEmpty()){
                %>
                    <jsp:include page="${param.page}" />
                <%
                    } else {
                %>
                    <div class="empty-panel">
                        <div>
                            <h5 class="mb-2 text-light">Admin Dashboard Ready</h5>
                            <p class="mb-0">Choose <strong>User Register</strong> or <strong>User Details</strong> from the left menu.</p>
                        </div>
                    </div>
                <%
                    }
                %>
            </div>

        </div>

    </div>
</div>

</body>
</html>