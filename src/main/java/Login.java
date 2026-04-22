import java.io.IOException;

import com.model.User;
import com.model.UserDAO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Login extends HttpServlet {
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		UserDAO ud=new UserDAO();
		User user=ud.login(email,password); 

		int totalCount=0;
		totalCount=ud.userCount();

		HttpSession hs=request.getSession();
		

		if(user!=null)
		{
			 hs.setAttribute("email",email);
			 hs.setAttribute("logged_in", true);
			 hs.setAttribute("user", user);
			if(email.equals("admin@gmail.com"))
			{



				
				  RequestDispatcher rd = request.getRequestDispatcher("Admindashboard");

				    rd.forward(request, response);

			
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
