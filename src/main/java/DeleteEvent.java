import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.EventDAO;

public class DeleteEvent extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        
    	int id = Integer.parseInt(request.getParameter("id"));
    	EventDAO eDao=new EventDAO();
    	eDao.deleteEvent(id);
        response.sendRedirect("ViewEventsAdmin");
    }
}