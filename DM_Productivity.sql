
-- when were the dm employees last logged on the phone
-- Michael Scott wants to ensure that people are productive on the phone to maximize paper sales
SELECT

e.ENTERPRISENAME AS "Agent Team",
a.EXTENSION,
a.LOGOUTDATETIME - (a.LOGINDURATION/86400) AS "Logon DateTime",
a.LOGINDURATION AS "Login Duration",
a.LOGOUTDATETIME AS "Logout DateTime",
a.REASONCODE AS "Reason Code",
a.SKILLTARGETID,
r."Full Name",
r."Location",
r."Dept",
r."Sub Dept",
r."Supervisor",
r."Term"

FROM
CCEP.AGENT_LOGOUT a

INNER JOIN (
SELECT aa.SKILLTARGETID, MAX(aa.LOGOUTDATETIME) AS MAXDATE
FROM CCEP.AGENT_LOGOUT aa
GROUP BY aa.SKILLTARGETID) a2
ON a.SKILLTARGETID = a2.SKILLTARGETID AND a.LOGOUTDATETIME = a2.MAXDATE
JOIN CCEP.AGENT b ON a.SKILLTARGETID = b.SKILLTARGETID
JOIN CCEP.PERSON c ON b.PERSONID = c.PERSONID
JOIN CCEP.AGENT_TEAM_MEMBER d ON a.SKILLTARGETID = d.SKILLTARGETID
JOIN CCEP.AGENT_TEAM e ON d.AGENTTEAMID = e.AGENTTEAMID
JOIN OPS_REPORTING.CC_ROSTER r ON upper(b.ENTERPRISENAME) = UPPER(r."Full Name")


WHERE
a.DBDATETIME >= add_months(trunc(sysdate, 'MM'), -1)
AND r."Term" = 'No' -- still working at Dunder Mifflin
ORDER BY a.logoutdatetime DESC