/* PERSON_DIM - MEMBER EXPERIENCE DM */

/* AUTHOR: KATHRYN L SHUT */

/* LAST UPDATED DATE: 2/12/2024 - KLS - ADDED LOGIC FOR CURRENT INDICATOR, EXCLUDING NULL FIRST NAMES FOR OLD CHARGE-OFF ACCOUNTS */

/* APPROX. 75,567+ RECORDS */


SELECT

P.SERIAL AS PSN_REC_KEY,                                                 /* REPLACE SERIAL WITH ETL SEQ # TO CREATE SURROGATE KEYS AND ENFORCE TYPE II SDC */

P.LAST_FM_DATE AS PSN_BEGIN_DT,                                   /* LAST FM IN KEYSTONE SHOWS THE LAST TIME RECORD CHANGED */

NULL AS PSN_END_DT,                                                             /* REPLACE WITH DATE THAT RECORD CHANGED AND SET END DATE; IF RECORD HAS NOT CHANGED, LEAVE NULL */ 

(CASE

       WHEN P.FIRST_NAME IS NULL AND P.CATEGORY = 'I' THEN 'N'    /* LEGACY INDIVIDUAL ACCOUNTS THAT WERE PREVIOUSLY CHARGED-OFF AND MIGRATED SHOW WITH NO FIRST NAME */

       WHEN P.DEATH_DATE IS NOT NULL THEN '0'        /* DECEASED PERSONS - SHOULD NOT CARRY A CURRENT IND */

       ELSE '1'                                                                               /* ALL ELSE SHOULD BE CONSIDERED A CURRENT, LIVING INDIVIDUAL PERSON, TRUST, BENEFICIARY, OR BUSINESS/VENDOR ENTITY */

END) PSN_CURR_IND, 

P.SERIAL AS PSN_SERIAL_NUM,

P.ROW_CHANGE_TIMESTAMP AS PSN_ROW_CHANGE_TS,

P.LAST_FM_DATE AS PSN_LAST_FM_DT,

P.BIRTH_DATE AS PSN_BIRTH_DT,

P.DEATH_DATE AS PSN_DEATH_DT,

(CASE

       WHEN P.DEATH_DATE IS NOT NULL THEN '1' ELSE '0'

END) PSN_DEATH_IND,

NULL AS PSN_FULL_NM,                                        /* CONCAT THE FIRST, MIDDLE, AND LAST NAMES, SUCH AS CHARLES A FARR */

NULL AS PSN_FULL_NM,                                        /* CONCAT THE FIRST, MIDDLE, AND LAST NAMES, SUCH AS FARR, CHARLES A */

P.TITLE AS PSN_TITLE_NM,

P.FIRST_NAME AS PSN_FIRST_NM,

P.MIDDLE_NAME AS PSN_MIDDLE_NM,

P.LAST_NAME AS PSN_LAST_NM,

P.SUFFIX AS PSN_SUFFIX_NM,

P.NICKNAME AS PSN_NICKNAME_NM,

P.GENDER AS PSN_GENDER_CD,

P.MARKETING_OPTION AS PSN_MKTG_OPTION_CD,

CASE                                                                            /* CALC PERSON AGE AND RANGE BUCKET */

       WHEN P.DEATH_DATE IS NULL THEN FLOOR(DATEDIFF(DAYS,P.BIRTH_DATE,CURRENT_DATE)/365)

       WHEN P.DEATH_DATE IS NOT NULL THEN FLOOR(DATEDIFF(DAYS,P.BIRTH_DATE, P.DEATH_DATE)/365)

END AS PSN_AGE_NUM,

CASE

       WHEN P.DEATH_DATE IS NOT NULL THEN 'Deceased'

       WHEN DATEDIFF(DAYS, P.BIRTH_DATE, CURRENT_DATE) < 6573 THEN '< 18'

       WHEN DATEDIFF(DAYS, P.BIRTH_DATE, CURRENT_DATE) BETWEEN 6574 AND 9130   THEN '18-24'

       WHEN DATEDIFF(DAYS, P.BIRTH_DATE, CURRENT_DATE) BETWEEN 9131 AND 12783  THEN '25-34'

       WHEN DATEDIFF(DAYS, P.BIRTH_DATE, CURRENT_DATE) BETWEEN 12784 AND 16435 THEN '35-44'

       WHEN DATEDIFF(DAYS, P.BIRTH_DATE, CURRENT_DATE) BETWEEN 16436 AND 20088 THEN '45-54'

       WHEN DATEDIFF(DAYS, P.BIRTH_DATE, CURRENT_DATE) BETWEEN 20089 AND 23740 THEN '55-64'

       WHEN DATEDIFF(DAYS, P.BIRTH_DATE, CURRENT_DATE) >= 23741 THEN '65+'

       ELSE 'UNDEFINED'

END AS PSN_AGE_RANGE_NM,

NULL AS PSN_NOTE_DSC,                                /* SEE MAPPING & Note FOR BUSINESS LOGIC */

CURRENT_DATE() AS DM_LOAD_DT

FROM RRCU_STG_PRD.KEYSTONE_CORE.T_KS_PERSON_STG P