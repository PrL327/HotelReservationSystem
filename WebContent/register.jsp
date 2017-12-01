<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	//[email, password, name, number, address]
	boolean[] pass = new boolean[5];
	String email = null;
	String password = null;
	String firstName= "";
	String lastName = "";
	String number = null;
	String address = null;
	

	//setting up DB connection
	
	//get parameters
	password = request.getParameter("password");
	
	if(password != null){
		pass[1] = true;
	}
	
	email = request.getParameter("email");
	
	if(email != null){
		pass[0] = true;
	}
	
	String userName = request.getParameter("name");
	firstName ="";
	lastName = "";
	
	if(userName!=null){
		String[] result = userName.split("\\s");
		pass[2] = true;
		int size = result.length;
		if(size>1){
			firstName = result[0];
			lastName = result[1];
		}
		else{
			firstName = result[0];
		}
	}
	
	number = request.getParameter("phone");
	//do some error checking for phone numeber 
	if(number!=null){
		pass[3] = true;
	}
	
	address = request.getParameter("address");
	
	if(address!=null){
		pass[4] = true;
	}
	
	int i = 0;
	boolean failed = false;
	while(i < 5){
		if(pass[i]==false){
			failed = true;
			break;
		}
		i++;
	}
	
	if(failed){
		--i;
		String failedAt = "";
		switch(i){
		case 0:
			failedAt = "email";
			break;
		case 1:
			failedAt = "password";
			break;
		case 2:
			failedAt = "name";
			break;
		case 3:
			failedAt = "number";
			break;
		case 4:
			failedAt = "address";
			break;
		}
		//NOTE: There was some failure. 
		String redirectPage = "account_register.jsp";
		System.out.println( failedAt +" was null");
		response.sendRedirect(redirectPage);
		return;
	}
	
	//Will be doing SQL here 
	String message = "";
	try{
		String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");
		
		
		int randomID = Integer.MIN_VALUE;
		
		while(true){
			Statement stmt = con.createStatement();
			randomID = (int)(Math.random() * 99999999+10000000);
			String str = "SELECT COUNT(*) as cnt FROM Customer c WHERE c.ID = " + Integer.toString(randomID);
			ResultSet count = stmt.executeQuery(str);
			count.next();
			if(count.getInt("cnt")==0){
				break;
			}
		}
		
		
		String newUser = "INSERT INTO Customer values(?, ?, ?, ?, ?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(newUser);
		
		ps.setInt( 1 , randomID);
		ps.setString( 2 , firstName);
		ps.setString( 3 , email);
		ps.setString(4, address);
		ps.setString(5, number);
		ps.setString(6, lastName);
		ps.setString(7, password);
		ps.executeUpdate();
		
		System.out.println("successful");
		message = "Successful";
		con.close();
	}catch(Exception e){
		out.print("Failed");
		message = "Failed";
	}finally{
		
		session.setAttribute("logInAttempt", message);
		String redirectPage = "login.jsp";
		response.sendRedirect(redirectPage);
	}



%>
</body>
</html>