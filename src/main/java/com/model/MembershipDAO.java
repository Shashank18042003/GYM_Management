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
	@Override
	public Membership getMembershipByEmail(String email) {
	    Membership m = null;

	    try {
	        JdbcRowSet jrs = MyrowSet.Myrowset();

	        jrs.setCommand(
	            "SELECT m.plan_name, m.start_date, m.end_date, m.status " +
	            "FROM membership m " +
	            "JOIN gym_users u ON m.user_id = u.id " +
	            "WHERE u.email = ? " +
	            "ORDER BY m.end_date DESC " +
	            "LIMIT 1"
	        );

	        jrs.setString(1, email);
	        jrs.execute();

	        if (jrs.next()) {
	            m = new Membership();
	            m.setPlan_name(jrs.getString("plan_name"));
	            m.setStart_date(jrs.getString("start_date"));
	            m.setEnd_date(jrs.getString("end_date"));
	            m.setStatus(jrs.getString("status"));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return m;
	}
}
