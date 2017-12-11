<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
<title>Hotel Stats</title>
</head>
<body>
<h2>Hotel Stats</h2>
<form action="room_query.jsp">
	<p> Find the Best Room Type for Each Hotel </p>
	<label>Start Date: </label><input name="Best_Room_StartDate" type="Date">
	<label>End Date: </label><input name="Best_Room_EndDate" type="Date">
	<input type="submit" value="Submit">
</form>
<form action ="customer_query.jsp">
	<p> Our Best Customers </p>
	<label>Start Date: </label><input name="Best_Customer_StartDate" type="Date">
	<label>End Date: </label><input name="Best_Customer_EndDate" type="Date">
	<input type="submit" value="Submit">
</form>
<form action="breakfast_query.jsp">
	<p> The Best Breakfast</p>
	<label>Start Date: </label><input name="Best_Brk_StartDate" type="Date">
	<label>End Date: </label><input name="Best_Brk_EndDate" type="Date">
	<input type="submit" value="Submit">
</form>
<form action="service_query.jsp">
	<p> The Best Service</p>
	<label>Start Date: </label><input name="Best_Srv_StartDate" type="Date">
	<label>End Date: </label><input name="Best_Srv_EndDate" type="Date">
	<input type="submit" value="Submit">
</form>

</body>
</html>