<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import= "com.Hotel.HotelRoom"%>
<%@ page import= "com.Hotel.HotelServices" %>
<%@ page import = "com.Hotel.HotelBreakfast" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String hotelSelected = request.getParameter("hotelName");
System.out.println(hotelSelected);

int hotelID = 0;
List<HotelServices> hotelsServices = new ArrayList<HotelServices>();
List<HotelRoom> hotelsRooms = new ArrayList<HotelRoom>();
List<HotelBreakfast> hotelsBreakfast = new ArrayList<HotelBreakfast>();

try{
	String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");	
	
	String getIDStatement = "SELECT * FROM Hotel h WHERE h.name = ?";
	PreparedStatement ps = con.prepareStatement(getIDStatement);
	ps.setString(1, hotelSelected);
	ResultSet result = ps.executeQuery();
	
	
	if(result.next()){
		hotelID = result.getInt("h.HotelID");
	}
	
	if(hotelID == 0){
		System.out.println("Not able to find hotel id");
		con.close();
		out.close();
	}
	
	//Statement to get hotel services 
	try{
		String servicesStatement = "SELECT * FROM OffersServices s WHERE s.HotelID = ?";
		PreparedStatement ps2 = con.prepareStatement(servicesStatement);
		ps2.setInt(1, hotelID);
		
		
		ResultSet services = ps2.executeQuery();
		
		
		
		while(services.next()){
			String service = services.getString("s.sType");
			float cost = services.getFloat("s.sCost");
			HotelServices temp = new HotelServices(hotelID, service, cost);
			hotelsServices.add(temp);
		}
	}catch(Exception e){
		System.out.println("Error getting the services");
	}
	
	//Statement to get hotelRooms
	try{
		
		String roomStatement = "SELECT * FROM Room r WHERE r.HotelID = ?";
		PreparedStatement getRoom = con.prepareStatement(roomStatement);
		getRoom.setInt(1, hotelID);
		
		ResultSet rooms = getRoom.executeQuery();
		
		while(rooms.next()){
			int room = rooms.getInt("r.room_no");
			float rPrice = rooms.getFloat("r.Price");
			int rCapacity = rooms.getInt("r.Capacity");
			int floor_no = rooms.getInt("r.Floor_no");
			String description = rooms.getString("r.Description");
			String roomType = rooms.getString("r.RoomType");
			HotelRoom tempR = new HotelRoom(hotelID, room, rPrice, rCapacity, floor_no, roomType);
			tempR.addDescription(description);
			
			hotelsRooms.add(tempR);
		}
	}catch(Exception e){
		System.out.println("Error getting rooms");
	}
	
	//Statement to get hotelBreakfeastest
	try{
		String breakfastStatement = "SELECT * FROM OffersBreakfast b WHERE b.HotelID = ?";
		PreparedStatement getBreakfast = con.prepareStatement(breakfastStatement);
		getBreakfast.setInt(1, hotelID);
		
		ResultSet breakfasts = getBreakfast.executeQuery();
		
		while(breakfasts.next()){
			String description = breakfasts.getString("b.Description");
			float bPrice = breakfasts.getFloat("b.bPrice");
			String bType = breakfasts.getString("b.bType");
			System.out.println(bType);
			HotelBreakfast tmpB = new HotelBreakfast(hotelID, description, bPrice, bType);
			hotelsBreakfast.add(tmpB);
		}
	}catch(Exception e ){
		System.out.println("Erorr getting the breakfasts");
	}
	con.close();
}catch(Exception e){
	System.out.println("Error getting the hotel's id");	
}



String[] sTypeList = null;
String[] sCostList = null;
int k = 0;
if(hotelsServices!=null){
	int numServices = hotelsServices.size();
	sTypeList = new String[numServices];
	sCostList = new String[numServices];
	while(k<hotelsServices.size()){
		sTypeList[k] = hotelsServices.get(k).type;
		sCostList[k] = Float.toString(hotelsServices.get(k).cost);
		k++;
	}
}

String[] room_no = null;
String[] rPrice = null;
String[] rCapacity = null;
String[] floor_no = null;
String[] rDescription = null;
String[] rType = null;

if(hotelsRooms!=null){
	int numRooms = hotelsRooms.size();
	room_no = new String[numRooms];
	rPrice = new String[numRooms];
	rCapacity = new String[numRooms];
	floor_no = new String[numRooms];
	rDescription = new String[numRooms];
	rType = new String[numRooms];
	
	k = 0;
	while(k<hotelsRooms.size()){
		HotelRoom tmp = hotelsRooms.get(k);
		room_no[k] = Integer.toString(tmp.roomNum);
		rPrice[k] = Float.toString(tmp.price);
		rCapacity[k] = Integer.toString(tmp.capacity);
		floor_no[k] = Integer.toString(tmp.floorNo);
		rDescription[k] = tmp.description;
		rType[k] = tmp.roomType;
		k++;
	}
}

String[] bDescriptionList = null;
String[] bPriceList = null;
String[] bTypeList = null;

if(hotelsBreakfast!=null){
	int numOfBreakfast = hotelsBreakfast.size();
	bDescriptionList = new String[numOfBreakfast];
	bPriceList = new String[numOfBreakfast];
    bTypeList = new String[numOfBreakfast];
	
	k = 0;
	while(k < hotelsBreakfast.size()){
		HotelBreakfast bTemp = hotelsBreakfast.get(k);
		bDescriptionList[k] = bTemp.description;
		bPriceList[k] = Float.toString(bTemp.price);
		bTypeList[k] = bTemp.type;
		k++;
	}
	
}

%>

<%!
public static String toScriptArray(String[] arr){
	if(arr == null){
		return "";
	}
    StringBuffer sb = new StringBuffer();
    sb.append("[");
    for(int i=0; i<arr.length; i++){
        sb.append("\"").append(arr[i]).append("\"");
        if(i+1 < arr.length){
            sb.append(",");
        }
    }
    sb.append("]");
    return sb.toString();
}
%>

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
  var serviceTypeArray = <%= toScriptArray(sTypeList)%> 
  var serviceCostArray = <%= toScriptArray(sCostList)%>
  
  var roomNoArray = <%= toScriptArray(room_no)%> 
  var roomPriceArray = <%= toScriptArray(rPrice)%>
  var roomCapacityArray = <%= toScriptArray(rCapacity)%>
  var floorNoArray = <%= toScriptArray(floor_no)%> 
  var roomDescription = <%= toScriptArray(rDescription)%>
  var roomType = <%= toScriptArray(rType)%> 
  
  var breakfastDescriptions = <%= toScriptArray(bDescriptionList) %>
  var breakfastPriceList = <%= toScriptArray(bPriceList)%>
  var breakfastType = <%= toScriptArray(bTypeList) %>
  
  var currTotal = 0;

  </script>
  
  <script type="text/javascript"> 
  
  var roomCount = 1;
  
  function updatePrice(selectObj){
	  // get the index of the selected option 
	  var idx = selectObj.selectedIndex;
	  // get the country select element via its known id 
	  var cSelect = document.getElementById("test");
	  var total = 0;
	  
	  total = +roomPriceArray[idx-1];
	  
	  var bSelectIndex = document.getElementById("Breakfast_Type_");
	  
	  total = +total + +breakfastPriceList[bSelectIndex.selectedIndex-1];
	  total = Math.round(total*100)/100
	  cSelect.innerHTML = total;
  }
  
  function populateBreakfast(){
	  
	  var cSelect = document.getElementById("Breakfast_Type_"); 
	  // remove the current options from the country select 
	  var len=cSelect.options.length; 
	  while (cSelect.options.length > 0) { 
	  cSelect.remove(0); 
	  } 
	  var newOption; 
	  // create new options 
	  for (var i=0; i<breakfastType.length; i++) { 
	  newOption = document.createElement("option"); 
	  newOption.value = breakfastType[i];  // assumes option string and value are the same 
	  newOption.text=breakfastType[i]; 
	  // add the new option 
	  try { 
	  cSelect.add(newOption);  // this will fail in DOM browsers but is needed for IE 
	  } 
	  catch (e) { 
	  cSelect.appendChild(newOption); 
	  } 
	  }
	  
  }
  
  function cloneReserve(){
	  var roomAreaID = "Room_1";
	  roomAreaID=  roomAreaID + roomCount;
	  
	  var roomArea = document.getElementById("Room_1");
	  var roomAreaClone = roomArea.cloneNode(true);
	  
	  roomCount = +roomCount + 1;
	  
	 // roomAreaClone.setAttribute("class","Room_"+roomCount);
	  //roomAreaClone.setAttribute("id","Room_"+roomCount);
	  document.getElementById("RoomReservation_").appendChild(roomAreaClone);
	  
	  //updateIDs();
	 // 
  }
  
  function updateIDs(){
	  var newRoomID = "Room_"+roomCount;
	  var newRoomArea = document.getElementById(newRoomID);
	  var updateFormControl = newRoomArea.getElementsByClassName("form-control");
	  var updateButton = newRoomArea.getElementsByClassName("col");
	  
	  var optionsButton = updateButton[0];
	  optionsButton.setAttribute("id","options_"+roomCount);
	  //update room select id
	  var room_select = updateFormControl[0];
	  room_select.setAttribute("id","roomSelection_"+roomCount);
	  
	  //update num of guess id
	  var num_of_guest = updateFormControl[1];
	  num_of_guest.setAttribute("id","Num_Of_Guest_"+roomCount);
	  
	  //update check in date
	  var check_in_date = updateFormControl[2];
	  check_in_date.setAttribute("id","Check_in_date_"+roomCount);
	  
	  //update id of checkout date
	  var check_out_date = updateFormControl[3];
	  check_out_date.setAttribute("id","Check_out_date_"+roomCount);
	  
	  var breakfast_type = updateFormControl[4];
	  breakfast_type.setAttribute("id", "Breakfast_Type_"+roomCount);
	  
	  var quantity = updateFormControl[5];
	  quantity.setAttribute("id","Quantity_"+roomCount);
	  
	  var services__ = updateFormControl[6];
	  services__.setAttribute("id", "Services_"+roomCount);
	  
  }
  
  
  </script>
  
</head>
<body>



<form class="jumbotron">
    <h4>Room Reservation Details:<Small> Reserve up to 3 Rooms</small> </h4>
    
    <a href="">View Hotel Rooms</a>
    <div id="RoomReservation_" style="margin-bottom:2vh; margin-top:1vh;">
      <div id= "Room_1" class="Room_1">
        <fieldset class="appear">
          <h6>Room Details</h6>
          <div class="row">
            <div class="col-2">
              <div class="form-group">
                <label for="Room_Select_">Room</label>
                <select class="form-control" id="roomSelection_1" onchange = "updatePrice(this);">
            <option value = 0 >Pick a Room</option>
           <%
        int count = 0;
        if(hotelsRooms!=null){
	    	while(count<hotelsRooms.size()){
	    		out.print("<option value = \""+Integer.toString(hotelsRooms.get(count).roomNum)+"\">"+ Integer.toString(hotelsRooms.get(count).roomNum)+"</option>");
	    		count++;
	    		
	    	}
        }
        %>
          </select>
              </div>
            </div>
            <div class="col-2">
              <div class="form-group">
                <label>Number of Guests in Room:</label>
                <input id="Num_Of_Guest_1"type=text class="form-control">
              </div>
            </div>
            <div class="col-2">
              <div class="form-group">
                <label>From:</label>
                <input id="Check_in_date_1" type=date class="form-control">
              </div>
            </div>
            <div class="col-2">
              <div class="form-group">
                <label>To:</label>
                <input id="Check_out_date_1" type=date class="form-control">
              </div>
            </div>
          </div>
        </fieldset>
        <div class="col">
         <button type="Button" href="#" id="options_1" class='options btn btn-success' onclick = "populateBreakfast(this);">Options</button>
      </div>
      
      
      
      
      
      <div id="roomOptions" class= "hidden" >
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
                    </select>
                  </div>
                </div>
                <div class="col">
                  <div class="form-group">
                    <label for="BQuantity_">Quantity</label>
                    <input class="form-control" id= "Quantity_"size=2>
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
                  <% 
                  if(hotelsServices!=null){
                	  count = 0;
                	  while(count<hotelsServices.size()){
          	    		out.print("<option value = \""+hotelsServices.get(count).type+"\">"+ hotelsServices.get(count).type+"</option>");
          	    		count++;
          	    		
          	    	}
                  }
                %>    
                </select>
              </div>
            </div>
            <div class = "col">
            <h4>Room total: </h4>
            <label id="test">Test</label>
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
    </div>
    
    
    
    <div class="form-row">
      <div class="col-sm-2">
        <!--  <button href="#" class='btn btn-primary addsection' onclick = "cloneReserve()">Add Another Room</button>
      	-->
      </div>
      <button onclick = "cloneReserve();">Add Another Room</button>
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