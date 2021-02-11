
CREATE SEQUENCE product_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 999999
  START 1;

CREATE TABLE IF NOT EXISTS product (
  id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('product_seq'::regclass),
  name varchar(60) NOT NULL,
  weight decimal(10,2) NOT NULL,
  prod_type varchar(30) NOT NULL
);


CREATE SEQUENCE person_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 999999
  START 1;

CREATE TABLE IF NOT EXISTS person (
  id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('person_seq'::regclass),
  fio varchar(255) NOT NULL,
  sex INTEGER NOT NULL,
  birth_date date NOT NULL
);

CREATE TABLE IF NOT EXISTS warehouse (
  number INTEGER NOT NULL PRIMARY KEY,
  name varchar(100) NOT NULL,
  owner_id BIGINT NOT NULL
);

ALTER TABLE warehouse
  ADD CONSTRAINT warehouse_ibfk_1 FOREIGN KEY (owner_id) REFERENCES person (id) ON DELETE CASCADE;


CREATE TABLE IF NOT EXISTS car (
  register_number varchar(10) NOT NULL PRIMARY KEY,
  model varchar(30) NOT NULL,
  full_capacity decimal(10,2) NOT NULL,
  driver_id BIGINT NOT NULL
);

ALTER TABLE car
  ADD CONSTRAINT car_ibfk_1 FOREIGN KEY (driver_id) REFERENCES person (id) ON DELETE CASCADE;


CREATE SEQUENCE transport_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 999999
  START 1;

CREATE TABLE IF NOT EXISTS transport (
  id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('transport_seq'),
  car_reg_num varchar(10) NOT NULL,
  war_number INTEGER NOT NULL,
  transp_date date NOT NULL
);


ALTER TABLE transport
  ADD CONSTRAINT transport_ibfk_2 FOREIGN KEY (car_reg_num) REFERENCES car (register_number) ON DELETE CASCADE,
  ADD CONSTRAINT transport_ibfk_3 FOREIGN KEY (war_number) REFERENCES warehouse (number) ON DELETE CASCADE;


CREATE SEQUENCE prod_transport_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 999999
  START 1;

CREATE TABLE IF NOT EXISTS prod_transport (
  id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('prod_transport_seq'::regclass),
  transport_id BIGINT NOT NULL,
  prod_id BIGINT NOT NULL,
  quantity INTEGER NOT NULL
);

ALTER TABLE prod_transport
  ADD CONSTRAINT prod_transport_ibfk_3 FOREIGN KEY (transport_id) REFERENCES transport (id) ON DELETE CASCADE,
  ADD CONSTRAINT prod_transport_ibfk_2 FOREIGN KEY (prod_id) REFERENCES product (id) ON DELETE CASCADE;


INSERT INTO product (name, weight, prod_type) VALUES
('Чипсы', '0.30', 'Продукты'),
('Огурцы', '0.10', 'Продукты'),
('Ноутбук HP', '2.00', 'Электроника'),
('Персональный компьютер', '12.50', 'Электроника'),
('Стиральная машина', '25.00', 'Бытовая техника'),
('SONY Xperia Z', '0.20', 'Электроника'),
('Соковыжималка', '3.30', 'Бытовая техника'),
('SAMSUNG', '0.20', 'Электроника'),
('Кухонный стол', '10.70', 'Мебель'),
('Люстра хрустальная', '8.00', 'Люстры'),
('Капуста', '0.60', 'Продукты'),
('Спрайт', '1.50', 'Газированные напитки');

INSERT INTO person (fio, sex, birth_date) VALUES
('Курносов Константин Сергеевич', 1, '2005-03-15'),
('Болтикова Арина Семёновна', 0, '1977-08-20'),
('Кудряшов Валентин Анатольевич', 1, '1989-01-23'),
('Сокольникова Антонина Павловна', 0, '1993-04-11'),
('Мишурин Владимир Юрьевич', 1, '1963-12-29'),
('Никифоров Григорий Викторович', 1, '1987-11-15'),
('Кузнецова Анна Олеговна', 0, '1995-02-01');

INSERT INTO warehouse (number, name, owner_id) VALUES
(13579, 'База13', 3),
(24680, 'Склад2', 5),
(124578, 'База17', 3),
(347801, 'Склад3', 2),
(467254, 'База116', 4),
(942568, 'Склад5', 6);

INSERT INTO car (register_number, model, full_capacity, driver_id) VALUES
('1270YT59', 'Белаз', '100000.00', 7),
('BY287O89', 'MAN', '24000.00', 4),
('HA879K71', 'Камаз', '17000.00', 2),
('PC235Y144', 'Камаз', '12000.00', 6),
('TE435Y78', 'Камаз', '34000.00', 4),
('TY817T59', 'MAN', '10000.00', 1),
('6523HO79', 'ЗИЛ', 25000.00, 7),
('2410YE76', 'Белаз', 100000.00, 1);


INSERT INTO transport (car_reg_num, war_number, transp_date) VALUES
('HA879K71', 124578, '2035-05-23'),
('PC235Y144', 24680, '2017-01-23'),
('1270YT59', 13579, '2015-02-01'),
('TY817T59', 347801, '2014-10-17'),
('BY287O89', 24680, '2016-06-25'),
('HA879K71', 942568, '2015-08-04'),
('TE435Y78', 467254, '2016-09-01'),
('BY287O89', 124578, '2011-05-23'),
('1270YT59', 467254, '2017-01-03'),
('TY817T59', 124578, '2019-03-03');

INSERT INTO prod_transport (transport_id, prod_id, quantity) VALUES
(6, 11, 90000),
(1, 1, 1000),
(1, 7, 5000),
(1, 2, 400),
(2, 5, 100),
(2, 6, 1000),
(7, 4, 500),
(7, 10, 300),
(8, 9, 10000),
(9, 3, 50),
(9, 11, 150),
(9, 1, 1000),
(10, 4, 500),
(10, 6, 5000);