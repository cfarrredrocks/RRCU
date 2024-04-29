--==================================================================================================
--Author: Farr, C
--Create Date:	2024-04-16  	
--Object Name:	sp_LOAD_T_PRODUCT_DIM
--Description:  Loading Person Data
--***********************************************************************************************************************
--Date			Trello#					ChangedBy						Description 
------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE RRCU_DW_DEV.DM.sp_LOAD_T_PRODUCT_DIM ()
RETURNS VARCHAR NOT NULL
LANGUAGE SQL

AS
$$

BEGIN 


TRUNCATE TABLE RRCU_DW_DEV.DM.T_PRODUCT_DIM_CF;
 

-- MEMBER SHARE PRODUCTS
INSERT INTO RRCU_DW_DEV.DM.T_PRODUCT_DIM_CF
(
PRODUCT_KEY, -- created FOR UNIQUE key
SERIAL_NUM, 
ID, 
TYPE_CD, 
BEGIN_DT, 
END_DT,
LAST_FM_DT,
CAT_CD, 
DSC, 
ORIG_BAL_AMT, 
OPEN_DT, 
CLOSE_DT, 
CREDIT_SCORE_NUM, 
CREDIT_SCORE_TIER_NM,
MATURITY_DT, 
LAST_MONETARY_DT, 
LAST_ACTIVITY_DT, 
CHARGE_OFF_DT, 
COLLECTION_NOTICE_DT, 
BANKRUPTCY_IND, 
CERT_LAST_BUMP_DT, 
LAST_PAYMENT_DT, 
PAYMENT_METHOD_NM, 
PAYMENT_DUE_DT, 
COLLECT_STATUS_CD, 
COLLECT_NOTICE_CNT, 
CREDIT_LIMIT_AMT, 
LOAN_TO_VALUE_PCT, 
INTEREST_RATE_PCT, 
ORIG_FUNDING_DT, 
ORIG_SHARE_DT, 
DTI_PCT,
BRANCH_DSC, 
BRANCH_STATUS_CD, 
BRANCH_CD, 
INTEREST_UNPAID_AMT, 
PAYMENT_PARTIAL_AMT, 
PAYMENT_FREQ_DAY_1_NUM, 
LATE_FEE_CALC_DT, 
PROMO_CD, 
PAYMENT_AMT, 
PAYMENT_COUNT_SCHED_CNT, 
PAYMENT_COUNT_MADE_CNT, 
PAYMENT_SKIP_CNT, 
CC_BAL_XFR_INTEREST_RATE_PCT, 
INTEREST_APR_PCT, 
INTEREST_RATE_MARGIN_PCT, 
INTEREST_RATE_MIN_PCT, 
INTEREST_RATE_MAX_PCT,
BALLOON_DT, 
BALLOON_AMT
)

SELECT 
A.SHAR_SERIAL || A.SHAR_ID || 'SH' AS PRODUCT_KEY,
A.SHAR_SERIAL AS SERIAL_NUM,
A.SHAR_ID AS ID,
'SH' AS TYPE_CD,
A.SHAR_OPEN_DATE AS BEGIN_DT,
CASE
       WHEN A.SHAR_MATURITY_DATE IS NOT NULL THEN A.SHAR_MATURITY_DATE
       WHEN A.SHAR_CLOSE_DATE IS NOT NULL THEN A.SHAR_CLOSE_DATE
       ELSE NULL
END AS END_DT,
A.SHAR_LAST_FM_DATE AS LAST_FM_DT,
B.SHTYP_CATEGORY AS CAT_CD,
A.SHAR_DESCRIPTION AS DSC,
A.SHAR_ORIGINAL_AMOUNT,
A.SHAR_OPEN_DATE AS OPEN_DT,
A.SHAR_CLOSE_DATE AS CLOSE_DT,
0 AS CREDIT_SCORE_NUM,
NULL AS CREDIT_SCORE_TIER_NM,
A.SHAR_MATURITY_DATE AS MATURITY_DT,
A.SHAR_LAST_MONETARY_DATE AS LAST_MONETARY_DT,
A.SHAR_LAST_ACTIVITY_DATE AS LAST_ACTIVITY_DT,
A.SHAR_CHARGE_OFF_DATE AS CHARGE_OFF_DT,
A.SHAR_COLLECTION_NOTICE_DATE AS COLLECTION_NOTICE_DT,
NULL AS BANKRUPTCY_IND,
--COALESCE(A.SHAR_CERT_BUMP_COUNT,0) AS CERT_BUMP_CNT,
A.SHAR_CERT_BUMP_LAST_DATE AS CERT_LAST_BUMP_DT,
NULL AS LAST_PAYMENT_DT,
NULL AS PAYMENT_METHOD_NM,
NULL AS PAYMENT_DUE_DT,
NULL AS COLLECTION_STATUS_CD,
NULL AS COLLECTION_NOTICE_CNT,
NULL AS CREDIT_LIMIT_AMT,
NULL AS LOAN_TO_VALUE_PCT,
A.SHAR_DIVIDEND_CUSTOM_RATE AS INTEREST_RATE_PCT,
NULL AS ORIG_FUNDING_DT,
A.SHAR_ORIGINAL_DATE AS ORIG_SHARE_DT,
NULL AS DTI_PCT,
BR.BRCH_DESCRIPTION AS BRANCH_DSC,
BR.BRCH_STATUS AS BRANCH_STATUS_CD,
BR.BRCH_CODE AS BRANCH_CD,
NULL AS INTEREST_UNPAID_AMT,
NULL AS PAYMENT_PARTIAL_AMT,
NULL AS PAYMENT_FREQ_DAY_1_NUM,
NULL AS LATE_FEE_CALC_DT,
SP.SHPC_SHARE_PROMOCODE AS PROMO_CD,
NULL AS PAYMENT_AMT,
NULL AS PAYMENT_COUNT_SCHED_CNT,
NULL AS PAYMENT_COUNT_MADE_CNT,
NULL AS PAYMENT_SKIP_CNT,
NULL AS CC_BAL_XFR_INTEREST_RATE_PCT,
NULL AS INTEREST_APR_PCT,
NULL AS INTEREST_RATE_MARGIN_PCT, 
NULL AS INTEREST_RATE_MIN_PCT,
NULL AS INTEREST_RATE_MAX_PCT,
NULL AS BALLOON_DT,
NULL AS BALLOON_AMT
--NULL AS KEY_CNT,
--CURRENT_DATE AS DW_LOAD_DT
FROM RRCU_DW_DEV.DW.T_KS_SHARE_DW_CF A
LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_SH_TYPE_DW_CF B ON A.SHAR_TYPE_SERIAL = B.SHTYP_SERIAL AND B.SHTYP_CURR_IND = 1
LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_BRANCH_DW_CF BR ON BR.BRCH_SERIAL = A.SHAR_BRANCH_SERIAL AND BR.BRCH_CURR_IND = 1
LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_CU_SHAREPROMOCODE_DW_CF SP ON SP.SHPC_PARENT_SERIAL = A.SHAR_SERIAL AND SP.SHPC_CURR_IND = 1
WHERE A.SHAR_CURR_IND = 1

UNION 

SELECT 
A.LOAN_SERIAL || A.LOAN_ID || 'LN' AS PRODUCT_KEY,
A.LOAN_SERIAL AS SERIAL_NUM,
A.LOAN_ID AS ID,
'LN' AS TYPE_CD,
A.LOAN_OPEN_DATE AS BEGIN_DT,
CASE
    WHEN A.LOAN_MATURITY_DATE IS NOT NULL THEN A.LOAN_MATURITY_DATE
    WHEN A.LOAN_CLOSE_DATE IS NOT NULL THEN A.LOAN_CLOSE_DATE ELSE NULL
END AS END_DT,
A.LOAN_LAST_FM_DATE AS LAST_FM_DT,
B.LNTYP_CATEGORY AS CAT_CD,
A.LOAN_DESCRIPTION AS DSC,
A.LOAN_ORIGINAL_BALANCE,
A.LOAN_OPEN_DATE AS OPEN_DT,
A.LOAN_CLOSE_DATE AS CLOSE_DT,
A.LOAN_CREDIT_SCORE AS CREDIT_SCORE_NUM,
CASE
     WHEN A.LOAN_CREDIT_SCORE BETWEEN '780' AND '900' THEN 'A++'
     WHEN A.LOAN_CREDIT_SCORE BETWEEN '740' AND '779' THEN 'A+'
     WHEN A.LOAN_CREDIT_SCORE BETWEEN '720' AND '739' THEN 'A'
     WHEN A.LOAN_CREDIT_SCORE BETWEEN '700' AND '719' THEN 'B+'
     WHEN A.LOAN_CREDIT_SCORE BETWEEN '680' AND '699' THEN 'B'
     WHEN A.LOAN_CREDIT_SCORE BETWEEN '660' AND '679' THEN 'C+'
     WHEN A.LOAN_CREDIT_SCORE BETWEEN '640' AND '659' THEN 'C'
     WHEN A.LOAN_CREDIT_SCORE BETWEEN '639' AND '1' THEN 'D-'
     ELSE 'UNDEFINED'
END AS CREDIT_SCORE_TIER_NM,
A.LOAN_MATURITY_DATE AS MATURITY_DT,
A.LOAN_LAST_MONETARY_DATE AS LAST_MONETARY_DT,
A.LOAN_LAST_ACTIVITY_DATE AS LAST_ACTIVITY_DT,
A.LOAN_CHARGE_OFF_DATE AS CHARGE_OFF_DT,
A.LOAN_COLLECTION_NOTICE_DATE AS COLLECTION_NOTICE_DT,
A.LOAN_BANKRUPTCY_INDICATOR AS BANKRUPTCY_IND,
--0 AS CERT_BUMP_CNT,
NULL AS CERT_LAST_BUMP_DT,
A.LOAN_PAYMENT_LAST_DATE AS LAST_PAYMENT_DT,
A.LOAN_PAYMENT_METHOD AS PAYMENT_METHOD_NM,
A.LOAN_PAYMENT_DUE_DATE AS PAYMENT_DUE_DT,
A.LOAN_COLLECTION_STATUS AS COLLECTION_STATUS_CD,
A.LOAN_COLLECTION_NOTICE_COUNT AS COLLECTION_NOTICE_CNT,
A.LOAN_CREDIT_LIMIT AS CREDIT_LIMIT_AMT,
C.COLL_LOAN_TO_VALUE AS LOAN_TO_VALUE_PCT,
A.LOAN_INTEREST_RATE AS INTEREST_RATE_PCT,
A.LOAN_ORIGINAL_FUNDING_DATE AS ORIG_FUNDING_DT,
NULL AS ORIG_SHARE_DT,
E.LRDR_RATIO AS DTI_PCT,
BR.BRCH_DESCRIPTION AS BRANCH_DSC,
BR.BRCH_STATUS AS BRANCH_STATUS,
BR.BRCH_CODE AS BRANCH_CD,
A.LOAN_INTEREST_UNPAID AS INTEREST_UNPAID_AMT,
A.LOAN_PAYMENT_PARTIAL_AMOUNT AS PAYMENT_PARTIAL_AMT,
A.LOAN_PAYMENT_FREQUENCY_DAY_1 AS PAYMENT_FREQ_DAY_1_NUM,
A.LOAN_LATE_FEE_CALCULATION_DATE AS LATE_FEE_CALC_DT,
LP.LNPC_PROMOCODE AS PROMO_CD,
A.LOAN_PAYMENT_AMOUNT AS PAYMENT_AMT,
A.LOAN_PAYMENT_COUNT_SCHEDULED AS PAYMENT_COUNT_SCHED_CNT,
A.LOAN_PAYMENT_COUNT_MADE AS PAYMENT_COUNT_MADE_CNT,
A.LOAN_PAYMENT_SKIP_COUNT AS PAYMENT_SKIP_CNT,
A.LOAN_CC_BAL_XFR_INT_RATE AS CC_BAL_XFR_INTEREST_RATE_PCT,
A.LOAN_INTEREST_APR AS INTEREST_APR_PCT,
A.LOAN_INTEREST_RATE_MARGIN AS INTEREST_RATE_MARGIN_PCT,
A.LOAN_INTEREST_RATE_MINIMUM AS INTEREST_RATE_MIN_PCT,
A.LOAN_INTEREST_RATE_MAXIMUM AS INTEREST_RATE_MAX_PCT,
A.LOAN_BALLOON_DATE AS BALLOON_DT,
A.LOAN_BALLOON_AMOUNT AS BALLOON_AMT,
--NULL AS PRD_KEY_CNT,
--CURRENT_DATE AS DW_LOAD_DT
FROM RRCU_DW_DEV.DW.T_KS_LOAN_DW_CF A
JOIN RRCU_DW_DEV.DW.T_KS_LN_TYPE_DW_CF B ON A.LOAN_TYPE_SERIAL = B.LNTYP_SERIAL AND B.LNTYP_CURR_IND = 1
LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_COLLATERAL_DW_CF C ON A.LOAN_SERIAL = C.COLL_PARENT_SERIAL AND C.COLL_CURR_IND = 1
LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_LOAN_REQUEST_DW_CF D ON D.LNRQ_APPROVED_LOAN_SERIAL = A.LOAN_SERIAL AND D.LNRQ_CURR_IND = 1
LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_LR_DEBT_RATIO_DW_CF E ON E.LRDR_PARENT_SERIAL = D.LNRQ_SERIAL AND E.LRDR_CURR_IND = 1
LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_BRANCH_DW_CF BR ON BR.BRCH_SERIAL = A.LOAN_BRANCH_SERIAL AND BR.BRCH_CURR_IND = 1
LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_CU_LOANPROMOCODE_DW_CF LP ON LP.LNPC_PARENT_SERIAL = A.LOAN_SERIAL AND LP.LNPC_CURR_IND = 1
WHERE A.LOAN_CURR_IND = 1

UNION


SELECT 
R.RENT_SERIAL || 'RN' AS PRODUCT_KEY,
R.RENT_SERIAL AS SERIAL_NUM,
NULL AS ID,
'RN' AS TYPE_CD,
R.RENT_RENTAL_START_DATE AS BEGIN_DT,
R.RENT_AVAILABLE_DATE AS END_DT,
R.RENT_LAST_FM_DATE AS PRD_LAST_FM_DT,
NULL AS CAT_CD, 
R.RENT_DESCRIPTION AS DSC,
NULL AS ORIG_BAL_AMT,
R.RENT_RENTAL_START_DATE AS OPEN_DT,
R.RENT_AVAILABLE_DATE AS CLOSE_DT,
NULL AS CREDIT_SCORE_NUM,
NULL AS CREDIT_SCORE_TIER_NM,
R.RENT_NEXT_FEE_DATE AS MATURITY_DT,
NULL AS LAST_MENTARY_DT,
R.RENT_LAST_FM_DATE AS PRD_LAST_ACTIVITY_DT,
NULL AS CHARGE_OFF_DT,
NULL AS COLLECTION_NOTICE_DT,
NULL AS PBANKRUPTCY_IND,
--NULL AS CERT_BUMP_CNT,
NULL AS CERT_LAST_BUMP_DT,
NULL AS LAST_PAYMENT_DT,
NULL AS PAYMENT_METHOD_NM,
NULL AS PAYMENT_DUE_DT,
NULL AS COLLECTION_STATUS_CD,
NULL AS COLLECTION_NOTICE_CNT,
NULL AS CREDIT_LIMIT_AMT,
NULL AS LOAN_TO_VALUE_PCT,
NULL AS INTEREST_RATE_PCT,
NULL AS ORIG_FUNDING_DT,
NULL AS ORIG_SHARE_DT,
NULL AS DTI_PCT,
BR.BRCH_DESCRIPTION AS BRANCH_DSC,
BR.BRCH_STATUS AS BRANCH_STATUS_CD,
BR.BRCH_CODE AS BRANCH_CD,
NULL AS INTEREST_UNPAID_AMT,
NULL AS PAYMENT_PARTIAL_AMT,
RT.RNTYP_FREQUENCY_DAY_1 AS PAYMENT_FREQ_DAY_1_NUM,
NULL AS LATE_FEE_CALC_DT,
NULL AS PROMO_CD,
NULL AS PAYMENT_AMT,
NULL AS PAYMENT_COUNT_SCHED_CNT,
NULL AS PAYMENT_COUNT_MADE_CNT,
NULL AS PAYMENT_SKIP_CNT,
NULL AS CC_BAL_XFR_INTEREST_RATE_PCT,
NULL AS INTEREST_APR_PCT,
NULL AS INTEREST_RATE_MARGIN_PCT,
NULL AS INTEREST_RATE_MIN_PCT,
NULL AS INTEREST_RATE_MAX_PCT,
NULL AS BALLOON_DT,
NULL AS BALLOON_AMT,
--R.KEY_COUNT AS PRD_KEY_CNT,
--CURRENT_DATE AS DW_LOAD_DT
FROM RRCU_DW_DEV.DW.T_KS_RENTAL_DW_CF AS R
JOIN RRCU_DW_DEV.DW.T_KS_RENTAL_TYPE_DW_CF AS RT ON RT.RNTYP_SERIAL = R.RENT_TYPE_SERIAL AND RT.RNTYP_CURR_IND = 1
LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_BRANCH_DW_CF BR ON BR.BRCH_SERIAL = R.RENT_BRANCH_SERIAL AND BR.BRCH_CURR_IND = 1
WHERE R.RENT_CURR_IND = 1;


 END;
$$
;