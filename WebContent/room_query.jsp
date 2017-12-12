<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Best Room Types</title>
</head>
<body>
<%

String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");	

String Startdate_rcv = request.getParameter("Best_Room_StartDate");
String EndDate_rcv = request.getParameter("Best_Room_EndDate");

String start_date[] = Startdate_rcv.split("-");
String StartDateNewFormat = start_date[1]+"/"+start_date[2]+"/"+start_date[0];


String end_date[] = EndDate_rcv.split("-");
String EndDateNewFormat = end_date[1]+"/"+end_date[2]+"/"+end_date[0];


String roomReviewStatement = "SELECT rReview.HotelID hotelID "+
							"FROM "+
								"(SELECT r.ReviewID, r.Rating as rating " + 
								" FROM Review r "+
								" WHERE r.isRoomReview = 1 AND "+
								" r.ReviewDate BETWEEN ? AND ? )T1, "+
  								" RoomReview_Assesed rReview "+
							" WHERE T1.ReviewID = rReview.ReviewID "+
  							" GROUP BY rReview.HotelID";

PreparedStatement ps = con.prepareStatement(roomReviewStatement);
ps.setString(1, StartDateNewFormat);
ps.setString(2, EndDateNewFormat);

ResultSet  hotelIDs = ps.executeQuery();

while(hotelIDs.next()){
	
	int currHotelID  = hotelIDs.getInt("hotelID");
	
	String statement = "SELECT max(T2.rating) topRating, T2.room as topRoom FROM (SELECT T1.Rating rating, T1.Room_no as room FROM (SELECT distinct * FROM Review NATURAL JOIN RoomReview_Assesed)T1 WHERE T1.HotelID = ? ) T2 GROUP BY T2.room";
	PreparedStatement topRoom = con.prepareStatement(statement);
	topRoom.setInt(1, currHotelID);
	
	try{
		ResultSet result = topRoom.executeQuery();
		result.next();
		
		int roomNo = result.getInt("topRoom");
		
		String roomTypeStatement = "SELECT r.RoomType typeOfRoom FROM Room r WHERE r.HotelID = ? AND r.room_no = ?";
		PreparedStatement getRoomType = con.prepareStatement(roomTypeStatement);
		getRoomType.setInt(1, currHotelID);
		getRoomType.setInt(2, roomNo);

		ResultSet result2 = getRoomType.executeQuery();
		if(result2.next()){
			String hotelNameStmt = "SELECT h.name hName FROM Hotel h WHERE h.HotelID = ?";
			PreparedStatement nameStmt = con.prepareStatement(hotelNameStmt);
			nameStmt.setInt(1, currHotelID);
			
			ResultSet currSet = nameStmt.executeQuery();
			currSet.next();
			
			String name = currSet.getString("hName");
			
			String type = result2.getString("typeOfRoom");
			out.print("<h2> The top type of room for hotel : "+ name + " is: "+type+"</h2>");
		}
		
	}catch(Exception e){
		System.out.println("Error");
	}
	
}

con.close();
%>
</body>
</html>