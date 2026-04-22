package com.model;

public interface ProjectDesign {
User login(String email,String password);
void register();
void update();
void delete();
void fetch();
int userCount();
}
