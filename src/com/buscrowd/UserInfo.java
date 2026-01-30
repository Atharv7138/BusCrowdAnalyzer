package com.buscrowd;

public class UserInfo {

	public static int id;
	public static String email;
	public static String busnumber;
	public static String routenumber;
	public static int getId() {
		return id;
	}
	public static void setId(int id) {
		UserInfo.id = id;
	}
	public static String getEmail() {
		return email;
	}
	public static void setEmail(String email) {
		UserInfo.email = email;
	}
	public static String getBusnumber() {
		return busnumber;
	}
	public static void setBusnumber(String busnumber) {
		UserInfo.busnumber = busnumber;
		
	}
	public static String getRoutenumber() {
		return routenumber;
	}
	public static void setRoutenumber(String routenumber) {
		UserInfo.routenumber = routenumber;
	}
	
}
