<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*"%>
<%@ page import="com.buscrowd.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Rescheduled Buses | Bus Depot Panel</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- PROFILE CSS -->
<link href="css/profile.css" rel="stylesheet">

<style>
:root{
    --primary:#7a3cff;
    --bg:#f4f6fb;
    --dark:#1f1f2e;
}

body{
    font-family:'Poppins',sans-serif;
    background:var(--bg);
}

/* NAVBAR */
.navbar{
    background:#fff;
    box-shadow:0 6px 25px rgba(0,0,0,.08);
    border-bottom:3px solid var(--primary);
}
.navbar-brand{
    font-weight:700;
    color:var(--primary)!important;
}

/* HEADER */
.header-bar{
    margin:30px 0 15px;
}
.header-bar h4{
    font-weight:700;
    margin:0;
}
.header-bar span{
    font-size:13px;
    color:#666;
}

/* DATA PANEL */
.data-panel{
    background:#fff;
    border-radius:18px;
    padding:25px;
    box-shadow:0 30px 60px rgba(122,60,255,.18);
}

/* TABLE */
.table{
    margin:0;
}
.table thead th{
    font-size:13px;
    text-transform:uppercase;
    letter-spacing:.4px;
    color:#555;
    border-bottom:2px solid #eee;
}
.table td{
    font-size:14px;
    vertical-align:middle;
    border-top:1px solid #f0f0f0;
}
.table tbody tr:hover{
    background:#f7f5ff;
}

/* STATUS BADGE */
.badge-status{
    padding:6px 14px;
    border-radius:50px;
    font-size:12px;
    font-weight:600;
}
.badge-assigned{
    background:#d4edda;
    color:#155724;
}

/* FOOTER */
footer{
    text-align:center;
    font-size:13px;
    color:#777;
    padding:12px;
    margin-top:30px;
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

    <button class="navbar-toggler" data-toggle="collapse" data-target="#nav">
        <span class="navbar-toggler-icon"></span>
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
        </ul>
    </div>
</div>
</nav>

<!-- CONTENT -->
<div class="container">

<!-- HEADER -->
<div class="header-bar">
    <h4>Rescheduled Extra Buses</h4>
    <span>Extra buses automatically assigned due to crowd capacity</span>
</div>

<!-- TABLE -->
<div class="data-panel table-responsive">

<table class="table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Extra Bus</th>
            <th>Route</th>
        </tr>
    </thead>
    <tbody>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try{
    con = ConnectionDB.getCon();
    
    ps = con.prepareStatement("SELECT * FROM extra_buses WHERE busroute!=?");
    ps.setString(1, "Pending");
    rs = ps.executeQuery();

    while(rs.next()){
%>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("busnumber") %></td>
            <td><%= rs.getString("busroute") %></td>
        </tr>
<%
    }
}catch(Exception e){
    e.printStackTrace();
}
%>

    </tbody>
</table>

</div>
</div>

<footer>
    © 2026 BusCrowd Analyzer | Bus Depot Panel
</footer>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>

</body>
</html>
