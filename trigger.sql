CREATE OR REPLACE TRIGGER check_coordinate_trigger
BEFORE INSERT ON location
FOR EACH ROW
EXECUTE PROCEDURE check_coordinate();



CREATE OR REPLACE FUNCTION check_coordinate()
RETURNS TRIGGER AS $$
BEGIN 
    IF EXISTS (
        SELECT 1
        FROM location
        WHERE id_location = (
            SELECT MAX(id_location)
            FROM location
            WHERE id_tehnic = NEW.id_tehnic
            AND EXTRACT(YEAR FROM location_time::TIMESTAMP) = EXTRACT(YEAR FROM NEW.location_time::TIMESTAMP)
            AND EXTRACT(MONTH FROM location_time::TIMESTAMP) = EXTRACT(MONTH FROM NEW.location_time::TIMESTAMP)
            AND EXTRACT(DAY FROM location_time::TIMESTAMP) = EXTRACT(DAY FROM NEW.location_time::TIMESTAMP)
            AND location.coordinates::text = NEW.coordinates::text
        )
    ) THEN 
        NEW.interval = NEW.location_time - (
            SELECT MAX(location_time)
            FROM location
            WHERE coordinates::text = NEW.coordinates::text
            AND id_location = (
                SELECT MAX(id_location)
                FROM location
                WHERE id_tehnic = NEW.id_tehnic
            ) 
        );

        NEW.repetition = 1 + (
            SELECT MAX(repetition)
            FROM location
            WHERE coordinates::text = NEW.coordinates::text
            AND id_tehnic = NEW.id_tehnic
        );
    ELSE NEW.repetition = 0;
    END IF;
    RETURN NEW;
END;
$$

LANGUAGE plpgsql;











