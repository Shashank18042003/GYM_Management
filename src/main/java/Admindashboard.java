import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.model.UserDAO;

public class Admindashboard extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔥 DO NOT create new session
        HttpSession hs = request.getSession(false);

        // 🔥 Check session properly
        if (hs == null || hs.getAttribute("userId") == null) {
            response.sendRedirect("login.html");
            return;
        }

       

            UserDAO ud = new UserDAO();
            int totalCount = ud.userCount();

            hs.setAttribute("totalUsers", totalCount);

            RequestDispatcher rd = request.getRequestDispatcher("admindashboard.jsp");
            rd.forward(request, response);

    }
}