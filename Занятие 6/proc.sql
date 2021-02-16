CREATE PROCEDURE insert_delivery(prod_id bigint, qnt bigint)
LANGUAGE SQL
AS $$
	INSERT INTO delivery(product_id, quantity) VALUES (prod_id, qnt);
	UPDATE stored_product
	SET quantity = quantity + qnt
	WHERE product_id = prod_id;
$$;