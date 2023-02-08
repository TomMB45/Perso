-- Request for calendar

-- Returns the list of days (format yyyy-mm-dd) that are no longer available (all slots are already taken)   
SELECT 
    DATE(start_time) 
FROM 
    Service NATURAL JOIN Appointment 
WHERE 
    name_service = "Gynecologie" 
GROUP BY 
    DATE(start_time) 
    HAVING COUNT(id_service) = 
        (SELECT 
        daily_activity_time * nb_simultaneous_slots * 60 /slot_duration 
        FROM 
            Service 
        WHERE 
        name_service = "Gynécologie"
        );

-- Returns the list of slots (hh-mm-ss) that are no longer available for a given day and service  

SELECT 
    DATE_FORMAT(start_time, "%T") 
FROM 
    Service NATURAL JOIN Appointment 
WHERE 
    name_service = "Gynecologie" 
    AND DATE(start_time) = "2022-11-22" 
GROUP BY 
    DATE_Format(start_time, "%T") 
    HAVING COUNT(id_service) = 
        (SELECT 
            nb_simultaneous_slots 
        FROM 
            Service 
        WHERE 
        name_service = "Gynécologie"
        )


-- Returns the date of the last appointment made by a client in a given Service
SELECT 
    DATE_FORMAT(start_time, "%T") 
AS 
    'last_rdv' 
FROM
    Appointment JOIN Users 
    ON Users.email = Appointment.id_user 
WHERE 
    id_service = 
    (SELECT
        id_service 
    FROM 
        Service 
    WHERE 
        name_service = "Radiologie"
    ) 
AND 
    id_user = "jean-paul.commet@projetweb.fr" 
AND 
    start_time < CURRENT_DATE 
ORDER BY start_time 
DESC LIMIT 1;



-- Select all the 
SELECT 
    * 
FROM Appointment 
WHERE 
    id_service = 
    (SELECT 
        id_service 
    FROM 
        Service 
    WHERE 
        name_service = "Radiologie"
    )
AND 
    start_time > CURRENT_DATE;


-- Delete all the appointment older than one month

DELETE 
FROM 
    Appointment 
WHERE 
    start_time < DATE_SUB(CURRENT_DATE,INTERVAL 1 MONTH)
