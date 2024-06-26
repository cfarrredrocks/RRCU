--==================================================================================================
--Author: Farr, C
--Create Date:	2024-04-02  	
--Object Name:	sp_LOAD_T_PRODUCT_GROUP_DIM
--Description:  Loading PRODUCT GROUP Data
--***********************************************************************************************************************
--Date			Trello#					ChangedBy						Description 
------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE RRCU_DW_DEV.DM.sp_LOAD_T_PRODUCT_GROUP_DIM()
RETURNS VARCHAR NOT NULL
LANGUAGE SQL

AS
$$

BEGIN 


TRUNCATE TABLE RRCU_DW_DEV.DM.T_PRODUCT_GROUP_DIM_CF;

INSERT INTO RRCU_DW_DEV.DM.T_PRODUCT_GROUP_DIM_CF
(
GRP,
SERIAL, 
BEGIN_DT, 
END_DT, 
CLOSED_DT, 
LAST_FM_DT, 
NM, 
TYPE_CD, 
CAT_NM, 
TYPE_DSC, 
STATUS_CD, 
DORMANCY_DAYS_NUM, 
MIN_DEPOSIT_AMT
)

SELECT
'SH' AS GRP, 
ST.SHTYP_SERIAL,   --REPLACE WITH ETL SEQ # / SURROGATE KEY, JOIN AS FOREIGN KEY PG_REC_KEY TO PRODUCT_FACT
ST.SHTYP_LAST_FM_DATE AS BEGIN_DT,
CASE 
       WHEN ST.SHTYP_STATUS = 'C' THEN ST.SHTYP_LAST_FM_DATE
       WHEN ST.SHTYP_LAST_FM_DATE IS NULL THEN '2022-03-01' --DEFAULT TO KS CONVERSION DATE
       ELSE NULL
END AS END_DT,  
CASE 
       WHEN ST.SHTYP_STATUS = 'C' THEN ST.SHTYP_LAST_FM_DATE
       WHEN ST.SHTYP_LAST_FM_DATE IS NULL THEN '2022-03-01' --DEFAULT TO KS CONVERSION DATE
       ELSE NULL
END AS CLOSED_DT, 
ST.SHTYP_LAST_FM_DATE,
CASE
       WHEN ST.SHTYP_CODE IN ('CHK','BCHK','BC','CC','PC') THEN 'Checking Accounts'
       WHEN ST.SHTYP_CODE IN ('ASAV','BSAV','BHYS','LTSV','EMRG','EMS') THEN 'Savings Accounts'
       WHEN ST.SHTYP_CODE LIKE '%CD%' THEN 'Certificates of Deposit' 
       WHEN ST.SHTYP_CODE LIKE '%RR%' THEN 'Red Rocks Corporate Accounts'
       WHEN ST.SHTYP_CODE LIKE '%WO%' THEN 'Written-Off'
       WHEN ST.SHTYP_STATUS = 'C' THEN 'Legacy'
       ELSE 'Undefined' 
END NM,
ST.SHTYP_CATEGORY AS CATEGORY_NM,
ST.SHTYP_CODE AS TYPE_CD,
ST.SHTYP_DESCRIPTION AS TYPE_DSC,
ST.SHTYP_STATUS AS STATUS_CD,
ST.SHTYP_DORMANCY_RESTRICTION_DAYS AS DORMANCY_DAYS_NUM,
ST.SHTYP_MINIMUM_BALANCE AS MIN_BAL_AMT

FROM RRCU_DW_DEV.DW.T_KS_SH_TYPE_DW_CF ST
WHERE SHTYP_CURR_IND = 1

UNION ALL 

SELECT
'LN' AS GRP, 
LT.LNTYP_SERIAL,  --REPLACE WITH ETL SEQ # / SURROGATE KEY, JOIN AS FOREIGN KEY PG_REC_KEY TO PRODUCT_FACT
LT.LNTYP_LAST_FM_DATE AS BEGIN_DT,
CASE 
       WHEN LT.LNTYP_STATUS = 'C' THEN LT.LNTYP_LAST_FM_DATE
       WHEN LT.LNTYP_LAST_FM_DATE IS NULL THEN '2022-03-01' --DEFAULT TO KS CONVERSION DATE
       ELSE NULL
END AS END_DT,
CASE 
       WHEN LT.LNTYP_STATUS = 'C' THEN LT.LNTYP_LAST_FM_DATE
       WHEN LT.LNTYP_LAST_FM_DATE IS NULL THEN '2022-03-01' --DEFAULT TO KS CONVERSION DATE
       ELSE NULL
END AS CLOSED_DT,
LT.LNTYP_LAST_FM_DATE,
CASE
       WHEN LT.LNTYP_CODE IN ('MORT','10YM') THEN '1st Mortgages'
       WHEN LT.LNTYP_CODE IN ('30D7','FRBL','FRH','FROE','IOD89.9','IOS','IOD','ZHEL','SOE','OEH','DOE','OED','HELCFLR','HLO','OES','OEP','OEHE') THEN '2nd Mortgages'
       WHEN LT.LNTYP_CODE IN ('REFI','FABN','FAB','GAR','INA','IUA','LPRF','LPIN','LPIU','LPNA','LPRG','LPUA','NA','INRG','UA') THEN 'Auto Loans'
       WHEN LT.LNTYP_CODE IN ('BTP','BTR','CSEC','INM','IUM','MCP','MCR','REC','RECP','RECR','SSEC','SLOC')  THEN 'Other Secured Loans'
       WHEN LT.LNTYP_CODE IN ('CCRW','CCSG','ZCR2') THEN 'Credit Cards'
       WHEN LT.LNTYP_CODE IN ('DEL','MCEL','SIG') THEN 'Personal Loans'
       WHEN LT.LNTYP_CODE IN ('BOD','ZBOD','IALC','IA','IAL','ZOD','OD','ZUOD') THEN 'Other Unsecured Loans'
       WHEN LT.LNTYP_CODE LIKE '%RR%' THEN 'Red Rocks Corporate Accounts'
       WHEN LT.LNTYP_CODE LIKE '%WO%' THEN 'Written-Off'
       WHEN LT.LNTYP_STATUS = 'C' THEN 'Legacy'
       ELSE 'Undefined' 
END NM,
LT.LNTYP_CATEGORY AS PG_CATEGORY_NM,
LT.LNTYP_CODE AS PG_TYPE_CD,                                      --FOR TESTING, CAN JOIN TO PRODUCT_FACT.PG_TYPE_CD AT SAME LEVEL OF AGGREGATION
LT.LNTYP_DESCRIPTION AS PG_TYPE_DSC,
LT.LNTYP_STATUS AS PG_STATUS_CD,
LT.LNTYP_DORMANCY_RESTRICTION_DAYS AS PG_DORMANCY_DAYS_NUM,
LT.LNTYP_MINIMUM_BALANCE AS PG_MIN_BAL_AMT

FROM RRCU_DW_DEV.DW.T_KS_LN_TYPE_DW_CF LT
WHERE LNTYP_CURR_IND = 1
 
UNION ALL

SELECT
'RN' AS GRP, 
RT.RNTYP_SERIAL,
RT.RNTYP_LAST_FM_DATE AS BEGIN_DT,
CASE 
       WHEN RT.RNTYP_STATUS = 'C' THEN RT.RNTYP_LAST_FM_DATE
       WHEN RT.RNTYP_LAST_FM_DATE IS NULL THEN '2022-03-01' --DEFAULT TO KS CONVERSION DATE
       ELSE NULL
END AS END_DT,
CASE 
       WHEN RT.RNTYP_STATUS = 'C' THEN RT.RNTYP_LAST_FM_DATE
       WHEN RT.RNTYP_LAST_FM_DATE IS NULL THEN '2022-03-01' --DEFAULT TO KS CONVERSION DATE
       ELSE NULL
END AS CLOSED_DT,
RT.RNTYP_LAST_FM_DATE,
CASE
       WHEN RT.RNTYP_CODE IN ('3X5','3X10','5X10','10X10') THEN 'Safe Deposit Box'
       WHEN RT.RNTYP_STATUS = 'C' THEN 'Legacy'
       ELSE 'Undefined' 
END NM,
RT.RNTYP_CATEGORY AS CATEGORY_NM,
RT.RNTYP_CODE AS TYPE_CD,
RT.RNTYP_DESCRIPTION AS TYPE_DSC,
RT.RNTYP_STATUS AS STATUS_CD,
0 AS DORMANCY_DAYS_NUM,
0 AS MIN_BAL_AMT

FROM RRCU_DW_DEV.DW.T_KS_RENTAL_TYPE_DW_CF RT
WHERE RNTYP_CURR_IND = 1;

END;
$$
;

