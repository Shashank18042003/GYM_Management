

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.model.UserDAO;

public class Admindashboard extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO ud=new UserDAO();
		int totalCount=0;
		totalCount=ud.userCount();
		HttpSession hs=request.getSession();
		hs.setAttribute("totalUsers", totalCount);
		Boolean logged_in=(Boolean) hs.getAttribute("logged_in");
		if(logged_in)
		{
			RequestDispatcher rd=request.getRequestDispatcher("admindashboard.jsp");
			rd.forward(request, response);
		}
	}

	

}
