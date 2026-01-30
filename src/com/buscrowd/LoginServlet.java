package com.buscrowd;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		try {
			Connection con = ConnectionDB.getCon();

			PreparedStatement ps = con.prepareStatement(
				"SELECT * FROM users WHERE email=? AND password=?"
			);

			ps.setString(1, email);
			ps.setString(2, password);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				HttpSession session = request.getSession();
				session.setAttribute("uid", rs.getInt("id"));
				session.setAttribute("uname", rs.getString("name"));
				session.setAttribute("uemail", rs.getString("email"));

				response.sendRedirect("user_dashboard.jsp"); // create later
			} else {
				request.setAttribute("msg", "Invalid Email or Password");
				request.getRequestDispatcher("user_login.jsp")
				       .forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
