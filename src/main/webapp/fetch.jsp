<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.Vector, com.model.User" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Details</title>
    <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css' rel='stylesheet'>
</head>

<body class="bg-light">

<div class="container mt-5">

    <h2 class="text-center mb-4">User Details</h2>

    <table class="table table-bordered table-hover shadow">

        <thead class="table-dark">
        <tr>
            <th>Username</th>
            <th>Email</th>
            <th>Password</th>
            <th>Age</th>
            <th>Gender</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Weight</th>
            <th>Height</th>
            <th>Date of Joining</th>
            <th>Actions</th>
        </tr>
        </thead>

        <tbody>

        <%
            Vector<User> users = (Vector<User>) request.getAttribute("users");

            for(User hs : users){
        %>

        <tr>
            <td><%= hs.getUsername() %></td>
            <td><%= hs.getEmail() %></td>
            <td><%= hs.getPassword() %></td>
            <td><%= hs.getAge() %></td>
            <td><%= hs.getGender() %></td>
            <td><%= hs.getPhone() %></td>
            <td><%= hs.getAddress() %></td>
            <td><%= hs.getWeight() %></td>
            <td><%= hs.getHeight() %></td>
            <td><%= hs.getDoj() %></td>

            <td>
                <!-- Delete -->
                <form action="Delete" method="post" style="display:inline;">
                    <input type="hidden" name="email" value="<%= hs.getEmail() %>">
                    <button class="btn btn-danger btn-sm">Delete</button>
                </form>

                <!-- Update -->
                <form action="Update" method="get" style="display:inline;margin-left:10px;">
                    <input type="hidden" name="email" value="<%= hs.getEmail() %>">
                    <button class="btn btn-primary btn-sm">Update</button>
                </form>
            </td>
        </tr>

        <%
            }
        %>

        </tbody>
    </table>

    <div class="text-center mt-3">
        <a href="Elements" class="btn btn-secondary">Back</a>
    </div>

</div>

</body>
</html>