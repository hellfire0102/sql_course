BEGIN;
-- Возвращаем прежнее количество товаров
UPDATE stored_product
SET quantity = quantity + (SELECT quantity FROM receipt_lines WHERE id = 1)
WHERE product_id = 1;
-- Совершаем покупку 15 товаров, вместо 1 как раньше
UPDATE receipt_lines
SET quantity = 15
WHERE id = 1;
-- Вычитаем купленные товары
UPDATE stored_product
SET quantity = quantity - 15
WHERE product_id = 1;

COMMIT;