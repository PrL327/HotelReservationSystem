<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1> The best breakfast is: </h1>
	<h2> Tada</h2>
<%

	String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");	

	String start = request.getParameter("Best_Brk_StartDate");
	String end = request.getParameter("Best_Brk_EndDate");
	
	String[] startArr =  start.split("-");
	String[] endArr = end.split("-");
	
	String fromDate = startArr[1]+"/"+startArr[2]+"/"+startArr[0];
	String toDate = endArr[1]+"/"+endArr[2]+"/"+endArr[0];
	
	String statement  = "SELECT max(T2.avgrating) topRating, T2.typeOfB topBreakfast FROM (SELECT avg(T1.rating) as avgrating, bReview.bType typeOfB FROM (SELECT r.ReviewID, r.Rating as rating FROM Review r WHERE r.isBreakReviw = 1 AND r.ReviewDate BETWEEN ? AND ? )T1, BreakReview_Evaluated bReview WHERE T1.ReviewID = bReview.ReviewID GROUP BY bReview.bType) T2";
	

	PreparedStatement ps = con.prepareStatement(statement);
	ps.setString(1, fromDate);
	ps.setString(2, toDate);
	
	ResultSet result = ps.executeQuery();

	result.next();
	
	String btype = result.getString("topBreakfast");
	
	
	
	out.println("The world greatest breakfast is " + btype);
	
	con.close();
%>



</body>
</html>