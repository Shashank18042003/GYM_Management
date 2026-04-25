package com.gym.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Date;

import com.gym.dao.UserDAO;
import com.gym.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig
public class UpdateProfile extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            response.sendRedirect("login.html");
            return;
        }

        String username = request.getParameter("username");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirm = request.getParameter("confirmPassword");
        String dobStr = request.getParameter("dob");
        String weightStr = request.getParameter("weight");
        String heightStr = request.getParameter("height");

        UserDAO dao = new UserDAO();

        User existing = (User) session.getAttribute("user");
        if (existing == null) {
            existing = dao.getUserByEmail(email);
            if (existing == null) {
                response.sendRedirect("login.html");
                return;
            }
        }

        String finalPassword = existing.getPassword();
        boolean wantsPasswordChange = newPassword != null && !newPassword.isBlank();

        if (wantsPasswordChange) {
            if (confirm == null || !newPassword.equals(confirm)) {
                response.sendRedirect("userdashboard.jsp?page=profile.jsp&error=2");
                return;
            }
            User auth = dao.login(email, currentPassword);
            if (auth == null) {
                response.sendRedirect("userdashboard.jsp?page=profile.jsp&error=1");
                return;
            }
            finalPassword = newPassword;
        }

        int weight = 0;
        int height = 0;
        Date dob = null;
        try { weight = (weightStr == null || weightStr.isBlank()) ? 0 : Integer.parseInt(weightStr); } catch (Exception ignored) {}
        try { height = (heightStr == null || heightStr.isBlank()) ? 0 : Integer.parseInt(heightStr); } catch (Exception ignored) {}
        try { dob = (dobStr == null || dobStr.isBlank()) ? null : Date.valueOf(dobStr); } catch (Exception ignored) {}

        String profilePic = existing.getProfilePic();
        Part filePart = request.getPart("profilePic");
        if (filePart != null && filePart.getSize() > 0) {
            String originalName = filePart.getSubmittedFileName();
            String fileName = System.currentTimeMillis() + "_" + originalName;
            String uploadPath = getServletContext().getRealPath("/") + "uploads";
            File dir = new File(uploadPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            filePart.write(uploadPath + File.separator + fileName);
            profilePic = fileName;
        }

        User u = new User();
        u.setEmail(email);
        u.setUsername(username);
        u.setPassword(finalPassword);
        u.setDob(dob);
        u.setPhone(phone);
        u.setAddress(address);
        u.setWeight(weight);
        u.setHeight(height);
        u.setProfilePic(profilePic);

        dao.updateUserProfile(u);

        // update session
        existing.setUsername(username);
        existing.setPassword(finalPassword);
        existing.setDob(dob);
        existing.setPhone(phone);
        existing.setAddress(address);
        existing.setWeight(weight);
        existing.setHeight(height);
        existing.setProfilePic(profilePic);
        session.setAttribute("user", existing);

        session.setAttribute("msg", "updated");

        response.sendRedirect("userdashboard.jsp?page=profile.jsp");
    }
}