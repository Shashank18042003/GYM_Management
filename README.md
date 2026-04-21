DB structure
CREATE TABLE gym_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    password VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    place VARCHAR(50),
    date_of_join DATE
);
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
INSERT INTO gym_users(username, email, password, age, gender, place, date_of_join)
VALUES ('Admin', 'admin@gmail.com', 'admin123', 25, 'male', 'city', CURDATE());


insert
