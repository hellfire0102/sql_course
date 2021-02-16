CREATE FUNCTION quantity_check(prod_id bigint) RETURNS boolean AS $$
DECLARE
	full_quantity bigint;
	stored_quantity bigint;
	sold_quantity bigint;
BEGIN
	full_quantity := (SELECT quantity FROM delivery WHERE product_id = prod_id);
	stored_quantity := (SELECT quantity FROM stored_product WHERE product_id = prod_id);
	sold_quantity := (SELECT a.cnt
					  FROM (SELECT product_id, SUM(quantity) AS cnt
							FROM receipt_lines GROUP BY product_id) a
					  WHERE a.product_id = prod_id
					 );
	IF full_quantity != stored_quantity + sold_quantity THEN
		RETURN false;
	END IF;
	RETURN true;
END;
$$ LANGUAGE plpgsql;