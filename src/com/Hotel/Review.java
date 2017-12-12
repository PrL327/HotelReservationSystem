package com.Hotel;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Review {
	private int    review_id;
	private int    rating;
	private String review_comment;
	private String review_date;
	private String itemDescription;
	private String customer_email;
	
	static public String fetchOption(String hotelId, String type) {
		Connection con = null;
		PreparedStatement cs = null;
		ResultSet rs = null;
		String stmt = null;
		try {
		String url = "jdbc:mysql://cs336-hoteldbms.cwop6c6w5v0u.us-east-2.rds.amazonaws.com/HotelReservation";
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url, "HotelDBMS", "password");
		
		String itemColumn = "";
		if(type.equals("B")){
			itemColumn = "Breakfast Type";
			stmt = "SELECT t.ReviewID, t.Rating,  t.textComment, t.ReviewDate, b.bType, c.email " +
				" FROM Review t, BreakReview_Evaluated b, Customer c " +
				" Where b.HotelID  = ? AND b.ReviewID = t.ReviewID AND t.CID = c.ID AND t.isBreakReviw = 1";
		} else if(type.equals("S")){
			itemColumn = "Service Type";
			stmt = "SELECT t.ReviewID, t.Rating,  t.textComment, t.ReviewDate, s.sType, c.email " +
				" FROM Review t, ServiceReview_Rated s, Customer c " +
				" Where s.HotelID  = ? AND s.ReviewID = t.ReviewID AND t.CID = c.ID AND t.isServiceReview = 1";
		} else if(type.equals("R")){
			itemColumn = "Room No";
			stmt = "SELECT t.ReviewID, t.Rating,  t.textComment, t.ReviewDate, s.room_no, c.email " +
				" FROM Review t, RoomReview_Assesed s, Customer c " +
				" Where s.HotelID  = ? AND s.ReviewID = t.ReviewID AND t.CID = c.ID AND t.isRoomReview = 1";
		
		}else throw new Exception(type + " is not recognized");
		
	
		StringBuffer sb = new StringBuffer();
		sb.append("<table><tr><th>Review ID</th><th>Rating</th><th>Review Comment</th><th>Review Date</th><th>" + itemColumn +"</th><th>Customer Email</th></tr>");
	 
		
			cs = con.prepareStatement(stmt);
			cs.setString(1, hotelId);
			 
			rs = cs.executeQuery();
			ArrayList<Review> list = new ArrayList<Review>();
			while (rs.next()) {
				int idx = 1;
				sb.append("<tr><td>" + rs.getInt(idx++) + "</td>");
				sb.append("<td>" +  rs.getInt(idx++) + "</td>");
				sb.append("<td>" +  rs.getString(idx++) + "</td>");
				sb.append("<td>" +  rs.getString(idx++) + "</td>");
				sb.append("<td>" +  rs.getString(idx++) + "</td>");
				sb.append("<td>" +  rs.getString(idx++) + "</td>");
				sb.append("</tr>");
			}
			sb.append("</table>");
			 return sb.toString();
		} catch (Exception e) {
			return("Failed to execute: [" + stmt + "], exception: " + e);
		} finally {
			if(con != null)
				try {
					con.close();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			if (cs != null)
				try {
					cs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
	}
	 
	public static void main(String[] args) {
		
		try {

			String html = Review.fetchOption( "88877741", "R");
			System.out.println("List = " + html);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
