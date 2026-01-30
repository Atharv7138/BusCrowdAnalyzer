<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="com.buscrowd.*"%>

<%
    if(session.getAttribute("uid") == null){
        response.sendRedirect("user_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Crowd Analysis | Bus Crowd Analyzer</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
:root{
  --primary:#7a3cff;
  --bg:#f4f6fb;
}

body{
  font-family:'Poppins',sans-serif;
  background:var(--bg);
  margin:0;
}

/* NAVBAR */
.navbar{
  background:#fff;
  padding:14px 30px;
  box-shadow:0 8px 30px rgba(0,0,0,.08);
}

.navbar-brand{
  font-weight:700;
  color:var(--primary)!important;
}

.nav-link{
  font-weight:500;
  color:#374151!important;
  margin:0 10px;
}

.nav-link.active{
  color:var(--primary)!important;
}

.logout-btn{
  background:var(--primary);
  color:#fff!important;
  padding:8px 18px;
  border-radius:20px;
  font-weight:600;
}

.logout-btn:hover{
  background:#5a28cc;
}

/* PAGE */
.page{
  padding:100px 30px 40px;
}

.page-title{
  font-size:32px;
  font-weight:700;
}

.page-title span{
  color:var(--primary);
}

/* CARD */
.card-box{
  background:#fff;
  border-radius:18px;
  padding:25px;
  box-shadow:0 25px 60px rgba(0,0,0,.1);
}

/* TABLE */
.table thead th{
  border-top:none;
  background:#f3f0ff;
  color:#4c1d95;
  font-weight:600;
}

.badge-low{
  background:#d1fae5;
  color:#065f46;
  padding:6px 14px;
  border-radius:20px;
  font-weight:600;
}

.badge-medium{
  background:#fef3c7;
  color:#92400e;
  padding:6px 14px;
  border-radius:20px;
  font-weight:600;
}

.badge-high{
  background:#fee2e2;
  color:#991b1b;
  padding:6px 14px;
  border-radius:20px;
  font-weight:600;
}
</style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg fixed-top">
<div class="container-fluid">

  <a class="navbar-brand" href="user_dashboard.jsp">
    <i class="fas fa-bus-alt mr-2"></i>Bus Crowd Analyzer
  </a>

  <button class="navbar-toggler" data-toggle="collapse" data-target="#nav">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="nav">

    <ul class="navbar-nav mx-auto">
      <li class="nav-item">
        <a class="nav-link" href="user_dashboard.jsp">Dashboard</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="viewbusesuser.jsp">View Buses</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="UserViewRoute.jsp">Routes</a>
      </li>
      <li class="nav-item">
        <a class="nav-link active" href="CrowdAnalysis.jsp">Crowd</a>
      </li>
    </ul>

    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link logout-btn" href="LogoutServlet">
          <i class="fas fa-sign-out-alt mr-1"></i>Logout
        </a>
      </li>
    </ul>

  </div>
</div>
</nav>

<!-- CONTENT -->
<div class="page container-fluid">

  <h2 class="page-title mb-4">
    Live <span>Crowd Analysis</span>
  </h2>

  <div class="card-box">

    <div class="table-responsive">
      <table class="table table-hover">
        <thead>
          <tr>
            <th>Bus ID</th>
            <th>Route ID</th>
            <th>Passengers</th>
            <th>Crowd Level</th>
            <th>Recorded Time</th>
          </tr>
        </thead>
        <tbody>

        <%
          try{
            Connection con = ConnectionDB.getCon();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(
              "SELECT * FROM crowd_data ORDER BY recorded_time DESC"
            );

            while(rs.next()){
              String level = rs.getString("crowd_level");
        %>
          <tr>
            <td><%=rs.getInt("bus_id")%></td>
            <td><%=rs.getInt("route_id")%></td>
            <td><%=rs.getInt("people_count")%></td>
            <td>
              <% if("HIGH".equals(level)){ %>
                <span class="badge-high">HIGH</span>
              <% } else if("MEDIUM".equals(level)){ %>
                <span class="badge-medium">MEDIUM</span>
              <% } else { %>
                <span class="badge-low">LOW</span>
              <% } %>
            </td>
            <td><%=rs.getTimestamp("recorded_time")%></td>
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

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
