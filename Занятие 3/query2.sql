SELECT warehouse.number, warehouse.name, person.fio
FROM warehouse, person
WHERE warehouse.owner_id = person.id;