import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.User;
import com.model.UserDAO;

public class Update extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	String email = request.getParameter("email");

    	UserDAO dao = new UserDAO();
    	
    	User user = dao.getUserByEmail(email);

    	response.setContentType("text/html");
    	PrintWriter out = response.getWriter();

    	if (user != null) {

    		out.println("<!DOCTYPE html>");
    		out.println("<html lang='en'>");

    		out.println("<head>");
    		out.println("<meta charset='UTF-8'>");
    		out.println("<title>Update User</title>");
    		out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>");

    		out.println("<style>");
    		out.println("body { background-color: #f8f9fa; }");
    		out.println(".form-card { max-width: 600px; margin: auto; margin-top: 40px; border-radius: 10px; }");
    		out.println("</style>");
    		out.println("</head>");

    		out.println("<body>");

    		out.println("<div class='card shadow p-4 form-card'>");

    		// Back Button
    		out.println("<div class='d-flex justify-content-end mb-2'>");
    		out.println("<a href='Fetch' class='btn btn-outline-secondary btn-sm'> ← Back</a>");
    		out.println("</div>");

    		out.println("<h3 class='text-center mb-4'>Update User</h3>");

    		out.println("<form action='Update' method='post'>");

    		// 🔥 Hidden Email (important for update)
    		out.println("<input type='hidden' name='email' value='" + user.getEmail() + "'>");

    		// Username
    		out.println("<div class='mb-3'>");
    		out.println("<label>Username</label>");
    		out.println("<input type='text' class='form-control' name='username' value='" + user.getUsername() + "' required>");
    		out.println("</div>");

    		// Email (readonly)
    		out.println("<div class='mb-3'>");
    		out.println("<label>Email</label>");
    		out.println("<input type='email' class='form-control' value='" + user.getEmail() + "' readonly>");
    		out.println("</div>");

    		// Password
    		out.println("<div class='mb-3'>");
    		out.println("<label>Password</label>");
    		out.println("<input type='password' class='form-control' name='password' value='" + user.getPassword() + "' required>");
    		out.println("</div>");

    		// Age
    		out.println("<div class='mb-3'>");
    		out.println("<label>Age</label>");
    		out.println("<input type='number' class='form-control' name='age' value='" + user.getAge() + "'>");
    		out.println("</div>");

    		// Gender
    		out.println("<div class='mb-3'>");
    		out.println("<label>Gender</label>");
    		out.println("<select class='form-control' name='gender'>");
    		out.println("<option " + ("Male".equals(user.getGender()) ? "selected" : "") + ">Male</option>");
    		out.println("<option " + ("Female".equals(user.getGender()) ? "selected" : "") + ">Female</option>");
    		out.println("<option " + ("Other".equals(user.getGender()) ? "selected" : "") + ">Other</option>");
    		out.println("</select>");
    		out.println("</div>");

    		// Phone
    		out.println("<div class='mb-3'>");
    		out.println("<label>Phone Number</label>");
    		out.println("<input type='text' class='form-control' name='phone' value='" + user.getPhone() + "'>");
    		out.println("</div>");

    		// Address
    		out.println("<div class='mb-3'>");
    		out.println("<label>Address</label>");
    		out.println("<textarea class='form-control' name='address'>" + user.getAddress() + "</textarea>");
    		out.println("</div>");

    		// Weight
    		out.println("<div class='mb-3'>");
    		out.println("<label>Weight (kg)</label>");
    		out.println("<input type='number' class='form-control' name='weight' value='" + user.getWeight() + "'>");
    		out.println("</div>");

    		// Height
    		out.println("<div class='mb-3'>");
    		out.println("<label>Height (cm)</label>");
    		out.println("<input type='number' class='form-control' name='height' value='" + user.getHeight() + "'>");
    		out.println("</div>");

    		// DOJ
    		out.println("<div class='mb-3'>");
    		out.println("<label>Date of Joining</label>");
    		out.println("<input type='date' class='form-control' name='doj' value='" + user.getDoj() + "'>");
    		out.println("</div>");

    		// Submit
    		out.println("<button class='btn btn-primary w-100'>Update</button>");

    		out.println("</form>");
    		out.println("</div>");

    		out.println("</body>");
    		out.println("</html>");

    	} else {
    	    out.println("User not found");
    	}
    }
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