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
//We will connect to our sql database
//check to see if user put in correct credentials
//succes ? continue : return
	boolean wasFound = false;
	int user = 0;
	try{
		
		//setting up DB connection
		String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "HotelDBMS", "password");
		
		//get parameters
		String userPassword = request.getParameter("password");
		String userEmail = request.getParameter("email");
		System.out.println("email: " + userEmail + " password: "+ userPassword);
		//make statment
		String search = "SELECT c.ID as customerID FROM Customer c WHERE c.Email = ? AND c.password = ?";
		PreparedStatement ps = con.prepareStatement(search);
		ps.setString(1, userEmail);
		ps.setString(2, userPassword);
		
		ResultSet result = ps.executeQuery();
		
		if(result.next()){
			wasFound = true;
			user = result.getInt("customerID");
		}
		
		System.out.println("Successful");
		con.close();
	}catch(Exception e){
		System.out.println("LOG IN ERROR");
	}finally{
		if(wasFound){
			out.print("continue to make reservation");
			
			session.setAttribute("LOGIN_STATUS", "successful");
			session.setAttribute("userID", Integer.toString(user));
			String redirectPage = "user_dashboard.jsp";
			response.sendRedirect(redirectPage);
		}else{
			//NOTE: Will redirect to the user log in, try making a message
			//that will alert the user that their email or password was incorrect
			System.out.print("user email or password was incorrect");
			session.setAttribute("LOGIN_STATUS", "invalid_login");
			String redirectPage = "login.jsp";
			response.sendRedirect(redirectPage);
		}
	}


%>
</body>
</html>