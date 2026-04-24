<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Registration</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: linear-gradient(145deg,#0b1220,#0f172a,#111827);
    color: #e2e8f0;
}

.form-card {
    max-width: 760px;
    margin: 40px auto;
    padding: 30px;
    border-radius: 18px;
    background: rgba(15,23,42,0.95);
    border: 1px solid rgba(148,163,184,0.25);
}

h3 { color: #f8fafc; }
.subtle { color: #94a3b8; }

label {
    color: #e2e8f0;
    font-weight: 600;
}

.form-control, .form-select {
    background: rgba(2,6,23,0.85);
    border: 1px solid rgba(148,163,184,0.35);
    color: #ffffff;
    border-radius: 12px;
}

.form-control::placeholder {
    color: #94a3b8;
}

.form-control:focus, .form-select:focus {
    border-color: #38bdf8;
    box-shadow: 0 0 0 0.2rem rgba(56,189,248,0.2);
}

.btn-success {
    background: linear-gradient(120deg,#22c55e,#16a34a);
    border: none;
    font-weight: 700;
    border-radius: 12px;
}

.preview-img {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid #38bdf8;
}
</style>
</head>

<body>

<div class="card shadow form-card">

<%
HttpSession hs = request.getSession(false);
boolean isEmbeddedInAdmin = request.getRequestURI() != null &&
                             request.getRequestURI().contains("admindashboard.jsp");

if(!isEmbeddedInAdmin){
    String p = request.getParameter("page");
    if(p != null && p.equalsIgnoreCase("userregister.jsp")){
        isEmbeddedInAdmin = true;
    }
}
%>

<h3 class="text-center mb-2 fw-bold">Create Account</h3>
<p class="text-center subtle mb-4">Join the gym system</p>

<!-- MESSAGE -->
<%
String msg = (String) request.getAttribute("msg");
if(msg != null){
%>
<div class="alert alert-info text-center"><%= msg %></div>
<%
}
%>

<form action="Register" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">

<div class="row g-3">

<!-- PROFILE PIC -->
<div class="col-12 text-center mb-3">
    <img id="previewImg"
         src="https://cdn-icons-png.flaticon.com/512/149/149071.png"
         class="preview-img">

    <input type="file" name="profilePic"
           class="form-control mt-3"
           accept="image/*"
           onchange="previewImage(event)">
</div>

<div class="col-md-6">
<label>Username</label>
<input type="text" class="form-control" name="username" required>
</div>

<div class="col-md-6">
<label>Email</label>
<input type="email" class="form-control" name="email" required>
</div>

<div class="col-md-6">
<label>Password</label>
<input type="password" id="pass" class="form-control" name="password" required>
</div>

<div class="col-md-6">
<label>Confirm Password</label>
<input type="password" id="cpass" class="form-control" name="confirmPassword" required>
</div>

<div class="col-md-6">
<label>Date of Birth</label>
<input type="date" class="form-control" name="dob" required>
</div>

<div class="col-md-6">
<label>Gender</label>
<select class="form-select" name="gender">
<option value="">Select</option>
<option>Male</option>
<option>Female</option>
<option>Other</option>
</select>
</div>

<div class="col-md-6">
<label>Phone</label>
<input type="text" class="form-control" name="phone">
</div>

<div class="col-md-6">
<label>Weight (kg)</label>
<input type="number" class="form-control" name="weight">
</div>

<div class="col-md-6">
<label>Height (cm)</label>
<input type="number" class="form-control" name="height">
</div>

<div class="col-12">
<label>Address</label>
<textarea class="form-control" name="address" rows="3"></textarea>
</div>

</div>

<button class="btn btn-success w-100 mt-4">Register</button>

<!-- LOGIN LINK LOGIC -->
<%
if(hs == null || hs.getAttribute("userId") == null){
    if(!isEmbeddedInAdmin){
%>
<div class="text-center mt-3">
<a href="login.html" style="color:#93c5fd; text-decoration:none;">
Already have an account? Login
</a>
</div>
<%
    }
}
%>

</form>
</div>

<!-- JS -->
<script>
function validateForm(){
    let p = document.getElementById("pass").value;
    let c = document.getElementById("cpass").value;

    if(p !== c){
        alert("Passwords do not match ❌");
        return false;
    }
    return true;
}

function previewImage(event){
    const file = event.target.files[0];
    if(file){
        const reader = new FileReader();
        reader.onload = function(e){
            document.getElementById("previewImg").src = e.target.result;
        }
        reader.readAsDataURL(file);
    }
}
</script>

</body>
</html>