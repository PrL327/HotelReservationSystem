<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "com.Hotel.Today" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");

String room_no = request.getParameter("rTypes");
int rating = Integer.valueOf(request.getParameter("r_rating"));
int hotel_id = Integer.valueOf(request.getParameter("review_hotelID"));

String review_comment = request.getParameter("r_comment");
int review_id = Integer.MIN_VALUE;
review_id = (int)(Math.random() * 99999999+10000000);
int customer_id = Integer.valueOf((String)session.getAttribute("userID"));
String current_date = Today.getToday();


String new_review = "INSERT INTO Review values(?, ?, 1, 0, 0, ?, ?, ?)";
PreparedStatement ps = con.prepareStatement(new_review);
ps.setInt(1, review_id);
ps.setInt(2, rating);
ps.setString(3, review_comment);
ps.setInt(4, customer_id);
ps.setString(5, current_date);
ps.executeUpdate();

String new_room_review = "INSERT INTO RoomReview_Assesed values(?, ?, ?)";
PreparedStatement ps_2 = con.prepareStatement(new_room_review);
ps_2.setInt(1, review_id);
ps_2.setString(2, room_no);
ps_2.setInt(3, hotel_id);
ps_2.executeUpdate();

con.close();
String redirectPage = "user_dashboard.jsp";
response.sendRedirect(redirectPage);

%>
</body>
</html>