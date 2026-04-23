DB structure
CREATE TABLE gym_users ( id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(50), email VARCHAR(50) UNIQUE, password VARCHAR(50), age INT, gender VARCHAR(10), phone VARCHAR(15), address VARCHAR(50),weight int,height int, doj DATE );

CREATE TABLE membership (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    plan_name VARCHAR(30),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES gym_users(id)
);
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DOUBLE,
    payment_date DATE,
    payment_status VARCHAR(20),
    payment_method VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES gym_users(id)
);

creating admin account
INSERT INTO gym_users(username, email, password, age, gender, phone,address,weight,height, doj) VALUES ('Admin', 'admin@gmail.com', 'admin123', 25, 'male','6281020126' , 'city', 60, 180, CURDATE());

#################################################################################################
event database
CREATE TABLE events (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     title VARCHAR(100),
    ->     description VARCHAR(255),
    ->     event_date DATE
    -> );
