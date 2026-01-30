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
 * Servlet implementation class AddingRoute
 */
@WebServlet("/AddingRoute")
public class AddingRoute extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddingRoute() {
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
		String number,name,stop,slocation,elocation;
		
		number=request.getParameter("number");
		name=request.getParameter("rname");
		stop=request.getParameter("stop");
		slocation=request.getParameter("slocation");
		elocation=request.getParameter("elocation");
		
		try{
			
			Connection Con=ConnectionDB.getCon();
			
	PreparedStatement ps= Con.prepareCall("Insert INTO route Values(?,?,?,?,?,?,?)");
			ps.setInt(1,0);
			ps.setString(2,number);
			ps.setString(3,name);
			ps.setString(4,stop);
			ps.setString(5,slocation);
			ps.setString(6,elocation);
			ps.setString(7,UserInfo.getEmail());
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
		RequestDispatcher rd=request.getRequestDispatcher("AddRoute.html");
				rd.include(request,response);
	        	response.sendRedirect("AddRoute.html");
				System.out.println("Fail");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		
		}
	
	}

}
