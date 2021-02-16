WITH seller_nine AS (
	SELECT * FROM sales_person
	WHERE id IN(SELECT DISTINCT sales_person_id
				FROM receipt
				WHERE id IN(SELECT DISTINCT receipt_id
							FROM receipt_lines
							WHERE product_id = 9))
)
SELECT * FROM sales_person WHERE id =(
	SELECT t.id FROM (
		SELECT sn.id, SUM(r.amount) AS sm
		FROM receipt r INNER JOIN seller_nine sn ON r.sales_person_id = sn.id
		GROUP BY sn.id
		ORDER BY sm DESC
		LIMIT 1) t
);