<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Registration | Bus Crowd Analyzer</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<style>
:root{
    --accent:#7a3cff;
}

body{
    margin:0;
    font-family:'Poppins',system-ui,sans-serif;
    background:#f3f4f8;
    color:#1f2937;
}

/* BACK CANVAS */
.canvas{
    position:fixed;
    inset:0;
    background:
        radial-gradient(circle at 10% 10%, rgba(122,60,255,.15), transparent 40%),
        radial-gradient(circle at 90% 80%, rgba(122,60,255,.12), transparent 40%);
    z-index:-1;
}

/* TITLE */
.site-title{
    padding:30px 50px;
    font-size:26px;
    font-weight:800;
    color:var(--accent);
}

/* MAIN */
.main{
    min-height:calc(100vh - 120px);
    display:flex;
    align-items:center;
}

/* LEFT TEXT */
.hero-text h1{
    font-size:46px;
    font-weight:800;
    line-height:1.2;
}
.hero-text span{
    color:var(--accent);
}
.hero-text p{
    color:#6b7280;
    font-size:16px;
    margin-top:15px;
    max-width:420px;
}

/* CARD */
.auth-wrap{
    background:#fff;
    border-radius:22px;
    padding:50px;
    box-shadow:0 30px 80px rgba(0,0,0,0.12);
    position:relative;
}

/* TAG */
.tag{
    position:absolute;
    top:-16px;
    left:30px;
    background:var(--accent);
    color:#fff;
    padding:6px 18px;
    border-radius:20px;
    font-size:13px;
    font-weight:700;
    letter-spacing:.5px;
}

/* INPUT */
.form-control{
    height:52px;
    border-radius:14px;
    border:1px solid #e5e7eb;
    padding-left:46px;
    font-size:14px;
}
.form-control:focus{
    border-color:var(--accent);
    box-shadow:none;
}

/* ICON */
.input-box{
    position:relative;
}
.input-box i{
    position:absolute;
    top:50%;
    left:16px;
    transform:translateY(-50%);
    color:#9ca3af;
    font-size:14px;
}

/* BUTTON */
.btn-main{
    height:54px;
    border-radius:16px;
    background:var(--accent);
    color:#fff;
    font-weight:700;
    border:none;
    transition:.3s;
}
.btn-main:hover{
    transform:translateY(-2px);
    box-shadow:0 10px 30px rgba(122,60,255,.4);
}

/* RESPONSIVE */
@media(max-width:768px){
    .hero-text{
        text-align:center;
        margin-bottom:30px;
    }
    .hero-text h1{
        font-size:34px;
    }
    .auth-wrap{
        padding:35px;
    }
}
</style>
</head>

<body>

<div class="canvas"></div>

<div class="site-title">
    Bus Crowd Analyzer
</div>

<div class="main">
<div class="container">
<div class="row align-items-center justify-content-center">

    <!-- LEFT CONTENT -->
    <div class="col-lg-6 hero-text">
        <h1>
            User<br>
            <span>Registration</span>
        </h1>
        <p>
            Create your account to track real-time
            bus crowd levels, routes and timings.
        </p>
    </div>

    <!-- REGISTER CARD -->
    <div class="col-lg-5">
        <div class="auth-wrap">

            <div class="tag">USER REGISTER</div>

            <form action="RegisterServlet" method="post">

                <div class="form-group input-box">
                    <i class="fas fa-user"></i>
                    <input type="text" name="name"
                           class="form-control"
                           placeholder="Full Name" required>
                </div>

                <div class="form-group input-box">
                    <i class="fas fa-envelope"></i>
                    <input type="email" name="email"
                           class="form-control"
                           placeholder="Email Address" required>
                </div>

                <div class="form-group input-box">
                    <i class="fas fa-phone"></i>
                    <input type="text" name="mobile"
                           class="form-control"
                           placeholder="Mobile Number" required>
                </div>

                <div class="form-group input-box">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password"
                           class="form-control"
                           placeholder="Password" required>
                </div>

                <button type="submit" class="btn btn-main btn-block mt-4">
                    Create Account
                </button>

            </form>

            <p class="text-success text-center mt-3">
                ${msg}
            </p>

            <p class="text-center mt-3" style="font-size:14px;">
                Already registered?
                <a href="user_login.jsp"
                   style="color:#7a3cff;font-weight:600;">
                    Login here
                </a>
            </p>

        </div>
    </div>

</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
