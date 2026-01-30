<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.buscrowd.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Bus Depot Dashboard | BusCrowd Analyzer</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- PROFILE CSS -->
<link href="css/profile.css" rel="stylesheet">

<style>

/* Logout */
.profile-menu .logout {
    color: #dc2626;
    font-weight: 600;
}


:root{
    --primary:#7a3cff;
    --secondary:#9f7cff;
    --dark:#1f1f2e;
    --bg:#f4f6fb;
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

body{
    font-family:'Poppins',sans-serif;
    background:var(--bg);
}

/* NAVBAR */
.navbar{
    background:#fff;
    box-shadow:0 8px 30px rgba(0,0,0,.1);
    position:relative;
}
.navbar::after{
    content:'';
    position:absolute;
    bottom:0;
    left:0;
    width:100%;
    height:4px;
    background:linear-gradient(135deg,var(--primary),var(--secondary));
}
.navbar-brand{
    font-weight:700;
    color:var(--primary)!important;
}
.navbar-nav .nav-link{
    font-weight:500;
    color:#444;
}
.navbar-nav .nav-link.active,
.navbar-nav .nav-link:hover{
    color:var(--primary);
}

/* HERO */
.hero{
    background:
        radial-gradient(circle at top right, rgba(122,60,255,.35), transparent 60%),
        linear-gradient(rgba(0,0,0,.55),rgba(0,0,0,.55)),
        url("img/bus_crowd.jpg") center/cover no-repeat;
    padding:110px 20px 90px;
    text-align:center;
    color:#fff;
}
.hero h1{
    font-weight:700;
    font-size:46px;
}
.hero p{
    opacity:.9;
    font-size:18px;
    margin-top:10px;
}

/* MODULE CARDS */
.module-section{
    margin-top:-70px;
    padding-bottom:70px;
}
.module-card{
    background:#fff;
    border-radius:22px;
    padding:32px;
    box-shadow:0 35px 70px rgba(122,60,255,.2);
    transition:.35s ease;
    height:100%;
}
.module-card:hover{
    transform:translateY(-10px);
}
.module-icon{
    width:68px;
    height:68px;
    border-radius:20px;
    background:linear-gradient(135deg,var(--primary),var(--secondary));
    display:flex;
    align-items:center;
    justify-content:center;
    color:#fff;
    font-size:28px;
    margin-bottom:20px;
}
.module-card h5{
    font-weight:600;
}
.module-card p{
    font-size:14px;
    color:#666;
}

/* INFO */
.info-section{
    padding:70px 0;
}
.info-box{
    background:#fff;
    border-radius:24px;
    padding:45px;
    box-shadow:0 25px 50px rgba(0,0,0,.08);
}

/* FOOTER */
footer{
    text-align:center;
    padding:14px;
    font-size:13px;
    color:#777;
}

/* MOBILE */
@media(max-width:768px){
    .hero h1{ font-size:30px; }
    .module-section{ margin-top:-40px; }
}
</style>
</head>

<script>
function confirm_alert() {
    return confirm("Are you sure you want to delete this route?");
}

/* Toggle profile dropdown */
function toggleProfile() {
    event.stopPropagation();
    document.querySelector(".profile-dropdown").classList.toggle("show");
}

/* Toggle profile info */
function toggleInfo() {
    const info = document.getElementById("profileInfo");
    info.style.display = (info.style.display === "none") ? "block" : "none";
}

/* Close dropdown when clicking outside */
document.addEventListener("click", function (e) {
    const profile = document.querySelector(".profile-container");
    const dropdown = document.querySelector(".profile-dropdown");

    if (!profile.contains(e.target)) {
        dropdown.classList.remove("show");
        document.getElementById("profileInfo").style.display = "none";
    }
});
</script>
<body>
<!--  ################################# MY PROFILE  ####################################################### -->
<%@ page import="java.sql.*" %>
<%@ page import="com.buscrowd.ConnectionDB" %>

<%
String adminName = "";
String adminContact = "";
String email="";
int id= UserInfo.getId();


try {
    Connection con = ConnectionDB.getCon();
    PreparedStatement ps = con.prepareStatement(
        "SELECT depotname, contact, email FROM busdepot WHERE id=?"
    );
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        adminName = rs.getString("depotname");
        adminContact = rs.getString("contact");
        email= rs.getString("email");

    }
} catch(Exception e) {
    e.printStackTrace();
}
%>
<!--  ############################################################################################################# -->
<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-light">
<div class="container">
    <a class="navbar-brand" href="#">Bus Depot Panel</a>

    <button class="navbar-toggler border-0" type="button" data-toggle="collapse" data-target="#nav">
        <i class="fas fa-bars"></i>
    </button>

    <div class="collapse navbar-collapse" id="nav">
         <ul class="navbar-nav ml-auto">
          <li class="nav-item"><a href="BusDepotDashboard.jsp" class="nav-link active">Home</a></li>
            <li class="nav-item"><a href="ViewRoute.jsp" class="nav-link">View Route</a></li>
            <li class="nav-item"><a href="ViewBuses.jsp" class="nav-link">View Bus</a></li>
            <li class="nav-item"><a href="AssignRoute.jsp" class="nav-link">Assign Bus</a></li>
            <li class="nav-item"><a href="ViewExtraBuses.jsp" class="nav-link">Extra Buses</a></li>
            <li class="nav-item"><a class="nav-link active" href="ViewRescheduling.jsp">Rescheduled Buses</a></li>

<!-- ####################################- Profile ################################### -->

             <li class="nav-item">
<div class="profile-container">

    <img src="img/profile.png"
         class="profile-icon"
         alt="Profile"
         onclick="toggleProfile()">

    <div class="profile-dropdown">

        <!-- PROFILE HEADER -->
        <div class="profile-header">
            <img src="img/profile.png" alt="User">
            <h4><%= adminName %></h4>
            <p><%= adminContact %></p>
        </div>

        <!-- PROFILE MENU -->
        <div class="profile-menu">

            <!-- TOGGLE PROFILE INFO (NO REDIRECT) -->
            <a href="javascript:void(0);" onclick="toggleInfo()">My Profile</a>

            <!-- PROFILE INFO SHOWN HERE -->
            <div id="profileInfo" style="display:none; padding:12px 20px; font-size:14px;">
                <p><strong>Name:</strong> <%= adminName %></p>
                <p><strong>Contact:</strong> <%= adminContact %></p>
                <p><strong>Email:</strong> <%= email %></p>
            </div>

            <a href="ChangePassword.jsp">Change Password</a>
            <a href="#">Settings</a>
            <a href="index.html" class="logout">Logout</a>

        </div>
    </div>
</div>
</li>

        </ul>
    </div>
</div>
</nav>


<!--  ############################################################################################################## -->



<!-- HERO -->
<section class="hero">
    <h1 style=color:white>Bus Depot Dashboard</h1>
    <p>Smarter operations. Smoother commutes. Better city transport.</p>
</section>

<!-- MODULES -->
<section class="container module-section">
<div class="row">

    <div class="col-lg-3 col-md-6 mb-4">
		<a href="ViewRoute.jsp">
        <div class="module-card">        
            <div class="module-icon"><i class="fas fa-route"></i></div>
            <h5>Route Management</h5>
            <p>Create, update and manage bus routes.</p>
        </div>
        </a>
    </div>
   

    <div class="col-lg-3 col-md-6 mb-4">
    <a href="ViewBuses.jsp">
        <div class="module-card">
            <div class="module-icon"><i class="fas fa-bus"></i></div>
            <h5>Bus Management</h5>
            <p>Register buses and assign them efficiently.</p>
        </div>
        </a>
    </div>

    <div class="col-lg-3 col-md-6 mb-4">
        <div class="module-card">
            <div class="module-icon"><i class="fas fa-users"></i></div>
            <h5>Crowd Monitoring</h5>
            <p>Monitor real-time passenger congestion.</p>
        </div>
    </div>

    <div class="col-lg-3 col-md-6 mb-4">
    <a href="ViewRescheduling.jsp">
        <div class="module-card">
            <div class="module-icon"><i class="fas fa-sync-alt"></i></div>
            <h5>Rescheduling</h5>
            <p>Optimize schedules dynamically.</p>
        </div>
        </a>
    </div>

</div>
</section>

<!-- INFO -->
<section class="info-section">
<div class="container">
    <div class="info-box text-center">
        <h4 class="font-weight-bold">Depot Operations Control Center</h4>
        <p class="text-muted mt-3">
            A centralized system for depot managers to control routes,
            buses and crowd flow — ensuring reliable and efficient public transport.
        </p>
    </div>
</div>
</section>

<footer>
    © 2026 BusCrowd Analyzer | Bus Depot Panel
</footer>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>

</body>
</html>