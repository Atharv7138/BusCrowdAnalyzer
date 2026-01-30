package com.buscrowd;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Alogin")
public class Alogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        if ("admin@gmail.com".equals(email) && "admin".equals(pass)) {

            // ✅ SUCCESS → redirect (BEST PRACTICE)
            response.sendRedirect("Admindashboard.html");

        } else {

            // ❌ FAIL → show error on same page
            pw.println("<script type='text/javascript'>");
            pw.println("alert('Wrong email or password');");
            pw.println("</script>");

            RequestDispatcher rd =
                    request.getRequestDispatcher("AdminLogin.html");
            rd.include(request, response);
        }
    }

    // OPTIONAL (safe)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect("AdminLogin.html");
    }
}
