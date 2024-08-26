-- Создание таблицы person_audit
CREATE TABLE person_audit (
    created TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    type_event CHAR(1) DEFAULT 'I' NOT NULL,
    row_id BIGINT NOT NULL,
    name VARCHAR,
    age INTEGER,
    gender VARCHAR,
    address VARCHAR,
    CONSTRAINT ch_type_event CHECK (type_event IN ('I', 'U', 'D'))
);

-- Создание триггерной функции fnc_trg_person_insert_audit
CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO person_audit (created, type_event, row_id, name, age, gender, address)
    VALUES (CURRENT_TIMESTAMP, 'I', NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Создание триггера trg_person_insert_audit
CREATE TRIGGER trg_person_insert_audit
AFTER INSERT ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_insert_audit();

-- Тестирование триггера
INSERT INTO person(id, name, age, gender, address) VALUES (10, 'Damir', 22, 'male', 'Irkutsk');

-- Проверка
-- SELECT * FROM person_audit;
