package com.model;

import java.sql.Date;

public class Membership {
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
public String getPlan_name() {
	return plan_name;
}
public void setPlan_name(String plan_name) {
	this.plan_name = plan_name;
}
public Date getStart_date() {
	return start_date;
}
public void setStart_date(Date start_date) {
	this.start_date = start_date;
}
public Date getEnd_date() {
	return end_date;
}
public void setEnd_date(Date end_date) {
	this.end_date = end_date;
}
public String getStatus() {
	return status;
}
public void setStatus(String status) {
	this.status = status;
}
int user_id;
String plan_name;
Date start_date;
Date end_date;
String status;
}
