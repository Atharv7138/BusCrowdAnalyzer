package com.buscrowd;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddingBus
 */
@WebServlet("/AddingBus")
public class AddingBus extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddingBus() {
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
		
		PrintWriter pw=response.getWriter();
		String number,capacity,password;
		double lat=0.0,lon=0.0;
		int count=0;
		
		number=request.getParameter("number");
		capacity=request.getParameter("capacity");
		password=request.getParameter("password");
		
		
		try{
			
			Connection Con=ConnectionDB.getCon();
			
			PreparedStatement ps= Con.prepareCall("Insert INTO buses Values(?,?,?,?,?,?,?,?,?)");
			ps.setInt(1,0);
			ps.setString(2,number);
			ps.setString(3,capacity);
			ps.setString(4,password);
			ps.setString(5,UserInfo.getEmail());
			ps.setString(6,"Pending");
			ps.setDouble(7,lat);
			ps.setDouble(8,lon);
			ps.setInt(9,count);
			int i=ps.executeUpdate();
			if(i>0){
				response.setContentType("text/html");
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('Added Successful');");
				pw.println("</script>");
				RequestDispatcher rd=request.getRequestDispatcher("BusDepotDashboard.html");
				rd.include(request, response);
				System.out.println("Welcome");
			}else
			{
				response.setContentType("text/html");
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('Fail to Add Please Try Again');");
				pw.println("</script>");
				RequestDispatcher rd=request.getRequestDispatcher("AddBus.html");
				rd.include(request,response);
	        	response.sendRedirect("AddBus.html");
				System.out.println("Fail");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		
		}
	
	}
}

		
		