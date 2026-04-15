CREATE DATABASE machine_project;
USE machine_project;
SELECT * FROM machine_data LIMIT 10;
CREATE VIEW machine_risk_2025 AS
WITH ranked_data AS (
    SELECT
        MachineID,
        Vibration,
        Temperature,
        DefectCount,

        PERCENT_RANK() OVER (ORDER BY Vibration) AS vib_rank,
        PERCENT_RANK() OVER (ORDER BY Temperature) AS temp_rank,
        PERCENT_RANK() OVER (ORDER BY DefectCount) AS defect_rank

    FROM machine_data
)

SELECT
    MachineID,

    CASE
        WHEN vib_rank >= 0.90 
          OR temp_rank >= 0.90 
          OR defect_rank >= 0.90
        THEN 'High'

        WHEN vib_rank >= 0.75 
          OR temp_rank >= 0.75 
          OR defect_rank >= 0.75
        THEN 'Medium'

        ELSE 'Low'
    END AS RiskLevel

FROM ranked_data;
SELECT * FROM machine_risk_2025 LIMIT 20;