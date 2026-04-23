import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.UserDAO;

public class Elements extends HttpServlet {
	public void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		UserDAO ud=new UserDAO();
		int totalCount=0;
		totalCount=ud.userCount();
		request.setAttribute("totalUsers", totalCount);
		RequestDispatcher rd = request.getRequestDispatcher("admindashboard.jsp");
	    rd.forward(request, response);
	}
}
