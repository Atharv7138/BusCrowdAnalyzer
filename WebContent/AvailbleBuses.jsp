<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="com.buscrowd.*"%> 
    <%@page import="java.util.*"%>
    <%@page import="java.sql.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html><html lang="en">

<head>
    <meta charset="utf-8">
    <title>Bus Crowd Analyzer</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Free HTML Templates" name="keywords">
    <meta content="Free HTML Templates" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Rubik&display=swap" rel="stylesheet"> 

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.0/css/all.min.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">

    <style>
        /* Custom Styles to Center the Form */
        .carousel-item {
            position: relative;
            height: 100vh;
        }

        .carousel-item img {
            height: 100%;
            object-fit: cover;
        }

        .login-container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(255, 255, 255, 0.85);
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
        }

        .login-container h1 {
            margin-bottom: 30px;
            font-size: 2rem;
            font-weight: 600;
            text-align: center;
        }

        .carousel-caption {
            bottom: 0;
        }
    </style>
</head>

<body>
    <!-- Topbar Start -->
    <div class="container-fluid bg-dark py-3 px-lg-5 d-none d-lg-block">
        <div class="row">
            <div class="col-md-6 text-center text-lg-left mb-2 mb-lg-0">
                <div class="d-inline-flex align-items-center">
                    <a class="text-body pr-3" href=""><i class="fa fa-phone-alt mr-2"></i>+012 345 6789</a>
                    <span class="text-body">|</span>
                    <a class="text-body px-3" href=""><i class="fa fa-envelope mr-2"></i>info@example.com</a>
                </div>
            </div>
            <div class="col-md-6 text-center text-lg-right">
                <div class="d-inline-flex align-items-center">
                    <a class="text-body px-3" href="">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a class="text-body px-3" href="">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a class="text-body px-3" href="">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                    <a class="text-body px-3" href="">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a class="text-body pl-3" href="">
                        <i class="fab fa-youtube"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Topbar End -->

    <!-- Navbar Start -->
    <div class="container-fluid position-relative nav-bar p-0">
        <div class="position-relative px-lg-5" style="z-index: 9;">
          <nav class="navbar navbar-expand-lg bg-secondary navbar-dark py-3 py-lg-0 pl-3 pl-lg-5">
                <a href="" class="navbar-brand">
                    <h1 class="text-uppercase text-primary mb-1">Bus Depot</h1>
                </a>
                <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-between px-3" id="navbarCollapse">
                <div class="navbar-nav ml-auto py-0">
                        <a href="BusDepotDashboard.html" class="nav-item nav-link active">Home</a>
                        <a href="AddRoute.html" class="nav-item nav-link">Route</a>
                        <a href="ViewRoute.jsp" class="nav-item nav-link">ViewRoute</a>
                        <a href="AddBus.html" class="nav-item nav-link">AddBus</a>
                        <a href="ViewBuses.jsp" class="nav-item nav-link">ViewBus</a>
                        <a href="AssignRoute.jsp" class="nav-item nav-link">AssignBus</a>
                        <a href="#" class="nav-item nav-link">Crowd</a>
                        <a href="#" class="nav-item nav-link">Rescheduling</a>
                        <a href="index.html" class="nav-item nav-link">Logout</a>
               </div>
               </div>
               </div>
                </div>
         </nav>
    <!-- Navbar End -->

  <main class="main">
 <div class="container-fluid p-0" style="margin-bottom: 50px;">
        <div id="header-carousel" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
        <div class="carousel-item active">
        <img class="w-100" src="img/bus_crowd.jpg" alt="Image" style=height:900px;>
       
<div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
         <h1 Style=color:red;>View Buses</h1>
      <table class="table table-success table-striped"style="width:100px;margin-bottom:300px;">
        <thead>
          <tr style="color:blue">
            <th scope="col">Id</th>
            <th scope="col">BusNumber</th>

            <th scope="col">BusRoute</th>
	
          </tr>
        </thead>
        <tbody>
         <% 
            Statement statement = null;
            ResultSet rs = null;
            try {
              Connection con = ConnectionDB.getCon();
            
             // String sql = "select * from buses where demail=?";
              PreparedStatement ps = con.prepareStatement("select * from buses where demail=?");
               ps.setString(1,UserInfo.getEmail());
              rs = ps.executeQuery();
              while (rs.next()) {
          %> 
          <tr>
            <td scope="row"> <%= rs.getInt("id") %> </td>
            <td scope="row"> <%= rs.getString("Busnumber") %> </td>
         
            <td scope="row"> <%= rs.getString("BusRoute") %> </td>
            
            
          </tr>
           
          <% 
              }
            }
            
            catch(Exception e) {
              e.printStackTrace();
            
           }
          %>
        </tbody>
      </table>
    </div>
</div>
</div>
</div>
</div>


   

   
    <!-- Carousel End -->

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/tempusdominus/js/moment.min.js"></script>
    <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>
