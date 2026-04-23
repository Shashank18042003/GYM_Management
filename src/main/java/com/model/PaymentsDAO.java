package com.model;

import java.util.Vector;

import javax.sql.rowset.JdbcRowSet;

import com.DBconnection.MyrowSet;

public class PaymentsDAO  implements PaymentsDesign{
@Override
public Vector<Payments> getuserdata(String email) {
	Vector v=new Vector();
JdbcRowSet jrs=MyrowSet.Myrowset();
try {
	jrs.setCommand("SELECT p.*\n"
			+ "FROM payments p\n"
			+ "JOIN gym_users u ON p.user_id = u.id\n"
			+ "WHERE u.email = ?;");
	jrs.setString(1, email);
	jrs.execute();

	while(jrs.next()){
		Payments p=new Payments();
		p.setId(jrs.getInt("id"));
		p.setUser_id(jrs.getInt("user_id"));
		p.setAmount(jrs.getDouble("amount"));
		p.setPayment_date(jrs.getString("payment_date"));
		p.setPayment_status(jrs.getString("payment_status"));
		p.setPayment_method(jrs.getString("payment_method"));
		v.add(p);
	}
	
}
catch(Exception e)
{
	e.printStackTrace();
	
}
return v;
}
@Override
public Vector<Payments> getallpayments() {
	Vector v=new Vector();
JdbcRowSet jrs=MyrowSet.Myrowset();
try {
	jrs.setCommand("SELECT p.*,u.email\n"
			+ "FROM payments p\n"
			+ "JOIN gym_users u ON p.user_id = u.id\n");
	jrs.execute();

	while(jrs.next()){
		Payments p=new Payments();
		p.setId(jrs.getInt("id"));
		p.setEmail(jrs.getString("email")); 
		p.setUser_id(jrs.getInt("user_id"));
		p.setAmount(jrs.getDouble("amount"));
		p.setPayment_date(jrs.getString("payment_date"));
		p.setPayment_status(jrs.getString("payment_status"));
		p.setPayment_method(jrs.getString("payment_method"));
		v.add(p);
	}
	
}
catch(Exception e)
{
	e.printStackTrace();
	
}
return v;
}
}

