--==================================================================================================
--Author: Farr, C
--Create Date:	2024-03-25  	
--Object Name:	sp_LOAD_T_KS_PERSON_CONTACT_STG
--Description:  Loading Account Eligibility Data
--***********************************************************************************************************************
--Date			Trello#					ChangedBy						Description 
------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE RRCU_STG_DEV.KEYSTONE_CORE.sp_LOAD_T_KS_PERSON_CONTACT_STG ()
RETURNS VARCHAR NOT NULL
LANGUAGE SQL

AS
$$

BEGIN 
	
	TRUNCATE TABLE RRCU_STG_DEV.KEYSTONE_CORE.T_KS_PERSON_CONTACT_STG_CF;
	
	-- REMOVE PK	
	ALTER TABLE RRCU_STG_DEV.KEYSTONE_CORE.T_KS_PERSON_CONTACT_STG_CF DROP PRIMARY KEY;	


	-- Populate STAGING WITH CTE DATA
	INSERT INTO RRCU_STG_DEV.KEYSTONE_CORE.T_KS_PERSON_CONTACT_STG_CF
	(
	SERIAL,
	SOURCEHASH2,
	PARENT_SERIAL, 
	ORDINAL, 
	LAST_FM_DATE, 
	CATEGORY, 
	DESCRIPTION, 
	VALUE, 
	MARKETING_OPTION, 
	CARD_FRAUD_ALERT_OPTION, 
	ALERT_OPTION, 
	BAD_CONTACT, 
	EXPIRATION_DATE, 
	LAST_VERIFICATION_DATE	
	)
	
	WITH CTE AS

	(	
	SELECT 
	SERIAL,
	MD5(TO_VARCHAR(ARRAY_CONSTRUCT(*))) AS SourceHash2,  -- SOURCE HASH		
	PARENT_SERIAL, 
	ORDINAL, 
	LAST_FM_DATE, 
	CATEGORY, 
	DESCRIPTION, 
	VALUE, 
	MARKETING_OPTION, 
	CARD_FRAUD_ALERT_OPTION, 
	ALERT_OPTION, 
	BAD_CONTACT, 
	EXPIRATION_DATE, 
	LAST_VERIFICATION_DATE,
	ROW_NUMBER() OVER (PARTITION BY SERIAL ORDER BY SERIAL) AS rn -- helps identify mutliple serial number dupes		
	FROM RRCU_STG_DEV.KEYSTONE_CORE.T_KS_PERSON_CONTACT_STG
	)

    SELECT SERIAL, SOURCEHASH2, PARENT_SERIAL, ORDINAL, LAST_FM_DATE, CATEGORY, DESCRIPTION, VALUE, MARKETING_OPTION, CARD_FRAUD_ALERT_OPTION,
    ALERT_OPTION, BAD_CONTACT, EXPIRATION_DATE, LAST_VERIFICATION_DATE
	FROM CTE
	WHERE rn = 1;

	-- DUPE CHECK / DELETE 
	DELETE FROM RRCU_STG_DEV.KEYSTONE_CORE.T_KS_PERSON_CONTACT_STG_CF USING (
    	WITH CTE_DUP AS
    	(
    	SELECT SERIAL,
	 	ROW_NUMBER () OVER ( PARTITION BY SERIAL ORDER BY SERIAL) AS RN
	 	FROM RRCU_STG_DEV.KEYSTONE_CORE.T_KS_PERSON_CONTACT_STG_CF
    	)
        SELECT SERIAL, RN FROM CTE_DUP
        ) AS CTE_RESULT
	WHERE CTE_RESULT.RN > 1;

	-- ADD PRIMARY KEY BACK

	ALTER TABLE RRCU_STG_DEV.KEYSTONE_CORE.T_KS_PERSON_CONTACT_STG_CF ADD PRIMARY KEY (SERIAL);

	-- Expiration for records not coming back into resultset
	UPDATE RRCU_DW_DEV.DW.T_KS_PERSON_CONTACT_DW_CF
	SET PSNCONT_CURR_IND = 0
	, PSNCONT_EXP_DT = CURRENT_DATE
	WHERE PSNCONT_CURR_IND = 1
	AND PSNCONT_SERIAL NOT IN (SELECT SERIAL FROM RRCU_STG_DEV.KEYSTONE_CORE.T_KS_PERSON_CONTACT_STG_CF);
	

	DROP TABLE IF EXISTS RRCU_STG_DEV.KEYSTONE_CORE.Update_STG;

	CREATE TEMPORARY TABLE RRCU_STG_DEV.KEYSTONE_CORE.Update_STG(
	PSNCONT_REC_KEY BIGINT,
	STG_SOURCEHASH2 VARCHAR(32),
	NEW_SOURCEHASH2 VARCHAR(32),
	IS_TYPE2 INT,  -- REPRESENTS TYPE 2
	IS_NEW INT -- INDICATION FOR NEW RECORD TYPE 2
	);

	--DROP TABLE RRCU_STG_DEV.KEYSTONE_CORE.Update_STG;
	
	INSERT INTO RRCU_STG_DEV.KEYSTONE_CORE.Update_STG (
	PSNCONT_REC_KEY,
	STG_SOURCEHASH2,
	NEW_SOURCEHASH2,
	IS_NEW,
	IS_TYPE2	
	)
	
	WITH CTE_COMPARE AS
	(
	SELECT dim.PSNCONT_REC_KEY ,  dim.PSNCONT_SOURCEHASH2, stg.sourcehash2,
	CASE WHEN dim.PSNCONT_REC_KEY IS NULL THEN 1 ELSE 0 END CASE,
	CASE WHEN dim.PSNCONT_REC_KEY IS NOT NULL AND stg.SOURCEHASH2 <> dim.PSNCONT_SOURCEHASH2 THEN 1 ELSE 0 END CASE
	FROM RRCU_STG_DEV.KEYSTONE_CORE.T_KS_PERSON_CONTACT_STG_CF stg
	LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_PERSON_CONTACT_DW_CF dim ON dim.PSNCONT_SERIAL = stg.SERIAL AND dim.PSNCONT_CURR_IND  = 1
	)
	SELECT *
	FROM CTE_COMPARE;

	--SELECT * FROM RRCU_STG_DEV.KEYSTONE_CORE.Update_STG;
	--SELECT * FROM RRCU_STG_DEV.KEYSTONE_CORE..T_KS_PERSON_CONTACT_STG_CF;

	UPDATE RRCU_STG_DEV.KEYSTONE_CORE.T_KS_PERSON_CONTACT_STG_CF a
	SET PSNCONT_REC_KEY = b.PSNCONT_REC_KEY,
	ISNEW = b.IS_NEW,
	ISTYPE2 = b.IS_TYPE2
	FROM (SELECT PSNCONT_REC_KEY, IS_NEW, IS_TYPE2, NEW_SOURCEHASH2 FROM RRCU_STG_DEV.KEYSTONE_CORE.Update_STG) b
	WHERE a.SOURCEHASH2 = b.NEW_SOURCEHASH2 AND a.PSNCONT_REC_KEY IS NULL;

   -- Expiration for records type 2
	
    UPDATE RRCU_DW_DEV.DW.T_KS_PERSON_CONTACT_DW_CF
	SET PSNCONT_CURR_IND = 0
	, PSNCONT_EXP_DT = CURRENT_DATE
	WHERE PSNCONT_CURR_IND = 1
	AND PSNCONT_SERIAL IN (SELECT SERIAL FROM RRCU_STG_DEV.KEYSTONE_CORE.T_KS_PERSON_CONTACT_STG_CF WHERE ISTYPE2 = 1); 

	INSERT INTO RRCU_DW_DEV.DW.T_KS_PERSON_CONTACT_DW_CF
	(
	PSNCONT_SERIAL,
	PSNCONT_CURR_IND,
	PSNCONT_EFF_DT,
	PSNCONT_EXP_DT, 
	--PSNCONT_MOD_DT, 
	PSNCONT_SOURCEHASH2, 
	PSNCONT_PARENT_SERIAL, 
	PSNCONT_ORDINAL, 
	PSNCONT_LAST_FM_DATE,
	PSNCONT_CATEGORY, 
	PSNCONT_DESCRIPTION, 
	PSNCONT_VALUE, 
	PSNCONT_MARKETING_OPTION, 
	PSNCONT_CARD_FRAUD_ALERT_OPTION, 
	PSNCONT_ALERT_OPTION, 
	PSNCONT_BAD_CONTACT, 
	PSNCONT_EXPIRATION_DATE, 
	PSNCONT_LAST_VERIFICATION_DATE,
	DW_LOAD_DT
	)
	
	SELECT 
	stg.SERIAL,
	1,
	CURRENT_DATE,
	NULL,
	stg.SOURCEHASH2,
	stg.PARENT_SERIAL, 
	stg.ORDINAL, 
	stg.LAST_FM_DATE, 
	stg.CATEGORY, 
	stg.DESCRIPTION, 
	stg.VALUE, 
	stg.MARKETING_OPTION, 
	stg.CARD_FRAUD_ALERT_OPTION, 
	stg.ALERT_OPTION, 
	stg.BAD_CONTACT, 
	stg.EXPIRATION_DATE, 
	stg.LAST_VERIFICATION_DATE,
	CURRENT_DATE
	FROM RRCU_STG_DEV.KEYSTONE_CORE.T_KS_PERSON_CONTACT_STG_CF stg
		WHERE ISNEW = 1 OR ISTYPE2 = 1;

END;
$$
;
