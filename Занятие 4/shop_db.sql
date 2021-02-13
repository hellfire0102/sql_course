CREATE SEQUENCE sales_person_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 1000000
	START 1;
	
CREATE TABLE sales_person(
	id bigint NOT NULL PRIMARY KEY DEFAULT nextval('sales_person_seq'::regclass),
	full_name character varying(5000) NOT NULL,
	sex boolean NOT NULL,
	birth_date date
);

CREATE SEQUENCE staff_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 1000000
	START 1;
	
CREATE TABLE staff(
	id bigint NOT NULL PRIMARY KEY DEFAULT nextval('staff_seq'::regclass),
	sales_person_id bigint NOT NULL,
	recruiting_date date NOT NULL,
	firing_date date,
	firing_reason character varying(5000),
	
	FOREIGN KEY (sales_person_id) REFERENCES sales_person (id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE SEQUENCE supplier_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 1000000
	START 1;
	
CREATE TABLE supplier(
	id bigint NOT NULL PRIMARY KEY DEFAULT nextval('supplier_seq'::regclass),
	company_name character varying(500) NOT NULL,
	registration_city character varying(50) NOT NULL,
	registration_date date NOT NULL
);

CREATE SEQUENCE receipt_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 1000000
	START 1;

CREATE TABLE receipt(
	id bigint NOT NULL PRIMARY KEY DEFAULT nextval('receipt_seq'::regclass),
	customer_full_name character varying(500) NOT NULL,
	sales_person_id bigint NOT NULL,
	discount decimal(10, 2) NOT NULL DEFAULT 0,
	amount decimal(19, 2) NOT NULL DEFAULT 0,
	purchase_date timestamp NOT NULL DEFAULT now(),
	
	FOREIGN KEY (sales_person_id) REFERENCES sales_person(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE SEQUENCE release_form_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 1000000
	START 1;
	
CREATE TABLE release_form(
	id bigint NOT NULL PRIMARY KEY DEFAULT nextval('release_form_seq'::regclass),
	name character varying(255) NOT NULL
);

CREATE SEQUENCE product_category_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 1000000
	START 1;
	
CREATE TABLE product_category(
	id bigint NOT NULL PRIMARY KEY DEFAULT nextval('product_category_seq'::regclass),
	name character varying(255) NOT NULL
);

CREATE SEQUENCE product_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 1000000
	START 1;
	

CREATE TABLE product(
	id bigint NOT NULL PRIMARY KEY DEFAULT nextval('product_seq'::regclass),
	name character varying(1000) NOT NULL,
	origin_country character varying(250),
	supplier_id bigint NOT NULL,
	release_form_id bigint NOT NULL,
	price decimal(19, 2),
	product_category_id bigint NOT NULL,
	
	FOREIGN KEY (supplier_id) REFERENCES supplier(id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (release_form_id) REFERENCES release_form(id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (product_category_id) REFERENCES product_category(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE SEQUENCE stored_product_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 1000000
	START 1;
	
CREATE TABLE stored_product(
	id bigint NOT NULL PRIMARY KEY DEFAULT nextval('stored_product_seq'::regclass),
	product_id bigint NOT NULL,
	quantity bigint NOT NULL,
	
	FOREIGN KEY (product_id) REFERENCES product(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE SEQUENCE receipt_lines_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 1000000
	START 1;
	
CREATE TABLE receipt_lines(
	id bigint NOT NULL PRIMARY KEY DEFAULT nextval('receipt_lines_seq'::regclass),
	receipt_id bigint NOT NULL,
	product_id bigint NOT NULL,
	quantity bigint NOT NULL,
	amount decimal(19, 2) NOT NULL DEFAULT 0,
	
	FOREIGN KEY (receipt_id) REFERENCES receipt(id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (product_id) REFERENCES product(id) ON UPDATE CASCADE ON DELETE RESTRICT
);


--Вставка данных

INSERT INTO sales_person(full_name, sex, birth_date) VALUES
	('Петров Александр Семёнович', true, '1988-12-22'),
	('Кудрявцев Иван Степанович', true, '1996-05-11'),
	('Куницева Тамара Яковлевна', false, '2000-01-03'),
	('Бедров Роман Сергеевич', true, null),
	('Лыжина Зинаида Алексеевна', false, '1978-12-08'),
	('Ведерникова Анна Валентиновна', false, '1993-11-30'),
	('Князев Олег Аристархович', true, '1977-04-16'),
	('Зимина Любовь Александровна', false, '2002-02-28'),
	('Зубенко Михаил Петрович', true, '1980-09-11');
	
INSERT INTO supplier(company_name, registration_city, registration_date) VALUES
	('Рога и Копыта', 'Пермь', '2012-04-10'),
	('Четыре бояниста и кО', 'Москва', '2003-01-01'),
	('ИП Сергеич', 'Пермь', '2020-10-29'),
	('Вот те нож: вынь, да положь', 'Новосибирск', '1992-03-16');
	
INSERT INTO staff(sales_person_id, recruiting_date, firing_date, firing_reason) VALUES
	(1, '2018-10-19', null, ''),
	(2, '2017-07-20', '2019-07-18', 'Бухал на работе'),
	(3, '2020-03-16', null, ''),
	(4, '2019-11-12', '2020-03-15', 'Сменил место работы'),
	(5, '2013-02-04', '2019-05-03', 'Множество прогулов'),
	(6, '2011-12-14', '2015-10-26', 'Раздражала весь коллекти'),
	(7, '2018-09-02', null, ''),
	(8, '2020-10-19', null, ''),
	(9, '2016-08-28', null, '');

INSERT INTO release_form(name) VALUES
	('Упаковка 250г'),
	('Упаковка 1кг'),
	('Мешок 1кг'),
	('Упаковка 100г'),
	('Бутылка 1.5л'),
	('Бутылка 1л'),
	('Бутылка 2л'),
	('Бутылка 0.5л'),
	('Штука');
	
INSERT INTO product_category(name) VALUES
	('Овощи'),
	('Компьютеры'),
	('Бытовая техника'),
	('Бытовая химия'),
	('Фрукты'),
	('Бакалея'),
	('Мясо'),
	('Рыба'),
	('Полуфабрикаты'),
	('Напитки');
	
INSERT INTO product(name, origin_country, supplier_id, release_form_id, price, product_category_id) VALUES
	('Картофель мытый', 'Беларусь', 3, 3, 60.79, 1),
	('Макароны Макфа', 'Россия', 2, 1, 110, 6),
	('Чипсы Lays с сыром', 'Россия', 4, 4, 59.90, 6),
	('Лапша быстрого приготовления Ролтон', 'Россия', 2, 9, 25, 6),
	('Порошок стиральный Tide', 'Россия', 4, 3, 320.99, 4),
	('Ноутбук Lenovo офигенный', 'Тайвань', 3, 9, 54000, 2),
	('Ноутбук HP spectre x360', 'Япония', 3, 9, 129000, 2),
	('Яблоки сладкие', 'Греция', 1, 2, 115.30, 5),
	('Яблоки садовые', 'Украина', 1, 2, 170.40, 5),
	('Стиральная машина Bosh', 'Китай', 3, 9, 28900, 3),
	('Холодильник Indesit G560', 'Италия', 3, 9, 87499, 3),
	('Холодильник Indesit G340', 'Италия', 3, 9, 49400.50, 3),
	('Лосось замороженный', 'Япония', 4, 9, 480.99, 8),
	('Лосось охлаждённый', 'Россия', 4, 9, 632, 8),
	('Бедро индейки', 'Россия', 4, 9, 239, 7),
	('Медальоны из индейки', 'Россия', 4, 9, 267, 7),
	('Фарш свиной', 'Беларусь', 3, 2, 550, 7),
	('Заготовка для плова', 'Грузия', 2, 9, 137, 9),
	('Котлеты замороженные', 'Россия', 2, 1, 259.99, 9),
	('Пельмени радость моя с мясом', 'Россия', 2, 2, 489, 9),
	('ПК DEXP для учёбы', 'США', 1, 9, 170000, 2),
	('ПК Lenovo', 'Китай', 1, 9, 125900, 2),
	('ПК HP Omen', 'Япония', 1, 9, 122999, 2),
	('ПК DEXP обыкновенный', 'США', 3, 9, 21399, 2),
	('Хлеб белый', 'Россия', 4, 9, 25, 6),
	('Coca-cola Zero', 'США', 4, 5, 109.90, 10),
	('Coca-cola Zero', 'США', 4, 6, 89.90, 10),
	('Холодный чай Nestea лимон', 'Россия', 2, 5, 115, 10),
	('Lipton персик', 'Россия', 2, 6, 111, 10);
	
INSERT INTO stored_product (product_id, quantity)
SELECT id, ROUND(RANDOM()*(100-1)+1)
FROM product;

INSERT INTO receipt(customer_full_name, sales_person_id, discount, purchase_date)
VALUES
('Земеля Борис Иванович', 7, 5, '2020-07-17 14:20:00'),
('Ключникова Екатерина Семёновна', 1, 0, '2019-05-14 23:17:14'),
('Заковыркин Роман Михайлович', 1, 0, '2019-05-14 22:59:11'),
('Челубей Татар Монголович', 7, 15, '2020-07-17 14:00:28');

INSERT INTO receipt_lines(receipt_id, product_id, quantity) VALUES
	(1, 1, 1),
	(1, 2, 3),
	(1, 9, 2),
	(2, 10, 1),
	(2, 12, 1),
	(2, 22, 1),
	(2, 26, 7),
	(3, 17, 8),
	(3, 18, 15),
	(4, 8, 1),
	(4, 9, 2),
	(4, 11, 1),
	(4, 13, 3),
	(4, 19, 10);
	
UPDATE receipt_lines
SET amount = quantity*(SELECT p.price
					   FROM product p
					   WHERE p.id = receipt_lines.product_id);
					   
UPDATE receipt
SET amount = (SELECT SUM(amount)
				FROM receipt_lines
				WHERE receipt_id = receipt.id) - (SELECT SUM(amount)
					   								FROM receipt_lines
					   							WHERE receipt_id = receipt.id)*discount;
												

ALTER TABLE stored_products ADD CHECK (quantity >= 0);
												
ALTER TABLE receipt_lines ADD CHECK (quantity >= 0 AND amount >= 0.0);

CREATE SEQUENCE delivery_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 1000000
	START 1;
	
CREATE TABLE delivery(
	id bigint PRIMARY KEY DEFAULT nextval('delivery_seq'::regclass),
	product_id bigint REFERENCES product(id),
	delivery_date date DEFAULT NOW(),
	quantity bigint NOT NULL
);


INSERT INTO delivery(product_id, quantity) VALUES
	(1, 600),
	(2, 140),
	(3, 85),
	(4, 90),
	(5, 18),
	(6, 3),
	(7, 15),
	(8, 73),
	(9, 77),
	(10, 5),
	(11, 3),
	(12, 8),
	(13, 12),
	(14, 21),
	(15, 16),
	(16, 7),
	(17, 12),
	(18, 49),
	(19, 83),
	(20, 24),
	(21, 9),
	(22, 17),
	(23, 1),
	(24, 6),
	(25, 117),
	(26, 120),
	(27, 237),
	(28, 43),
	(29, 1990);