package com.Hotel;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Today {

	public static String getToday(){
		String today = "";
		
		DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyy");
		Date date =  new Date();
		today = dateFormat.format(date);
		return today;
	}
}
