

import java.io.IOException;
import java.net.Authenticator.RequestorType;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.User;
import com.model.UserDAO;

public class Delete extends HttpServlet {
	
	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		String email = request.getParameter("email");
		UserDAO ud=new UserDAO();
		ud.delete(email);
		response.sendRedirect("Fetch");
	}
}
