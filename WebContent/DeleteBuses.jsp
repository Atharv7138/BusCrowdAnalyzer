<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.buscrowd.*"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
PreparedStatement pst = null;

try{
	Connection Con= ConnectionDB.getCon();
//String id1=request.getParameter("id");
int id=Integer.parseInt(request.getParameter("id"));
PreparedStatement ps=Con.prepareStatement("DELETE FROM buses WHERE id=?");
ps.setInt(1,id);
int i=ps.executeUpdate();
if(i>0)
  {
	response.sendRedirect("ViewBuses.jsp");
  }
else{
	response.sendRedirect("ViewBuses.jsp");
  }
    }  catch (Exception e) {
      e.printStackTrace();
}
%>

</body>
</html>