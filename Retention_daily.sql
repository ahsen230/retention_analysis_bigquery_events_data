-- Inserting data into the generic retention table
INSERT INTO `your_database.retention_table`(Registration_Date, Active_Users, Days_Since_Registration, Application_Version, Source_Installation)


SELECT registration_date, SUM(users) as active_users, days_since_registration, application_version , 
    source
FROM
(
    -- Subquery to gather relevant data for retention analysis
    SELECT
        DATE(TIMESTAMP_MILLIS(SAFE_CAST(userprop.value.string_value AS INT64)), 'America/Los_Angeles') AS registration_date,
        DATE(TIMESTAMP_MICROS(event_timestamp), 'America/Los_Angeles') AS event_date,
        DATE_DIFF(DATE(TIMESTAMP_MICROS(event_timestamp), 'America/Los_Angeles'), DATE(TIMESTAMP_MILLIS(SAFE_CAST(userprop.value.string_value AS INT64)), 'America/Los_Angeles'), DAY) AS             days_since_registration,
        COUNT(DISTINCT user_id) AS users,
        app_info.version AS application_version 
        traffic_source.medium AS source
    FROM `your_database.events_table`, UNNEST(user_properties) as userprop
    WHERE  userprop.key = "SignUp_Success_Time" AND event_name IN ("yourevents") AND
        DATE(TIMESTAMP_MILLIS(SAFE_CAST(userprop.value.string_value AS INT64)), 'America/Los_Angeles') = DATE_SUB(CURRENT_DATE(), INTERVAL 8 DAY) 
        AND _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE(), INTERVAL 8 DAY)) AND FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))
    GROUP BY
        1,2,3,4,5
) WHERE app_version IS NOT NULL

-- Grouping and filtering the data
GROUP BY registration_date, days_since_registration, application_version source

HAVING days_since_registration BETWEEN 0 AND 7 --for 7 day retention only

-- Sorting the results
ORDER BY registration_date ASC;
