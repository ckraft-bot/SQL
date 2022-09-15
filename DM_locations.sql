-- Calls by each location of the DM branch

SELECT 
CTI.*,
cd.ENTERPRISE_NAME,
cd.LOCATIONS
FROM DUNDER_MIFFLIN.CALL_TYPE_INTERVAL_V CTI
LEFT JOIN DUNDER_MIFFLIN.CALLTYPE2_DIM cd ON CTI.CALLTYPEID = cd.MODIFIED_CTID
WHERE cd.LOCATIONS = 'Akron'
OR cd.LOCATIONS = 'Nashua' 
OR cd.LOCATIONS = 'Rochester' 
OR cd.LOCATIONS = 'Scranton'
OR cd.LOCATIONS = 'Syracuse'
OR cd.LOCATIONS = 'Utica'
AND CTI.DATETIME >= add_months(trunc(sysdate, 'MM'), -3)