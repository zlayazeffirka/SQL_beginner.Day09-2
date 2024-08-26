-- Удаление старых функций
DROP FUNCTION IF EXISTS fnc_persons_female();
DROP FUNCTION IF EXISTS fnc_persons_male();

-- Создание общей функции fnc_persons
CREATE OR REPLACE FUNCTION fnc_persons(pgender varchar DEFAULT 'female')
RETURNS TABLE (id bigint, name varchar, age integer, gender varchar, address varchar) AS $$
    SELECT person.id, person.name, person.age, person.gender, person.address
    FROM person
    WHERE person.gender = pgender;
$$ LANGUAGE sql;

-- Тестирование функции для получения лиц мужского пола
SELECT *
FROM fnc_persons(pgender := 'male');

-- Тестирование функции для получения лиц женского пола (значение по умолчанию)
SELECT *
FROM fnc_persons();
