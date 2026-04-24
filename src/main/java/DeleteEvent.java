import java.io.IOException;

import com.model.EventDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DeleteEvent extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        
    	int id = Integer.parseInt(request.getParameter("id"));
    	EventDAO eDao=new EventDAO();
    	eDao.deleteEvent(id);
        response.sendRedirect("ViewEventsAdmin");
    }
}