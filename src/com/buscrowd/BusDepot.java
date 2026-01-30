package com.buscrowd;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BusDepot")
public class BusDepot extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String pwd = request.getParameter("password");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        PrintWriter pw = response.getWriter();
        response.setContentType("text/html");

        try {
            con = ConnectionDB.getCon();

            ps = con.prepareStatement(
                "SELECT * FROM busdepot WHERE email=? AND password=?"
            );
            ps.setString(1, email);
            ps.setString(2, pwd);

            rs = ps.executeQuery();

            if (rs.next()) {

                UserInfo.setEmail(rs.getString("email"));
                UserInfo.setId(rs.getInt("id")); // depot_id

                pw.println("<script>alert('Login Successful');</script>");
                RequestDispatcher rd =
                        request.getRequestDispatcher("BusDepotDashboard.jsp");
                rd.include(request, response);

            } else {

                pw.println("<script>alert('Wrong User Credentials');</script>");
                RequestDispatcher rd =
                        request.getRequestDispatcher("BusDepotlogin.html");
                rd.include(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                   // ✅ MOST IMPORTANT
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
