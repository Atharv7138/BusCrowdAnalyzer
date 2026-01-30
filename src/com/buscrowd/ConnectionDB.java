package com.buscrowd;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionDB {
	
	static Connection Con = null;
	public static Connection getCon()
		{
			try
			{
				
			if(Con==null)
			{
			Class.forName("com.mysql.cj.jdbc.Driver");
			 //Con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buscrowd1","root","");
			 Con = DriverManager.getConnection("jdbc:mysql://sql12.freesqldatabase.com:3306/sql12815677?useSSL=false&serverTimezone=UTC","sql12815677","iq6tw3VjTW");

			}
		}
		catch(Exception e)
			{
			e.printStackTrace();
			
			}
			return Con;
		}
}

	
