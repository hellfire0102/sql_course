SELECT * FROM transport
WHERE (transp_date BETWEEN '2013-01-01' AND '2016-12-31')
AND (car_reg_num IN('1270YT59', 'BY287089'));