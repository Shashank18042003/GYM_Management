import java.io.IOException;

import com.model.MembershipDAO;
import com.model.UserDAO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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

       
        	MembershipDAO mb=new MembershipDAO();
        	int memcount=mb.MemberCount();
            UserDAO ud = new UserDAO();
            int totalCount = ud.userCount();

            hs.setAttribute("totalUsers", totalCount);
            hs.setAttribute("activeMembers", memcount);
            RequestDispatcher rd = request.getRequestDispatcher("admindashboard.jsp");
            rd.forward(request, response);

    }
}