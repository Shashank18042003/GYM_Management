import org.json.JSONObject;

import com.model.Membership;
import com.model.MembershipDAO;
import com.model.Payments;
import com.model.PaymentsDAO;
import com.razorpay.Utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/VerifyPayment")
public class VerifyPayment extends HttpServlet {

	private static final String KEY_SECRET = System.getenv().getOrDefault("RAZORPAY_KEY_SECRET", "crmu32isUHthgOSjodbaOMYq");

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/plain");
		res.setCharacterEncoding("UTF-8");

		Object userIdObj = req.getSession().getAttribute("userId");
		Integer userId = null;
		if (userIdObj instanceof Integer) {
			userId = (Integer) userIdObj;
		} else if (userIdObj instanceof String) {
			try {
				userId = Integer.parseInt((String) userIdObj);
			} catch (NumberFormatException ignored) {
				userId = null;
			}
		}
		if (userId == null || userId <= 0) {
			res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			String message = "Session expired. Please login again.";
			req.getSession().setAttribute("flashMessage", message);
			res.getWriter().write(message);
			return;
		}

		try {
			String paymentId = coalesce(req.getParameter("payment_id"), req.getParameter("razorpay_payment_id"));
			String orderId = coalesce(req.getParameter("order_id"), req.getParameter("razorpay_order_id"));
			String signature = coalesce(req.getParameter("signature"), req.getParameter("razorpay_signature"));
			String plan = req.getParameter("plan");
			int amount = Integer.parseInt(req.getParameter("amount"));
			int days = Integer.parseInt(req.getParameter("days"));

			if (isBlank(paymentId) || isBlank(orderId) || isBlank(signature) || isBlank(plan) || amount <= 0 || days <= 0) {
				res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				String message = "Invalid payment request.";
				req.getSession().setAttribute("flashMessage", message);
				res.getWriter().write(message);
				return;
			}

			JSONObject options = new JSONObject();
			options.put("razorpay_order_id", orderId);
			options.put("razorpay_payment_id", paymentId);
			options.put("razorpay_signature", signature);
			boolean validSignature = Utils.verifyPaymentSignature(options, KEY_SECRET);
			if (!validSignature) {
				res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				String message = "Payment verification failed.";
				req.getSession().setAttribute("flashMessage", message);
				res.getWriter().write(message);
				return;
			}

			MembershipDAO membershipDAO = new MembershipDAO();
			if (membershipDAO.hasActivePlan(userId)) {
				String message = "You already have an active membership.";
				req.getSession().setAttribute("flashMessage", message);
				res.getWriter().write(message);
				return;
			}

			Payments payment = new Payments();
			payment.setUserId(userId);
			payment.setAmount(amount);
			payment.setPaymentId(paymentId);
			payment.setOrderId(orderId);
			payment.setStatus("SUCCESS");
			new PaymentsDAO().savePayment(payment);

			LocalDate start = LocalDate.now();
			LocalDate end = start.plusDays(days);
			Membership membership = new Membership();
			membership.setUserId(userId);
			membership.setPlanName(plan);
			membership.setStartDate(java.sql.Date.valueOf(start));
			membership.setEndDate(java.sql.Date.valueOf(end));
			membership.setStatus("ACTIVE");
			membershipDAO.createMembership(membership);

			String message = "Payment successful. Membership activated.";
			req.getSession().setAttribute("flashMessage", message);
			res.getWriter().write(message);
		} catch (NumberFormatException ex) {
			res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			String message = "Invalid plan amount or duration.";
			req.getSession().setAttribute("flashMessage", message);
			res.getWriter().write(message);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			String message = "Unable to complete payment verification.";
			req.getSession().setAttribute("flashMessage", message);
			res.getWriter().write(message);
		}
	}

	private static String coalesce(String first, String second) {
		return isBlank(first) ? second : first;
	}

	private static boolean isBlank(String value) {
		return value == null || value.trim().isEmpty();
	}
}