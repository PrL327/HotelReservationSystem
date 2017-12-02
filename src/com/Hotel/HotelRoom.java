package com.Hotel;

public class HotelRoom {

	private int hotelID = 0;
	private int roomNum = 0; 
	private Discount discount;
	
	
	public HotelRoom(int hotelID, int roomNum){
		this.hotelID= hotelID;
		this.roomNum = roomNum;
		
	}
	
	public void setDiscount(String sDate, String eDate, float percent){
		discount = new Discount(sDate, eDate, percent);
	}
	
	public Discount getDiscount(){return discount;}
	public int getRoomNum(){return roomNum;}
	public int getHotelID(){return hotelID;}
	
}
