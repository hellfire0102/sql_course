SELECT * FROM transport
WHERE car_reg_num IN(
	SELECT register_number
	FROM car
	WHERE full_capacity > 12000;
)
