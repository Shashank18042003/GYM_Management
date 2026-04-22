package com.model;

import java.util.Vector;

public interface ProjectDesign {
User login(String email,String password);
int register(User user);
public User getUserByEmail(String email);
public void updateUserByEmail(User user);
void delete(String email);
Vector<User> fetch();
int userCount();
}
