<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add Event</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background-color: #f8f9fa;
}

.form-card {
    max-width: 600px;
    margin: auto;
    margin-top: 40px;
    border-radius: 10px;
}
</style>
</head>

<body>

<div class="card shadow p-4 form-card">

    <!-- 🔹 Back Button -->
    <div class="d-flex justify-content-end mb-2">
        <a href="ViewEventsAdmin" class="btn btn-outline-secondary btn-sm">
            ← Back
        </a>
    </div>

    <h3 class="text-center mb-4">Add Event </h3>

    <!-- 🔹 Success Message -->
    <%
        String msg = request.getParameter("msg");
        if(msg != null){
    %>
        <div class="alert alert-success text-center">
            Event Added Successfully 
        </div>
    <%
        }
    %>
    
    

    <!-- 🔹 Form -->
    <form action="AddEvent" method="post">

        <!-- Title -->
        <div class="mb-3">
            <label>Event Title</label>
            <input type="text" class="form-control" name="title" placeholder="Enter event title..." required>
        </div>

        <!-- Description -->
        <div class="mb-3">
            <label>Description</label>
            <textarea class="form-control" name="description" rows="3" placeholder="Write event details..." required></textarea>
        </div>

        <!-- Date -->
        <div class="mb-3">
            <label>Event Date</label>
            <input type="date" class="form-control" name="date" required>
        </div>

        <!-- Submit -->
        <button class="btn btn-success w-100">+ Add Event</button>

    </form>

</div>

</body>
</html>