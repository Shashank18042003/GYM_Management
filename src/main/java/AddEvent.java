import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.EventDAO;
import com.model.EventData;

public class AddEvent extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String date = request.getParameter("date");
        
        if (title == null || description == null || date == null ||
                title.isEmpty() || description.isEmpty() || date.isEmpty()) {
        	response.sendRedirect("addevent.jsp?msg=error");
            return;
            }
        EventData event=new EventData();
        event.setTitle(title);
        event.setDescription(description);
        event.setDate(date);
        
        EventDAO ed=new EventDAO();
        ed.insertEvent(event);
        response.sendRedirect("addevent.jsp?msg=success");
    }
}