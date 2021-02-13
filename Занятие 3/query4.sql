SELECT p.fio, w.number 
FROM person p LEFT OUTER JOIN warehouse w ON w.owner_id = p.id;