CREATE TABLE modern_role(
	id BIGINT PRIMARY KEY,
	name character varying(255) NOT NULL,
	parent_id BIGINT REFERENCES modern_role(id)
);

INSERT INTO modern_role VALUES
	(1, 'Генеральный директор', null),
	(2, 'Исполнительный директор', 1),
	(3, 'Финансовый директор', 1),
	(4, 'Юрист', 3),
	(5, 'Секретарь', 2);