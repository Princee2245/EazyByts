create database crm_db;
use crm_db;


-- Create users table
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL
);



-- Create roles table
CREATE TABLE roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);



-- Insert sample roles
INSERT INTO roles (name) VALUES ('ROLE_MANAGER');
INSERT INTO roles (name) VALUES ('ROLE_SALES_PERSON');

-- Insert sample users
INSERT INTO users (email, password,role) VALUES ('manager@example.com', 'password','ROLE_MANAGER'); -- password: password (BCrypt hashed)
INSERT INTO users (email, password,role) VALUES ('salesperson@example.com', 'password','ROLE_SALES_PERSON'); -- password: password (BCrypt hashed)

-- Assign roles to users


set SQL_SAFE_UPDATES=0;

CREATE TABLE customers (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_details TEXT,
    notes TEXT,
    assigned_to_id BIGINT,
    FOREIGN KEY (assigned_to_id) REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
drop table customers;


CREATE TABLE tasks (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    description TEXT NOT NULL,
    due_date DATE NOT NULL,
    user_email VARCHAR(255)  NOT NULL,
    FOREIGN KEY (user_email) REFERENCES users(email) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE meetings (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    description TEXT NOT NULL,
    date TIMESTAMP NOT NULL,
    user_email VARCHAR(255)  NOT NULL,
    FOREIGN KEY (user_email) REFERENCES users(email) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

drop table tasks;

CREATE TABLE sales (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    amount DECIMAL(10, 2) NOT NULL,
    sale_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE activities (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    description TEXT NOT NULL,
    date TIMESTAMP NOT NULL,
    user_id BIGINT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE VIEW sales_metrics AS
SELECT 
    user_id,
    SUM(amount) AS total_sales,
    SUM(CASE WHEN sale_date >= CURDATE() - INTERVAL 1 MONTH THEN amount ELSE 0 END) AS monthly_sales,
    SUM(CASE WHEN sale_date >= CURDATE() - INTERVAL 3 MONTH THEN amount ELSE 0 END) AS quarterly_sales
FROM sales
GROUP BY user_id;




INSERT INTO customers (name, contact_details, notes, assigned_to_id) VALUES
('Company A', 'contact@companya.com', 'Key client', 1),
('Company B', 'contact@companyb.com', 'Potential lead', 1),
('Company C', 'contact@companyc.com', 'Regular customer', 2);


INSERT INTO tasks (description, due_date, user_email) VALUES
('Follow up with Company A', '2024-07-10', 'manager@example.com'),
('Prepare presentation for Company B', '2024-07-12', 'manager@example.com'),
('Schedule meeting with Company C', '2024-07-15', 'salesperson@example.com');
	

INSERT INTO meetings (description, date, user_email) VALUES
('Meeting with Company A', '2024-07-11 10:00:00', 'manager@example.com'),
('Lunch with Company B', '2024-07-13 12:30:00', 'manager@example.com'),
('Strategy session with Company C', '2024-07-16 09:00:00', 'salesperson@example.com');


INSERT INTO sales (user_id, amount, sale_date) VALUES
(1, 1000.00, '2024-07-01'),
(1, 1500.00, '2024-07-05'),
(2, 2000.00, '2024-07-02'),
(2, 2500.00, '2024-07-03');


INSERT INTO activities (description, date, user_id) VALUES
('Call with Company A', '2024-07-01 09:00:00', 1),
('Email to Company B', '2024-07-01 10:00:00', 1),
('Meeting with Company C', '2024-07-02 14:00:00', 2),
('Follow-up with Company A', '2024-07-03 15:00:00', 1);

select * from activities;
