<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
        }

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

        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 sidebar">

            <h4 class="text-center mb-4">User Panel</h4>

            <a href="#"><i class="bi bi-person-circle"></i> My Profile</a>

			<a href="#"><i class="bi bi-card-checklist"></i> Membership</a>

			<a href="rechargeplan.jsp"><i class="bi bi-credit-card"></i> Recharge Plan</a>

			<a href="#"><i class="bi bi-clock-history"></i> Payment History</a>

			<a href="login.html"><i class="bi bi-box-arrow-right"></i> Logout</a>

        </div>

        <!-- Main Content -->
        <div class="col-md-9 col-lg-10 content">

            <h2>Welcome ${user.username} 👋</h2>
            <p class="text-muted">Here is your gym overview</p>

            <div class="row mt-4">

                <!-- Membership Status -->
                <div class="col-md-4">
                    <div class="card shadow p-3 card-box">
                        <h5>Membership Status</h5>
                        <h4 class="text-success">${status}</h4>
                    </div>
                </div>

                <!-- Expiry Date -->
                <div class="col-md-4">
                    <div class="card shadow p-3 card-box">
                        <h5>Expiry Date</h5>
                        <h4>${expiryDate}</h4>
                    </div>
                </div>

                <!-- Remaining Days -->
                <div class="col-md-4">
                    <div class="card shadow p-3 card-box">
                        <h5>Remaining Days</h5>
                        <h4>${remainingDays} Days</h4>
                    </div>
                </div>

            </div>

            <!-- Profile Section -->
            <div class="card shadow p-4 mt-4">
                <h5>My Details</h5>
                <p><strong>Name:</strong> ${user.username}</p>
                <p><strong>Email:</strong> ${user.email}</p>
                <p><strong>Phone:</strong> ${user.phone}</p>
            </div>

        </div>

    </div>
</div>

</body>
</html>