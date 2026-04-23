<%@ page language="java" contentType="text/html;charset=UTF-8" %>

<div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
    <h4 class="mb-0 fw-bold">Choose Your Plan</h4>
    <span class="badge bg-primary-subtle text-primary">Recharge</span>
</div>

<!-- FILTER -->
<div class="mb-3 d-flex flex-wrap gap-2">
    <button class="btn btn-outline-primary btn-sm" onclick="filter('all')">All</button>
    <button class="btn btn-outline-secondary btn-sm" onclick="filter('monthly')">Monthly</button>
    <button class="btn btn-outline-secondary btn-sm" onclick="filter('quarterly')">Quarterly</button>
    <button class="btn btn-outline-secondary btn-sm" onclick="filter('half')">Half-Year</button>
    <button class="btn btn-outline-secondary btn-sm" onclick="filter('annual')">Annual</button>
</div>

<div class="row g-4">

    <!-- MONTHLY -->
    <div class="col-md-4 plan monthly">
        <div class="plan-card">
            <h6>Monthly</h6>
            <div class="price text-warning">₹1500</div>
            <p>30 Days</p>
            <button class="btn btn-warning w-100 buy-btn" onclick="pay(1500)">Buy</button>
            <form action="TestPurchase" method="post" class="mt-2">
                <input type="hidden" name="plan" value="Monthly">
                <input type="hidden" name="amount" value="1500">
                <input type="hidden" name="days" value="30">
                <button type="submit" class="btn btn-outline-secondary w-100 buy-btn">Test Buy (No Razorpay)</button>
            </form>
        </div>
    </div>

    <!-- QUARTERLY (POPULAR) -->
    <div class="col-md-4 plan quarterly">
        <div class="plan-card plan-popular">
            <div class="tag">Best Value</div>
            <h6>Quarterly</h6>
            <div class="price text-primary">₹4000</div>
            <p>90 Days</p>
            <button class="btn btn-primary w-100 buy-btn" onclick="pay(4000)">Buy</button>
            <form action="TestPurchase" method="post" class="mt-2">
                <input type="hidden" name="plan" value="Quarterly">
                <input type="hidden" name="amount" value="4000">
                <input type="hidden" name="days" value="90">
                <button type="submit" class="btn btn-outline-secondary w-100 buy-btn">Test Buy (No Razorpay)</button>
            </form>
        </div>
    </div>

    <!-- HALF -->
    <div class="col-md-4 plan half">
        <div class="plan-card">
            <h6>Half-Year</h6>
            <div class="price text-info">₹7500</div>
            <p>180 Days</p>
            <button class="btn btn-info w-100 buy-btn" onclick="pay(7500)">Buy</button>
            <form action="TestPurchase" method="post" class="mt-2">
                <input type="hidden" name="plan" value="Half-Year">
                <input type="hidden" name="amount" value="7500">
                <input type="hidden" name="days" value="180">
                <button type="submit" class="btn btn-outline-secondary w-100 buy-btn">Test Buy (No Razorpay)</button>
            </form>
        </div>
    </div>

    <!-- ANNUAL -->
    <div class="col-md-4 plan annual">
        <div class="plan-card">
            <h6>Annual</h6>
            <div class="price text-success">₹10000</div>
            <p>365 Days</p>
            <button class="btn btn-success w-100 buy-btn" onclick="pay(10000)">Buy</button>
            <form action="TestPurchase" method="post" class="mt-2">
                <input type="hidden" name="plan" value="Annual">
                <input type="hidden" name="amount" value="10000">
                <input type="hidden" name="days" value="365">
                <button type="submit" class="btn btn-outline-secondary w-100 buy-btn">Test Buy (No Razorpay)</button>
            </form>
        </div>
    </div>

</div>

<!-- FILTER SCRIPT -->
<script>
function filter(type){
    let plans = document.querySelectorAll(".plan");

    plans.forEach(p => {
        if(type === "all" || p.classList.contains(type)){
            p.style.display = "block";
        } else {
            p.style.display = "none";
        }
    });
}
</script>

<!-- Razorpay -->
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<script>
function pay(amount) {

    fetch("CreateOrder?amount=" + amount)
    .then(res => res.json())
    .then(data => {

        var options = {
            key: "YOUR_KEY_ID",
            amount: data.amount,
            currency: "INR",
            name: "Gym System",
            description: "Membership",
            order_id: data.id,

            handler: function (response) {
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

                alert("Payment Successful");
                location.reload();
            }
        };

        new Razorpay(options).open();
    });
}
</script>