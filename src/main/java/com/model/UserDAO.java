package com.model;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.rowset.JdbcRowSet;

import com.myjars.MyConnection;
import com.myjars.MyJdbcRowSet;

public class UserDAO implements ProjectDesign{

	@Override
	public User login(String email,String password) {
		JdbcRowSet jrs=MyJdbcRowSet.MyJdbcRowSet();
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
		Connection connection=MyConnection.connect();
		try {
			
			PreparedStatement preparedStatement=connection.prepareStatement("insert into gym_users (Username, email, password, age, gender, phone, address, weight, height, doj) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			preparedStatement.setString(1,user.getName() );
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
	public void fetch() {
		// TODO Auto-generated method stub
		
	}

}
