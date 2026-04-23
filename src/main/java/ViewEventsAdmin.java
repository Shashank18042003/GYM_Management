import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.EventDAO;
import com.model.EventData;

public class ViewEventsAdmin extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	EventDAO ed=new EventDAO();
        List<EventData> events = ed.viewEvent();
       
        request.setAttribute("events", events);
        RequestDispatcher rd = request.getRequestDispatcher("adminevents.jsp");
        rd.forward(request, response);
    }
}