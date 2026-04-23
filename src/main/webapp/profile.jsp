<%@ page contentType="text/html; charset=UTF-8" %>

<div class="card-box">
    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
        <h5 class="mb-0">My Profile</h5>
        <span class="badge bg-primary-subtle text-primary">Account</span>
    </div>

    <div class="row g-3">
        <div class="col-md-4">
            <p class="text-muted mb-1">Name</p>
            <p class="mb-0 fw-semibold">${sessionScope.user.username}</p>
        </div>
        <div class="col-md-4">
            <p class="text-muted mb-1">Email</p>
            <p class="mb-0 fw-semibold">${sessionScope.email}</p>
        </div>
        <div class="col-md-4">
            <p class="text-muted mb-1">Phone</p>
            <p class="mb-0 fw-semibold">${sessionScope.user.phone}</p>
        </div>
    </div>

    <a href="#" class="btn btn-outline-primary btn-sm mt-4">Edit Profile</a>
</div>