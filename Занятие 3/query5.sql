SELECT p.fio, p.sex, p.birth_date
FROM person p LEFT OUTER JOIN warehouse w ON w.owner_id = p.id
WHERE w.number IS NULL;