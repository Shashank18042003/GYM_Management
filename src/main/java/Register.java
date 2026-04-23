

import java.io.IOException;

import com.model.User;
import com.model.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Register extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String username=request.getParameter("username");
	String email=request.getParameter("email");
	String password=request.getParameter("password");
	String ageParam = request.getParameter("age");
	int age = (ageParam == null || ageParam.isBlank()) ? 0 : Integer.parseInt(ageParam);
	String gender=request.getParameter("gender");
	String phone=request.getParameter("phone");
	String address=request.getParameter("address");
	String weightParam = request.getParameter("weight");
	String heightParam = request.getParameter("height");
	int weight = (weightParam == null || weightParam.isBlank()) ? 0 : Integer.parseInt(weightParam);
	int height = (heightParam == null || heightParam.isBlank()) ? 0 : Integer.parseInt(heightParam);
	String doj=request.getParameter("doj");
	
	User user=new User();
	user.setUsername(username);
	user.setEmail(email);
	user.setPassword(password);
	user.setAge(age);
	user.setGender(gender);
	user.setPhone(phone);
	user.setAddress(address);
	user.setWeight(weight);
	user.setHeight(height);
	user.setDoj(doj);
	
	UserDAO userDAO=new UserDAO();
	int r=userDAO.register(user);
	if(r > 0)
	{
	    request.setAttribute("msg", "User Registered Successfully ✅");
	
	}

	else
	{
	    request.setAttribute("msg", "User already exists ❌");

	}

	// If admin is logged in, show message inside admin dashboard.
	// Otherwise, this is a public registration: go to success page (or login).
	HttpSession session = request.getSession(false);
	boolean isAdminFlow = false;
	if (session != null && session.getAttribute("userId") != null) {
		Object u = session.getAttribute("user");
		if (u instanceof User) {
			User su = (User) u;
			if (su.getEmail() != null && su.getEmail().equalsIgnoreCase("admin@gmail.com")) {
				isAdminFlow = true;
			}
		}
	}

	if (isAdminFlow) {
		request.getRequestDispatcher("admindashboard.jsp?page=userregister.jsp")
		       .forward(request, response);
	} else {
		if (r > 0) {
			response.sendRedirect("login.html?registered=1");
		} else {
			// re-show the same registration page with message
			request.getRequestDispatcher("userregister.jsp").forward(request, response);
		}
	}
	
	}

}
