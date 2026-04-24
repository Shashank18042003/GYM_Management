package com.model;

import java.util.Vector;

import javax.sql.rowset.JdbcRowSet;

import com.DBconnection.MyrowSet;

public class PaymentsDAO  implements PaymentsDesign{
@Override
public Vector<Payments> getuserdata(String email) {
	Vector<Payments> v=new Vector<>();
	if (email == null || email.trim().isEmpty()) {
		return v;
	}
	JdbcRowSet jrs=MyrowSet.Myrowset();
	try {
		jrs.setCommand("SELECT p.id, p.user_id, p.amount, p.payment_date, p.payment_status, p.payment_method\n"
				+ "FROM payments p\n"
				+ "JOIN gym_users u ON p.user_id = u.id\n"
				+ "WHERE u.email = ?\n"
				+ "ORDER BY p.id DESC");
		jrs.setString(1, email);
		jrs.execute();
		mapPayments(jrs, v);
	} catch(Exception e) {
		e.printStackTrace();
	}
	return v;
}

public Vector<Payments> getuserdataByUserId(int userId) {
	Vector<Payments> v = new Vector<>();
	if (userId <= 0) {
		return v;
	}
	JdbcRowSet jrs = MyrowSet.Myrowset();
	try {
		jrs.setCommand("SELECT id, user_id, amount, payment_date, payment_status, payment_method FROM payments WHERE user_id = ? ORDER BY id DESC");
		jrs.setInt(1, userId);
		jrs.execute();
		mapPayments(jrs, v);
	} catch (Exception e) {
		e.printStackTrace();
	}
	return v;
}
@Override
public Vector<Payments> getallpayments() {
	Vector<Payments> v=new Vector<>();
JdbcRowSet jrs=MyrowSet.Myrowset();
try {
	jrs.setCommand("SELECT p.id, p.user_id, p.amount, p.payment_date, p.payment_status, p.payment_method, u.email\n"
			+ "FROM payments p\n"
			+ "LEFT JOIN gym_users u ON p.user_id = u.id\n"
			+ "ORDER BY p.id DESC");
	jrs.execute();
	mapPayments(jrs, v);
	
}
catch(Exception e)
{
	e.printStackTrace();
}
return v;
}

private void mapPayments(JdbcRowSet jrs, Vector<Payments> v) throws Exception {
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
}

