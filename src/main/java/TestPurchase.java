import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;

import com.DBconnection.Myjdbc;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class TestPurchase extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		handle(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		handle(request, response);
	}

	private void handle(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("email") == null) {
			response.sendRedirect("login.html");
			return;
		}

		String email = (String) session.getAttribute("email");
		String plan = request.getParameter("plan");
		String amountStr = request.getParameter("amount");
		String daysStr = request.getParameter("days");

		if (plan == null || amountStr == null || daysStr == null) {
			response.sendRedirect("userdashboard.jsp?page=rechargeplan.jsp");
			return;
		}

		double amount;
		int days;
		try {
			amount = Double.parseDouble(amountStr);
			days = Integer.parseInt(daysStr);
		} catch (Exception e) {
			response.sendRedirect("userdashboard.jsp?page=rechargeplan.jsp");
			return;
		}

		LocalDate start = LocalDate.now();
		LocalDate end = start.plusDays(days);

		try (Connection con = Myjdbc.myconn()) {

			// 1) Get user_id by email
			int userId = -1;
			try (PreparedStatement ps = con.prepareStatement("SELECT id FROM gym_users WHERE email=?")) {
				ps.setString(1, email);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) userId = rs.getInt(1);
				}
			}
			if (userId == -1) {
				response.sendRedirect("login.html");
				return;
			}

			// 2) Block if already active membership exists
			try (PreparedStatement ps = con.prepareStatement(
					"SELECT 1 FROM membership WHERE user_id=? AND start_date<=CURDATE() AND end_date>=CURDATE() LIMIT 1")) {
				ps.setInt(1, userId);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						response.sendRedirect("userdashboard.jsp?page=membership.jsp");
						return;
					}
				}
			}

			// 3) Insert payment
			try (PreparedStatement ps = con.prepareStatement(
					"INSERT INTO payments (user_id, amount, payment_date, payment_status, payment_method) "
							+ "VALUES (?, ?, CURDATE(), 'Paid', 'Test')")) {
				ps.setInt(1, userId);
				ps.setDouble(2, amount);
				ps.executeUpdate();
			}

			// 4) Insert membership
			try (PreparedStatement ps = con.prepareStatement(
					"INSERT INTO membership (user_id, plan_name, start_date, end_date, status) "
							+ "VALUES (?, ?, ?, ?, 'ACTIVE')")) {
				ps.setInt(1, userId);
				ps.setString(2, plan);
				ps.setDate(3, java.sql.Date.valueOf(start));
				ps.setDate(4, java.sql.Date.valueOf(end));
				ps.executeUpdate();
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("userdashboard.jsp?page=rechargeplan.jsp");
			return;
		}

		response.sendRedirect("userdashboard.jsp?page=membership.jsp");
	}
}

