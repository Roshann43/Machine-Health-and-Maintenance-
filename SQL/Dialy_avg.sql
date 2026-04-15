USE machine_project;
SELECT 
    Plant,
    DATE(Timestamp) AS Date,
    AVG(Temperature) AS Avg_Temperature,
    AVG(Vibration) AS Avg_Vibration,
    AVG(Pressure) AS Avg_Pressure
FROM machine_data
GROUP BY Plant, DATE(Timestamp)
ORDER BY Plant, Date;