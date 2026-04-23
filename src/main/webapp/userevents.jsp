<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.model.EventData" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Gym Events</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }

        .event-card {
            border-radius: 10px;
        }
    </style>
</head>

<body>

<div class="container mt-5">

    <h3 class="text-center mb-4">Upcoming Events </h3>

    <%
        List<EventData> events = (List<EventData>) request.getAttribute("events");

        if(events == null || events.size() == 0){
    %>

        <!-- No Events -->
        <div class="alert alert-warning text-center">
            No events available right now.
        </div>

    <%
        } else {
            for(EventData e : events){
    %>

        <!-- Event Card -->
        <div class="card shadow p-3 mb-3 event-card">
            <h5 class="mb-2"><%= e.getTitle() %></h5>
            <p class="mb-1"><%= e.getDescription() %></p>
            <small class="text-muted"> Date: <%= e.getDate() %></small>
        </div>

    <%
            }
        }
    %>

    <!-- Back Button -->
    <div class="text-center mt-4">
        <a href="UserDashboard" class="btn btn-secondary">← Back to Dashboard</a>
    </div>

</div>

</body>
</html>