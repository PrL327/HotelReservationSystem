<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
  <style>
  	body {
  		background-image: url('photos/hotel-stock.jpeg');
        background-size: 100% 100%;
  	}
  	.hidden {
  		visibility: hidden;
  	}
  </style>
</head>
<body>
	<div class="container jumbotron" style="margin-top: 4vh;">	
<%
List<String> list = new ArrayList<String>();

try{
	
	String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");
	Statement stmt = con.createStatement();
	Statement stmt_2 = con.createStatement();
	Statement stmt_3 = con.createStatement();
	Statement stmt_4 = con.createStatement();
	Statement stmt_5 = con.createStatement();
	String entity = request.getParameter("Hotel");
	//Get the combobox from the HelloWorld.jsp
	//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the HelloWorld.jsp
	String str = "SELECT h.HotelID, h.name, p.phone, a.Street, a.City, a.State, a.Zip, a.Country FROM Hotel h, PhoneBook p, Location a WHERE h.HOTELID = p.hotelID AND h.hotelID = a.HotelID AND h.HOTELID = "+entity;
	String str2 = "SELECT * FROM OffersBreakfast b WHERE b.HotelID = "+entity;
	String str3 = "SELECT * FROM OffersServices s WHERE s.HOTELID = "+entity;
	String str4 = "SELECT COUNT(*) FROM Room r WHERE r.HOTELID = "+entity;
	String str5 = "SELECT r.RoomType FROM Room r WHERE r.HOTELID ="+entity+" GROUP BY r.RoomType";
	//Run the query against the database.
	ResultSet result = stmt.executeQuery(str);
	ResultSet result2 = stmt_2.executeQuery(str2);
	ResultSet result3 = stmt_3.executeQuery(str3);
	ResultSet result4 = stmt_4.executeQuery(str4);
	ResultSet result5 = stmt_5.executeQuery(str5);

	//parse out the results
	while (result.next()) {
		//make a row
		
		//Print out current bar name:
		out.print("<h2 style='margin-top:2vh; margin-bottom:3vh;'>");
		//Print out current bar name:
		out.print(result.getString("name"));
		out.print("</h2>");
		out.print("<div id='generalInfo'>");
		out.print("<h4>General Info:</h4>");
		out.print("<table class='table'>");
		out.print("<tr>");
		out.print("<td>");
		out.print("<strong>");
		out.print("Phone: ");
		out.print("</strong>");
		out.print(result.getString("phone"));
		out.print("</td>");
		out.print("<td>");
		out.print("<strong>");
		out.print("Address : ");
		out.print("</strong>");
		out.print(result.getString("Street")+", "+result.getString("City")+", "+result.getString("state")+", "+result.getString("Country")+", "+result.getString("Zip"));
		out.print("</td>");
		out.print("</table>");
		out.print("</div>");
		
	
	
	out.print("<div id='roomsOffered'>");
	out.print("<h4>Room Info: </h4>");
	out.print("<table class='table'><tr>");
	
	while(result4.next()){
		out.print("<td>");
		out.print("# of Rooms: "+result4.getString("COUNT(*)"));
		out.print("</td>");
	}
	out.print("<td>");
	out.print("Room Types: ");
	while(result5.next()){
		out.print(result5.getString("RoomType") + ", ");
	}
	out.print("</td>");
	out.print("</tr></table>");
	out.print("</div>");
		
	  out.print("<div id='breakfastServices'>");
	  out.print("<h4> Breakfasts & Services </h4>");
	  out.print("<div class='row'>");
	  out.print("<div class='col'>");
	  out.print("<table class='table'>");
	  out.print("<tr><td><h5>Breakfasts Offered</h5></td></tr>");
	  out.print("<tr><td>");
	  out.print("<ul>");
	
	  while(result2.next()){
		out.print("<li><strong>");
		out.print(result2.getString("btype")+": $"+result2.getString("bPrice"));
		out.print("</strong>");
		out.print("<p>");
		out.print(result2.getString("Description"));
		out.print("</p>");
		out.print("</li>");
	  }
	  
	  out.print("</ul>");
	  out.print("</td>");
	  out.print("</tr>");
	  out.print("</td></table></div>");
	  out.print("<div class='col'><table class='table'><tr><td><h5>Services Offered</h5></td></tr>");
	  out.print("<tr><td>");
	  out.print("<ul>");
	  
	  while(result3.next()){
			out.print("<li><strong>");
			out.print(result3.getString("stype")+": $"+result3.getString("sCost"));
			out.print("</strong>");
			out.print("</li>");
			
		  }
	  out.print("</ul>");
	  out.print("</td></tr>");
	  out.print("</table></div>");
	  out.print("</div>");
	  
	  out.print("<div class='row'>");
	  out.print("<form action='viewBreakfastReviews.jsp'>");
		out.print("<input class='hidden' name='HotelID'  value=\""+result.getString("HotelID")+"\">");
		out.print("<input class='btn btn-link' type='submit' value='View Breakfast Reviews'>");
		out.print("</form>");
		
		out.print("<form action='viewServiceReviews.jsp'>");
		out.print("<input class='hidden' name='HotelID'  value=\""+result.getString("HotelID")+"\">");
		out.print("<input class='btn btn-link' type='submit' value='View Service Reviews'>");
		out.print("</form>");
		
		out.print("<form action='viewRoomReviews.jsp'>");
		out.print("<input class='hidden' name='HotelID'  value=\""+result.getString("HotelID")+"\">");
		out.print("<input class='btn btn-link' type='submit' value='View Room Reviews'>");
		out.print("</form>");
	  out.print("</div>");
	  
	}

	con.close();
 }
catch (Exception e) {
	}

	%>
	</div>
</body>
</html>