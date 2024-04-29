
--==================================================================================================
--Author: Farr, C
--Create Date:	2024-03-12  	
--Object Name:	sp_LOAD_T_ACCOUNT_DIM_STG
--Description:  Loading Person Data
--***********************************************************************************************************************
--Date			Trello#					ChangedBy						Description 
------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE RRCU_DW_DEV.DM.sp_LOAD_T_ACCOUNT_DIM ()
RETURNS VARCHAR NOT NULL
LANGUAGE SQL

AS
$$

BEGIN 
	
TRUNCATE TABLE RRCU_DW_DEV.DM.T_ACCOUNT_DIM_CF;

DROP TABLE IF EXISTS RRCU_STG_DEV.KEYSTONE_CORE.NoteUpdate_STG;

CREATE TEMPORARY TABLE RRCU_STG_DEV.KEYSTONE_CORE.NoteUpdate_STG(
MAXPSERIAL BIGINT,
MAXORD BIGINT,
MAXEXPL VARCHAR(2000),
MAXEXPDATE DATE
);

INSERT INTO RRCU_STG_DEV.KEYSTONE_CORE.NoteUpdate_STG(
MAXPSERIAL,
MAXORD,
MAXEXPL,
MAXEXPDATE
)

WITH CTE AS
(
	
SELECT AN.ACNOTE_PARENT_SERIAL AS MAXPSERIAL, --ACNOTE_PARENT_SERIAL
	MAX(AN.ACNOTE_ORDINAL) AS MAXORD ,
	UPPER(AN.ACNOTE_EXPLANATION) AS MAXEXPL,
	ROW_NUMBER() OVER (PARTITION BY ACNOTE_PARENT_SERIAL  ORDER BY ACNOTE_ORDINAL DESC) AS rn,
	AN.ACNOTE_EXPIRATION_DATE AS MAXEXPDATE 
	FROM RRCU_DW_DEV.DW.T_KS_AC_NOTE_DW_CF AN
	WHERE AN.ACNOTE_CURR_IND = 1
	--WHERE ACNOTE_PARENT_SERIAL = 18 
	GROUP BY ACNOTE_PARENT_SERIAL, ACNOTE_EXPLANATION, ACNOTE_ORDINAL, ACNOTE_EXPLANATION, ACNOTE_EXPIRATION_DATE	
	
)

SELECT MAXPSERIAL, MAXORD, MAXEXPL, MAXEXPDATE
FROM CTE WHERE RN = 1;
	
INSERT INTO RRCU_DW_DEV.DM.T_ACCOUNT_DIM_CF
(SERIAL,
BEGIN_DT, 
END_DT, 
ACCOUNT_NUMBER,
ACCOUNT_TRIM_NUMBER,
OPEN_DT, 
CLOSE_DT, 
LAST_FM_DT, 
CLOSE_REASON, 
CLOSE_REASON_DESC, 
CLOSE_STATUS, 
CLOSE_REASON_LAST_FM_DT, 
ELIG_CODE, 
ELIG_DESC, 
ELIG_STATUS, 
ELIG_LAST_FM_DT, 
OPENED_BY, 
DELINQUENCY_RESTRICTION,
NOTE_DESC,
NOTE_EXPIRATION_DT
)
	
SELECT DISTINCT 
A.ACCT_SERIAL, --AS ACCT_REC_KEY,  		 
A.ACCT_OPEN_DATE AS ACCT_BEGIN_DT,
A.ACCT_CLOSE_DATE AS ACCT_END_DT, 		 
A.ACCT_ACCOUNT_NUMBER AS ACCT_NUM, 
LTRIM(A.ACCT_ACCOUNT_NUMBER,0) AS ACCT_TRIM_NUM, 
A.ACCT_OPEN_DATE AS ACCT_OPEN_DT, 
A.ACCT_CLOSE_DATE AS ACCT_CLOSE_DT, 	
A.ACCT_LAST_FM_DATE AS ACCT_LAST_FM_DT, 					 
UPPER(AC.CLRSN_CODE) AS ACCT_CLOSE_REASON_CD,
AC.CLRSN_STATUS AS ACCT_CLOSE_REASON_STATUS_CD, 
UPPER(AC.CLRSN_DESCRIPTION) AS ACCT_CLOSE_REASON_DSC, 
AC.CLRSN_LAST_FM_DATE AS ACCT_CLOSE_REASON_LAST_FM_DT,
AE.ELIG_CODE AS ACCT_ELIG_CD,
AE.ELIG_DESCRIPTION AS ACCT_ELIG_DSC, 
AE.ELIG_STATUS AS ACCT_ELIG_STATUS_CD,
AE.ELIG_LAST_FM_DATE AS ACCT_ELIG_LAST_FM_DT,
U.USER_USERNAME AS ACCT_OPENED_BY_NM, 
A.ACCT_DELINQUENCY_RESTRICTION AS ACCT_DQ_RESTRICT_CD, 
N.MAXEXPL ACCT_NOTE_DSC, 			 
N.MAXEXPDATE AS ACCT_NOTE_EXPIRATION_DT 	 
FROM RRCU_DW_DEV.DW.T_KS_ACCOUNT_DW_CF A 
LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_PERSON_DW_CF P ON A.ACCT_PRIMARY_PERSON_SERIAL = P.PSN_SERIAL AND P.PSN_CURR_IND = 1
LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_ACCOUNT_ELIGIBILITY_DW_CF AE ON AE.ELIG_SERIAL = A.ACCT_ELIGIBILITY_SERIAL AND AE.ELIG_CURR_IND = 1
LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_ACCOUNT_CLOSE_REASON_DW_CF AC ON AC.CLRSN_SERIAL = A.ACCT_CLOSE_REASON_SERIAL AND CLRSN_CURR_IND = 1
LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_USER_DW_CF U ON U.USER_SERIAL = A.ACCT_OPENED_BY_USER_SERIAL AND USER_CURR_IND = 1
LEFT OUTER JOIN RRCU_STG_DEV.KEYSTONE_CORE.NoteUpdate_STG N ON A.ACCT_SERIAL = N.MAXPSERIAL
WHERE A.ACCT_CURR_IND = 1;
	
END;
$$
;