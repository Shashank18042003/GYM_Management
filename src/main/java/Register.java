

import java.io.IOException;

import com.model.User;
import com.model.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Register extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String username=request.getParameter("username");
	String email=request.getParameter("email");
	String password=request.getParameter("password");
	int age =Integer.parseInt(request.getParameter("age"));
	String gender=request.getParameter("gender");
	String phone=request.getParameter("phone");
	String address=request.getParameter("address");
	int weight=Integer.parseInt(request.getParameter("weight"));
	int height=Integer.parseInt(request.getParameter("height"));
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

	// 🔥 go back to dashboard with same page
	request.getRequestDispatcher("admindashboard.jsp?page=userregister.jsp")
	       .forward(request, response);
	
	}

}
