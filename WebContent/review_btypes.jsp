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
public List<String> getBreakfastTypes(){
	
	try{
	String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");	
    
	Statement getBTypes = con.createStatement();
	String entity = request.getParameter("invoice_no_for_breakfast");
	String bTypesString = " SELECT Reservation_Includes.bType FROM Reservation_Includes GROUP BY Reservation_Includes.HotelID HAVING Reservation_Includes.InvoiceNo =" + entity;
    ResultSet bType = getBTypes.executeQuery(bTypesString);

	List<String> bTypeNames = new ArrayList<String>();
	while(bType.next()){
		String temp = bType.getString("Reservation_Includes.bType");
		bTypeNames.add(temp);
	}
	con.close();
	return bTypeNames;
	
	}catch(Exception e){
		System.out.println("Error getting Breakfast Types");
		return null;
	}
}
%>


  <form class="jumbotron" method = "selectedHotel" action = "user_dashboard.jsp">
    <div>
      <h2>Write a Review</h2>
    </div>
    <div class="form-group col-2 ">
      <label for="Hotel_Selection">Breakfast Type</label>
      <select class="form-control" id="bType_review" name="bTypes">
        <option selected="selected">Select Type</option>
        <%
        List<String> bTypeNames = getBreakfastTypes();
        int count = 0;
    	while(count<bTypeNames.size()){
    		out.print("<option value = \""+bTypeNames.get(count)+"\">"+ bTypeNames.get(count)+"</option>");
    		count++;
    	}
        %>
      </select>
     
	<div style="width: 400px;">
</div>
<div style="padding-bottom: 18px;">Rate this Breakfast<br/>
<select id="data_3" name="data_3" style="width : 150px;" class="form-control">
<option>10</option>
<option>9</option>
<option>8</option>
<option>7</option>
<option>6</option>
<option>5</option>
<option>4</option>
<option>3</option>
<option>2</option>
<option>1</option>
</select>
</div>
<div style="padding-bottom: 18px;">Text Comment<span style="color: red;"> *</span><br/>
<textarea id="data_8" ${readonly} name="data_8" style="width : 450px;" rows="10" class="form-control"></textarea>
</div>

<input class = "btn btn-success" type="submit" value="submit">
</form>
   
</body>
</html>