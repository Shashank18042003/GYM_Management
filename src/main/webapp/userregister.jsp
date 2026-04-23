<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: radial-gradient(circle at 15% 10%, rgba(59, 130, 246, 0.18), transparent 30%),
                        radial-gradient(circle at 85% 10%, rgba(167, 139, 250, 0.14), transparent 28%),
                        linear-gradient(145deg, #0b1220, #0f172a 55%, #111827);
            color: #e2e8f0;
        }
        .form-card {
            max-width: 760px;
            margin: 40px auto;
            border-radius: 18px;
            border: 1px solid rgba(148, 163, 184, 0.22);
            background: linear-gradient(160deg, rgba(30, 41, 59, 0.74), rgba(15, 23, 42, 0.64));
        }
        h3 { color: #f8fafc; }
        .subtle { color: rgba(226, 232, 240, 0.78) !important; }
        label { color: rgba(226, 232, 240, 0.92); font-weight: 600; }
        .form-control, .form-select {
            background: rgba(2, 6, 23, 0.35);
            border: 1px solid rgba(148, 163, 184, 0.22);
            color: #e2e8f0;
            border-radius: 12px;
        }
        .form-control::placeholder { color: rgba(148, 163, 184, 0.85); }
        .form-select { color: rgba(226, 232, 240, 0.92); }
        .form-select option { color: #0f172a; }
        .form-control:focus, .form-select:focus {
            box-shadow: 0 0 0 .2rem rgba(59, 130, 246, 0.18);
            border-color: rgba(59, 130, 246, 0.5);
        }
        .btn-success {
            background: linear-gradient(120deg, #22c55e, #16a34a);
            border: 0;
            border-radius: 12px;
            font-weight: 800;
        }
        .btn-outline-secondary {
            border-color: rgba(148, 163, 184, 0.35);
            color: rgba(226, 232, 240, 0.9);
        }
    </style>
</head>

<body>

<div class="card shadow p-4 form-card">

<%
HttpSession hs = request.getSession(false);
boolean isEmbeddedInAdmin = request.getRequestURI() != null && request.getRequestURI().contains("admindashboard.jsp");
if(!isEmbeddedInAdmin){
    String p = request.getParameter("page");
    if(p != null && p.equalsIgnoreCase("userregister.jsp")){
        isEmbeddedInAdmin = true;
    }
}

if(hs != null && hs.getAttribute("userId") != null){
%>

<!-- Logged-in (admin view) -->

<%
} else {
%>

<!-- Not logged-in (public view) -->

<%
}
%>
  
    <h3 class="text-center mb-1 fw-bold">Create Account</h3>
    <p class="text-center subtle mb-4">
        Join the gym system
    </p>

    <!-- OPTIONAL: success message -->
    <%
        String msg = (String) request.getAttribute("msg");
        if(msg != null){
    %>
        <div class="alert alert-success"><%= msg %></div>
    <%
        }
    %>

    <form action="Register" method="post">
        <div class="row g-3">
            <div class="col-12 col-md-6">
                <label>Username</label>
                <input type="text" class="form-control" name="username" required>
            </div>

            <div class="col-12 col-md-6">
                <label>Email</label>
                <input type="email" class="form-control" name="email" required>
            </div>

            <div class="col-12 col-md-6">
                <label>Password</label>
                <input type="password" class="form-control" name="password" required>
            </div>

            <div class="col-12 col-md-3">
                <label>Age</label>
                <input type="number" class="form-control" name="age">
            </div>

            <div class="col-12 col-md-3">
                <label>Gender</label>
                <select class="form-select" name="gender">
                    <option value="">Select</option>
                    <option>Male</option>
                    <option>Female</option>
                    <option>Other</option>
                </select>
            </div>

            <div class="col-12 col-md-6">
                <label>Phone Number</label>
                <input type="text" class="form-control" name="phone">
            </div>

            <div class="col-12 col-md-6">
                <label>Weight (kg)</label>
                <input type="number" class="form-control" name="weight">
            </div>

            <div class="col-12 col-md-6">
                <label>Height (cm)</label>
                <input type="number" class="form-control" name="height">
            </div>

            <div class="col-12 col-md-6">
                <label>Date of Joining</label>
                <input type="date" class="form-control" name="doj">
            </div>

            <div class="col-12">
                <label>Address</label>
                <textarea class="form-control" name="address" rows="3"></textarea>
            </div>
        </div>

        <button class="btn btn-success w-100 mt-4">Register</button>

        <%
            // Show login link only for public registration page (not inside admin dashboard)
            if(hs == null || hs.getAttribute("userId") == null){
                if(!isEmbeddedInAdmin){
        %>
            <div class="text-center mt-3">
                <a href="login.html" class="btn btn-link p-0" style="color: rgba(191,219,254,.95); text-decoration: none;">
                    Already have an account? Login
                </a>
            </div>
        <%
                }
            }
        %>
    </form>

</div>

</body>
</html>