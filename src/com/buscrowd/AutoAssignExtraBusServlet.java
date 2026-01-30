package com.buscrowd;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AutoAssignExtraBus")
public class AutoAssignExtraBusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String busNumber = request.getParameter("busnumber");
        int depotId = Integer.parseInt(request.getParameter("depot_id"));
        String route = request.getParameter("route");

        try {
            Connection con = ConnectionDB.getCon();

            /* 1️⃣ Get capacity & count */
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT capacity, count FROM bus WHERE busnumber=? AND depot_id=?"
            );
            ps1.setString(1, busNumber);
            ps1.setInt(2, depotId);

            ResultSet rs = ps1.executeQuery();

            if (!rs.next()) {
                response.getWriter().print("Bus not found");
                return;
            }

            int capacity = rs.getInt("capacity");
            int count = rs.getInt("count");

            /* 2️⃣ Check capacity */
            if (count < capacity) {
                response.getWriter().print("Bus not full yet");
                return;
            }

            /* 3️⃣ 12 HOURS CHECK */
            PreparedStatement ps2 = con.prepareStatement(
                "SELECT scheduled_at FROM rescheduling " +
                "WHERE main_busnumber=? AND depot_id=? " +
                "ORDER BY scheduled_at DESC LIMIT 1"
            );
            ps2.setString(1, busNumber);
            ps2.setInt(2, depotId);

            ResultSet rs2 = ps2.executeQuery();

            if (rs2.next()) {
                Timestamp lastTime = rs2.getTimestamp("scheduled_at");
                long diff = System.currentTimeMillis() - lastTime.getTime();

                if (diff < 12 * 60 * 60 * 1000) {
                    response.getWriter().print("Already scheduled in last 12 hours");
                    return;
                }
            }

            /* 4️⃣ Get one extra bus from SAME depot */
            PreparedStatement ps3 = con.prepareStatement(
                "SELECT busnumber FROM extra_buses " +
                "WHERE depot_id=? AND busroute=? AND status='Pending' " +
                "ORDER BY created_at ASC LIMIT 1"
            );
            ps3.setInt(1, depotId);
            ps3.setString(2, route);

            ResultSet rs3 = ps3.executeQuery();

            if (!rs3.next()) {
                response.getWriter().print("No extra bus available");
                return;
            }

            String extraBus = rs3.getString("busnumber");

            /* 5️⃣ Update extra bus status */
            PreparedStatement ps4 = con.prepareStatement(
                "UPDATE extra_buses SET status='Assigned' WHERE busnumber=?"
            );
            ps4.setString(1, extraBus);
            ps4.executeUpdate();

            /* 6️⃣ Insert into rescheduling table */
            PreparedStatement ps5 = con.prepareStatement(
                "INSERT INTO rescheduling (depot_id, main_busnumber, extra_busnumber, busroute) " +
                "VALUES (?,?,?,?)"
            );
            ps5.setInt(1, depotId);
            ps5.setString(2, busNumber);
            ps5.setString(3, extraBus);
            ps5.setString(4, route);
            ps5.executeUpdate();

            response.getWriter().print("Extra bus scheduled successfully");

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
