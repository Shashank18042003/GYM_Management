package com.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Vector;

import javax.sql.rowset.JdbcRowSet;

import com.DBconnection.Myjdbc;
import com.DBconnection.MyrowSet;


public class UserDAO implements ProjectDesign{

	@Override
	public User login(String email,String password) {
		JdbcRowSet jrs=MyrowSet.Myrowset();
		try {
			jrs.setCommand("select * from gym_users where email=? and password=?");
			jrs.setString(1, email);
			jrs.setString(2,password);
			jrs.execute();
			if(jrs.next())
			{
				User u=new User();
				//u.setId(jrs.getInt("id"));
				u.setEmail(jrs.getString("email"));
				u.setUsername(jrs.getString("username"));
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
	public int register(User user) {
		int r=0;
		Connection connection=Myjdbc.myconn();
		try {
			
			PreparedStatement preparedStatement=connection.prepareStatement("insert into gym_users (Username, email, password, age, gender, phone, address, weight, height, doj) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			preparedStatement.setString(1,user.getUsername() );
			preparedStatement.setString(2,user.getEmail() );
			preparedStatement.setString(3,user.getPassword() );
			preparedStatement.setInt(4,user.getAge() );
			preparedStatement.setString(5,user.getGender() );
			preparedStatement.setString(6,user.getPhone() );
			preparedStatement.setString(7,user.getAddress() );
			preparedStatement.setInt(8,user.getWeight() );
			preparedStatement.setInt(9,user.getHeight() );
			preparedStatement.setString(10,user.getDoj() );
			r=preparedStatement.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return r;
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
	public Vector<User> fetch() {
		// TODO Auto-generated method stub
		JdbcRowSet jrs=MyrowSet.Myrowset();
		Vector vector=new Vector();
		try {
			
			jrs.setCommand("select * from gym_users");
			jrs.execute();
			for(;jrs.next();)
			{
				User u=new User();
				//u.setId(jrs.getInt("id"));
				u.setUsername(jrs.getString("username"));
				u.setEmail(jrs.getString("email"));
				u.setPassword(jrs.getString("password"));
				u.setAge(jrs.getInt("age"));
				u.setGender(jrs.getString("gender"));
				u.setPhone(jrs.getString("phone"));
				u.setAddress(jrs.getString("address"));
				u.setWeight(jrs.getInt("weight"));
				u.setHeight(jrs.getInt("height"));
				u.setDoj(jrs.getString("doj"));
				vector.add(u);
				
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return vector;
		
	}
	@Override
	public int userCount() {
		 int count = 0;
		JdbcRowSet jrs=MyrowSet.Myrowset();
		try {
			
			jrs.setCommand("select count(email) from gym_users where email!=? ");
			jrs.setString(1, "admin@gmail.com");
			jrs.execute();
			if(jrs.next())
			{
				 count = jrs.getInt(1);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return count;
	}

}
