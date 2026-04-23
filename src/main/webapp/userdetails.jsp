<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.Vector, com.model.User" %>

<div class="container">

    <h3 class="mb-3">User Details</h3>

    <table class="table table-bordered table-hover">

      <tr class="table-dark">
    <th>Username</th>
    <th>Email</th>
    <th>Phone</th>

    <th>Plan</th>        <!-- 🔥 NEW -->
    <th>Start Date</th>  <!-- 🔥 NEW -->
    <th>End Date</th>    <!-- 🔥 NEW -->

    <th>Status</th>
    <th>Last Payment</th> <!-- 🔥 NEW -->

    <th>Actions</th>
</tr>

<%
Vector<User> users = (Vector<User>) request.getAttribute("users");

if(users != null){
    for(User u : users){
%>

<tr>
    <td><%= u.getUsername() %></td>
    <td><%= u.getEmail() %></td>
    <td><%= u.getPhone() %></td>

    <!-- 🔥 Membership Info -->
    <td>Monthly</td> <!-- later dynamic -->
    <td>2026-04-01</td>
    <td>2026-05-01</td>

    <!-- 🔥 Status -->
    <td>
        <span class="badge bg-success">ACTIVE</span>
        <!-- later: EXPIRED / INACTIVE -->
    </td>

    <!-- 🔥 Payment -->
    <td>₹999</td>

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

        <!-- 🔥 NEW -->
        <form action="AssignMembership" method="get" style="display:inline;">
            <input type="hidden" name="email" value="<%= u.getEmail() %>">
            <button class="btn btn-primary btn-sm">Assign</button>
        </form>
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