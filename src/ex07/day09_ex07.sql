-- Создание функции func_minimum
CREATE OR REPLACE FUNCTION func_minimum(arr float8[])
RETURNS float8 AS $$
DECLARE
    min_val float8;
BEGIN
    -- Инициализация минимального значения первым элементом массива
    min_val := arr[1];
    
    -- Перебор всех элементов массива
    FOR i IN 1..array_length(arr, 1) LOOP
        IF arr[i] < min_val THEN
            min_val := arr[i];
        END IF;
    END LOOP;
    
    RETURN min_val;
END;
$$ LANGUAGE plpgsql;

-- Тестирование функции с массивом [10.0, -1.0, 5.0, 4.4]
SELECT func_minimum(VARIADIC arr := ARRAY[10.0, -1.0, 5.0, 4.4]);
