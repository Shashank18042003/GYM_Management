import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.EventDAO;
import com.model.EventData;

public class ViewEventsUser extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EventDAO dao = new EventDAO();

        dao.resetNotification();

        List<EventData> events = dao.viewEvent();

        request.setAttribute("events", events);

        RequestDispatcher rd = request.getRequestDispatcher("userevents.jsp");
        rd.forward(request, response);
    }
}