<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Recharge Plans</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Razorpay -->
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<style>
body {
    background-color: #f1f3f6;
}

/* Sidebar */
.sidebar {
    background: #e9ecef;
    height: 100vh;
    padding: 20px;
}

.sidebar a {
    display: block;
    padding: 10px;
    color: #333;
    text-decoration: none;
    border-radius: 5px;
    margin-bottom: 5px;
}

.sidebar a:hover, .sidebar a.active {
    background: #dcdfe3;
}

/* Plan cards */
.plan-card {
    border-radius: 15px;
    padding: 20px;
    background: #fff;
    transition: 0.3s;
}

.plan-card:hover {
    transform: scale(1.03);
}

.price {
    font-size: 28px;
    font-weight: bold;
}

.buy-btn {
    border-radius: 25px;
}
</style>

</head>

<body>

<div class="container-fluid">
<div class="row">

    <!-- 🔹 Sidebar -->
    <div class="col-md-3 col-lg-2 sidebar">
        <h5>Plan Category</h5>

        <a href="#" class="active" onclick="filterPlans('all', this)">All Plans</a>
        <a href="#" onclick="filterPlans('monthly', this)">Monthly Plans</a>
        <a href="#" onclick="filterPlans('quarterly', this)">Quarterly Plans</a>
        <a href="#" onclick="filterPlans('half', this)">Half-Year Plans</a>
        <a href="#" onclick="filterPlans('annual', this)">Annual Plans</a>
    </div>

    <!-- 🔹 Main Content -->
    <div class="col-md-9 col-lg-10 p-4">

        <h4 class="mb-4">Top Gym Membership Plans</h4>

        <div class="row g-4">

            <!-- Monthly -->
            <div class="col-md-4 plan monthly">
                <div class="plan-card shadow">
                    <h6>Monthly Plan</h6>
                    <div class="price">₹1500</div>
                    <p>Validity: <b>30 Days</b></p>
                    <button class="btn btn-warning w-100 buy-btn" onclick="pay(1500)">Buy</button>
                </div>
            </div>

            <!-- Quarterly -->
            <div class="col-md-4 plan quarterly">
                <div class="plan-card shadow">
                    <h6>Quarterly Plan</h6>
                    <div class="price">₹4000</div>
                    <p>Validity: <b>90 Days</b></p>
                    <button class="btn btn-primary w-100 buy-btn" onclick="pay(4000)">Buy</button>
                </div>
            </div>

            <!-- Half-Year -->
            <div class="col-md-4 plan half">
                <div class="plan-card shadow">
                    <h6>Half-Year Plan</h6>
                    <div class="price">₹7500</div>
                    <p>Validity: <b>180 Days</b></p>
                    <button class="btn btn-primary w-100 buy-btn" onclick="pay(7500)">Buy</button>
                </div>
            </div>

            <!-- Annual -->
            <div class="col-md-4 plan annual">
                <div class="plan-card shadow">
                    <h6>Annual Plan</h6>
                    <div class="price">₹10000</div>
                    <p>Validity: <b>365 Days</b></p>
                    <button class="btn btn-success w-100 buy-btn" onclick="pay(10000)">Buy</button>
                </div>
            </div>

        </div>

    </div>

</div>
</div>

<!-- 🔥 Filter Logic -->
<script>
function filterPlans(type, element) {

    let plans = document.querySelectorAll(".plan");

    plans.forEach(plan => {
        if (type === "all") {
            plan.style.display = "block";
        } else if (plan.classList.contains(type)) {
            plan.style.display = "block";
        } else {
            plan.style.display = "none";
        }
    });

    // Highlight active menu
    document.querySelectorAll(".sidebar a").forEach(link => {
        link.classList.remove("active");
    });

    element.classList.add("active");
}
</script>

<!-- 🔥 Razorpay -->
<script>
function pay(amount) {

    fetch("CreateOrder?amount=" + amount)
    .then(res => res.json())
    .then(data => {

        var options = {
            "key": "YOUR_KEY_ID",
            "amount": data.amount,
            "currency": "INR",
            "name": "Gym System",
            "description": "Membership Recharge",
            "order_id": data.id,

            "handler": function (response) {

                fetch("VerifyPayment", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body:
                        "payment_id=" + response.razorpay_payment_id +
                        "&order_id=" + response.razorpay_order_id +
                        "&signature=" + response.razorpay_signature
                });

                alert("Payment Successful ✅");
                window.location.href = "userdashboard.jsp";
            }
        };

        var rzp = new Razorpay(options);
        rzp.open();
    });
}
</script>

</body>
</html>