<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.Vector, com.model.Payments, com.model.PaymentsDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payments</title>

<style>

/* Background */
body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(135deg, #0f172a, #020617);
    color: white;
}

/* Container */
.payments-container {
    max-width: 500px;
    margin: 40px auto;
    padding: 20px;
}

/* Title */
.title {
    font-size: 22px;
    font-weight: 600;
    margin-bottom: 20px;
    text-align: center;
}

/* Card */
.payment-card {
    background: rgba(255,255,255,0.05);
    backdrop-filter: blur(12px);
    border-radius: 16px;
    padding: 15px;
    margin-bottom: 12px;
    border: 1px solid rgba(255,255,255,0.1);
    transition: 0.3s;
}

.payment-card:hover {
    transform: translateY(-3px);
}

/* Top Row */
.row-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* Amount */
.amount {
    font-size: 20px;
    font-weight: bold;
}

/* Status */
.status-paid {
    color: #22c55e;
    font-weight: bold;
}

.status-pending {
    color: #ef4444;
    font-weight: bold;
}

/* Details */
.details {
    margin-top: 6px;
    font-size: 14px;
    color: #cbd5f5;
}

/* Method badge */
.method {
    display: inline-block;
    margin-top: 6px;
    font-size: 12px;
    background: rgba(255,255,255,0.1);
    padding: 4px 8px;
    border-radius: 6px;
}

</style>
</head>

<body>

<div class="payments-container">

    <div class="title">💸 Payments</div>


<%
String email = (String) session.getAttribute("email");

PaymentsDAO dao = new PaymentsDAO();
Vector<Payments> payments = dao.getuserdata(email);
%>
<% 
if(payments != null && !payments.isEmpty()){
    for(Payments p : payments){
%>

<div class="payment-card">

    <div class="row-top">
        <div class="amount">&#8377;<%= p.getAmount() %></div>

        <div class="<%= p.getPayment_status().equalsIgnoreCase("Paid") ? "status-paid" : "status-pending" %>">
            <%= p.getPayment_status().toUpperCase() %>
        </div>
    </div>

    <div class="details">
        📅 <%= p.getPayment_date() %><br>
        👤 User ID: <%= p.getUser_id() %>
    </div>

    <div class="details">
        <span class="method">💳 <%= p.getPayment_method() %></span>
    </div>

</div>

<%
    }
} else {
%>

<div style="text-align:center; color:#aaa;">
    No payments found
</div>

<%
}
%>

</div>

</body>
</html>