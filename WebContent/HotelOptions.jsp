<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import= "com.Hotel.HotelRoom"%>
<%@ page import= "com.Hotel.HotelServices" %>
<%@ page import = "com.Hotel.HotelBreakfast" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
  <style>
    .hidden {
      visibility: hidden;
    }
  </style>
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
  
  var room_bOption1 = 1;
  var room_sOption1 = 1;
  var room_bOption2 = 1;
  var room_sOption2 = 1;
  var room_bOption3 = 1;
  var room_sOption3 = 1;
  
  var max_room_bOption1 = 0;
  var max_room_sOption1 = 0;
  var max_room_bOption2 = 0;
  var max_room_sOption2 = 0;
  var max_room_bOption3 = 0;
  var max_room_sOption3 = 0;
  
  
  </script>
  
  <script type="text/javascript"> 
  var hotelID = <%= hotelID%>
  var roomCount = 1;

  function updateNumOfGuest(id){
	  var roomOption = document.getElementById(id);
	  var index = id.slice(-1);
	  
	  var guestList = document.getElementById("Num_Of_Guest_"+index);
	  
	  var maxGuest = roomCapacityArray[roomOption.selectedIndex-1];
	  
	  var newOption; 
	  //removing previous list
	  while (guestList.options.length > 0) { 
	  	guestList.remove(0); 
	  } 
	  // create new options 
	  for (var i=0; i<=maxGuest; i++) { 
	  newOption = document.createElement("option"); 
	  newOption.value = i;  // assumes option string and value are the same 
	  newOption.text= i; 
	  // add the new option 
		  try { 
			  guestList.add(newOption);  // this will fail in DOM browsers but is needed for IE 
		  } 
		  catch (e) { 
			  guestList.appendChild(newOption); 
		  } 
	  }
	  
	  //need to reset the number of services upon room change
	  
	  removeDuplicates(index);
	  if(index == 1){
		  room_bOption1 = 1;
		  room_sOption1 = 1;
	 } 
	  
	  if(index == 2) {
		  room_bOption2 = 1;
		  room_sOption2 = 1;
	  } 
	  
	  if(index == 3){
		  room_bOption3 = 1;
		  room_sOption3 = 1;
	  }
	  
	  var quantityList = document.getElementById("Quantity_"+index+"_1");
	  
	  while (quantityList.options.length > 0) { 
		  quantityList.remove(0); 
	  }
	  
	  for (var i = 0; i<=maxGuest; i++) { 
	  newOption = document.createElement("option"); 
	  newOption.value = i;  // assumes option string and value are the same 
	  newOption.text= i; 
	  // add the new option 
		  try { 
			  quantityList.add(newOption);  // this will fail in DOM browsers but is needed for IE 
		  } 
		  catch (e) { 
			  quantityList.appendChild(newOption); 
		  } 
	  }
	  var totalLabel = document.getElementById("total_"+index);
	  updatePrice(id);
  }
  
  function updateQuantity(id){
	  var index = id.slice(-1);
	  
	  removeDuplicates(index);
	  if(index == 1){
		  room_bOption1 = 1;
		  room_sOption1 = 1;
	 } 
	  
	  if(index == 2) {
		  room_bOption2 = 1;
		  room_sOption2 = 1;
	  } 
	  
	  if(index == 3){
		  room_bOption3 = 1;
		  room_sOption3 = 1;
	  }
	  
	  var quantityList = document.getElementById("Quantity_"+index+"_1");
	  
	  var numOfGuest = +document.getElementById(id).selectedIndex;
	  
	  while (quantityList.options.length > 0) { 
		  quantityList.remove(0); 
	  }
	  
	  for (var i = 0; i<=numOfGuest; i++) { 
	  newOption = document.createElement("option"); 
	  newOption.value = i;  // assumes option string and value are the same 
	  newOption.text= i; 
	  // add the new option 
		  try { 
			  quantityList.add(newOption);  // this will fail in DOM browsers but is needed for IE 
		  } 
		  catch (e) { 
			  quantityList.appendChild(newOption); 
		  } 
	  }
	  var totalLabel = document.getElementById("total_"+index);
	  updatePrice(id);
	  var arr = [index, numOfGuest];
	  updateMaxOptions(arr);
  }
  
  function updateMaxOptions(arr){
	  var num = arr[1];
	  var index = arr[0];
	  
	  if(index == 1){
	  max_room_bOption1 = num;
	  max_room_sOption1 = num;
	  return;
	  }
	  if(index == 2){
	  max_room_bOption2 = num;
	  max_room_sOption2 = num;
	  return;
	  }
	  max_room_bOption3 = num;
	  max_room_sOption3 = num;
	  return;
  }
  
  function updateNumOfBreakfast(id){
	  var index = id.slice(-3);
	  index = index.charAt(0);
	  var numBOption = 0;
	  if(index == 1){
		  numBOptions = room_bOption1;
	 } 
	  
	  if(index == 2) {
		  numBOptions = room_bOption2;
	  } 
	  
	  if(index == 3){
		  numBOptions = room_bOption3;
	  }
	  var count = 1;
	  var numOfB = 0;
	  var error = 0;
	  //looping through the number of breadfast options per current room
	  while(true){
		  var bQauntityIndex = document.getElementById("Quantity_"+index+"_"+count);
		  if(bQauntityIndex!=null){
			  var bNum = bQauntityIndex.selectedIndex;
			  numOfB  = +numOfB + bNum;
			  count = +count + 1;
		  }else{break;}
		  
	  }
	  
	  var maxB = 0;
	  if(index == 1){ 
		  if(numOfB > max_room_bOption1){
			  error = 1;
			  maxB = max_room_bOption1;
		  }else{
		  	room_bOption1 = numOfB;
		  }
		  
	  }
	  
	  if(index == 2){ 
		  if(numOfB > max_room_bOption2){
			  error = 1;
			  maxB = max_room_bOption2;
		  }else{
		  	room_bOption2 = numOfB;
		  }
	  }
	  
	  if(index == 3){
		  if(numOfB > max_room_bOption3){
			  error = 1;
			  maxB = max_room_bOption3
		  }else{
		  	room_bOption3 = numOfB;
		  }
	  }
	  //max num of breakfast was reached
	  if(error == 1){
		  alert("You can not have more than "+ maxB + " breakfast");
		  var optionSelected = document.getElementById(id);
		  if(optionSelected!=null){
			  optionSelected.selectedIndex = 0;
		  }
		  
		  return;
	  }
	  updatePrice(id);
  }
  
  function updatePrice(id){
	  
	  var selection = 0;
	  var option = id.slice(-3);
	  option = option.charAt(0);
	  if(isNaN(option)){
		  selection = id.slice(-1);
	  }else{
		  selection = option;
	  }
	  
	  var numBOptions = 0;
	  var numSOptions = 0;
	  
	  if(selection == 1){
		  numBOptions = room_bOption1;
		  numSOptions = room_sOption1;
	 } 
	  
	  if(selection == 2) {
		  numBOptions = room_bOption2;
		  numSOptions = room_sOption2;
	  } 
	  
	  if(selection == 3){
		  numBOptions = room_bOption3;
		  numSOptions = room_sOption3;
	  }
	  
	  
	  // get the index of the selected option 
	  // get the country select element via its known id 
	  var cSelect = document.getElementById("total_"+selection);
	  var total = 0;
	  
	 
	  var rSelectIndex = document.getElementById("roomSelection_"+selection);
	  
	  if(rSelectIndex.selectedIndex!=null && rSelectIndex.selectedIndex>0){
	  	total = +total + +roomPriceArray[rSelectIndex.selectedIndex-1];
	  }
	  
	  var count = 1;
	  //looping through the number of breadfast options per current room
	  while(true){
		  var bSelectIndex = document.getElementById("Breakfast_Type_"+selection+"_"+count);
		  var bQauntityIndex = document.getElementById("Quantity_"+selection+"_"+count);
		  if(bQauntityIndex!=null){
			  var bNum = bQauntityIndex.selectedIndex;
			  if(bSelectIndex.selectedIndex!=null && bSelectIndex.selectedIndex>0){
				var bprice = breakfastPriceList[bSelectIndex.selectedIndex-1];
				
			  	total = +total + +(bprice * bNum);
			  }
			  count = +count + 1;
		  }else{break;}
		 
	  }
	  
	  //looping through the number of services in the current room
	  count = 1;
	  while(count<=numSOptions){
		  
		  var sSelectIndex = document.getElementById("Services_"+selection+"_"+count)
		  try{
		  if(sSelectIndex.selectedIndex!=null && sSelectIndex.selectedIndex>0){
		  	total = +total + +serviceCostArray[sSelectIndex.selectedIndex-1];
		  }
		  }catch(err){
			  document.getElementById("search").innerHTML = "Services_"+selection+"_"+count;
		  }
		  count = +count + 1;
	  }
	  total = Math.round(total*100)/100;
	  cSelect.innerHTML = total;
  }
  
  
  function cloneReserve(){
	  if(roomCount >2){
		  alert("You can not reserve more than 3 rooms!");
		  return;
	  }
	  
	  var roomAreaID = "Room_";
	  roomAreaID=  roomAreaID + roomCount;
	  
	  var roomArea = document.getElementById("Room_1");
	  var roomAreaClone = roomArea.cloneNode(true);
	  
	  roomCount = +roomCount + 1;
	  
	  roomAreaClone.setAttribute("class","Room_"+roomCount);
	  roomAreaClone.setAttribute("id","Room_"+roomCount);
	  
	  
	  
	  document.getElementById("RoomReservation_").appendChild(roomAreaClone);
	  
	  updateIDs();
  }
  
  function updateIDs(){
	  var newRoomID = "Room_"+roomCount;
	  var newRoomArea = document.getElementById(newRoomID);
	  
	  var updateFormControl = newRoomArea.getElementsByClassName("form-control");
	  
	  var updateOptions = newRoomArea.getElementsByClassName("roomOptions")[0];
	  updateOptions.setAttribute("id","roomOptions_"+roomCount);
	  
	  var updateOther = newRoomArea.getElementsByClassName("options");
	  var bOptions = updateOther[0];
	  bOptions.setAttribute("id","BreakfastOption_"+roomCount);
	  
	  var sOptions = updateOther[1];
	  sOptions.setAttribute("id","ServicesOption_"+roomCount);
	  //update room select id
	  var room_select = updateFormControl[0];
	  room_select.setAttribute("id","roomSelection_"+roomCount);
	  
	  //update num of guess id
	  var num_of_guest = updateFormControl[1];
	  num_of_guest.setAttribute("id","Num_Of_Guest_"+roomCount);
	  num_of_guest.setAttribute("name","Num_Of_Guest_"+roomCount);
	  
	  //update check in date
	  var check_in_date = updateFormControl[2];
	  check_in_date.setAttribute("id","Check_in_date_"+roomCount);
	  check_in_date.setAttribute("name","Check_in_date_"+roomCount);
	  
	  //update id of checkout date
	  var check_out_date = updateFormControl[3];
	  check_out_date.setAttribute("id","Check_out_date_"+roomCount);
	  check_out_date.setAttribute("name","Check_out_date_"+roomCount);
	  
	  var breakfast_type = updateFormControl[4];
	  
	  breakfast_type.setAttribute("id", "Breakfast_Type_"+roomCount+"_1");
	  
	  var quantity = updateFormControl[5];
	  quantity.setAttribute("id","Quantity_"+roomCount+"_1");
	  quantity.setAttribute("name", "Quantity_"+roomCount+"_1");
	  
	  var services__ = updateFormControl[6];
	  services__.setAttribute("id", "Services_"+roomCount+"_1");
	  
	  var totalLabel = newRoomArea.getElementsByClassName("amount")[0];
	  totalLabel.setAttribute("id","total_"+roomCount);
	  nullTotal();
	  
	  var updateAddService = newRoomArea.getElementsByClassName("addservices")[0];
	  updateAddService.setAttribute("id", "addserive_"+roomCount);
	  
	  var updateAddBreakfast = newRoomArea.getElementsByClassName("addbreakfast")[0];
	  updateAddBreakfast.setAttribute("id","addbreakfast"+roomCount);
	  
	  removeDuplicates(roomCount);
  }
  
  function removeDuplicates(section){
	  var newServiceOptions = document.getElementById("ServicesOption_"+section);
	  var listOfOptions = newServiceOptions.getElementsByClassName("form-control");
	  
	  if(listOfOptions.length > 1){
		  var num = listOfOptions.length-1;
		  while(num > 0){
			  var temp = listOfOptions[num];
			  temp.remove();
			  num--;
		  }
		  
		  
	  }
	  listOfOptions[0].setAttribute("id", "Services_"+section+"_1");
	  var newBreakfastOptions = document.getElementById("BreakfastOption_"+section);
	  var listofBoptions = newBreakfastOptions.getElementsByClassName("breakfasts");
	  
	  if(listofBoptions.length > 1){
		  var num = listofBoptions.length-1;
		  while(num>0){
			  var temp = listofBoptions[num];
			  temp.remove();
			  num--;
		  }
	  }
	  
	  
  }
  function nullTotal(){
	  document.getElementById("total_"+roomCount).innerHTML = 0;
  }
  
  function addservice(id){
	  var selection= id.slice(-1); 
	  var numSOptions = 0;
	  
	  if(selection == 1){
		  numSOptions = room_sOption1;
		  if(numSOptions > max_room_sOption1 - 1){
			  alert("You can select more than "+max_room_sOption1+" services");
			  return;
		  }
		  room_sOption1 = +room_sOption1 + 1;
	 } 
	  
	  if(selection == 2) {
		  numSOptions = room_sOption2;
		  if(numSOptions > max_room_sOption2 - 1){
			  alert("You can not select more than "+max_room_sOption2+" services");
			  return;
		  }
		  room_sOption2 = +room_sOption2 + 1;
	  } 
	  
	  if(selection == 3){
		  numSOptions = room_sOption3;
		  if(numSOptions > max_room_sOption3 - 1){
			  alert("You can not select more than "+ max_room_sOption3 + " services");
			  return;
		  }
		  room_sOption3 = +room_sOption3 + 1;
	  }
	  
	  
	  numSOptions = +numSOptions + 1;
	  
	  var serviceAreaID = "Services_";
	  
	  var serviceArea = document.getElementById(serviceAreaID+selection+"_1");
	  var serviceAreaClone = serviceArea.cloneNode(true);
	  
	  serviceAreaClone.setAttribute("id","Services_"+selection+"_"+numSOptions);
	  document.getElementById("ServicesOption_"+selection).appendChild(serviceAreaClone);
  }
  
  function addbreakfast(id){
	  var selection= id.slice(-1); 
	  var numBOptions = 0;
	  
	  if(selection == 1){
		  numBOptions = room_bOption1;
		  if(numBOptions > max_room_bOption1 - 1){
			  alert("You can get more than "+max_room_bOption1+ " breakfasts");
			  return;
		  }
		  room_bOption1 = +room_bOption1 + 1;
	 } 
	  
	  if(selection == 2) {
		  numBOptions = room_bOption2;
		  if(numBOptions > max_room_bOption2 - 1){
			  alert("You can not get more than "+max_room_bOption2+" breakfasts");
			  return;
		  }
		  room_bOption2 = +room_bOption2 + 1;
	  } 
	  
	  if(selection == 3){
		  numBOptions = room_bOption3;
		  if(numBOptions > max_room_bOption3 - 1){
			  alert("You can not get mroe than "+max_room_bOption3+" breakfasts");
			  return;
		  }
		  room_BOption3 = +room_bOption3 + 1;
	  }
	  
	  
	  numBOptions = +numBOptions + 1;
	  
	 
	  var breakfastArea = document.getElementById("breakfasts");
	  var breakfastAreaClone = breakfastArea.cloneNode(true);
	  
	  var newElements = breakfastAreaClone.getElementsByClassName("form-control");
	  newElements[0].setAttribute("id", "Breakfast_Type_"+selection+"_"+numBOptions);
	  newElements[1].setAttribute("id","Quantity_"+selection+"_"+numBOptions);
	  newElements[1].setAttribute("name","Quantity_"+selection+"_"+numBOptions);
	  
	  document.getElementById("BreakfastOption_"+selection).appendChild(breakfastAreaClone);
  }
  
  function verify(){
	  
	  var section = 1;
	  var numOfRooms = 0;
	  var submissionForm = document.getElementById("reservationDetails");
	  
	  while(true){
		  var currRoom = document.getElementById("roomSelection_"+section);
		  
		  if(currRoom!=null){
			  var roomSelected = currRoom.selectedIndex;
			  if(roomSelected>0){
				  var roomName = "roomPicked_"+section;
				  submissionForm.appendChild(newInput(roomName, roomSelected));
				  
				  var index = 0;
				  var callIndex = 1;//could be possible that index doesn't exists
				  var done = 0;
				  //get breakfast and quantity for room X
				  while(done!=1){
					  index++;
					  var currBreakfast = document.getElementById("Breakfast_Type_"+section+"_"+index);
					  var currQuantity = document.getElementById("Quantity_"+section+"_"+index);
					  if(currBreakfast!=null){
						  
						  var bIndex = currBreakfast.selectedIndex;
						  var qIndex = currQuantity.selectedIndex;
						  //if not breakfast was selected skip it, if quantity is none skip it
						  if(bIndex>0 && qIndex !=0){
						  
							  var bName = "Breakfast_Type_"+section+"_"+callIndex;
							  var bValue = breakfastType[bIndex-1];
							  var bQName = "Quantity_"+section+"_"+callIndex;
							  var bQValue = qIndex;
							  submissionForm.appendChild(newInput(bName, bValue));
							  submissionForm.appendChild(newInput(bQName, bQValue));
							  callIndex++;
						  }else{
							  continue;
						  }
					  }else{
						  done = 1;
					  }
				  }
				  done = 0;
				  //getting the services for this room
				  index = 0;
				  callIndex = 1;
				  while(done!=1){
					  index++;
					  var currService = document.getElementById("Services_"+section+"_"+index);
					  if(currService!=null){
						  
						  var sIndex = currService.selectedIndex;
						  //if not breakfast was selected skip it, if quantity is none skip it
						  if(sIndex>0){
						  
							  var sName = "Services_"+section+"_"+callIndex;
							  var sValue = serviceTypeArray[sIndex-1];
							  submissionForm.appendChild(newInput(sName, sValue));
							  callIndex++;
						  }else{
							  continue;
						  }
					  }else{
						  done = 1;
					  }
				  }
				  
				  var currTotal = document.getElementById("total_"+section);
				  var totalName = "totalForRoom_"+section;
				  submissionForm.appendChild(newInput(totalName, currTotal.innerText));
				  
				  numOfRooms++;
				  section++; 
			  }else{
				  alert("room was not selected for option "+ section);
				  return;
			  }
		  }else{
			  break;
		  }
	  }
	  
	  var cardUsed = document.getElementById("card_type");
	  var cardIndex = cardUsed.selectedIndex;
	  var cards = ["None","Visa","MasterCard","Amex","Discover"];
	  submissionForm.appendChild(newInput("card_type_used", cards[cardIndex]));
	  submissionForm.appendChild(newInput("numOfRoomsReserved",numOfRooms));
	  submissionForm.appendChild(newInput("hotelID", <%= hotelID%>))
	  end();
  }
  
  function newInput(name, value){
	  var form = document.getElementById("form-line").cloneNode(true);
	  form.setAttribute("name", name);
	  form.setAttribute("value", value);
	  return form;
  }
  function end(){
	  document.getElementById("reserve").submit();
  }
  
  
  </script>
   <script>
  $(document).on('click', '.next', function() {
	    $("#Payment_info").removeClass("hidden");;
	});
  </script>
</head>
<body>
<form class='form-control' method="getHotelRooms" action="hotel_rooms.jsp">
	 	<input class = "hidden" name="hotel_rooms" value="<%
	 	out.print(Integer.toString(hotelID));%>">
	    <input class ="btn btn-link" value="View Rooms Offered By This Hotel" type=submit>
</form>
<form class="jumbotron" id = "reserve" method="query" action="VerifyReservation.jsp">
    <h4>Room Reservation Details:<Small> Reserve up to 3 Rooms</small> </h4>
    <div id="RoomReservation_" style="margin-bottom:2vh; margin-top:1vh;">
      <div id= "Room_1" class="Room_1">
        <fieldset class="appear">
          <h6>Room Details</h6>
          <div class="row">
            <div class="col-2">
              <div class="form-group">
                <label for="Room_Select_">Room</label>
                <select class="form-control" id="roomSelection_1" onchange = "updatePrice(this.id); updateNumOfGuest(this.id);">
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
                <select id="Num_Of_Guest_1"type=text class="form-control" name="Num_of_Guest_1" onchange = "updateQuantity(this.id);">
                <option value =0>Select Number of Guest</option>
                </select>
              </div>
            </div>
            <div class="col-2">
              <div class="form-group">
                <label>From:</label>
                <input id="Check_in_date_1" type=date class="form-control" name="Check_in_date_1">
              </div>
            </div>
            <div class="col-2">
              <div class="form-group">
                <label>To:</label>
                <input id="Check_out_date_1" type=date class="form-control" name="Check_out_date_1">
              </div>
            </div>
          </div>
        </fieldset>
      
      
      
      
      
      <div id="roomOptions_1" class= "roomOptions" >
        <fieldset>
          <h6>Breakfast & Services:</h6>
          <div class="col-sm-4" style="margin-left:2vw; margin-top:1vh;">
            <div class="row options" style="margin-right:2vw;" id="BreakfastOption_1">
              <div id = "breakfasts" class="breakfasts col">
              <div class="form-row">
                <div class="col">
                  <div class="form-group">
                    <label for="Breakfast_Type_">Breakfast</label>
                    <select class="form-control" id="Breakfast_Type_1_1"  onchange="updatePrice(this.id);">
                      <option selected="selected">Choose a Breakfast</option>
                       <% 
                  if(hotelsBreakfast!=null){
                	  count = 0;
                	  while(count<hotelsBreakfast.size()){
          	    		out.print("<option value = \""+hotelsBreakfast.get(count).type+"\">"+ hotelsBreakfast.get(count).type+"</option>");
          	    		count++;
          	    		
          	    	}
                  }
                %> 
                    </select>
                  </div>
                </div>
                <div class="col">
                  <div class="form-group">
                    <label for="BQuantity_">Quantity</label>
                    <select class="form-control" id= "Quantity_1_1" name="Quantity_1_1" onchange = "updateNumOfBreakfast(this.id);">
                    <option>Quantity</option>
                    </select>
                  </div>
                </div>
              </div>
              </div>
              </div>
            <div class="col-sm-6" >
              <div class="services form-group options" id="ServicesOption_1">
                <label for="Services_">Services</label>
                <select class="form-control" id="Services_1_1"  onchange="updatePrice(this.id)">
                  <option selected="selected" >Choose a Service</option> 
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
            
            </div>
          </div>
          <h4>Room total: </h4>
    <label class = "amount" id="total_1"></label>
          <div class="form-row">
            <div class="col-sm-2">
              <a href="#" id= "addservice_1" class="addservices" onclick = "addservice(this.id);">Add another Service</a>
            </div>
            <div class="col">
              <a href="#" id = "addbreakfast_1" class="addbreakfast" onclick = "addbreakfast(this.id);">Add another Breakfast</a>
            </div>
            
          </div>
        </fieldset>
      </div>
    </div>
    
    </div>
    
    
    
    <div class="form-row">
      <div class="col-sm-2">
      </div>
      <button  type = "Button" onclick = "cloneReserve();">Add Another Room</button>
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
            <input class='form-control' type='text' id="card_num" name = "card_num">
          </div>
        </div>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>Card Type</label>
            <select class="form-control" id="card_type" placeholder="Hotel.." >
            <option selected="selected">Card Type</option>
            <option id ="Visa" value="Visa">Visa</option>
            <option id="MasterCard" value="MasterCard">MasterCard</option>
            <option id="Amex" value="Amex">Amex</option>
            <option id="Discover" value="Discover">Discover</option>
          </select>
          </div>
        </div>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>CVC Num</label>
            <input class='form-control' type='text' size=3 placeholder="CVC" id="cvc_num" name="cvc_num">
          </div>
        </div>
      </div>
      <div class='row'>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>Name on Card</label>
            <input class='form-control' type='text' id="name_on_card" name="name_on_card">
          </div>
        </div>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>Exp Date</label>
            <input class='form-control' type='month' id="exp_date" name="exp_date">
          </div>
        </div>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>Billing Address</label>
            <input class='form-control' type='text' size=3 placeholder="Address" id="billing_addr" name="billing_addr">
          </div>
        </div>
      </div>
    </fieldset>
    <button type="Button"  onclick="verify();">Submit</button>
  </div>
  <div id = "reservationDetails" class="hidden">

  <input id = "form-line">
  
	</div>
</form>
  
</body>
</html>