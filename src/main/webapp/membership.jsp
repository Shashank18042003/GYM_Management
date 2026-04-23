<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.model.MembershipDAO, com.model.Membership" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Membership</title>

<style>
body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(135deg, #0f172a, #020617);
    color: white;
}

.member-box {
    background: rgba(255,255,255,0.05);
    padding: 20px;
    border-radius: 12px;
    margin-top: 20px;
}

.member-box p {
    margin: 8px 0;
    font-size: 15px;
}

.active {
    color: #22c55e;
    font-weight: bold;
}

.expired {
    color: #ef4444;
    font-weight: bold;
}
</style>

</head>

<body>

<div style="max-width:600px; margin:40px auto;">

<%
String email = (String) session.getAttribute("email");

MembershipDAO dao = new MembershipDAO();
Membership m = null;

if(email != null){
    m = dao.getMembershipByEmail(email);
}

String status = "No Membership";
long days = 0;

if(m != null){

    java.time.LocalDate today = java.time.LocalDate.now();

    // Fix for DATETIME (important)
    String rawDate = m.getEnd_date();
    String cleanDate = rawDate.split(" ")[0];

    java.time.LocalDate end = java.time.LocalDate.parse(cleanDate);

    days = java.time.temporal.ChronoUnit.DAYS.between(today, end);

    if(days >= 0){
        status = "ACTIVE";
    } else {
        status = "EXPIRED";
    }
}
%>

<h3>Membership Details</h3>

<div class="member-box">

<p><strong>Plan:</strong> <%= (m != null) ? m.getPlan_name() : "-" %></p>

<p>
<strong>Status:</strong> 
<span class="<%= status.equals("ACTIVE") ? "active" : "expired" %>">
    <%= status %>
</span>
</p>

<p><strong>Start Date:</strong> <%= (m != null) ? m.getStart_date() : "-" %></p>

<p><strong>Expiry Date:</strong> <%= (m != null) ? m.getEnd_date() : "-" %></p>

<p><strong>Remaining Days:</strong> 
<%= (m != null && days >= 0) ? days : 0 %>
</p>

</div>

</div>

</body>
</html>