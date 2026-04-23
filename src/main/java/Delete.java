

import java.io.IOException;

import com.model.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Delete extends HttpServlet {
	
	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		String email = request.getParameter("email");
		UserDAO ud=new UserDAO();
		ud.delete(email);
		response.sendRedirect("Fetch");
	}
}