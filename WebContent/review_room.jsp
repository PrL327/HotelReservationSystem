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
  <script src="js/reserve.js"></script>
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
String room_Invoice = request.getParameter("invoice_no_for_room");
String hotel_id = request.getParameter("r_hotelID");


%>

<%!
public List<String> getRoomTypes(String room_Invoice){
	
	
	try{
	String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");	
	
	Statement getRoom = con.createStatement();
	String roomString = "SELECT Room_Reserves.Room_no, Room_Reserves.HotelID FROM Room_Reserves WHERE Room_Reserves.InvoiceNo = "+room_Invoice;
    ResultSet room = getRoom.executeQuery(roomString);
   
	List<String> roomNames = new ArrayList<String>();
	while(room.next()){
		String temp = room.getString("Room_Reserves.Room_no");
		roomNames.add(temp);
		String hotel_id = room.getString("Room_Reserves.HotelID");
	}
	con.close();
	return roomNames;
	
	}catch(Exception e){
		System.out.println("Error getting Rooms Reserved");
		return null;
	}
}
%>


  <form class="jumbotron" method = "selectedHotel" action = "store_room_review.jsp">
    <div>
      <h2>Write a Review</h2>
    </div>
    <div class="form-group col-2 ">
      <label for="Hotel_Selection">Room</label>
      <select class="form-control" id="rType_review" name="rTypes">
        <option selected="selected">Select Type</option>
        <%
        List<String> roomNames = getRoomTypes(room_Invoice);
        int count = 0;
    	while(count<roomNames.size()){
    		out.print("<option value = \""+roomNames.get(count)+"\">"+ roomNames.get(count)+"</option>");
    		count++;
    	}
        %>
      </select>
     
	<div style="width: 400px;">
</div>
<div style="padding-bottom: 18px;">Rate this Room<br/>
	<select id="data_3" name="r_rating" style="width : 150px;" class="form-control">
		<option value = "10">10</option>
		<option value = "9">9</option>
		<option value = "8">8</option>
		<option value = "7">7</option>
		<option value = "6">6</option>
		<option value = "5">5</option>
		<option value = "4">4</option>
		<option value = "3">3</option>
		<option value = "2">2</option>
		<option value = "1">1</option>
	</select>
</div>

<div style="padding-bottom: 18px;">Text Comment<span style="color: red;"> *</span><br/>
	<textarea id="data_8"  name="r_comment" style="width : 450px;" rows="10" class="form-control"></textarea>
</div>
<%-- <input class ="hidden" value = <%hotel_id;%>> --%>
<%out.print("<input name=\"review_hotelID\" class='hidden' value =\""+hotel_id+"\">"); %>
<input class = "btn btn-success" type="submit" value="submit">
</form>
   
</body>
</html>