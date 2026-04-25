<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Registration</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

/* RESET */
*{margin:0;padding:0;box-sizing:border-box;}

html,body{
    height:100vh;
    overflow:hidden;
}

/* BACKGROUND */
body{
    background:url('login.jpg') no-repeat center/cover;
    display:flex;
    justify-content:center;
    align-items:center;
    padding:18px 12px; /* 🔥 more top/bottom balance */
    position:relative;
}

body::before{
    content:"";
    position:absolute;
    inset:0;
    background:rgba(0,0,0,0.65);
}

/* CARD */
.form-card{
    position:relative;
    z-index:1;

    width:90%;
    max-width:640px;
    height:92vh; /* 🔥 reduced from 100vh */

    border-radius:16px;
    background:rgba(15,23,42,0.85);
    backdrop-filter:blur(10px);

    border:1px solid rgba(148,163,184,0.2);
    display:flex;
    flex-direction:column;
}

/* HEADER */
.form-header{
    padding:14px 10px; /* 🔥 better top spacing */
    text-align:center;
}

.form-header h3{
    color:#fff;
    font-size:22px;
    font-weight:700;
}

.form-header p{
    color:#cbd5f5;
    font-size:13px;
}

/* BODY */
.form-body{
    padding:14px; /* 🔥 balanced inner gap */
}

/* GRID */
.form-row{
    display:grid;
    grid-template-columns: 1fr 1fr;
    gap:12px 16px;
}

.full{
    grid-column: span 2;
}

/* SMALL ROW */
.small-row{
    grid-column: span 2;
    display:grid;
    grid-template-columns: repeat(4,1fr);
    gap:10px;
}

/* INPUT */
.form-control,.form-select{
    height:36px;
    font-size:13px;
    padding:5px 10px;

    background:rgba(0,0,0,0.45);
    border:1px solid rgba(148,163,184,0.3);
    color:#fff;
    border-radius:6px;
}

/* SMALL */
.small{
    height:34px;
}

/* TEXTAREA */
textarea.form-control{
    height:60px; /* 🔥 reduced slightly */
}

/* LABEL */
label{
    font-size:13px;
    color:#e2e8f0;
    margin-bottom:3px;
}

/* BUTTON */
.btn-success{
    height:40px;
    font-size:14px;
    margin-top:10px;

    background:linear-gradient(135deg,#1d4ed8,#4f46e5);
    border:none;
    border-radius:8px;
}

/* IMAGE */
.preview-img{
    width:65px;
    height:65px;
    border-radius:50%;
    border:2px solid #3b82f6;
    object-fit:cover;
}

/* LINK */
a{
    font-size:13px;
    color:#93c5fd;
}

</style>
</head>

<body>

<div class="form-card">

<div class="form-header">
<h3>Create Account</h3>
<p>Join the gym system</p>
</div>

<form class="form-body" onsubmit="return validateForm()">

<div class="form-row">

<!-- PROFILE -->
<div class="full text-center">
<img id="previewImg"
     src="https://cdn-icons-png.flaticon.com/512/149/149071.png"
     class="preview-img">

<input type="file"
       class="form-control mt-1"
       accept="image/*"
       onchange="previewImage(event)">
</div>

<!-- BASIC -->
<div>
<label>Username</label>
<input type="text" class="form-control">
</div>

<div>
<label>Email</label>
<input type="email" class="form-control">
</div>

<div>
<label>Password</label>
<input type="password" id="pass" class="form-control">
</div>

<div>
<label>Confirm</label>
<input type="password" id="cpass" class="form-control">
</div>

<!-- SMALL ROW -->
<div class="small-row">

<div>
<label>DOB</label>
<input type="date" class="form-control small">
</div>

<div>
<label>Gender</label>
<select class="form-select small">
<option>Select</option>
<option>Male</option>
<option>Female</option>
</select>
</div>

<div>
<label>Weight</label>
<input type="number" class="form-control small">
</div>

<div>
<label>Height</label>
<input type="number" class="form-control small">
</div>

</div>

<div class="full">
<label>Phone</label>
<input type="text" class="form-control">
</div>

<div class="full">
<label>Address</label>
<textarea class="form-control"></textarea>
</div>

</div>

<button class="btn btn-success w-100">Register</button>

<div class="text-center mt-2">
<a href="login.html">Already have an account? Login</a>
</div>

</form>
</div>

<script>
function previewImage(event){
    const file = event.target.files[0];
    if(file){
        const reader = new FileReader();
        reader.onload = e => document.getElementById("previewImg").src = e.target.result;
        reader.readAsDataURL(file);
    }
}

function validateForm(){
    let p = document.getElementById("pass").value;
    let c = document.getElementById("cpass").value;

    if(p !== c){
        alert("Passwords do not match");
        return false;
    }
    return true;
}
</script>

</body>
</html>