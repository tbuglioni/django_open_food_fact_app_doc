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

INSERT INTO account (type)
values
('client'),
('manager'),
('pizzaiolo'),
('livreur')
;

INSERT INTO Payment_methode (Payment_methode)
values
('CB'),
('liquide'),
('cheque');

INSERT INTO Type_delivery (Type_delivery)
VALUES
('pizzeria'),
('domicile');

INSERT INTO Raw_material(name)
VALUES
('tomate'),
('olive'),
('oignon'),
('saumon'),
('viande hachée'),
('origan'),
('creme fraiche'),
('gruyere');

INSERT INTO User(name, family_name, phone_number, email, password, account_id)
VALUES
('oliver', 'brisette', '0691017278', 'oliver.b@gmail.com', 'SDFGHJKL', 1),
('travers', 'lauzier', '0764997659', 'krjx6hpy4ae@temporary-mail.net', 'dklhfmsqhf', 1),
('cher', 'arcouet', '0708063887', '75hdhb9kpp4@temporary-mail.net', 'flkqjhfjonjnnln', 2),
('leroy', 'garceau','0600200187', 'leroy,garceau@hotmail.fr', 'blajfoajdojfoo', 3),
('louis', 'charles', '0873929975', 'john.smith078@outlook.com', 'hfksjhflkskld', 4),
('Nicolas', 'Armon', '0754799875', 'n.amron@gmail.com', 'igfuigoagfiug', 2),
('Maxime', 'dumelon', '0662932738', 'max.mel@gmail.com', 'fljkshqflkzjbflbf', 3)
;

INSERT INTO Adress(id_user, city, street, numero, zip_code)
VALUE
(1, 'le havre', 'rue michel ange', 48, 76600),
(2, 'epinal', 'rue du palais', 90, 88000),
(3, 'MARCQ-EN-BAROEUL', 'Rue de la Pompe', 25, 59700),
(4, 'paris', 'place de la madeleine', 37, 75009),
(5, 'Montmorency', 'avenue des Pr', 64, 95160 ),
(6, 'gagny', 'rue saint germain', 79, 93220),
(7, 'nantes', 'place stanislas', 56, 44000),
(NULL, 'vannes', 'avenue de provence', 112, 56000),
(NULL, 'LE PUY-EN-VELAY', 'rue Adolphe Wurtz', 79, 43000);

INSERT INTO employe(user_id, salary)
VALUES
(3, 2200),
(4, 1500),
(5, 1500),
(6,2200),
(7,1500);

INSERT INTO order_status(status)
VALUES 
('en attente'),
('en preparation'),
('en livraison'),
('livrée'),
('annulée');

INSERT INTO shop(adress_id)
VALUES
(8),
(9);


INSERT INTO employe_pizzeria(employe_id, shop_id)
VALUES
(1,1),
(4,2),
(2,1),
(5,2),
(3,1);

INSERT INTO product(name, small_description, recipe, unit_price )
VALUES 
('la saumon', 'saumon, creme fraiche, fromage, origan','Préparez la pâte à pizza. Attendez au moins 15 min pour qu elle lève, elle sera plus facile à travailler.
Etalez la pâte sur une plaque graissée à l huile d olive, puis recouvrez-la d une fine couche de crème fraîche.
Disposez les tranches de saumon, de façon à ce qu elles recouvrent toute la pâte.
Arrosez de 2 cuillères à soupe d huile d olive, saupoudrez d origan et de quelques zestes de citron.
Enfin, coupez la mozzarella en tranches moyennes pour en recouvrir la pizza; vous pouvez décorer avec quelques tranches de citron.
Enfournez dans un four préchauffé à 180°C (th 6).
Facultatif : cassez des oeufs 5 min avant la fin de la cuisson et remettez au four quelques minutes. https://www.marmiton.org/recettes/recette_pizza-au-saumon_22391.aspx', 15 ),
('la cannibale', 'tomate, oignon, viande hachée, olives, gruyere', 'Dans une poêle huilée, faire revenir loignon et les tomates pelées. Ajouter les herbes de Provence et laisser mijoter 10 minutes à feu moyen.
Préchauffer le four à 210°C.
Etaler la pâte à pizza et verser dessus le mélange tomates/oignon/herbes.
Disposer les poivrons, la viande hachée sur la tomate et saupoudrer de gruyère râpé.
Saler et poivrer.
Ajouter quelques olives noires et des herbes de Provence.
Enfourner pendant 20 minutes. https://www.ptitchef.com/recettes/entree/pizza-cannibale-fid-800399', 15);

INSERT INTO all_order (user_id, date, payment_status, payment_methode_id, type_delivery_id, user_validation_order, Order_status_id, shop_id, comments)
values
(1, now(), 1, 1, 2, 1, 4, 1, 'digicode : 1407'),
(2, now(), 1, 1, 2, 1, 4, 2, NULL);

INSERT INTO invoice(all_order_id, product_id, quantity)
values
(1,2,2),
(1,1,1),
(2,1,3);

INSERT INTO inventory_raw(adress_id, raw_material_id, quantity)
values
(8, 1, 5),
(8, 2, 5),
(8, 3, 5),
(8, 4, 5),
(8, 5, 5),
(8, 6, 5),
(8, 7, 5),
(8, 8, 5),
(9, 1, 5),
(9, 2, 5),
(9, 3, 5),
(9, 4, 5),
(9, 5, 5),
(9, 6, 5),
(9, 7, 5),
(9, 8, 5);

INSERT INTO Product_food_Inventory(product_id, inventory_id, quantity_required)
VALUES 
(1,1,0.3),
(1,2,0.2),
(1,3,0.05),
(2,2,0.2),
(2,3,0.5),
(2,5,0.01);
