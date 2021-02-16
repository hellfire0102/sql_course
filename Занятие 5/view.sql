CREATE VIEW product_beauty AS
	SELECT p.name AS "Наименование", p.origin_country AS "Страна происхождения",
	s.company_name AS "Поставщик", pc.name AS "Категория", rf.name AS "Форма выпуска",
	p.price AS "Цена"
	FROM product p, supplier s, product_category pc, release_form rf
	WHERE (p.supplier_id = s.id) AND (p.product_category_id = pc.id)
		AND (p.release_form_id = rf.id);
