import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.User;
import com.model.UserDAO;

public class Fetch extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        int id=0;

        PrintWriter out = response.getWriter();

        UserDAO uDao = new UserDAO();
        Vector<User> users = uDao.fetch();

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>User Details</title>");
        out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css' rel='stylesheet'>");
        out.println("</head>");

        out.println("<body class='bg-light'>");

        out.println("<div class='container mt-5'>");

        out.println("<h2 class='text-center mb-4'>User Details</h2>");

        out.println("<table class='table table-bordered table-hover shadow'>");

        // Table Header
        out.println("<thead class='table-dark'>");
        out.println("<tr>");
        out.println("<th>Username</th>");
        out.println("<th>Email</th>");
        out.println("<th>Password</th>");
        out.println("<th>Age</th>");
        out.println("<th>Gender</th>");
        out.println("<th>Phone</th>");
        out.println("<th>Address</th>");
        out.println("<th>Weight</th>");
        out.println("<th>Height</th>");
        out.println("<th>Date of Joining</th>");
        out.println("<th>Actions</th>");
        out.println("</tr>");
        out.println("</thead>");

        out.println("<tbody>");

        // 🔥 FIXED LOOP
        for (User hs : users) {

            out.println("<tr>");

            out.println("<td>" + hs.getUsername() + "</td>");
            out.println("<td>" + hs.getEmail() + "</td>");
            out.println("<td>" + hs.getPassword() + "</td>");
            out.println("<td>" + hs.getAge() + "</td>");
            out.println("<td>" + hs.getGender() + "</td>");
            out.println("<td>" + hs.getPhone() + "</td>");
            out.println("<td>" + hs.getAddress() + "</td>");
            out.println("<td>" + hs.getWeight() + "</td>");
            out.println("<td>" + hs.getHeight() + "</td>");
            out.println("<td>" + hs.getDoj() + "</td>");
            
            out.println("<td>");

         // Delete Button
         out.println("<form action='Delete' method='post' style='display:inline;'>");
         out.println("<input type='hidden' name='email' value='" + hs.getEmail() + "'>");
         out.println("<button class='btn btn-danger btn-sm'>Delete</button>");
         out.println("</form>");

         // Update Button
         out.println("<form action='Update' method='get' style='display:inline;margin-left:10px;'>");
         out.println("<input type='hidden' name='email' value='" + hs.getEmail() + "'>");
         out.println("<button class='btn btn-primary btn-sm'>Update</button>");
         out.println("</form>");

         out.println("</td>");

            out.println("</tr>");
        }

        out.println("</tbody>");
        out.println("</table>");

        out.println("<div class='text-center mt-3'>");
        out.println("<a href='Elements' class='btn btn-secondary'>Back</a>");
        out.println("</div>");

        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }
}