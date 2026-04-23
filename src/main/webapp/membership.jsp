<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.model.MembershipDAO, com.model.Membership" %>

<%
String email = (String) session.getAttribute("email");

MembershipDAO dao = new MembershipDAO();
Membership m = null;

if(email != null){
    m = dao.getMembershipByEmail(email);
}

String status = "NO PLAN";
long days = 0;
long totalDays = 30; // default

if(m != null){

    java.time.LocalDate today = java.time.LocalDate.now();

    String rawDate = m.getEnd_date();
    String cleanDate = rawDate.split(" ")[0];

    java.time.LocalDate end = java.time.LocalDate.parse(cleanDate);

    String rawStart = m.getStart_date();
    String cleanStart = rawStart.split(" ")[0];

    java.time.LocalDate start = java.time.LocalDate.parse(cleanStart);

    days = java.time.temporal.ChronoUnit.DAYS.between(today, end);
    totalDays = java.time.temporal.ChronoUnit.DAYS.between(start, end);

    if(days >= 0){
        status = "ACTIVE";
    } else {
        status = "EXPIRED";
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
            <strong><%= (m != null) ? m.getStart_date() : "-" %></strong>
        </div>

        <div class="col-md-4">
            <p class="text-muted mb-1">Expiry</p>
            <strong><%= (m != null) ? m.getEnd_date() : "-" %></strong>
        </div>

    </div>

    <!-- ACTION -->
    <div class="text-center mt-4">

        <% if(status.equals("ACTIVE")){ %>
            <a href="userdashboard.jsp?page=rechargeplan.jsp" class="btn btn-primary px-4">
                Renew Membership
            </a>
        <% } else { %>
            <a href="RenewPlan" class="btn btn-danger px-4">
                Activate Plan
            </a>
        <% } %>

    </div>

</div>