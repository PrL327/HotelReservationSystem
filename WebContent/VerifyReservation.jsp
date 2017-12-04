<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
Hello
<%
	float total = Float.valueOf(request.getParameter("totalPrice"));
	int roomNo = Integer.valueOf(request.getParameter("room"));
	String bType = request.getParameter("breakfast");
	String sType = request.getParameter("service");
	String card_num = request.getParameter("card_num");
	String card_type = request.getParameter("card_type_used");
	String cvc_num = request.getParameter("cvc_num");
	String name_on_card = request.getParameter("name_on_card");
	String exp_date = request.getParameter("exp_date");
	String billing_addr = request.getParameter("billing_addr");
	int hotelID = Integer.valueOf(request.getParameter("hotelID"));
	String checkIn = request.getParameter("Check_in_date_1");
	String checkOut = request.getParameter("Check_out_date_1");
	
	

	int customerID = Integer.valueOf((String)session.getAttribute("userID"));

	
	
	String print = "total: "+ total + " roomNo: "+roomNo + " type: "+ bType + " sType: "+ sType;
	String print2 = "card_num: "+card_num + " card_type: "+card_type + " cvc_num: "+ cvc_num;
	
	out.print(print + print2);
	
	try{
		String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");	
		
		String createInvoice = "SELECT * FROM Reservation_Made rm WHERE rm.InvoiceNo = ?";
		PreparedStatement findInvoice = con.prepareStatement(createInvoice);
		
		int invoiceNo = Integer.MIN_VALUE;
		
		boolean done = false;
		//finding a voiceNo that doesnt work
		while(!done){
			try{
				invoiceNo = (int)(Math.random() * 99999999+10000000);
				findInvoice.setInt(1, invoiceNo);
				ResultSet result1 = findInvoice.executeQuery();
				
				if(result1.next()){
				}else{
					done = true;
					break;
				}
			}catch(Exception e){
				//set it emptry
				done = true;
				break;
				
			}
		}
		
		//inserting the reservation
		
		String insertStatement = "INSERT INTO Reservation_Made VALUES(?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement insertRes = con.prepareStatement(insertStatement);
		insertRes.setInt(1,invoiceNo);
		insertRes.setInt(2,roomNo);
		insertRes.setInt(3, hotelID);
		//simple code
		String today = "12/3/2017";
		insertRes.setString(4,today);
		insertRes.setFloat(5, total);
		insertRes.setInt(6,customerID);
		insertRes.setString(7,card_num);
		
		try{
			
			insertRes.executeUpdate();
			
			System.out.println("Successful insert reservation_made");
			
		}catch(Exception e){
			System.out.println("Not able to add registration");
		}
		
		
		//Inserting into Reservation_Containts
		                                     
		String insertContains = "INSERT INTO Reservation_Contains VALUES(?,?,?)";
		PreparedStatement containsPs = con.prepareStatement(insertContains);
		containsPs.setInt(1,invoiceNo);
		containsPs.setString(2,sType);
		containsPs.setInt(3,hotelID);
		
		try{
			containsPs.executeUpdate();
		}catch(Exception e){
			System.out.println("Unable to enter into contains");
		}
		
		//Inserting into Reservation_Includes
		String insertIncludes = "INSERT INTO Reservation_Includes VALUES(?,?,?)";
		PreparedStatement includesPs = con.prepareStatement(insertIncludes);
		includesPs.setInt(1, invoiceNo);
		includesPs.setString(2, bType);
		includesPs.setInt(3, hotelID);
		
		try{
			includesPs.executeUpdate();
		}catch(Exception e){
			System.out.println("unable to insert into includes table");
		}
		
		
		//Inserting into Room_Reserves
		
		String roomReserveStatement = "INSERT INTO Room_Reserves VALUES(?,?,?,?,?,?)";
		PreparedStatement roomReserves = con.prepareStatement(roomReserveStatement);
		roomReserves.setInt(1, invoiceNo);
		roomReserves.setInt(2, roomNo);
		roomReserves.setInt(3, hotelID);
		roomReserves.setString(4, checkOut);
		roomReserves.setString(5, checkIn);
		roomReserves.setInt(6,0);
		
		try{
			roomReserves.executeUpdate();
		}catch(Exception e){
			System.out.println("Unable to add to Room Reserves");
		}
		
		//inserting into credit card database
		
		String cardStatement = "INSERT INTO CreditCard VALUES(?,?,?,?,?,?)";
		PreparedStatement insertCard = con.prepareStatement(cardStatement);
		insertCard.setString(1, card_num);
		insertCard.setString(2, card_type);
		insertCard.setString(3, cvc_num);
		insertCard.setString(4, name_on_card);
		insertCard.setString(5, billing_addr);
		insertCard.setString(6, exp_date);
		
		try{
			insertCard.executeUpdate();
		}catch(Exception e){
			System.out.println("unadle to add to credit card database");
		}
		con.close();
		out.print("succesful");
	}catch(Exception e){
		out.print("failed");
		System.out.println("Error");
	}
	
%>
</body>
</html>