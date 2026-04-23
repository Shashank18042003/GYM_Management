package com.model;

import javax.sql.rowset.JdbcRowSet;

import com.DBconnection.MyrowSet;

public class MembershipDAO implements MembershipDesign {

	@Override
	public int MemberCount() {
		int count=0;
		JdbcRowSet jrs=MyrowSet.Myrowset();
		try {
		jrs.setCommand("SELECT COUNT(*) FROM membership WHERE end_date >= CURRENT_DATE");
		jrs.execute();
		if(jrs.next())
		{
			count=jrs.getInt(1);
		}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return count;
	}

}
