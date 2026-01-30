package com.buscrowd;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String password = request.getParameter("password");

		try {
			Connection con = ConnectionDB.getCon();

			PreparedStatement ps = con.prepareStatement(
				"INSERT INTO users(name,email,mobile,password) VALUES(?,?,?,?)"
			);

			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, mobile);
			ps.setString(4, password);

			int i = ps.executeUpdate();

			if (i > 0) {
				request.setAttribute("msg", "Registration Successful!");
				request.getRequestDispatcher("user_registration.jsp")
				       .forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
