CREATE SEQUENCE log_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 1000000
	START 1;
	
CREATE TABLE log(
	id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('log_seq'::regclass),
	full_name VARCHAR(1500) NOT NULL,
	sex boolean NOT NULL,
	insertation_date timestamp NOT NULL DEFAULT NOW()
);