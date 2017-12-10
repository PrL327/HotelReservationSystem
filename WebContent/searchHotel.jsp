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
  
  <script>
  
  var states = ["MA","CO","OR","WI"];
  var cities = new Array(5);
  
  cities["empty"] = ["select a state"];
  cities["MA"] = ["Nantucket"];
  cities["CO"] = ["Mountain Village", "Denver"];
  cities["OR"] = ["Cannon Beach"];
  cities["WI"] = ["La Crosse"];

  </script>

  <script>
  
  function getStates(countryOp){
	  
	  var index = countryOp.selectedIndex;
	  
	  var sOptions = document.getElementById("states");
		  
	  while(sOptions.length > 0){
		  sOptions.remove(0);
	  }
	  //remove the city options
	  var cOptions = document.getElementById("city");
	  while(cOptions.length > 0){
		  cOptions.remove(0);
	  }
	  
	  var newOption; 
	  
	  newOption = document.createElement("option");
	  newOption.value = "default";
	  newOption.text = "Select a City";
	  try{
		  cOptions.add(newOption);
	  }catch(e){
		  cOptions.appendChild(newOption);
	  }
	  
	  if(index>0){
		  for (var i=0; i<states.length; i++) { 
		  newOption = document.createElement("option"); 
		  newOption.value = states[i]; 
		  newOption.text= states[i]; 
		  
		  try { 
		 	 sOptions.add(newOption);  
		  } 
		  catch (e) { 
		  	sOptions.appendChild(newOption); 
		  } 
		  }
	  }else{
		  newOption = document.createElement("option");
		  newOption.value = "default";
		  newOption.text = "Select a State";
		  
		  try { 
			 	 sOptions.add(newOption);  
			  } 
			  catch (e) { 
			  	sOptions.appendChild(newOption); 
			  }
		  
	  }
	  
  }
  
  </script>
  
  <script>
  
  function getCity(stateOp){
	  
	  var index = stateOp.selectedIndex;
	  var state = stateOp.options[index].value;
	  
	  
	  var cList = document.getElementById("city");
	  
	  var cArray = cities[state];
	  
	  while(cList.length > 1){
		  cList.remove(1);
	  }
	  
	  for (var i=0; i<cArray.length; i++) { 
		  newOption = document.createElement("option"); 
		  newOption.value = cArray[i]; 
		  newOption.text= cArray[i]; 
		  // add the new option 
		  try { 
		  cList.add(newOption);  // this will fail in DOM browsers but is needed for IE 
		  } 
		  catch (e) { 
		  cList.appendChild(newOption); 
		  } 
		  }
	  
  }
  </script>
  
  <script>
  
  function informMe(message){
	  alert(message);
  }
  
  </script>
</head>

<body>

<%

try{
	
	String message =  (String)session.getAttribute("Reservation_STATUS");
	
	if(message!=null && message.length() > 0){
		%><script>
			informMe(<%= message%>)
		</script>
		<%
	}
	
}catch(Exception e){
	//no error
}

%>

<form class="jumbotron" method = "searchedHotel" action = "reserve.jsp">
    <div>
      <h2>Make Your Reservation</h2>
    </div>
    <div class="form-group col-2 ">
      <label for="Hotel_Selection">Hotel</label>
     
       <select id="country" name = "country" onchange ="getStates(this);">
	      <option value = "default">Select a Country</option>
	      <option value = "United States">United States</option>
      </select>
      &nbsp;
      <select id="states" name = "state" onchange = "getCity(this);">
      <option value = "default">Select a state</option>
      </select>
      &nbsp;
      <select id="city" name = "city">
      <option value = "default">Select a city</option>
      </select>&nbsp;<br> <input type="submit" value="submit">
      
   	
   	</div>
</form>


</body>
</html>