<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.Vector, com.model.AdminUserRow" %>

<div class="container">

    <h3 class="mb-3">User Details</h3>

    <table class="table table-bordered table-hover">

      <tr class="table-dark">
    <th>Username</th>
    <th>Email</th>
    <th>Phone</th>

    <th>Plan</th>
    <th>Start Date</th>
    <th>End Date</th>

    <th>Status</th>
    <th>Days Left</th>

    <th>Actions</th>
</tr>

<%
Vector<AdminUserRow> users = (Vector<AdminUserRow>) request.getAttribute("users");

if(users != null){
    for(AdminUserRow u : users){
%>

<tr>
    <td><%= u.getUsername() %></td>
    <td><%= u.getEmail() %></td>
    <td><%= u.getPhone() %></td>

    <!-- 🔥 Membership Info -->
    <td><%= (u.getPlanName() == null || u.getPlanName().isBlank()) ? "-" : u.getPlanName() %></td>
    <td><%= (u.getStartDate() == null || u.getStartDate().isBlank()) ? "-" : u.getStartDate() %></td>
    <td><%= (u.getEndDate() == null || u.getEndDate().isBlank()) ? "-" : u.getEndDate() %></td>

    <!-- 🔥 Status -->
    <td>
        <%
            String st = (u.getMembershipStatus() == null) ? "NO PLAN" : u.getMembershipStatus();
            String badgeCls = "bg-secondary";
            if("ACTIVE".equalsIgnoreCase(st)) badgeCls = "bg-success";
            else if("EXPIRED".equalsIgnoreCase(st)) badgeCls = "bg-danger";
        %>
        <span class="badge <%= badgeCls %>"><%= st %></span>
    </td>

    <td>
        <%= "NO PLAN".equalsIgnoreCase(st) ? "-" : u.getDaysLeft() %>
    </td>

    <td>
        <form id="deleteForm_<%= u.getEmail() %>" action="Delete" method="post" style="display:inline;">
    
    <input type="hidden" name="email" value="<%= u.getEmail() %>">

    <button type="button"
            onclick="confirmDelete('<%= u.getEmail() %>')"
            class="btn btn-danger btn-sm">
        Delete
    </button>
</form>

        <form action="Update" method="get" style="display:inline;">
            <input type="hidden" name="email" value="<%= u.getEmail() %>">
            <button class="btn btn-warning btn-sm">Edit</button>
        </form>

        <!-- Online purchase flow: no manual membership actions needed -->
    </td>
</tr>
<%
    }
}
%>
    </table>

</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
function confirmDelete(email){
    Swal.fire({
        title: 'Are you sure?',
        text: "This user will be deleted!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, delete!'
    }).then((result) => {
        if (result.isConfirmed) {
            document.getElementById("deleteForm_" + email).submit();
        }
    });
}
</script>