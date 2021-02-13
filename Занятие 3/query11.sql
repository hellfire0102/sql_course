SELECT *
FROM warehouse
WHERE owner_id = (
	SELECT id
	FROM person
	WHERE id IN(
		SELECT DISTINCT owner_id
		FROM warehouse
	)
	ORDER BY birth_date ASC
	LIMIT 1
);
