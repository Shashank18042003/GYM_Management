import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.EventDAO;

public class UserDashboard extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        EventDAO ed=new EventDAO();
        boolean hasNew = ed.countNotification();
        request.setAttribute("hasNew", hasNew);

        RequestDispatcher rd = request.getRequestDispatcher("userdashboard.jsp");
        rd.forward(request, response);
    }
}