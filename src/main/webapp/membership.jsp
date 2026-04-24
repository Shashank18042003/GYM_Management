<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.model.MembershipDAO, com.model.Membership, com.model.User" %>

<%
String email = (String) session.getAttribute("email");
User sUser = (User) session.getAttribute("user");
if ((email == null || email.trim().isEmpty()) && sUser != null) {
    email = sUser.getEmail();
}

MembershipDAO dao = new MembershipDAO();
Membership m = null;
Integer userId = null;
Object userIdObj = session.getAttribute("userId");
if (userIdObj instanceof Integer) {
    userId = (Integer) userIdObj;
} else if (userIdObj instanceof String) {
    try { userId = Integer.parseInt((String) userIdObj); } catch (Exception ignored) {}
}
if ((userId == null || userId <= 0) && sUser != null && sUser.getId() > 0) {
    userId = sUser.getId();
}

try {
    if(userId != null && userId > 0){
        m = dao.getMembershipByUserId(userId);
    } else if(email != null){
        m = dao.getMembershipByEmail(email);
    }
} catch (Exception ignored) {
    m = null;
}

String status = "NO PLAN";
long days = 0;
long totalDays = 30; // default

if(m != null){
    try {
        java.time.LocalDate today = java.time.LocalDate.now();
        java.sql.Date endDate = m.getEnd_date();
        java.sql.Date startDate = m.getStart_date();
        if (endDate == null || startDate == null) {
            throw new IllegalStateException("Membership dates are missing");
        }
        java.time.LocalDate end = endDate.toLocalDate();
        java.time.LocalDate start = startDate.toLocalDate();

        days = java.time.temporal.ChronoUnit.DAYS.between(today, end);
        totalDays = java.time.temporal.ChronoUnit.DAYS.between(start, end);

        if(days >= 0){
            status = "ACTIVE";
        } else {
            status = "EXPIRED";
        }
    } catch (Exception ignored) {
        status = "NO PLAN";
        days = 0;
        totalDays = 30;
    }
}

int percent = 0;
if(totalDays > 0 && days > 0){
    percent = (int)((days * 100) / totalDays);
}
%>

<!-- HEADER -->
<div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
    <h4 class="fw-bold mb-0">Your Membership</h4>
    <span class="badge bg-primary-subtle text-primary">Status</span>
</div>

<!-- CARD -->
<div class="card-box">

    <!-- STATUS -->
    <div class="text-center mb-4">
        <h6 class="text-muted">Status</h6>

        <h2 class="<%= status.equals("ACTIVE") ? "text-success" : "text-danger" %> fw-bold">
            <%= status %>
        </h2>

        <% if(days >= 0){ %>
            <span class="badge bg-warning-subtle text-dark mt-2">
                <%= days %> days remaining
            </span>
        <% } %>
    </div>

    <!-- PROGRESS BAR -->
    <% if(m != null && days > 0){ %>
    <div class="mb-4">
        <h6 class="text-muted">Membership Progress</h6>

        <div class="progress mt-2">
            <div class="progress-bar bg-success" style="width: <%= percent %>%;">
                <%= percent %>%
            </div>
        </div>
    </div>
    <% } %>

    <!-- DETAILS -->
    <div class="row text-center">

        <div class="col-md-4">
            <p class="text-muted mb-1">Plan</p>
            <strong><%= (m != null) ? m.getPlan_name() : "-" %></strong>
        </div>

        <div class="col-md-4">
            <p class="text-muted mb-1">Start</p>
            <strong><%= (m != null && m.getStart_date() != null) ? m.getStart_date().toLocalDate() : "-" %></strong>
        </div>

        <div class="col-md-4">
            <p class="text-muted mb-1">Expiry</p>
            <strong><%= (m != null && m.getEnd_date() != null) ? m.getEnd_date().toLocalDate() : "-" %></strong>
        </div>

    </div>

    <!-- ACTION -->
    <div class="text-center mt-4">

        <% if(status.equals("ACTIVE")){ %>
            <a href="userdashboard.jsp?page=rechargeplan.jsp" class="btn btn-primary px-4">
                Renew Membership
            </a>
        <% } else { %>
            <a href="userdashboard.jsp?page=rechargeplan.jsp" class="btn btn-danger px-4">
                View Recharge Plans
            </a>
        <% } %>

    </div>

</div>