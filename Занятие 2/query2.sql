SELECT register_number, model, (full_capacity - 25000) AS remaining_capacity FROM car
WHERE full_capacity > 25000;