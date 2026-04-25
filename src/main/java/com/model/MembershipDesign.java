package com.model;

import java.sql.SQLException;

public interface MembershipDesign {
int MemberCount();
public Membership getMembershipByEmail(String email);
public Membership getMembershipByUserId(int userId);
public boolean hasActivePlan(int userId) ;
public void createMembership(Membership m) throws SQLException;
}
