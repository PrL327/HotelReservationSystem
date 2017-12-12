<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
<title>Rooms in Hotel</title>
<script>
function goBack() {
    window.history.back()
}
</script>
</head>
<body style='margin-top:2vh;' class='container'>
<h2>Room Offered:</h2>
<table class='table'>
<tr>
<td>Room #</td>
<td>Floor #</td>
<td>Price</td>
<td>Max Capacity</td>
<td>Type</td>
<td>Descr.</td>
</tr>
<%
	String entity = request.getParameter("hotel_rooms");
	String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");
	String get_room_details = "SELECT * FROM Room r WHERE r.HotelID  ="+entity;
	
	Statement stmt = con.createStatement();
	
	ResultSet room_data = stmt.executeQuery(get_room_details);

	while(room_data.next())
	{
		out.print("<tr>");
		out.print("<td>");
		out.print(room_data.getString("r.room_no"));
		out.print("</td>");
		out.print("<td>");
		out.print(room_data.getString("r.floor_no"));
		out.print("</td>");
		out.print("<td>");
		out.print("$"+room_data.getString("r.Price"));
		out.print("</td>");
		out.print("<td>");
		out.print(room_data.getString("r.Capacity"));
		out.print("</td>");
		out.print("<td>");
		out.print(room_data.getString("r.RoomType"));
		out.print("</td>");
		out.print("<td>");
		out.print(room_data.getString("r.Description"));
		out.print("</td>");
		out.print("<tr>");
		
	}
	con.close();
%>
</table>
<button class='btn btn-primary' onclick="goBack()">Go Back</button>
</body>
</html>