import org.json.JSONObject;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CreateOrder")
public class CreateOrder extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res) {

        try {
            int amount = Integer.parseInt(req.getParameter("amount"));

            RazorpayClient client = new RazorpayClient(
                "rzp_test_ShYQR0oAoEClXB",
                "crmu32isUHthgOSjodbaOMYq"   // ⚠️ put correct secret
            );

            JSONObject options = new JSONObject();
            options.put("amount", amount * 100); // convert to paise
            options.put("currency", "INR");

            Order order = client.orders.create(options);

            res.setContentType("application/json");
            res.getWriter().write(order.toString());

        } catch (Exception e) {
            e.printStackTrace();

            try {
                res.setContentType("text/plain");
                res.getWriter().write("ERROR: " + e.getMessage());
            } catch (Exception ignored) {}
        }
    }
}