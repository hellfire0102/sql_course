SELECT prod_type, AVG(weight)
FROM product
GROUP BY prod_type
HAVING AVG(weight) > 8;
