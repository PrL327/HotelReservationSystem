package com.Hotel;

public class Discount {
	
	public String sDate = "";
	public String eDate = "";
	public float discount = 0;
	
	public Discount(String sDate, String eDate, float discount){
		this.sDate = sDate;
		this.eDate = eDate;
		this.discount=  discount;
	}
}