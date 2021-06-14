DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria;
USE pizzeria;


CREATE TABLE Type_delivery (
                id INT AUTO_INCREMENT NOT NULL,
                Type_delivery VARCHAR(255) NOT NULL,
                PRIMARY KEY (id)
);


CREATE UNIQUE INDEX type_livraison_idx
 ON Type_delivery
 ( Type_delivery );

CREATE TABLE Payment_methode (
                id INT AUTO_INCREMENT NOT NULL,
                Payment_methode VARCHAR(255) NOT NULL,
                PRIMARY KEY (id)
);


CREATE UNIQUE INDEX payment_methode_idx
 ON Payment_methode
 ( Payment_methode );

CREATE TABLE Raw_material (
                id INT AUTO_INCREMENT NOT NULL,
                Name VARCHAR(255) NOT NULL,
                PRIMARY KEY (id)
);


CREATE UNIQUE INDEX raw_material_idx
 ON Raw_material
 ( Name );

CREATE TABLE Product (
                id INT AUTO_INCREMENT NOT NULL,
                Name VARCHAR(255) NOT NULL,
                Small_description VARCHAR(255),
                Recipe LONGTEXT,
                Unit_price DECIMAL,
                PRIMARY KEY (id)
);


CREATE UNIQUE INDEX product_idx
 ON Product
 ( Name );

CREATE TABLE Order_status (
                id INT AUTO_INCREMENT NOT NULL,
                Status VARCHAR(255) NOT NULL,
                PRIMARY KEY (id)
);


CREATE UNIQUE INDEX order_status_idx
 ON Order_status
 ( Status );

CREATE TABLE Account (
                id INT AUTO_INCREMENT NOT NULL,
                Type VARCHAR(50) NOT NULL,
                PRIMARY KEY (id)
);


CREATE UNIQUE INDEX account_idx
 ON Account
 ( Type );

CREATE TABLE User (
                id INT AUTO_INCREMENT NOT NULL,
                Name VARCHAR(255) NOT NULL,
                Family_name VARCHAR(255) NOT NULL,
                Phone_number INT NOT NULL,
                Email VARCHAR(255) NOT NULL,
                Password VARCHAR(255) NOT NULL,
                account_id INT DEFAULT 1,
                PRIMARY KEY (id)
);


CREATE UNIQUE INDEX user_idx
 ON User
 ( Email ASC );

CREATE TABLE Employe (
                id INT AUTO_INCREMENT NOT NULL,
                Salary INT NOT NULL,
                User_id INT NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE Adress (
                id INT AUTO_INCREMENT NOT NULL,
                id_user INT,
                City VARCHAR(255) NOT NULL,
                Street VARCHAR(255) NOT NULL,
                Numero INT NOT NULL,
                Zip_code INT NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE shop (
                id INT AUTO_INCREMENT NOT NULL,
                adress_id INT NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE All_order (
                id INT AUTO_INCREMENT NOT NULL,
                User_id INT NOT NULL,
                Date DATETIME NOT NULL,
                Payment_status BOOLEAN NOT NULL,
                Payment_methode_id INT,
                Type_delivery_id INT NOT NULL,
                User_validation_order BOOLEAN,
                Order_status_id INT NOT NULL,
                Comments VARCHAR(255),
                shop_id INT NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE Invoice (
                id INT AUTO_INCREMENT NOT NULL,
                All_order_id INT NOT NULL,
                Product_id INT NOT NULL,
                Quantity SMALLINT NOT NULL,
                PRIMARY KEY (id)
);


CREATE UNIQUE INDEX invoice_idx
 ON Invoice
 ( All_order_id, Product_id );

CREATE TABLE inventory_raw (
                id INT AUTO_INCREMENT NOT NULL,
                Adress_id INT NOT NULL,
                Raw_material_id INT NOT NULL,
                Quantity DECIMAL(5,2) NOT NULL,
                PRIMARY KEY (id)
);


CREATE UNIQUE INDEX inventory_raw_idx
 ON inventory_raw
 ( Adress_id, Raw_material_id );

CREATE TABLE Product_food_Inventory (
                id INT AUTO_INCREMENT NOT NULL,
                Product_id INT NOT NULL,
                inventory_id INT NOT NULL,
                Quantity_required DECIMAL(5,2) NOT NULL,
                PRIMARY KEY (id)
);


CREATE UNIQUE INDEX product_food_inventory_idx
 ON Product_food_Inventory
 ( Product_id, inventory_id );

CREATE TABLE Employe_pizzeria (
                id INT AUTO_INCREMENT NOT NULL,
                Employe_id INT NOT NULL,
                shop_id INT,
                PRIMARY KEY (id)
);


CREATE UNIQUE INDEX employe_pizzeria_idx
 ON Employe_pizzeria
 ( Employe_id ASC, shop_id );

ALTER TABLE All_order ADD CONSTRAINT type_livraison_order_fk
FOREIGN KEY (Type_delivery_id)
REFERENCES Type_delivery (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE All_order ADD CONSTRAINT payment_methode_order_fk
FOREIGN KEY (Payment_methode_id)
REFERENCES Payment_methode (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE inventory_raw ADD CONSTRAINT raw_material_inventory_raw_fk
FOREIGN KEY (Raw_material_id)
REFERENCES Raw_material (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Invoice ADD CONSTRAINT product_invoice_fk
FOREIGN KEY (Product_id)
REFERENCES Product (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Product_food_Inventory ADD CONSTRAINT product_product_food_stock_fk
FOREIGN KEY (Product_id)
REFERENCES Product (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE All_order ADD CONSTRAINT order_status_order_fk
FOREIGN KEY (Order_status_id)
REFERENCES Order_status (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE User ADD CONSTRAINT account_user_fk
FOREIGN KEY (account_id)
REFERENCES Account (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Adress ADD CONSTRAINT user_adress_fk
FOREIGN KEY (id_user)
REFERENCES User (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE All_order ADD CONSTRAINT user_order_fk
FOREIGN KEY (User_id)
REFERENCES User (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Employe ADD CONSTRAINT user_employe_fk
FOREIGN KEY (User_id)
REFERENCES User (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Employe_pizzeria ADD CONSTRAINT employe_employe_pizzeria_fk
FOREIGN KEY (Employe_id)
REFERENCES Employe (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Employe_pizzeria ADD CONSTRAINT adress_employe_pizzeria_fk
FOREIGN KEY (shop_id)
REFERENCES Adress (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE inventory_raw ADD CONSTRAINT adress_inventory_fk
FOREIGN KEY (Adress_id)
REFERENCES Adress (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE shop ADD CONSTRAINT adress_shop_fk
FOREIGN KEY (adress_id)
REFERENCES Adress (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Employe_pizzeria ADD CONSTRAINT shop_employe_pizzeria_fk
FOREIGN KEY (shop_id)
REFERENCES shop (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE All_order ADD CONSTRAINT shop_all_order_fk
FOREIGN KEY (shop_id)
REFERENCES shop (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Employe_pizzeria ADD CONSTRAINT shop_employe_pizzeria_fk1
FOREIGN KEY (shop_id)
REFERENCES shop (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Invoice ADD CONSTRAINT order_invoice_fk
FOREIGN KEY (All_order_id)
REFERENCES All_order (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Product_food_Inventory ADD CONSTRAINT invoice_product_food_stock_fk
FOREIGN KEY (Product_id)
REFERENCES Invoice (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Product_food_Inventory ADD CONSTRAINT inventory_raw_product_food_stock_fk
FOREIGN KEY (inventory_id)
REFERENCES inventory_raw (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;