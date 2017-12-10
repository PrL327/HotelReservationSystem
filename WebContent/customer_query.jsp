<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Our Five Best Customers</title>
</head>
<body>
Our Best Customers from this time period are:
<%

	String Startdate_rcv = request.getParameter("Best_Customer_StartDate");
	String EndDate_rcv = request.getParameter("Best_Customer_EndDate");

	
	String start_date[] = Startdate_rcv.split("-");
	String StartDateNewFormat = start_date[1]+"/"+start_date[2]+"/"+start_date[0];
	
	String end_date[] = EndDate_rcv.split("-");
	String EndDateNewFormat = end_date[1]+"/"+end_date[2]+"/"+end_date[0];
	
	String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");	
	
	String getIDStatement = "SELECT c.first_name, t3.total FROM (SELECT * FROM (SELECT * FROM (SELECT r.CID as customer , sum(r.totalAmt) as total FROM `HotelReservation`.`Reservation_Made` AS r WHERE r.ResDate BETWEEN ? and ? GROUP BY r.CID) AS t1 ORDER BY t1.total DESC) t2 LIMIT 5) t3, `HotelReservation`.`Customer` AS c WHERE c.ID = t3.customer";
	
			
	PreparedStatement ps = con.prepareStatement(getIDStatement);
	ps.setString(1, StartDateNewFormat);
	ps.setString(2, EndDateNewFormat);
	ps.executeQuery();
	ResultSet best_customers = ps.executeQuery();
	
	
	while(best_customers.next()){
		out.print(best_customers.getString("c.first_name"));
		out.print(" ");
		out.print(best_customers.getString("t3.total"));	
	}
	

%>
<table>
<tr>
</tr>
</table>

</body>
</html>