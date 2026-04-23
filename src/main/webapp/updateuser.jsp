<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ page import="com.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Update User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: radial-gradient(circle at 12% 10%, rgba(56, 189, 248, 0.18), transparent 30%),
                        radial-gradient(circle at 88% 10%, rgba(99, 102, 241, 0.14), transparent 28%),
                        linear-gradient(145deg, #050b18, #0b1220 58%, #111827);
            color: #e5e7eb;
            -ms-overflow-style: none;  /* IE/Edge */
            scrollbar-width: none;     /* Firefox */
        }
        body::-webkit-scrollbar { width: 0; height: 0; } /* Chrome/Safari */
        * {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
        *::-webkit-scrollbar { width: 0; height: 0; }
        .page-wrap {
            max-width: 980px;
            margin: 18px auto;
            padding: 0 12px;
        }
        .form-card {
            border-radius: 20px;
            border: 1px solid rgba(148,163,184,0.25);
            background: linear-gradient(160deg, rgba(30,41,59,0.78), rgba(15,23,42,0.68));
            box-shadow: 0 18px 36px rgba(2, 6, 23, 0.42);
        }
        .header-chip {
            display: inline-block;
            padding: 6px 10px;
            font-size: 12px;
            border-radius: 999px;
            color: #dbeafe;
            border: 1px solid rgba(96, 165, 250, 0.42);
            background: rgba(37, 99, 235, 0.18);
        }
        label { color: rgba(226,232,240,0.96); font-weight: 600; margin-bottom: 6px; font-size: 14px; }
        .form-control, .form-select {
            background: rgba(2,6,23,0.45);
            border: 1px solid rgba(148,163,184,0.26);
            color: #e2e8f0;
            border-radius: 12px;
            min-height: 42px;
        }
        .form-control:focus, .form-select:focus {
            box-shadow: 0 0 0 .2rem rgba(59,130,246,0.20);
            border-color: rgba(96,165,250,0.56);
        }
        .form-control[readonly] {
            background: rgba(15,23,42,0.72);
            color: #93c5fd;
        }
        .title { font-weight: 800; color: #f8fafc; letter-spacing: 0.01em; }
        .subtitle { color: rgba(148,163,184,.95); }
        .btn-update {
            background: linear-gradient(120deg, #2563eb, #4f46e5);
            border: 0;
            border-radius: 12px;
            font-weight: 800;
            min-height: 44px;
            letter-spacing: 0.01em;
        }
        .btn-outline-secondary {
            border-color: rgba(148,163,184,0.42);
            color: rgba(226,232,240,0.9);
            border-radius: 10px;
        }
        .btn-outline-secondary:hover {
            color: #fff;
            background: rgba(148,163,184,0.16);
            border-color: rgba(148,163,184,0.5);
        }
        .field-group {
            padding: 12px;
            border-radius: 14px;
            border: 1px solid rgba(148,163,184,0.18);
            background: rgba(15, 23, 42, 0.36);
        }
        @media (max-width: 768px) {
            .page-wrap { margin: 10px auto; padding: 0 8px; }
            .form-card { border-radius: 14px; }
            .field-group { padding: 10px; }
        }
        @media (max-height: 800px) {
            .page-wrap { margin: 10px auto; }
            .form-card { padding: 1rem !important; }
            .title { font-size: 1.55rem; }
            .subtitle { margin-bottom: 0.9rem !important; }
            .btn-update { margin-top: 0.9rem !important; }
        }
    </style>
</head>
<body>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
%>
    <div class="container py-5 text-center">
        <h4>User not found</h4>
        <a href="Fetch" class="btn btn-outline-light mt-3">Back</a>
    </div>
<%
    } else {
%>
<div class="page-wrap">
<div class="card shadow p-4 form-card">
    <div class="d-flex justify-content-between align-items-center mb-2">
        <span class="header-chip">Admin / Update User</span>
        <a href="Fetch" class="btn btn-outline-secondary btn-sm">← Back</a>
    </div>

    <h3 class="text-center mb-1 title">Update User</h3>
    <p class="text-center mb-4 subtitle">Edit user profile details</p>

    <form action="Update" method="post">
        <input type="hidden" name="email" value="<%= user.getEmail() %>">
        <div class="row g-3">
            <div class="col-12 col-md-6 field-group">
                <label>Username</label>
                <input type="text" class="form-control" name="username" value="<%= user.getUsername() %>" required>
            </div>

            <div class="col-12 col-md-6 field-group">
                <label>Email</label>
                <input type="email" class="form-control" value="<%= user.getEmail() %>" readonly>
            </div>

            <div class="col-12 col-md-6 field-group">
                <label>Password</label>
                <input type="password" class="form-control" name="password" value="<%= user.getPassword() %>" required>
            </div>

            <div class="col-12 col-md-3 field-group">
                <label>Age</label>
                <input type="number" class="form-control" name="age" value="<%= user.getAge() %>">
            </div>

            <div class="col-12 col-md-3 field-group">
                <label>Gender</label>
                <select class="form-select" name="gender">
                    <option <%= "Male".equals(user.getGender()) ? "selected" : "" %>>Male</option>
                    <option <%= "Female".equals(user.getGender()) ? "selected" : "" %>>Female</option>
                    <option <%= "Other".equals(user.getGender()) ? "selected" : "" %>>Other</option>
                </select>
            </div>

            <div class="col-12 col-md-6 field-group">
                <label>Phone Number</label>
                <input type="text" class="form-control" name="phone" value="<%= user.getPhone() %>">
            </div>

            <div class="col-12 col-md-6 field-group">
                <label>Weight (kg)</label>
                <input type="number" class="form-control" name="weight" value="<%= user.getWeight() %>">
            </div>

            <div class="col-12 col-md-6 field-group">
                <label>Height (cm)</label>
                <input type="number" class="form-control" name="height" value="<%= user.getHeight() %>">
            </div>

            <div class="col-12 col-md-6 field-group">
                <label>Date of Joining</label>
                <input type="date" class="form-control" name="doj" value="<%= user.getDoj() %>">
            </div>

            <div class="col-12 field-group">
                <label>Address</label>
                <textarea class="form-control" name="address" rows="3"><%= user.getAddress() %></textarea>
            </div>
        </div>

        <button class="btn btn-update text-white w-100 mt-4">Update</button>
    </form>
</div>
</div>
<%
    }
%>
</body>
</html>

