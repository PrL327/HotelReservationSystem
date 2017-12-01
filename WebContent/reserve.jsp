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

<%!
//method for getting the list of hotel names in our database
public List<String> getHotelNames(){
	
	try{
	String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");	

	Statement getHotels = con.createStatement();
	String hotelsString = "SELECT * FROM Hotel h";
	ResultSet hotels = getHotels.executeQuery(hotelsString);

	List<String> hotelNames = new ArrayList<String>();
	while(hotels.next()){
		String temp = hotels.getString("h.name");
		hotelNames.add(temp);
	}
	con.close();
	return hotelNames;
	}catch(Exception e){
		System.out.println("Error getting hotels names");
		return null;
	}
}
%>

<%!
//getting the rooms available in our database upon selecting a hotel

public List<Integer> getRooms(int hotel){
	try{
		String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");	
		
		Statement getRoom = con.createStatement();
		String roomStatement = "SELECT * FROM OfferRoom r WHERE r.HotelID = " + Integer.toString(hotel);
		ResultSet rooms = getRoom.executeQuery(roomStatement);
		
		List<Integer> hotelsRoom = new ArrayList<Integer>();
		
		while(rooms.next()){
			int room = rooms.getInt("r.Room_no");
			hotelsRoom.add(room);
		}
		
		
		con.close();
		return hotelsRoom;
	}catch(Exception e){
		System.out.println("Error getting hotel's room numbers");
		return null;
	}
}

%>

<%!

public int getHotelID(String hotelName){ 
	
	try{
		String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");	
		
		Statement getID = con.createStatement();
		String getIDStatement = "SELECT * FROM Hotel h WHERE h.name = " + hotelName;
		ResultSet result = getID.executeQuery(getIDStatement);
		
		int hotelID = 0;
		if(result.next()){
			hotelID = result.getInt("h.HotelID");
		}
		
		con.close();
		return hotelID;
	}catch(Exception e){
		System.out.println("Error getting the hotel's id");
		return 0;
	}
}

%>

<%!

public List<String> getHotelServices(int hotelID){
	
	try{
		String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");	
		 return null;
	
	}catch (Exception e){
		System.out.println("Error getting hotel services");
		return null;
	}
}
%>


  <form class="jumbotron">
    <div>
      <h2>Make Your Reservation</h2>
    </div>
    <div class="form-group col-2 ">
      <label for="Hotel_Selection">Hotel</label>
      <select class="form-control" id="Hotel_Selection" placeholder="Hotel..">
        <option selected="selected">Select a Hotel</option>
        <%
        List<String> hotelNames = getHotelNames();
        int count = 0;
    	while(count<hotelNames.size()){
    		out.print("<option value = \""+hotelNames.get(count)+"\">"+ hotelNames.get(count)+"</option>");
    		count++;
    	}
        %>
      </select>
    </div>
    <h4>Room Reservation Details:<Small> Reserve up to 3 Rooms</small> </h4>
    <a href="">View Hotel Rooms</a>
    <div id="RoomReservation_" style="margin-bottom:2vh; margin-top:1vh;">
      <div class="Room_">
        <fieldset class="appear">
          <h6>Room Details</h6>
          <div class="row">
            <div class="col-2">
              <div class="form-group ">
                <label for="Room_Select_">Room</label>
                <select class="form-control" id="Room_Select_">
            <option selected="selected">Pick a Room</option>
            <%
            	String hotelName = request.getParameter("hotelSelected");
                System.out.println("User selected: " + hotelName);
            	int hotelID = getHotelID(hotelName);
                if(hotelID!=0){
                	List<Integer> rooms = getRooms(hotelID);
                	int i = 0;
                	while(i < rooms.size()){
                		out.print("<option>"+Integer.toString(rooms.get(i))+"</option>");
                		i++;
                	}
                }
            
            %>
          </select>
              </div>
            </div>
            <div class="col-2">
              <div class="form-group">
                <label>Number of Guests in Room:</label>
                <input id="Num_Of_Guest_"type=text class="form-control">
              </div>
            </div>
            <div class="col-2">
              <div class="form-group">
                <label>From:</label>
                <input id="Check_in_date_" type=date class="form-control">
              </div>
            </div>
            <div class="col-2">
              <div class="form-group">
                <label>To:</label>
                <input id="Check_out_date_" type=date class="form-control">
              </div>
            </div>
          </div>
        </fieldset>
        <fieldset>
          <h6>Breakfast & Services:</h6>
          <div class="col-sm-4" style="margin-left:2vw; margin-top:1vh;">
            <div class="row" style="margin-right:2vw;" id="BreakfastOption_1">
              <div class="breakfasts col">
              <div class="form-row">
                <div class="col">
                  <div class="form-group">
                    <label for="Breakfast_Type_">Breakfast</label>
                    <select class="form-control" id="Breakfast_Type_" placeholder="Hotel..">
                      <option selected="selected">Choose a Breakfast</option>
                      <option>American</option>
                      <option>British</option>
                      <option>Mexican</option>
                      <option>Dutch</option>
                    </select>
                  </div>
                </div>
                <div class="col">
                  <div class="form-group">
                    <label for="BQuantity_">Quantity</label>
                    <input class="form-control" size=2>
                  </div>
                </div>
              </div>
              </div>
              </div>
            <div class="col-sm-6" id="ServicesOption_">
              <div class="services form-group">
                <label for="Services_">Services</label>
                <select class="form-control" id="Services_" placeholder="Hotel..">
                  <option selected="selected">Choose a Service</option>
                  <option>Spa</option>
                  <option>Parking</option>
                  <option>Conference</option>
                  <option>Shuttle</option>
                </select>
              </div>
            </div>
          </div>
          <div class="form-row">
            <div class="col-sm-2">
              <a href="#" class="addservices">Add another Service</a>
            </div>
            <div class="col">
              <a href="#" class="addbreakfast">Add another Breakfast</a>
            </div>
          </div>
        </fieldset>
      </div>
    </div>
    <div class="form-row">
      <div class="col-sm-2">
        <button href="#" class='btn btn-primary addsection'>Add Another Room</button>
      </div>
      <div class="col">
        <button type="Button" href="#" id="next" class='next btn btn-success'>Next</button>
      </div>
    </div>
    <div id="Payment_info" class="hidden">
    <fieldset style="margin-top:3vh;">
      <h4>Payment Info</h4>
      <div class='row'>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>Card Number</label>
            <input class='form-control' type='text' id="card_num">
          </div>
        </div>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>Card Type</label>
            <select class="form-control" id="card_type" placeholder="Hotel..">
            <option selected="selected">Card Type</option>
            <option>Visa</option>
            <option>MasterCard</option>
            <option>Amex</option>
            <option>Discover</option>
          </select>
          </div>
        </div>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>CVC Num</label>
            <input class='form-control' type='text' size=3 placeholder="CVC" id="cvc_num">
          </div>
        </div>
      </div>
      <div class='row'>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>Name on Card</label>
            <input class='form-control' type='text' id="name_on_card">
          </div>
        </div>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>Exp Date</label>
            <input class='form-control' type='month' id="exp_date">
          </div>
        </div>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>Billing Address</label>
            <input class='form-control' type='text' size=3 placeholder="Address" id="billing_addr">
          </div>
        </div>
      </div>
    </fieldset>
    <button type="add" class="btn btn-primary btn-lg">Submit</button>
  </div>
  </form>
</body>
</html>