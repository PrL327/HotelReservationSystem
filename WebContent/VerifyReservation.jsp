<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "com.Hotel.RoomDetails" %>
<%@ page import = "com.Hotel.Today" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
boolean failed = false;
String message = "";
String card_type = request.getParameter("card_type_used");
String card_num = request.getParameter("card_num");
String cvc_num = request.getParameter("cvc_num");
String name_on_card = request.getParameter("name_on_card");
String exp_date = request.getParameter("exp_date");
String billing_addr = request.getParameter("billing_addr");

if(card_type == null || card_num ==null || cvc_num == null || name_on_card == null || exp_date == null || billing_addr == null){
	failed = true;
	message = "Invalid payment information";
}

if(!failed){
	String todaysDate = Today.getToday();
	
	String[] todayArr = todaysDate.split("/");
	int todaysValue = Integer.valueOf(todayArr[2])*365 + Integer.valueOf(todayArr[0]);
	int expValue = 0;
	String[] expArr = exp_date.split("/");
	if(expArr.length > 1){
		expValue = Integer.valueOf(expArr[0])*365 + Integer.valueOf(expArr[1]);
	}else{
		String[] other = exp_date.split("-");
		expValue = Integer.valueOf(other[0])*365 + Integer.valueOf(other[1]);
	}
	
	if(expValue < todaysValue){
		message = "Card has expired";
		failed = true;
	}
}

int numOfRooms = Integer.valueOf(request.getParameter("numOfRoomsReserved"));

List<RoomDetails> rooms = new ArrayList<RoomDetails>();

int i = 1;
if(!failed){
	try{
		while(i<=numOfRooms ){
			RoomDetails temp = new RoomDetails();
			int roomNum = 0;
			String roomRequest = "roomPicked_"+String.valueOf(i);
			try{
				roomNum = Integer.valueOf(request.getParameter(roomRequest));
			}catch(Exception e){
				i++;
				continue;
			}
			temp.roomNum = roomNum;
			temp.checkInDate = request.getParameter("Check_in_date_"+String.valueOf(i));
			temp.checkOutDate = request.getParameter("Check_out_date_"+String.valueOf(i));
			
			float total = Float.valueOf(request.getParameter("totalForRoom_"+String.valueOf(i)));
			temp.total = Math.round(total*100)/100;
			
			//setting the number of days stayed and update the the total
			System.out.println("Error after line 50");
			message = temp.setDays();
			if(message.compareTo("OK")!=0){
				//there was some error setting the days reserved
				i += numOfRooms;
				failed = true;
				continue;
			}
			
			int j = 1;//second variable for item
			
			
			try{
				while(request.getParameter("Breakfast_Type_"+String.valueOf(i)+"_"+String.valueOf(j))!=null){
					String received = request.getParameter("Breakfast_Type_"+String.valueOf(i)+"_"+String.valueOf(j));
					temp.bTypes.add(received);
					j++;
				}
			}catch(Exception e){
				System.out.println("Error getting breakfast types");
			}
			
			j = 1;		
			
			try{
				while(request.getParameter("Quantity_"+String.valueOf(i)+"_"+String.valueOf(j))!=null){
					String received = request.getParameter("Quantity_"+String.valueOf(i)+"_"+String.valueOf(j));
					temp.bQuantity.add(Integer.valueOf(received));
					j++;
				}
			}catch(Exception e){
				System.out.println("Error getting quantity type");
			}
			j= 1;
			try{
				while(request.getParameter("Services_"+String.valueOf(i)+"_"+String.valueOf(j))!=null){
					String received = request.getParameter("Services_"+String.valueOf(i)+"_"+String.valueOf(j));
					temp.sTypes.add(received);
					j++;
				}
			}catch(Exception e){
				System.out.println("Error getting services");
			}
			rooms.add(temp);
			i++;
		}
	} catch(Exception e){
		System.out.println("There was some error getting details of the rooms");
	}
}

int customerID = Integer.valueOf((String)session.getAttribute("userID"));
int hotelID = Integer.valueOf(request.getParameter("hotelID"));

Connection con = null;

try{
	String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection(url, "HotelDBMS", "password");	
}catch(Exception e ){
	System.out.println("Unable to connect to the database");
	failed = true;
}




//check if the room is current reserved or not

try{
	
	String datesGen = "SELECT * FROM Room_Reserves r WHERE r.Room_no = ? and r.HotelID = ?";
	PreparedStatement reservedRooms = con.prepareStatement(datesGen);
	
	
	int curr = 0;
	while(curr< rooms.size()){
		RoomDetails currRoom = rooms.get(curr);
		int currRoomNo = currRoom.roomNum;
		String checkOut = currRoom.checkOutDate;
		String checkIn = currRoom.checkInDate;
		
		reservedRooms.setInt(1, currRoomNo);
		reservedRooms.setInt(2, hotelID);
		
		try{
			ResultSet currResult = reservedRooms.executeQuery();
			
			currResult.next();
			String tableOut = currResult.getString("r.OutDate");
			String tableIn = currResult.getString("r.InDate");
			
			if(checkIn.compareTo(tableIn)>=0 && checkIn.compareTo(tableOut)<0){
				//room is already booked
				message = "Room: "+currRoomNo+" is currently booked during those days";
				failed = true;
				break;
			}
			
			if(checkOut.compareTo(tableIn)>0 && checkOut.compareTo(tableOut)<=0){
				//room is already booked
				message = "Room: "+currRoomNo+" is currently booked during those days";
				failed = true;
				break;
			}
			
		}catch(Exception e){
			curr++;
			continue;
		}
		
		
		
		curr++;
	}
}catch(Exception e){
	System.out.println("Some error");
}


if(failed){
	//there was some error with the days and stuff
	if(con!=null){
		con.close();
	}
	session.setAttribute("Reservation_STATUS", message);
	System.out.println(message);
	String redirectPage = "searchHotel.jsp";
	response.sendRedirect(redirectPage);
}else{

	try{
		
		
		String createInvoice = "SELECT * FROM Reservation_Made rm WHERE rm.InvoiceNo = ?";
		PreparedStatement findInvoice = con.prepareStatement(createInvoice);
		
		int invoiceNo = Integer.MIN_VALUE;
		
		boolean done = false;
		//finding an invoiceNo that has not been used
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
		int roomOneNum = rooms.size();
		float total = 0;
		int t = 0;
		//summing the total will need to take into accout num of days
		while(t<rooms.size()){
			total += rooms.get(t).total;
			t++;
		}
		
		String insertStatement = "INSERT INTO Reservation_Made VALUES(?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement insertRes = con.prepareStatement(insertStatement);
		insertRes.setInt(1,invoiceNo);
		insertRes.setInt(2, hotelID);
		String today = Today.getToday();
		insertRes.setString(3,today);
		insertRes.setFloat(4, total);
		insertRes.setInt(5,customerID);
		insertRes.setString(6,card_num);
		insertRes.setInt(7,roomOneNum);
		
		try{
			
			insertRes.executeUpdate();
			
			System.out.println("Successful insert reservation_made");
			
		}catch(Exception e){
			String called = insertRes.toString();
			System.out.println("Not able to add registration");
			System.out.println(called);
			System.out.println("InvoiceNO: "+invoiceNo + "\nHotelId: "+ hotelID + "\ntoday: "+ today + "\ntotal: "+ total +"\ncardNum: "+ card_num);
			System.out.println("CustomerID: "+customerID +"\nRoomNum: "+roomOneNum );
		}
		
		int k = 0;
		while(k<rooms.size()){	
			RoomDetails currRoom = rooms.get(k);
			int roomNo = currRoom.roomNum;
			//Inserting into Reservation_Containts
			List<String> currServices = currRoom.sTypes;
			int s = 0;
			while(s< currServices.size()){
				String sType = currServices.get(s);
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
				s++;
			}
			List<String> currBreakfasts = currRoom.bTypes;
			int b = 0;
			while(b<currBreakfasts.size()){
				//Inserting into Reservation_Includes
				String bType = currBreakfasts.get(b);
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
				b++;
			}
			
			
			//Inserting into Room_Reserves
			String checkOut = currRoom.checkOutDate;
			String checkIn = currRoom.checkInDate;
			String roomReserveStatement = "INSERT INTO Room_Reserves VALUES(?,?,?,?,?,?)";
			PreparedStatement roomReserves = con.prepareStatement(roomReserveStatement);
			roomReserves.setInt(1, invoiceNo);
			roomReserves.setInt(2, roomNo);
			roomReserves.setInt(3, hotelID);
			roomReserves.setString(4, checkOut);
			roomReserves.setString(5, checkIn);
			int days = currRoom.numOfDays;
			roomReserves.setInt(6,days);
			
			try{
				roomReserves.executeUpdate();
			}catch(Exception e){
				System.out.println("Unable to add to Room Reserves");
			}
			k++;
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
			System.out.println("unable to add to credit card database");
		}
		con.close();
		message = "Reservation made";
		session.setAttribute("Reservation_STATUS", message);
		System.out.println(message);
		String redirectPage = "user_dashboard.jsp";
		response.sendRedirect(redirectPage);
	}catch(Exception e){
		String redirectPage = "searchHotel.jsp";
		response.sendRedirect(redirectPage);
	}
}
%>
</body>
</html>