<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.buscrowd.ConnectionDB" %>

<%
/* ===============================
   USER PASSWORD CHANGE LOGIC
================================ */

if(session.getAttribute("uid")==null){
    response.sendRedirect("user_login.jsp");
    return;
}

int uid = (Integer) session.getAttribute("uid");

String message = "";
String msgType = ""; // success | danger | warning

if ("POST".equalsIgnoreCase(request.getMethod())) {

    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");

    if (!newPassword.equals(confirmPassword)) {
        message = "New passwords do not match.";
        msgType = "warning";
    } else {
        try {
            Connection con = ConnectionDB.getCon();

            PreparedStatement ps = con.prepareStatement(
                "SELECT password FROM users WHERE id=?"
            );
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");

                if (!dbPassword.equals(currentPassword)) {
                    message = "Current password is incorrect.";
                    msgType = "danger";
                } else {
                    PreparedStatement ps2 = con.prepareStatement(
                        "UPDATE users SET password=? WHERE id=?"
                    );
                    ps2.setString(1, newPassword);
                    ps2.setInt(2, uid);
                    ps2.executeUpdate();

                    message = "Password changed successfully.";
                    msgType = "success";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Server error. Please try again.";
            msgType = "danger";
        }
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password | User Panel</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
:root{
    --primary:#7a3cff;
    --secondary:#9f7cff;
    --bg:#f4f6fb;
}
body{
    font-family:'Poppins',sans-serif;
    background:var(--bg);
}
.back-btn{
    margin:25px;
}
.back-btn a{
    color:var(--primary);
    font-weight:600;
    text-decoration:none;
}
.page-wrapper{
    padding:40px 20px 70px;
}
.info-card,.form-card{
    background:#fff;
    border-radius:22px;
    padding:35px;
    box-shadow:0 35px 70px rgba(122,60,255,.2);
}
.info-step{
    display:flex;
    gap:15px;
    margin-bottom:18px;
}
.step-no{
    width:34px;
    height:34px;
    border-radius:50%;
    background:var(--primary);
    color:#fff;
    display:flex;
    align-items:center;
    justify-content:center;
}
.form-control{
    border-radius:14px;
    height:48px;
}
.btn-save{
    background:linear-gradient(135deg,var(--primary),var(--secondary));
    border:none;
    border-radius:30px;
    padding:12px;
    font-weight:600;
    color:#fff;
    width:100%;
}
footer{
    text-align:center;
    font-size:13px;
    color:#777;
    padding:15px;
}
</style>
</head>

<body>

<!-- BACK -->
<div class="back-btn">
    <a href="user_dashboard.jsp">← Back</a>
</div>

<div class="container page-wrapper">
    <div class="row g-4">

        <!-- LEFT INFO -->
        <div class="col-md-5 mb-4">
            <div class="info-card">
                <h4>Password Instructions</h4>
                <div class="info-step"><div class="step-no">1</div><p>Enter current password.</p></div>
                <div class="info-step"><div class="step-no">2</div><p>Choose a strong password.</p></div>
                <div class="info-step"><div class="step-no">3</div><p>Confirm new password.</p></div>
                <div class="info-step"><div class="step-no">4</div><p>Do not share your password.</p></div>
            </div>
        </div>

        <!-- RIGHT FORM -->
        <div class="col-md-7">
            <div class="form-card">
                <h4>Change Password</h4>

                <% if (!message.isEmpty()) { %>
                    <div class="alert alert-<%= msgType %>">
                        <%= message %>
                    </div>
                <% } %>

                <form method="post">

                    <div class="form-group mb-3">
                        <label>Current Password</label>
                        <input type="password" name="currentPassword" class="form-control" required>
                    </div>

                    <div class="form-group mb-3">
                        <label>New Password</label>
                        <input type="password" name="newPassword" class="form-control" required>
                    </div>

                    <div class="form-group mb-4">
                        <label>Confirm New Password</label>
                        <input type="password" name="confirmPassword" class="form-control" required>
                    </div>

                    <button type="submit" class="btn btn-save">
                        Save New Password
                    </button>

                </form>
            </div>
        </div>

    </div>
</div>

<footer>
    © 2026 BusCrowd Analyzer | User Panel
</footer>

</body>
</html>
