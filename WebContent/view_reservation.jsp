<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Reservation Details</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	<link rel="icon" href="../../../../favicon.ico">
	<link href="../static/css/login.css" rel="stylesheet">
	<script src="../static/js/login.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
	<style>
	.hidden {
		visibility: hidden;
	}
	</style>
</head>
<body>
<%
	  
%>
<div class="container">
<%
	String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");
	Statement stmt = con.createStatement();
	Statement stmt_2 = con.createStatement();
	Statement stmt_3 = con.createStatement();
	Statement stmt_4 = con.createStatement();
	Statement stmt_5 = con.createStatement();
	
	String invoice_no = request.getParameter("invoice");
	String str = "SELECT * FROM Reservation_Made rm, Room_Reserves rr WHERE rm.invoiceNo = rr.InvoiceNo AND rm.invoiceNo ="+invoice_no;
	String str2 = "SELECT * FROM Reservation_Contains rc WHERE rc.invoiceNo ="+invoice_no;
	String str_breakfast = "SELECT * FROM Reservation_Includes ri WHERE ri.invoiceNo = "+invoice_no;
	
	ResultSet gen_info = stmt.executeQuery(str);
	ResultSet reservation_info = stmt_5.executeQuery(str);
	ResultSet brkservice = stmt_2.executeQuery(str2);
	ResultSet breakfast_include = stmt_3.executeQuery(str_breakfast);
	
	gen_info.next();
	out.print("<h2 style='margin-top:5vh;'>Invoice: "+gen_info.getString("rm.invoiceNo")+"</h2>");
	out.print("<h5>Total Cost: $"+gen_info.getString("rm.TotalAmt")+"</h5>");
	out.print("<div class='row'>");
	out.print("<form class='col' action='review_btypes.jsp'>");
	out.print("<input class='hidden' name=\"b_hotelID\" value=\""+gen_info.getString("rm.HotelID")+"\">");
	out.print("<input class='hidden' name=\"invoice_no_for_breakfast\" value=\""+gen_info.getString("rm.InvoiceNo")+"\">");
	out.print("<input class='btn btn-primary' type='submit' value='Review Breakfast'>");
	out.print("</form>");
	out.print("<form class='col' action='review_stypes.jsp'>");
	out.print("<input class='hidden' name=\"s_hotelID\" value=\""+gen_info.getString("rm.HotelID")+"\">");
	out.print("<input class='hidden' name=\"invoice_no_for_service\" value=\""+gen_info.getString("rm.InvoiceNo")+"\">");
	out.print("<input class='btn btn-primary' type='submit' value='Review Service'>");
	out.print("</form>");
	out.print("<form class='col'action='review_room.jsp'>");
	out.print("<input class='hidden' name=\"r_hotelID\" value=\""+gen_info.getString("rm.HotelID")+"\">");
	out.print("<input class='hidden' name=\"invoice_no_for_room\" value=\""+gen_info.getString("rm.InvoiceNo")+"\">");
	out.print("<input class='btn btn-primary' type='submit' value='Review Room'>");
	out.print("</form>");
	out.print("</div>");
	out.print("<h5 style='margin-top:5vh;'>Room Details<h5>");
	out.print("<table class='Table'>");
	
	reservation_info.next();
  do
  {
	out.print("<tr>");
	out.print("<td>");
	out.print("Room: "+reservation_info.getString("rr.room_no"));
	out.print("</td>");
	out.print("<td>");
	out.print("Staying From/To: "+reservation_info.getString("rr.InDate")+" - "+reservation_info.getString("rr.OutDate"));
	out.print("</td>");
	out.print("</td>");
	out.print("<td>");
	out.print("Number of Days: "+reservation_info.getString("rr.NoOfDays"));
	out.print("</td>");
	out.print("</tr>");
	
  } while(reservation_info.next());

  out.print("</table>");
  out.print("<h5 style='margin-top:5vh;'>Breakfast and Services Included:<h5>");
  out.print("<table class= 'table'>");
  out.print("<tr>");
  try {
	    
		out.print("<td>");
		out.print("Breakfasts Ordered: ");
		
		while(breakfast_include.next()) {
			String breakfast = breakfast_include.getString("ri.bType");
			System.out.print("BREAKFAST: "+breakfast);
			out.print(breakfast_include.getString("ri.bType")+", ");
		
		}
		out.print("</td>");

	
}
catch(Exception e) {
	out.print("none");
	out.print("</td>");
	
	
}
out.print("<td>");
out.print("Service(s) Requested: ");
try {
	while(brkservice.next()){
	out.print(brkservice.getString("rc.sType")+", ");
	}
	
	out.print("</td>");
}catch(Exception e){
	
	out.print("none");
	
	
	
}
out.print("</tr>");
out.print("</table>");
  
 
%>
</div>
</body>