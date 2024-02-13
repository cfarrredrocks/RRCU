

CREATE or replace TABLE RRCU_STG_DEV.KEYSTONE_CORE.T_KS_PERSON_STG_CF (
	PSN_REC_KEY BIGINT, -- REPRESENT POINTER BACK TO PERSON DIM
	SOURCEHASH1 VARBINARY(32),  -- TYPE1 SOURCEHASHING
	SOURCEHASH2 VARBINARY(32),	-- TYPE2 SOURCEHASHING
	ISTYPE1	INT,  -- REPRESENTS TYPE 1
	ISTYPE2 INT,  -- REPRESENTS TYPE 2
	ISNEW INT, -- INDICATION FOR NEW RECORD TYPE 2
	SERIAL NUMBER(19,0),  -- NATURAL KEY
	HOUSEHOLD_PERSON_SERIAL NUMBER(19,0),	
	NAICS_SERIAL NUMBER(19,0),
	RELATIONSHIP_SERIAL NUMBER(19,0),
	TAX_PERSON_SERIAL NUMBER(19,0),
	TAX_STATE_SERIAL NUMBER(19,0),
	TYPE_SERIAL NUMBER(19,0),
	ACCESS_RESTRICTION VARCHAR(1),
	BACKUP_WITHHOLD VARCHAR(1),
	BIRTH_DATE DATE,
	CATEGORY VARCHAR(1),
	CHECK_HOLD_LEVEL_SERIAL NUMBER(19,0),
	CTR_EXEMPTION VARCHAR(1),
	CTR_EXEMPTION_REVIEW_DATE DATE,
	DEATH_DATE DATE,
	DEMOGRAPHICS_FURNISHED VARCHAR(1),
	TITLE VARCHAR(10),
	FIRST_NAME VARCHAR(20),
	MIDDLE_NAME VARCHAR(20),
	LAST_NAME VARCHAR(80),
	NICKNAME VARCHAR(20),
	SUFFIX VARCHAR(10),
	GENDER VARCHAR(1),
	HOUSEHOLD_CATEGORY VARCHAR(1),
	HOUSEHOLD_REASSIGNMENT VARCHAR(1),
	IRS_FORM_W8_EXPIRATION_DATE DATE,
	IRS_FORM_W9_RECEIVED_DATE DATE,
	MARKETING_OPTION VARCHAR(2),
	NOTE_RESTRICTION VARCHAR(1),
	OFAC_LAST_CHECK_DATE DATE,
	OFAC_RESTRICTION VARCHAR(1),
	OWNERSHIP_CHANGE_DATE DATE,
	RELATIONSHIP_OVR_EFF_DATE DATE,
	RELATIONSHIP_OVR_EXP_DATE DATE,
	RELATIONSHIP_OVR_SERIAL NUMBER(19,0),
	--ROW_CHANGE_TIMESTAMP TIMESTAMP_NTZ(9),
	TAX_COUNTRY_CODE VARCHAR(2),
	TAX_REPORTING VARCHAR(1),
	LAST_FM_DATE DATE,
	PRIMARY KEY (SERIAL)
);