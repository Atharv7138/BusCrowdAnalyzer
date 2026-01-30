package com.buscrowd;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CrowdDataServlet
 */
@WebServlet("/CrowdDataServlet")
public class CrowdDataServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int busId = Integer.parseInt(request.getParameter("bus_id"));
        int routeId = Integer.parseInt(request.getParameter("route_id"));
        int people = Integer.parseInt(request.getParameter("people"));
        double lat = Double.parseDouble(request.getParameter("lat"));
        double lng = Double.parseDouble(request.getParameter("lng"));

        String level = "LOW";
        if (people > 40) level = "HIGH";
        else if (people > 20) level = "MEDIUM";

        try {
            Connection con = ConnectionDB.getCon();
            PreparedStatement ps = con.prepareStatement(
              "INSERT INTO crowd_data(bus_id, route_id, people_count, crowd_level, latitude, longitude) VALUES(?,?,?,?,?,?)");

            ps.setInt(1, busId);
            ps.setInt(2, routeId);
            ps.setInt(3, people);
            ps.setString(4, level);
            ps.setDouble(5, lat);
            ps.setDouble(6, lng);
            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}

