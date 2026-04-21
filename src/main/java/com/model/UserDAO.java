package com.model;

import javax.sql.rowset.JdbcRowSet;

import com.DBconnection.MyrowSet;

public class UserDAO implements ProjectDesign{

	@Override
	public User login(String email,String password) {
		JdbcRowSet jrs=MyrowSet.Myrowset();
		try {
			if(email.equals("admin@gmail.com"))
			jrs.setCommand("select * from users where email=? and password=?");
			jrs.setString(1, email);
			jrs.setString(2,password);
			jrs.execute();
			if(jrs.next())
			{
				User u=new User();
				u.setId(jrs.getInt("id"));
				u.setEmail(jrs.getString("email"));
				return u;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void register() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void fetch() {
		// TODO Auto-generated method stub
		
	}

}
