<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.buscrowd.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Bus Depot Management | Admin</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<!-- Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>

:root{
    --primary:#7a3cff;
    --secondary:#9f7cff;
    --dark:#1e1e2f;
}

/* GLOBAL */
body{
    font-family:'Poppins',sans-serif;
    background:linear-gradient(135deg,#ede9ff,#f6f3ff);
    min-height:100vh;
}

/* NAVBAR */
.navbar{
    background:#fff;
    box-shadow:0 6px 25px rgba(0,0,0,.08);
}
.navbar-brand{
    font-weight:700;
    color:var(--primary)!important;
    font-size:22px;
}
.navbar-nav .nav-link{
    font-weight:500;
    color:#444;
}
.navbar-nav .nav-link.active,
.navbar-nav .nav-link:hover{
    color:var(--primary);
}
/* HEADER */
.page-title{
    margin:35px 0 25px;
}
.page-title h2{
    font-weight:700;
}
.page-title span{
    color:#666;
    font-size:14px;
}

/* GLASS CARD */
.glass-card{
    background:rgba(255,255,255,.75);
    backdrop-filter:blur(14px);
    border-radius:22px;
    padding:25px;
    box-shadow:0 40px 80px rgba(122,60,255,.25);
}

/* TABLE */
.table-wrapper{
    border-radius:18px;
    overflow:hidden;
}
.table{
    margin:0;
}
.table thead{
    background:linear-gradient(135deg,var(--primary),var(--secondary));
    color:#fff;
}
.table th{
    font-size:13px;
    text-transform:uppercase;
    letter-spacing:.5px;
    border:none;
    position:sticky;
    top:0;
}
.table td{
    font-size:14px;
    border-top:1px solid rgba(0,0,0,.05);
}
.table tbody tr{
    transition:.25s;
}
.table tbody tr:hover{
    background:rgba(122,60,255,.08);
    transform:scale(1.01);
}

/* ACTION */
.action-btn{
    background:rgba(220,53,69,.15);
    color:#dc3545;
    border-radius:50px;
    padding:6px 12px;
    font-size:13px;
    border:none;
}
.action-btn:hover{
    background:#dc3545;
    color:#fff;
}

/* FOOTER */
footer{
    text-align:center;
    font-size:13px;
    color:#777;
    padding:15px;
    margin-top:30px;
}



<!-- ################################## STYLE FOR BUTTON ####################################################### -->

/* Header row (title + button) */
.route-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

/* Add Route Button */
.add-route-btn {
    background: linear-gradient(135deg, #7c3aed, #8b5cf6);
    color: white;
    border: none;
    padding: 12px 22px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0 8px 20px rgba(124, 58, 237, 0.35);
    transition: all 0.3s ease;
}

/* Hover effect */
.add-route-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 25px rgba(124, 58, 237, 0.45);
}

/* Click effect */
.add-route-btn:active {
    transform: scale(0.96);
}
.table-action-bar {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 10px;
}



<!--############################################################################################################# -->

</style>

<script>
function confirm_alert() {
    return confirm("Delete this bus depot permanently?");
}
</script>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-light">
<div class="container">
    <a class="navbar-brand" href="#">Bus Crowd Analyzer</a>

    <button class="navbar-toggler border-0" type="button" data-toggle="collapse" data-target="#nav">
        <i class="fas fa-bars"></i>
    </button>

    <div class="collapse navbar-collapse" id="nav">
        <ul class="navbar-nav ml-auto">
           <li class="nav-item"><a class="nav-link active" href="Admindashboard.html">Dashboard <i class="fas fa-tachometer-alt"></i></a></li>
          <!--   <li class="nav-item"><a class="nav-link" href="AddDepot.html">Add Depot</a></li>  -->
            <li class="nav-item"><a class="nav-link" href="ViewDepot.jsp">View Depot <i class="fas fa-bus"></i></a></li>
            <li class="nav-item"><a class="nav-link" href="index.html">Logout  <i class="fas fa-sign-out-alt" title="Logout"></i></a></li>
        </ul>
    </div>
</div>
</nav>

<!-- CONTENT -->
<div class="container">

<!-- TITLE -->
<div class="page-title">
    <h2>Bus Depot Directory</h2>
    <span>Centralized depot management system</span>
</div>
<!-- ################################################## BUTTON FOR ADD ROUTE ############################################### -->
<div class="table-action-bar">
<a href="AddDepot.html">
    <button class="add-route-btn">
        + Add Depot
    </button>
    </a>
</div>



<!-- ########################################################################################################################3
<!-- TABLE -->
<div class="glass-card table-wrapper table-responsive">

<table class="table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Depot Name</th>
            <th>Location</th>
            <th>Contact</th>
            <th>Email</th>
            <th class="text-center">Action</th>
        </tr>
    </thead>
    <tbody>

<%
Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{
    con = ConnectionDB.getCon();
    ps = con.prepareStatement("SELECT * FROM busdepot");
    rs = ps.executeQuery();

    while(rs.next()){
%>
        <tr>
            <td><%=rs.getInt("id")%></td>
            <td><strong><%=rs.getString("depotname")%></strong></td>
            <td><%=rs.getString("location")%></td>
            <td><%=rs.getString("contact")%></td>
            <td><%=rs.getString("email")%></td>
            <td class="text-center">
                <a href="DeleteDepot.jsp?id=<%=rs.getInt("id")%>"
                   onclick="return confirm_alert();"
                   class="action-btn">
                    <i class="fas fa-trash"></i> Delete
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

<footer>
    © 2026 Bus Crowd Analyzer | Admin Panel
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
