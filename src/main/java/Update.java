import java.io.IOException;

import com.model.User;
import com.model.UserDAO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Update extends HttpServlet {

    // Show update form using JSP
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	String email = request.getParameter("email");
    	UserDAO dao = new UserDAO();
    	User user = dao.getUserByEmail(email);

    	if (user != null) {
    		request.setAttribute("user", user);
    		RequestDispatcher rd = request.getRequestDispatcher("updateuser.jsp");
    		rd.forward(request, response);
    	} else {
    		response.setContentType("text/plain");
    		response.getWriter().println("User not found");
    	}
    }

    // Update logic
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	String email = request.getParameter("email");

    	User user = new User();
    	user.setEmail(email);
    	user.setUsername(request.getParameter("username"));
    	user.setPassword(request.getParameter("password"));
    	user.setAge(Integer.parseInt(request.getParameter("age")));
    	user.setGender(request.getParameter("gender"));
    	user.setPhone(request.getParameter("phone"));
    	user.setAddress(request.getParameter("address"));
    	user.setWeight(Integer.parseInt(request.getParameter("weight")));
    	user.setHeight(Integer.parseInt(request.getParameter("height")));
    	user.setDoj(request.getParameter("doj"));

    	UserDAO dao = new UserDAO();
    	dao.updateUserByEmail(user);

    	response.sendRedirect("Fetch");
  }
}