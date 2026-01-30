package com.buscrowd;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AssignRoutetobus
 */
@WebServlet("/AssignRoutetobus")
public class AssignRoutetobus extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AssignRoutetobus() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		 PrintWriter pw = response.getWriter();
	        String busnumber, routenumber, routename, datetime;

	        routenumber = request.getParameter("number");
	        routename = request.getParameter("name");
	        busnumber = request.getParameter("busnumber");    
	        datetime = request.getParameter("datetime");

	        try {
	            Connection con = ConnectionDB.getCon();

	       
	            PreparedStatement psInsert = con.prepareStatement("INSERT INTO bus_route (routenumber, routename, busnumber, datetime, demail) VALUES (?, ?, ?, ?, ?)");
	            psInsert.setString(1, routenumber);
	            psInsert.setString(2, routename);
	            psInsert.setString(3, busnumber);
	            psInsert.setString(4, datetime);
	            psInsert.setString(5, UserInfo.getEmail());
	            int rowsInserted = psInsert.executeUpdate();

	            if (rowsInserted > 0) {
	            
	                PreparedStatement psUpdate = con.prepareStatement("UPDATE buses SET busroute = ? WHERE busnumber = ?");
	                psUpdate.setString(1, routename); 
	                psUpdate.setString(2, busnumber);
	                int rowsUpdated = psUpdate.executeUpdate();

	                if (rowsUpdated > 0) {
	                    response.setContentType("text/html");
	                    pw.println("<script type=\"text/javascript\">");
	                    pw.println("alert('Added Successful and bus updated');");
	                    pw.println("</script>");
	                    RequestDispatcher rd = request.getRequestDispatcher("BusDepotDashboard.html");
	                    rd.include(request, response);
	                } else {
	                
	                    response.setContentType("text/html");
	                    pw.println("<script type=\"text/javascript\">");
	                    pw.println("alert('Added Successful but failed to update the bus. Please try again.');");
	                    pw.println("</script>");
	                    RequestDispatcher rd = request.getRequestDispatcher("AssignRoute.jsp");
	                    rd.include(request, response);
	                }
	            } else {
	               
	                response.setContentType("text/html");
	                pw.println("<script type=\"text/javascript\">");
	                pw.println("alert('Fail to Add Please Try Again');");
	                pw.println("</script>");
	                RequestDispatcher rd = request.getRequestDispatcher("AssignRoute.jsp");
	                rd.include(request, response);
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}