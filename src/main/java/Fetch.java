import java.io.IOException;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.User;
import com.model.UserDAO;

public class Fetch extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO uDao = new UserDAO();
        Vector<User> users = uDao.fetch();

        request.setAttribute("users", users);

        RequestDispatcher rd = request.getRequestDispatcher("fetch.jsp");
        rd.forward(request, response);
    }}