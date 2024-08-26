-- Создание функции fnc_persons_female
CREATE OR REPLACE FUNCTION fnc_persons_female()
RETURNS TABLE (id bigint, name varchar, age integer, gender varchar, address varchar) AS $$
BEGIN
    RETURN QUERY
    SELECT person.id, person.name, person.age, person.gender, person.address
    FROM person
    WHERE person.gender = 'female';
END;
$$ LANGUAGE plpgsql;

-- Создание функции fnc_persons_male
CREATE OR REPLACE FUNCTION fnc_persons_male()
RETURNS TABLE (id bigint, name varchar, age integer, gender varchar, address varchar) AS $$
BEGIN
    RETURN QUERY
    SELECT person.id, person.name, person.age, person.gender, person.address
    FROM person
    WHERE person.gender = 'male';
END;
$$ LANGUAGE plpgsql;

-- Тестирование функции для получения лиц мужского пола
SELECT *
FROM fnc_persons_male();

-- Тестирование функции для получения лиц женского пола
SELECT *
FROM fnc_persons_female();
