import java.io.IOException;
import java.util.List;

import com.model.EventDAO;
import com.model.EventData;
import com.model.MembershipDAO;
import com.model.UserDAO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ViewEventsAdmin extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	EventDAO ed=new EventDAO();
        List<EventData> events = ed.viewEvent();
        HttpSession hs = request.getSession(false);
        if (hs != null && hs.getAttribute("userId") != null) {
            UserDAO ud = new UserDAO();
            MembershipDAO md = new MembershipDAO();
            hs.setAttribute("totalUsers", ud.userCount());
            hs.setAttribute("activeMembers", md.MemberCount());
            hs.setAttribute("eventsCount", ed.Eventcount());
        }
       
        request.setAttribute("events", events);
        RequestDispatcher rd = request.getRequestDispatcher("admindashboard.jsp?page=adminevents.jsp");
        rd.forward(request, response);
    }
}