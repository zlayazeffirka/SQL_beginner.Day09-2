-- Создание триггерной функции fnc_trg_person_delete_audit
CREATE OR REPLACE FUNCTION fnc_trg_person_delete_audit()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address)
    VALUES (CURRENT_TIMESTAMP, 'D', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Создание триггера trg_person_delete_audit
CREATE TRIGGER trg_person_delete_audit
AFTER DELETE ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_delete_audit();

-- Тестирование триггера
DELETE FROM person WHERE id = 10;

-- Проверка
-- SELECT * FROM person_audit;

