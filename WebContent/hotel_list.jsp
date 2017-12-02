<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	
	String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");
	Statement stmt = con.createStatement();
	//Get the combobox from the HelloWorld.jsp
	//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the HelloWorld.jsp
	String str = "SELECT h.HotelID, h.name, p.phone, a.Street, a.City, a.State, a.Zip, a.Country FROM Hotel h, PhoneBook p, Location a WHERE h.HOTELID = p.hotelID AND h.hotelID = a.HotelID ";
	//Run the query against the database.
	ResultSet result = stmt.executeQuery(str);
	/* out.print("<select>");
	while(result.next()){
		out.print("<option>"+result.getString("name"));
	}
	out.print("</option");
	out.print("</select>"); */
	
	out.print("<table class ='table'>");
	//make a row
	out.print("<tr>");
	out.print("<td>");
	out.print("Hotel ID");
	out.print("</td>");
	//make a column
	out.print("<td>");
	out.print("Hotel Name");
	out.print("</td>");
	//make a column
	out.print("<td>");
	out.print("Phone");
	out.print("</td>");
	out.print("<td>");
	out.print("Address");
	out.print("</td>");

	//parse out the results
	while (result.next()) {
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//Print out current bar name:
		out.print(result.getString("HotelID"));
		out.print("</td>");
		
		out.print("<td>");
		//Print out current bar name:
		out.print(result.getString("name"));
		out.print("</td>");
		
		out.print("<td>");
		//Print out current beer name:
		out.print(result.getString("phone"));
		out.print("</td>");
		out.print("<td>");
		//Print out current beer name:
		out.print(result.getString("Street")+", "+result.getString("City")+", "+result.getString("Country")+", "+result.getString("Zip"));
		out.print("</td>");
	}
	
	out.print("</table>"); 
	con.close();
 }
catch (Exception e) {
	}

	%>

 
</body>
</html>