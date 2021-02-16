CREATE FUNCTION quantity_check() RETURNS trigger AS $$
DECLARE
	maxqnt bigint;
BEGIN
	maxqnt := (SELECT quantity FROM stored_product WHERE product_id = NEW.product_id);
	IF NEW.quantity > maxqnt THEN
		RAISE EXCEPTION 'Такого количества товара нет на складе!';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER can_buy
BEFORE UPDATE OR INSERT ON receipt_lines
FOR EACH ROW
EXECUTE PROCEDURE quantity_check();