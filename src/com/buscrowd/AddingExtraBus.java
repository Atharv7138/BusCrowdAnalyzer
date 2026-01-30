package com.buscrowd;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddingExtraBus")
public class AddingExtraBus extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter pw = response.getWriter();

        String busNumber = request.getParameter("number");
        String capacity = request.getParameter("capacity");
        String password = request.getParameter("password");
        String busRoute = request.getParameter("route"); // optional input

        try {
            Connection con = ConnectionDB.getCon();

            String sql = "INSERT INTO extra_buses (busnumber, capacity, password, demail, busroute, status) "
                       + "VALUES (?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, busNumber);
            ps.setString(2, capacity);
            ps.setString(3, password);
            ps.setString(4, UserInfo.getEmail());
            ps.setString(5, busRoute);
            ps.setString(6, "Pending");

            int i = ps.executeUpdate();

            response.setContentType("text/html");

            if (i > 0) {
                pw.println("<script>");
                pw.println("alert('Extra Bus Added Successfully');");
                pw.println("</script>");

                RequestDispatcher rd = request.getRequestDispatcher("BusDepotDashboard.html");
                rd.include(request, response);

                System.out.println("Extra Bus Added Successfully");
            } else {
                pw.println("<script>");
                pw.println("alert('Failed to Add Extra Bus');");
                pw.println("</script>");

                RequestDispatcher rd = request.getRequestDispatcher("AddExtraBus.html");
                rd.include(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
