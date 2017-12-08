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
//using the search result of the user, this page will generate a list of hotels that are available by name
public List<String> getHotelNames(HttpServletRequest request){
	
	
	String country = request.getParameter("country");
	String state = request.getParameter("state");
	String city = request.getParameter("city");
	List<String> hotelNames = new ArrayList<String>();
	
	
	try{
		String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");	
		   
		String getByLocation = "SELECT * FROM Location l WHERE l.Country = ? AND l.state = ? AND l.City = ?";
		PreparedStatement ps = con.prepareStatement(getByLocation);
		ps.setString(1, country);
		ps.setString(2, state);
		ps.setString(3, city);
		
		ResultSet result = ps.executeQuery();
	
		while(result.next()){
			
			int hotelId = result.getInt("l.HotelID");
			System.out.println(hotelId);
			String getHotelName = "SELECT * FROM Hotel h WHERE h.HotelID = ?";
			PreparedStatement hotelStatement = con.prepareStatement(getHotelName);
			
			hotelStatement.setInt(1,hotelId);
			
			
			try{
				ResultSet returnedName = hotelStatement.executeQuery();
				returnedName.next();
				hotelNames.add(returnedName.getString("h.name"));
			}catch(Exception e){
				System.out.println("There was an error getting the hotel names");
			}
		}
	}catch(Exception e){
		System.out.println("There was an error making the hotel search call ");
	}
	
	return hotelNames;
}
%>


  <form class="jumbotron" method = "selectedHotel" action = "HotelOptions.jsp">
    <div>
      <h2>Make Your Reservation</h2>
    </div>
    <div class="form-group col-2 ">
      <label for="Hotel_Selection">Hotel</label>
      <select class="form-control" id="Hotel_Selection" name="hotelName">
        <option selected="selected">Select a Hotel</option>
        <%
        List<String> hotelNames = getHotelNames(request);
        int count = 0;
    	while(count<hotelNames.size()){
    		out.print("<option value = \""+hotelNames.get(count)+"\">"+ hotelNames.get(count)+"</option>");
    		count++;
    	}
        %>
      </select><input class = "btn btn-success" type="submit" value="submit">
    </div>
  </form>
</body>
</html>