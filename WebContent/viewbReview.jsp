<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
</head>
<body>
<% 
List<String> list = new ArrayList<String>();

try{
	
	/*String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");
	Statement stmt = con.createStatement();
	
	String str = "c.Email, b.bType, r.Rating, r.TextComment FROM Review r, Customer c, BreakReview_Evaluated b WHERE c.ID = r.CID ORDER BY r.Rating" ;
	ResultSet result = stmt.executeQuery(str);*/
	
	
	out.print("<table class ='table'>");
	//make a row
	out.print("<tr>");
	out.print("<td>");
	out.print("Email");
	out.print("</td>");
	//make a column
	out.print("<td>");
	out.print("Breakfast Type");
	out.print("</td>");
	//make a column
	out.print("<td>");
	out.print("Rating");
	out.print("</td>");
	//make a column
	out.print("<td>");
	out.print("Text Comment");
	out.print("</td>");
	
	/*while (result.next()) {
		
		out.print("<tr>");
		
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//Print out Email:
		out.print(result.getString("Email"));
		out.print("</td>");
		
		out.print("<td>");
		//Print out Rating:
		out.print(result.getString("Breakfast Type"));
		out.print("</td>");
		
		out.print("<td>");
		//Print out Breakfast Type:
		out.print(result.getString("Rating"));
		out.print("</td>");
		out.print("<td>");
		//Print out Text Comment:
		out.print(result.getString("Text Comment"));
	}*/
	
	out.print("</table>"); 
 }
catch (Exception e) {
	}

	%>
	

</body>
</html>
