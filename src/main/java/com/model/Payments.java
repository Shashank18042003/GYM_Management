package com.model;

public class Payments {
int id;
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public int getUser_id() {
	return user_id;
}
public void setUser_id(int user_id) {
	this.user_id = user_id;
}
public double getAmount() {
	return amount;
}
public void setAmount(double amount) {
	this.amount = amount;
}
public String getPayment_date() {
	return payment_date;
}
public void setPayment_date(String payment_date) {
	this.payment_date = payment_date;
}
public String getPayment_status() {
	return payment_status;
}
public void setPayment_status(String payment_status) {
	this.payment_status = payment_status;
}
public String getPayment_method() {
	return payment_method;
}
public void setPayment_method(String payment_method) {
	this.payment_method = payment_method;
}
int user_id;
double amount;
String payment_date ;
String payment_status;
String payment_method;
}
