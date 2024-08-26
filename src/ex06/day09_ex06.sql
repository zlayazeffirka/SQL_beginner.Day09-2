-- Создание функции fnc_person_visits_and_eats_on_date
CREATE FUNCTION fnc_person_visits_and_eats_on_date(
	pperson varchar default 'Dmitriy', 
	pprice numeric default 500, 
	pdate date default '2022-01-08'
) 
RETURNS TABLE(name varchar) AS $$ 
BEGIN 
	RETURN QUERY 
	select p.name as pizzeria_name 
	from menu 
	inner join pizzeria p on p.id = menu.pizzeria_id 
	inner join person_visits pv on menu.pizzeria_id = pv.pizzeria_id 
	inner join person p2 on p2.id = pv.person_id 
	where price < pprice and p2.name = pperson and visit_date = pdate; 
END; $$ LANGUAGE PLPGSQL;

-- Тестирование функции с параметром pprice = 800
SELECT *
FROM fnc_person_visits_and_eats_on_date(pprice := 800);

-- Тестирование функции с параметрами pperson = 'Anna', pprice = 1300, pdate = '2022-01-01'
SELECT *
FROM fnc_person_visits_and_eats_on_date(pperson := 'Anna', pprice := 1300, pdate := '2022-01-01');
