WITH RECURSIVE temp1 ( id,name,parent_id,PATH, LEVEL ) AS (
SELECT t1.id, t1.name, t1.parent_id, CAST (t1.name AS VARCHAR (255)) as PATH, 1
    FROM modern_role t1 WHERE t1.parent_id IS NULL
UNION
SELECT t2.id, t2.name, t2.parent_id,
	CAST ( temp1.PATH ||'->'|| t2.name AS VARCHAR(255)) ,LEVEL + 1
     FROM modern_role t2 INNER JOIN temp1 ON( temp1.id= t2.parent_id)
)
SELECT * FROM temp1 ORDER BY PATH LIMIT 100;