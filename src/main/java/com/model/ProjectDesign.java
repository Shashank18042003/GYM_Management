package com.model;

import java.util.Vector;

public interface ProjectDesign {
User login(String email,String password);
int register(User user);
void update();
void delete();
Vector<User> fetch();
int userCount();

public User getUserByEmail(String email);
public void updateUserByEmail(User user);
void delete(String email);
}
