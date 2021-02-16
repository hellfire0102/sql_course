CREATE FUNCTION sales_person_ins() RETURNS trigger AS $$
BEGIN
	INSERT INTO log(full_name, sex) VALUES (NEW.full_name, NEW.sex);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER pers_ins_logging
AFTER INSERT ON sales_person
FOR EACH ROW 
EXECUTE PROCEDURE sales_person_ins();