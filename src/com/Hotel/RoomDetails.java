package com.Hotel;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
public class RoomDetails {

	public String checkInDate = null;
	public String checkOutDate = null;
	public int roomNum = 0;
	public List<String> bTypes;
	public List<Integer> bQuantity;
	public List<String> sTypes;
	public float total = 0.0f;
	public int numOfDays;
	
	public RoomDetails(){
		this.bTypes = new ArrayList<String>();
		this.bQuantity = new ArrayList<Integer>();
		this.sTypes = new ArrayList<String>();
	}
	
	public void printMe(){
		System.out.println("IN: "+this.checkInDate + "\nOut: "+ this.checkOutDate + "\ntotal: "+ this.total);
	}
	
	//assuming that the set up of the dates are in mm/dd/yyyy format
	public String setDays(){

		
		String message = null;
		
		if(this.checkInDate == null || this.checkOutDate == null){
			this.numOfDays =  -1;
			message = "Check out date or Check in date is missing";
			return message;
		}
		
		DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyy");
		Date date =  new Date();
		String todayFormat = dateFormat.format(date);
		String[] today = todayFormat.split("/");
		int todayValue = Integer.valueOf(today[1]) + getMonthValue(today[0]) + (Integer.valueOf(today[2])*365);
		int checkOutValue = 0;
		int checkInValue = 0;
		int days = 0;
		
		List<String> checkoutdate = new ArrayList<String>();
		List<String> checkindate = new ArrayList<String>();
		
		String[] outDate = this.checkOutDate.split("/");
		if(outDate.length >1) {
			checkoutdate.add(outDate[0]);
			checkoutdate.add(outDate[1]);
			checkoutdate.add(outDate[2]);
		}else {
			String[] outDate1 =this.checkOutDate.split("-");
			checkoutdate.add(outDate1[0]);
			checkoutdate.add(outDate1[1]);
			checkoutdate.add(outDate1[2]);
		}
	
	
	
		String[] inDate = this.checkInDate.split("/");
		if(inDate.length>1) {
			checkindate.add(inDate[0]);
			checkindate.add(inDate[1]);
			checkindate.add(inDate[2]);
		}else {
			String[] inDate1 = this.checkInDate.split("-");
			checkindate.add(inDate1[0]);
			checkindate.add(inDate1[1]);
			checkindate.add(inDate1[2]);
		}
		
		if(checkindate.size()<3 || checkoutdate.size()<3){
			message = "Checkout or check in date is invalid";
			return message;
		}
		
		String strn = checkoutdate.get(0).replaceAll("\\s","");
		int yearOut = Integer.valueOf(strn);
		strn = checkindate.get(0).replaceAll("\\s", "");
		int yearIn = Integer.valueOf(strn);
		
		int yearsIn = yearOut - yearIn;
		
		if(yearsIn<0){
			//error in years
			message = "Checkout year can not be before checkIn date";
			return message;
		}
		
		checkOutValue += (yearOut *365);
		checkInValue += (yearIn * 365);
		
		int monthOut = 0;
		//get the checkout month
		monthOut = getMonthValue(checkoutdate.get(1));
		
		
		int monthIn = 0;
		//get the check-in month
		
		monthIn = getMonthValue(checkindate.get(1));
		
		
		checkOutValue += monthOut;
		checkInValue +=monthIn;
		
		//is the month values valid?
		if(checkOutValue<checkInValue){
			message = "Checkout month has to be after checkInDate";
			return message;
		}
	    strn = checkoutdate.get(2).replaceAll("\\s","");
		checkOutValue += Integer.valueOf(strn);
		strn = checkindate.get(2).replaceAll("\\s", "");
		checkInValue +=  Integer.valueOf(strn);
		
		if(checkOutValue<=todayValue){
			message = "Checkout date can not be before nor equal to todays date";
			return message;
		}
		
		if(checkInValue<todayValue){
			message = "Checkin date can not be before todays date";
		}
		
		//get the days that the person will reserve
		days = checkOutValue - checkInValue;
		
		if(days<1){
			//error 
			message = "At least one day has to be reserved";
			return message;
		}
		
		this.numOfDays = days;
		//everything is ok
		updateTotal();
		message = "OK";
		return message;
	}
	
	private void updateTotal(){
		float amount = this.total;
		amount = amount * this.numOfDays;
		amount = Math.round(amount * 100)/100;
		this.total = amount;
		return;
	}
	//return the value of the first day of the month 
	private int getMonthValue(String month){
		month = month.replaceAll("\\s","");
		int monthvalue = 0;
		int firstDayOfMonth = 0;
		
		boolean done = false;
		
		if(Character.isDigit(month.charAt(0))){
			monthvalue = Integer.valueOf(month);
			done = true;
		}
		
		if(!done) {
		String selectedMonth = month.trim().toLowerCase().substring(0, 3);
		
		switch(selectedMonth){
		case "jan":
			monthvalue = 1;
			break;
		case "feb":
			monthvalue = 2;
			break;
		case "mar":
			monthvalue = 3;
			break;	
		case "apr":
			monthvalue = 4;
			break;
		case "may":
			monthvalue = 5;
			break;
		case "jun":
			monthvalue = 6;
			break;
		case "jul":
			monthvalue = 7;
			break;
		case "aug":
			monthvalue = 8;
			break;
		case "sep":
			monthvalue = 9;
			break;
		case "oct":
			monthvalue = 10;
			break;
		case "nov":
			monthvalue = 11;
			break;
		case "dec":
			monthvalue = 12;
			break;
		default:
			monthvalue = 0;
			break;
		}
		
		}
		
		while(monthvalue>1){
			firstDayOfMonth += daysInMonth(--monthvalue);
		}
		
		
		return firstDayOfMonth;
	}
	
	//return the value of months in the day: used by getMonthValue
	private int daysInMonth(int month){

		
		int numOfDays = 0;
		
		switch(month){
		case 1:
			numOfDays = 31;
			break;
		case 2:
			numOfDays = 28;
			break;
		case 3:
			numOfDays = 31;
			break;
		case 4:
			numOfDays = 30;
			break;
		case 5:
			numOfDays = 31;
			break;
		case 6:
			numOfDays = 30;
			break;
		case 7:
			numOfDays = 31;
			break;
		case 8:
			numOfDays = 31;
			break;
		case 9:
			numOfDays = 30;
			break;
		case 10:
			numOfDays = 31;
			break;
		case 11:
			numOfDays = 30;
			break;
		case 12:
			numOfDays = 31;
			break;
		default:
			numOfDays = -1;
			break;
		}
		
		return numOfDays;
	}
}
