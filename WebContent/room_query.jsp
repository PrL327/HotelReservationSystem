<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Best Room Types</title>
</head>
<body>
<%

String Startdate_rcv = request.getParameter("Best_Room_StartDate");
String EndDate_rcv = request.getParameter("Best_Room_EndDate");

String start_date[] = Startdate_rcv.split("-");
String StartDateNewFormat = start_date[1]+"/"+start_date[2]+"/"+start_date[0];
out.print(StartDateNewFormat);

String end_date[] = EndDate_rcv.split("-");
String EndDateNewFormat = end_date[1]+"/"+end_date[2]+"/"+end_date[0];
out.print(EndDateNewFormat);

%>
</body>
</html>