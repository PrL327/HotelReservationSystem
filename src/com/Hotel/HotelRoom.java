package com.Hotel;

public class HotelRoom {

	public int hotelID = 0;
	public int roomNum = 0;
	public String description;
	public float price;
	public int capacity;
	public String roomType;
	public int floorNo;
	
	
	public HotelRoom(int hotelID, int roomNum, float price, int capacity, int floorNo, String roomType){
		this.hotelID= hotelID;
		this.roomNum = roomNum;
		this.price = price;
		this.capacity = capacity;
		this.roomType = roomType;
	}
	
	
	public void addDescription(String description){this.description =description;}
	
	
}
