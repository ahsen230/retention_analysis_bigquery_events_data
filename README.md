# Retention Analysis Query

This repository contains a SQL query used for daily retention analysis.

## Usage

1. Copy the SQL query from (https://github.com/ahsen230/retention_analysis_bigquery_events_data/blob/main/Retention_daily.sql) and execute it in your SQL environment.
2. Ensure that you replace placeholder names such as `your_database.generic_retention_table` and `your_database.generic_events_table` with your actual table names.

## Query Explanation

### Table Structure

- `Registration_Date`: Date when users signed up.
- `Active_Users`: Number of active users.
- `Days_Since_Registration`: Number of days since user registration.
- `Application_Version`: Version of the application.
- `Source_Installation`: Source of installation (Google, Facebook, etc.).

### Subquery Details

- The subquery retrieves relevant data for retention analysis, including sign-up date, event date, days since registration, user count, application version, and installation source.


## Notes

- Ensure that your database environment has the necessary tables (`generic_retention_table` and `generic_events_table`) before executing the query.
- Adjust the query as needed based on your specific database schema and requirements.
