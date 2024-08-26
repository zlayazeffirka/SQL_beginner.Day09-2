-- Удаление старых триггеров
DROP TRIGGER IF EXISTS trg_person_insert_audit ON person;
DROP TRIGGER IF EXISTS trg_person_update_audit ON person;
DROP TRIGGER IF EXISTS trg_person_delete_audit ON person;

-- Удаление старых триггерных функций
DROP FUNCTION IF EXISTS fnc_trg_person_insert_audit;
DROP FUNCTION IF EXISTS fnc_trg_person_update_audit;
DROP FUNCTION IF EXISTS fnc_trg_person_delete_audit;

-- Создание новой триггерной функции fnc_trg_person_audit
CREATE OR REPLACE FUNCTION fnc_trg_person_audit()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address)
        VALUES (CURRENT_TIMESTAMP, 'I', NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address)
        VALUES (CURRENT_TIMESTAMP, 'U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address)
        VALUES (CURRENT_TIMESTAMP, 'D', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Создание нового триггера trg_person_audit
CREATE TRIGGER trg_person_audit
AFTER INSERT OR UPDATE OR DELETE ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_audit();

-- Очистка таблицы person_audit
TRUNCATE TABLE person_audit;

-- Тестирование нового триггера

-- Вставка
INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk');

-- Обновления
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;

-- Удаление
DELETE FROM person WHERE id = 10;

-- Проверка содержимого таблицы person_audit
-- SELECT * FROM person_audit;
