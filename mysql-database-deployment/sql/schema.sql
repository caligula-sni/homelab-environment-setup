
CREATE DATABASE dbfarm2;
USE dbfarm2;

CREATE TABLE tbrole (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(45)
);

CREATE TABLE tbprovince (
    province_id INT AUTO_INCREMENT PRIMARY KEY,
    province_name VARCHAR(45)
);

CREATE TABLE tbcitymuni (
    cm_id INT AUTO_INCREMENT PRIMARY KEY,
    cm_name VARCHAR(45),
    province_id INT,
    FOREIGN KEY (province_id) REFERENCES tbprovince(province_id)
);

CREATE TABLE tbuser (
    id INT AUTO_INCREMENT PRIMARY KEY,
    UserName VARCHAR(45),
    PassWord VARCHAR(255),
    FullName VARCHAR(45),
    role_id INT,
    province_id INT,
    cm_id INT,
    FOREIGN KEY (role_id) REFERENCES tbrole(role_id),
    FOREIGN KEY (province_id) REFERENCES tbprovince(province_id),
    FOREIGN KEY (cm_id) REFERENCES tbcitymuni(cm_id)
);
