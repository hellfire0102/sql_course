SELECT warehouse.number, warehouse.name, person.fio
FROM warehouse INNER JOIN person ON warehouse.owner_id = person.id;