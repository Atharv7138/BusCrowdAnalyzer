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

/**
 * Servlet implementation class Adddepot
 */
@WebServlet("/Adddepot")
public class Adddepot extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Adddepot() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		PrintWriter pw=response.getWriter();
		String name,location,contact,email,password;
		
		name=request.getParameter("name");
		location=request.getParameter("location");
		contact=request.getParameter("contact");
		email=request.getParameter("email");
		password=request.getParameter("password");
		
		try{
			
			Connection Con=ConnectionDB.getCon();
			
			PreparedStatement ps=Con.prepareStatement("Insert Into busdepot Values(?,?,?,?,?,?)");
			ps.setInt(1, 0);
			ps.setString(2,name);
			ps.setString(3,location);
			ps.setString(4,contact);
			ps.setString(5,email);
			ps.setString(6,password);
			
			int i=ps.executeUpdate();
			if (i>0)
			{
				
				response.setContentType("text/html");
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('Added Successful');");
				pw.println("</script>");
				RequestDispatcher rd=request.getRequestDispatcher("Admindashboard.html");
				rd.include(request, response);
				System.out.println("Welcome");
				
			}
			
			else{
				
				response.setContentType("text/html");
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('Fail to Add Please Try Again');");
				pw.println("</script>");
				RequestDispatcher rd=request.getRequestDispatcher("AddDepot.html");
				rd.include(request,response);
	        	response.sendRedirect("AddDepot.html");
				System.out.println("Fail");
				
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
	}

}
