package com.model;

public interface ProjectDesign {
User login(String email,String password);
int register(User user);
void update();
void delete();
void fetch();
int userCount();
}
