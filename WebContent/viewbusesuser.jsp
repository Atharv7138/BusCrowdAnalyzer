<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.buscrowd.ConnectionDB"%>

<%
    if(session.getAttribute("uid")==null){
        response.sendRedirect("user_login.jsp");
        return;
    }

    int uid=(Integer)session.getAttribute("uid");

    String userName="",userEmail="",userMobile="";
    try{
        Connection con=ConnectionDB.getCon();
        PreparedStatement ps=con.prepareStatement(
            "SELECT name,email,mobile FROM users WHERE id=?");
        ps.setInt(1,uid);
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
            userName=rs.getString("name");
            userEmail=rs.getString("email");
            userMobile=rs.getString("mobile");
        }
    }catch(Exception e){e.printStackTrace();}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Buses | Bus Crowd Analyzer</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
:root{
    --primary:#7a3cff;
    --secondary:#9f7cff;
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
    padding-top:90px;
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
.nav-link{ font-weight:500; }

/* PROFILE */
.profile-container{ position:relative; }
.profile-icon{
    width:42px;height:42px;border-radius:50%;cursor:pointer;
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
.profile-dropdown.show{ display:block; }
.profile-header{
    background:linear-gradient(135deg,var(--primary),var(--secondary));
    padding:22px;
    color:#fff;
    text-align:center;
    border-radius:18px 18px 0 0;
}
.profile-header img{
    width:70px;height:70px;border-radius:50%;
    border:3px solid #fff;
}
.profile-menu a{
    display:block;padding:12px 20px;
    color:#333;text-decoration:none;font-size:14px;
}
.profile-menu a:hover{ background:#f3f4f6; }
.logout{ color:#dc2626;font-weight:600; }

/* PANEL */
.data-panel{
    background:#fff;
    border-radius:18px;
    padding:25px;
    box-shadow:0 25px 50px rgba(0,0,0,.1);
}

/* TABLE */
.table thead th{
    font-size:13px;
    text-transform:uppercase;
    color:#555;
}
.table tbody tr:hover{ background:#f7f5ff; }

/* MOBILE */
@media(max-width:768px){
    .profile-dropdown{ right:10px; }
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

<a class="navbar-brand" href="user_dashboard.jsp">
<i class="fas fa-bus mr-2"></i>Bus Crowd Analyzer
</a>

<button class="navbar-toggler" data-toggle="collapse" data-target="#nav">
<span class="navbar-toggler-icon"></span>
</button>

<div class="collapse navbar-collapse" id="nav">
<ul class="navbar-nav mx-auto">
<li class="nav-item"><a class="nav-link" href="user_dashboard.jsp">Dashboard</a></li>
<li class="nav-item"><a class="nav-link active" href="viewbusesuser.jsp">View Buses</a></li>
<li class="nav-item"><a class="nav-link" href="UserViewRoute.jsp">Routes</a></li>

</ul>

<ul class="navbar-nav">
<li class="nav-item">
<div class="profile-container">
<img src="img/profile.png" class="profile-icon" onclick="toggleProfile()">

<div class="profile-dropdown">
<div class="profile-header">
<img src="img/profile.png">
<h4><%=userName%></h4>
<p><%=userMobile%></p>
</div>

<div class="profile-menu">
<a href="javascript:void(0);" onclick="toggleInfo()">My Profile</a>
<div id="profileInfo" style="display:none;padding:12px 20px;">
<p><b>Name:</b> <%=userName%></p>
<p><b>Email:</b> <%=userEmail%></p>
<p><b>Mobile:</b> <%=userMobile%></p>
</div>
<a href="UserChangePassword.jsp">Change Password</a>
<a href="LogoutServlet" class="logout">Logout</a>
</div>
</div>
</li>
</ul>
</div>
</div>
</nav>

<!-- CONTENT -->
<div class="container">
<h4 class="mb-3">Bus Directory</h4>

<div class="data-panel table-responsive">
<table class="table">
<thead>
<tr>
<th>ID</th>
<th>Bus No</th>
<th>Capacity</th>
<th>Route</th>
<th>Count</th>
<th>Density</th>
<th>Location</th>
</tr>
</thead>
<tbody>
<%
try{
Connection con = ConnectionDB.getCon();
PreparedStatement ps = con.prepareStatement("SELECT * FROM buses");
ResultSet rs = ps.executeQuery();

while(rs.next()){
    int count = rs.getInt("count");
    String density = "";

    if(count > 7){
        density = "High";
    }else if(count > 2){
        density = "Medium";
    }else{
        density = "Low";
    }
%>
<tr>
<td><%=rs.getInt("id")%></td>
<td><b><%=rs.getString("Busnumber")%></b></td>
<td><%=rs.getString("Capacity")%></td>
<td><%=rs.getString("BusRoute")%></td>
<td><%=count%></td>

<td>
<span class="<%= density.toLowerCase() %>">
    <%= density %>
</span>
</td>

<td>
<a target="_blank"
href="https://maps.google.com/?q=<%=rs.getString("lat")%>,<%=rs.getString("lon")%>">
View
</a>
</td>
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

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
function toggleProfile(){
event.stopPropagation();
document.querySelector(".profile-dropdown").classList.toggle("show");
}
function toggleInfo(){
let i=document.getElementById("profileInfo");
i.style.display=i.style.display==="none"?"block":"none";
}
document.addEventListener("click",function(e){
if(!document.querySelector(".profile-container").contains(e.target)){
document.querySelector(".profile-dropdown").classList.remove("show");
document.getElementById("profileInfo").style.display="none";
}});
</script>

</body>
</html>
