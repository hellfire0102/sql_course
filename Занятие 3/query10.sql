SELECT id, birth_date
FROM person
WHERE id IN(
	SELECT DISTINCT owner_id
	FROM warehouse
)
ORDER BY birth_date ASC
LIMIT 1;