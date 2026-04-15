USE machine_project;
WITH machine_defects AS (
    SELECT 
        Plant,
        MachineID,
        SUM(DefectCount) AS Total_Defects
    FROM machine_data
    GROUP BY Plant, MachineID
),

ranked_machines AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY Plant ORDER BY Total_Defects DESC) AS rank_num
    FROM machine_defects
)

SELECT 
    Plant,
    MachineID,
    Total_Defects
FROM ranked_machines
WHERE rank_num <= 5;