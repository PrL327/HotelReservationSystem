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
  </head>
  <body>
  <%
  	String user = (String)session.getAttribute("userID");
  	int userID = Integer.parseInt(user);
  	
  	String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");
	
	String findCustomer ="SELECT * FROM Customer c WHERE c.ID = ?";
	PreparedStatement findStatement = con.prepareStatement(findCustomer);
	findStatement.setInt(1, userID);
	
	ResultSet result = findStatement.executeQuery();
	
	result.next();
	
	String firstName = result.getString("c.first_name");
	String email = result.getString("c.Email");
	String address = result.getString("c.Address");
	String phone = result.getString("c.Phone_no");
	String lastName = result.getString("c.last_name");
	
	System.out.println("Email: "+ email + " address: "+ address);
	
  %>
    <div class="container">
      <h1>User Dashboard</h1>
      <div class="jumbotron">
        <h4>User Details:</h4>
        <div class="row" style="margin-left:3vw;">
          <div class="col">
            <div class="row" style="margin-bottom:1vh;">
              <Label>Name: <% out.print(firstName +" " + lastName); %>&nbsp; </Label>
            </div>
            <div class="row">
              <Label>Email: <% out.print(email); %>&nbsp; </Label>
            </div>
          </div>
          <div class="col">
            <div class="row" style="margin-bottom:1vh;">
              <Label>Phone: <% out.print(phone); %>&nbsp;</Label>
            </div>
            <div class="row">
              <Label>Address: <% out.print(address); %>&nbsp; </Label>
            </div>
          </div>
        </div>
      </div>
      <div>
        <h4>Reservations:</h4>
          <table class="table">
            <thead>
              <tr>
                <th>Invoice #</th>
                <th>Hotel</th>
                <th>Room</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>More..</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Num</td>
                <td>Hotel Name</td>
                <td>Room Number</td>
                <td>Start</td>
                <td>End</td>
                <td>HyperLink<td>
              </tr>
            </tbody>
        </table>
      <Button class="btn btn-success">Reserve</Button>
      </div>
    </div>
  </body>
</html>
