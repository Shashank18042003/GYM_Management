<%@ page contentType="text/html; charset=UTF-8" %>

<div class="profile-wrapper">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="text-light mb-0">
            <i class="bi bi-person-circle"></i> My Profile
        </h5>

        <button onclick="toggleEdit()" class="btn btn-outline-info btn-sm">
            <i class="bi bi-pencil"></i> Edit
        </button>
    </div>

    <!-- PROFILE DISPLAY -->
    <div class="text-center mb-4">

        <%
        com.model.User sUser = (com.model.User) session.getAttribute("user");
        String pic = (sUser != null) ? sUser.getProfilePic() : null;
        String picPath = "images/default.png";
        if (pic != null && !pic.isBlank()) {
            picPath = "default.png".equalsIgnoreCase(pic) ? "images/default.png" : ("uploads/" + pic);
        }
        String dobValue = "";
        if (sUser != null && sUser.getDob() != null) {
            dobValue = sUser.getDob().toLocalDate().toString();
        }
        %>
        <img src="<%= picPath %>" class="avatar-circle avatar-img" alt="Profile picture">

        <h3 class="fw-bold mt-2 text-white">
            ${sessionScope.user.username}
        </h3>

        <p class="text-muted small">
            Member since: ${sessionScope.user.doj}
        </p>

    </div>

    <!-- EXTRA DETAILS (NO DUPLICATION) -->
    <div class="row text-center mb-4">

        <div class="col-4">
            <p class="label">Age</p>
            <p class="value">${sessionScope.user.age}</p>
        </div>

        <div class="col-4">
            <p class="label">Weight</p>
            <p class="value">${sessionScope.user.weight} kg</p>
        </div>

        <div class="col-4">
            <p class="label">Height</p>
            <p class="value">${sessionScope.user.height} cm</p>
        </div>

    </div>

    <!-- SUCCESS MESSAGE -->
    <%
    String msg = (String) session.getAttribute("msg");
    if ("updated".equals(msg)) {
    %>
        <p class="text-success text-center">Profile updated successfully</p>
    <%
        session.removeAttribute("msg");
    }
    %>

    <!-- ERROR MESSAGE -->
    <%
    String err = request.getParameter("error");
    if ("1".equals(err)) {
    %>
        <p class="text-danger text-center">Wrong current password</p>
    <%
    } else if ("2".equals(err)) {
    %>
        <p class="text-danger text-center">Passwords do not match</p>
    <%
    }
    %>

    <!-- EDIT FORM -->
    <div id="editForm"
         style="<%= (request.getParameter("error") != null || session.getAttribute("msg") != null) ? "display:block;" : "display:none;" %>">

        <form action="UpdateProfile" method="post" enctype="multipart/form-data" class="edit-box">

            <input type="text" name="username"
                   value="${sessionScope.user.username}"
                   class="form-control custom-input mb-2" required>

            <input type="date" name="dob"
                   value="<%= dobValue %>"
                   class="form-control custom-input mb-2">

            <input type="text" name="phone"
                   value="${sessionScope.user.phone}"
                   placeholder="Phone"
                   class="form-control custom-input mb-2">

            <input type="number" name="weight"
                   value="${sessionScope.user.weight}"
                   placeholder="Weight (kg)"
                   class="form-control custom-input mb-2">

            <input type="number" name="height"
                   value="${sessionScope.user.height}"
                   placeholder="Height (cm)"
                   class="form-control custom-input mb-2">

            <textarea name="address" rows="2"
                      placeholder="Address"
                      class="form-control custom-input mb-2">${sessionScope.user.address}</textarea>

            <input type="file" name="profilePic"
                   accept="image/*"
                   class="form-control custom-input mb-2">

            <input type="password" name="currentPassword"
                   placeholder="Current password (only for password change)"
                   class="form-control custom-input mb-2">

            <input type="password" name="newPassword"
                   placeholder="New password (optional)"
                   class="form-control custom-input mb-2">

            <input type="password" name="confirmPassword"
                   placeholder="Confirm password"
                   class="form-control custom-input mb-3">

            <button class="btn btn-success w-100">
                Update Profile
            </button>

            <button type="button" onclick="toggleEdit()"
                    class="btn btn-secondary w-100 mt-2">
                Cancel
            </button>

        </form>
    </div>

</div>

<!-- STYLE -->
<style>
.profile-wrapper {
    max-width: 520px;
    margin: auto;
    padding: 20px;
}

.avatar-circle {
    width: 75px;
    height: 75px;
    border-radius: 50%;
    background: linear-gradient(135deg, #2563eb, #7c3aed);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28px;
    font-weight: bold;
    color: white;
    margin: auto;
    box-shadow: 0 6px 20px rgba(0,0,0,0.5);
}
.avatar-img {
    object-fit: cover;
    border: 2px solid rgba(56, 189, 248, 0.5);
    background: rgba(15, 23, 42, 0.8);
}

.label {
    color: #94a3b8;
    font-size: 12px;
}

.value {
    color: white;
    font-weight: 600;
}

.edit-box {
    padding: 20px;
    border-radius: 14px;
    background: rgba(2,6,23,0.6);
    border: 1px solid rgba(148,163,184,0.2);
}

/* INPUT */
.custom-input {
    background: rgba(255,255,255,0.05);
    border: 1px solid rgba(148,163,184,0.2);
    color: white;
}

.custom-input::placeholder {
    color: #94a3b8;
}

.custom-input:focus {
    border-color: #38bdf8;
    box-shadow: 0 0 0 0.2rem rgba(56,189,248,0.2);
}
</style>

<!-- SCRIPT -->
<script>
function toggleEdit(){
    let f = document.getElementById("editForm");
    f.style.display = (f.style.display === "none" || f.style.display === "")
        ? "block"
        : "none";
}
</script>