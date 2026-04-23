import java.io.IOException;
import java.util.Vector;

import com.model.AdminUserRow;
import com.model.UserDAO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Fetch extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO dao = new UserDAO();

        // Fetch users from DB
        Vector<AdminUserRow> users = dao.fetch();

        // Send data to JSP
        request.setAttribute("users", users);

        // Forward to JSP
        RequestDispatcher rd = request.getRequestDispatcher("admindashboard.jsp?page=userdetails.jsp");
        rd.forward(request, response);
    }
}