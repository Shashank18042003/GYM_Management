

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model.User;
import com.model.UserDAO;

public class Login extends HttpServlet {
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		UserDAO ud=new UserDAO();
		User user=ud.login(email,password); 
		int totalCount=0;
		totalCount=ud.userCount();
		if(user!=null)
		{
			HttpSession hs=request.getSession();
			hs.setAttribute("user", user);
			request.setAttribute("totalUsers", totalCount);
			if(email.equals("admin@gmail.com"))
			{

				


				  RequestDispatcher rd = request.getRequestDispatcher("admindashboard.jsp");
				    rd.forward(request, response);

				response.sendRedirect("admindashboard.jsp");
			}
			else {
		        response.sendRedirect("userdashboard.jsp");
		    }
		}
		else {
			response.sendRedirect("login.html");
		}
	}
	

	

}
