package com.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.rowset.JdbcRowSet;

import com.myjars.MyConnection;
import com.myjars.MyJdbcRowSet;

public class EventDAO implements EventDesign {

	@Override
	public void insertEvent(EventData event) {
		Connection connection=new MyConnection().connect();
		try {
		PreparedStatement preparedStatement=connection.prepareStatement("INSERT INTO events(title, description, event_date, is_new) VALUES (?, ?, ?, true)");
		preparedStatement.setString(1,event.getTitle() );
		preparedStatement.setString(2, event.getDescription());
		preparedStatement.setString(3, event.getDate());
		preparedStatement.executeUpdate();
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	@Override
	public void deleteEvent(int id) {
		Connection connection=MyConnection.connect();
		try {
			PreparedStatement preparedStatement=connection.prepareStatement("DELETE FROM events WHERE id=?");
			preparedStatement.setInt(1,id);
			preparedStatement.executeUpdate();
			
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}

	@Override
	public boolean countNotification() {
		boolean hasNew=false;
		JdbcRowSet jRowSet=MyJdbcRowSet.MyJdbcRowSet();
		try {
			jRowSet.setCommand("SELECT COUNT(*) FROM events WHERE is_new = true");
			jRowSet.execute();
			
			if(jRowSet.next())
			{
				if(jRowSet.getInt(1)>0)
				 {
					 hasNew=true;
				 }
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return hasNew;
	}

	@Override
	public List<EventData> viewEvent() {
		List<EventData> aList=new ArrayList();
		JdbcRowSet jSet=MyJdbcRowSet.MyJdbcRowSet();
		try {
			jSet.setCommand("SELECT * FROM events ORDER BY event_date");
			jSet.execute();
			for(;jSet.next();)
			{
				EventData eData=new EventData();
				eData.setId(jSet.getInt("id"));
				eData.setTitle(jSet.getString("title"));
				eData.setDescription(jSet.getString("description"));
				eData.setDate(jSet.getString("event_date"));
				
				aList.add(eData);
			}
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return aList;
		
	}

	@Override
	public void resetNotification() {

	    try {
	        Connection con = MyConnection.connect();

	        PreparedStatement ps = con.prepareStatement("UPDATE events SET is_new = false");

	        ps.executeUpdate();

	        ps.close();
	        con.close();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		
	}

}
