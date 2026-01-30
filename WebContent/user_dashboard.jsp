<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.buscrowd.ConnectionDB" %>

<%
    if (session.getAttribute("uid") == null) {
        response.sendRedirect("user_login.jsp");
        return;
    }

    int uid = (Integer) session.getAttribute("uid");

    String userName = "";
    String userEmail = "";
    String userMobile = "";

    try {
        Connection con = ConnectionDB.getCon();
        PreparedStatement ps = con.prepareStatement(
            "SELECT name,email,mobile FROM users WHERE id=?"
        );
        ps.setInt(1, uid);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            userName = rs.getString("name");
            userEmail = rs.getString("email");
            userMobile = rs.getString("mobile");
        }
    } catch(Exception e){
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Dashboard | Bus Crowd Analyzer</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

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
/* ===== NAVBAR TOGGLER FIX (VISIBLE ON WHITE BG) ===== */

.navbar-toggler {
    border: none;
    outline: none;
}

/* Remove default blue outline */
.navbar-toggler:focus {
    outline: none;
    box-shadow: none;
}

/* Custom hamburger icon */
.navbar-toggler-icon {
    background-image: none;
    position: relative;
    width: 24px;
    height: 2px;
    background-color: #7a3cff; /* PRIMARY COLOR */
    display: inline-block;
}

/* Top & bottom lines */
.navbar-toggler-icon::before,
.navbar-toggler-icon::after {
    content: "";
    position: absolute;
    left: 0;
    width: 24px;
    height: 2px;
    background-color: #7a3cff;
}

/* Position lines */
.navbar-toggler-icon::before {
    top: -7px;
}
.navbar-toggler-icon::after {
    top: 7px;
}

/* Mobile spacing fix */
@media (max-width: 991px) {
    .navbar {
        padding-left: 15px;
        padding-right: 15px;
    }
}

/* NAVBAR */
.navbar{
    background:#fff;
    box-shadow:0 8px 30px rgba(0,0,0,.08);
}
.navbar-brand{
    font-weight:700;
    color:var(--primary)!important;
}
.nav-link{
    font-weight:500;
    color:#333!important;
}

/* PROFILE */
.profile-container{
    position:relative;
}
.profile-icon{
    width:42px;
    height:42px;
    border-radius:50%;
    cursor:pointer;
}

.profile-dropdown{
    position:absolute;
    top:55px;
    right:0;
    width:280px;
    background:#fff;
    border-radius:18px;
    box-shadow:0 20px 50px rgba(0,0,0,.15);
    display:none;
    z-index:999;
}
.profile-dropdown.show{
    display:block;
}

/* HEADER */
.profile-header{
    background:linear-gradient(135deg,var(--primary),var(--secondary));
    padding:22px;
    border-radius:18px 18px 0 0;
    text-align:center;
    color:#fff;
}
.profile-header img{
    width:70px;
    height:70px;
    border-radius:50%;
    border:3px solid #fff;
}
.profile-header h4{
    margin-top:10px;
    font-size:18px;
}
.profile-header p{
    font-size:14px;
    opacity:.9;
}

/* MENU */
.profile-menu a{
    display:block;
    padding:12px 20px;
    font-size:14px;
    color:#333;
    text-decoration:none;
}
.profile-menu a:hover{
    background:#f3f4f6;
}
.profile-menu .logout{
    color:#dc2626;
    font-weight:600;
}

/* DASHBOARD */
.dashboard{
    padding:110px 25px 40px;
}
.card-box{
    background:#fff;
    border-radius:18px;
    padding:28px;
    box-shadow:0 20px 50px rgba(0,0,0,.08);
    transition:.3s;
    height:100%;
}
.card-box:hover{
    transform:translateY(-6px);
}
.card-box i{
    font-size:32px;
    color:var(--primary);
}

/* MOBILE FIX */
@media(max-width:768px){
    .navbar-nav{
        text-align:center;
    }
    .profile-dropdown{
        right:10px;
    }
}
</style>
</head>

<body>
<script>
    // Page reload after 10 seconds (10000 ms)
    setTimeout(function () {
        location.reload();
    }, 10000);
</script>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg fixed-top">
<div class="container-fluid">

    <a class="navbar-brand" href="#">
        <i class="fas fa-bus mr-2"></i>Bus Crowd Analyzer
    </a>

    <button class="navbar-toggler" data-toggle="collapse" data-target="#nav">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="nav">
        <ul class="navbar-nav mx-auto">
            <li class="nav-item"><a class="nav-link active" href="user_dashboard.jsp">Dashboard</a></li>
            <li class="nav-item"><a class="nav-link" href="viewbusesuser.jsp">View Buses</a></li>
            <li class="nav-item"><a class="nav-link" href="UserViewRoute.jsp">Routes</a></li>
            
        </ul>

        <!-- PROFILE -->
        <ul class="navbar-nav">
            <li class="nav-item">
                <div class="profile-container">
                    <img src="img/profile.png" class="profile-icon" onclick="toggleProfile()">

                    <div class="profile-dropdown">
                        <div class="profile-header">
                            <img src="img/profile.png">
                            <h4><%= userName %></h4>
                            <p><%= userMobile %></p>
                        </div>

                        <div class="profile-menu">
                            <a href="javascript:void(0);" onclick="toggleInfo()">My Profile</a>

                            <div id="profileInfo" style="display:none;padding:12px 20px;">
                                <p><b>Name:</b> <%= userName %></p>
                                <p><b>Mobile:</b> <%= userMobile %></p>
                                <p><b>Email:</b> <%= userEmail %></p>
                            </div>

                            <a href="UserChangePassword.jsp">Change Password</a>
                            <a href="LogoutServlet" class="logout">Logout</a>
                        </div>
                    </div>
                </div>
            </li>
        </ul>

    </div>
</div>
</nav>

<!-- DASHBOARD -->
<div class="dashboard container-fluid">
    <h2 class="mb-2">Welcome, <span style="color:#7a3cff"><%= userName %></span></h2>
    <p class="text-muted mb-4">Travel smarter with real-time crowd updates.</p>

    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card-box">
                <i class="fas fa-route"></i>
                <h5 class="mt-3">Routes</h5>
                <p>Check available bus routes.</p>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card-box">
                <i class="fas fa-users"></i>
                <h5 class="mt-3">Crowd Status</h5>
                <p>Live crowd monitoring.</p>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card-box">
                <i class="fas fa-bus"></i>
                <h5 class="mt-3">Buses</h5>
                <p>View bus schedules.</p>
            </div>
        </div>
    </div>
</div>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
function toggleProfile(){
    event.stopPropagation();
    document.querySelector(".profile-dropdown").classList.toggle("show");
}
function toggleInfo(){
    const info=document.getElementById("profileInfo");
    info.style.display=(info.style.display==="none")?"block":"none";
}
document.addEventListener("click",function(e){
    if(!document.querySelector(".profile-container").contains(e.target)){
        document.querySelector(".profile-dropdown").classList.remove("show");
        document.getElementById("profileInfo").style.display="none";
    }
});
</script>

</body>
</html>
