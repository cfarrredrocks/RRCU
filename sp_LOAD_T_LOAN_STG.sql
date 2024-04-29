/*
--==================================================================================================
--Author: Farr, C
--Create Date:	2024-04-03  	
--Object Name:	sp_LOAD_T_LOAN_STG
--Description:  Loading Share Data
--***********************************************************************************************************************
--Date			Trello#					ChangedBy						Description 
------------------------------------------------------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE RRCU_STG_DEV.KEYSTONE_CORE.sp_LOAD_T_LOAN_STG()
RETURNS VARCHAR NOT NULL
LANGUAGE SQL

AS
$$

BEGIN 
	
	TRUNCATE TABLE RRCU_STG_DEV.KEYSTONE_CORE.T_KS_LOAN_STG_CF;
	
	-- REMOVE PK	
	ALTER TABLE RRCU_STG_DEV.KEYSTONE_CORE.T_KS_LOAN_STG_CF DROP PRIMARY KEY;
	
	-- Populate STAGING WITH CTE DATA
	INSERT INTO RRCU_STG_DEV.KEYSTONE_CORE.T_KS_LOAN_STG_CF
	(
	SERIAL,
	SOURCEHASH2,
	PARENT_SERIAL, 
	STORED_ACCESS_KEY, 
	ORDINAL, 
	LAST_FM_DATE, 
	ID, 
	DESCRIPTION, 
	TYPE_SERIAL, 
	PROCESSING, 
	EXTERNAL_ACCOUNT_NUMBER,
	EXTERNAL_INVESTOR_BANK_CODE, 
	EXTERNAL_INVESTOR_CODE, 
	EXTERNAL_INVESTOR_GROUP_CODE, 
	LAST_IMPORT_DATE, 
	BRANCH_SERIAL, 
	OPEN_DATE, 
	OPENED_BY_USER_SERIAL, 
	CLOSE_DATE, 
	CLOSE_REASON_SERIAL, 
	SHADOW_DATE, 
	SHADOW_BALANCE,
	SHADOW_INTEREST, 
	SHADOW_LATE_FEE, 
	CHARGE_OFF_DATE, 
	CHARGE_OFF_TYPE_SERIAL, 
	CHARGE_OFF_AMOUNT, 
	COLLECTION_STATUS, 
	COLLECTION_HANDLING, 
	COLLECTION_NOTICE_COUNT, 
	COLLECTION_NOTICE_DATE, 
	BANKRUPTCY_INDICATOR, 
	CRED_REP_PRIMARY_ECOA_CODE, 
	CRED_REP_PRIMARY_CONS_INFO_IND,
	CRED_REP_BANKRUPTCY_DATE, 
	CRED_REP_ACCOUNT_TYPE, 
	CRED_REP_PORTFOLIO_TYPE_OVR, 
	CRED_REP_SPEC_COMM_CODE, 
	CRED_REP_COMP_COND_CODE, 
	CRED_REP_FIRST_DQ_DATE, 
	CRED_REP_ACCOUNT_STATUS, 
	CRED_REP_PMT_HISTORY_PROFILE, 
	CRED_REP_LAST_DATE, 
	SHARED_BRANCH_OPTION, 
	NOTE_RESTRICTION, 
	MONETARY_PURGE_DATE, 
	LAST_MONETARY_DATE, 
	LAST_ACTIVITY_DATE, 
	LAST_ADVANCE_DATE,
	MATURITY_DATE, 
	PURPOSE_SERIAL, 
	PROCESSOR_USER_SERIAL, 
	APPROVAL_OFFICER_SERIAL, 
	APPROVAL_DATE, 
	APPLICATION_SERIAL, 
	CREDIT_SCORE_CATEGORY, 
	CREDIT_SCORE, 
	PAPER_GRADE_SERIAL, 
	COLLATERAL_TYPE_SERIAL, 
	NOTE_NUMBER, 
	BALANCE,
	UNAPPLIED_FUNDS_BALANCE, 
	MINIMUM_BALANCE, 
	MINIMUM_ADVANCE, 
	DOWN_PAYMENT, 
	MASTER_LINE_SERIAL, 
	CREDIT_LIMIT, 
	CREDIT_LIMIT_EXPIRATION_DATE, 
	CREDIT_LIMIT_SHARED_GRP_SERIAL, 
	CC_CASH_ADV_LIMIT_PERCENTAGE, 
	CC_CASH_ADV_LIMIT_AMOUNT, 
	POSITIVE_PAY_OPTION, 
	DRAW_PERIOD_EXPIRATION_DATE, 
	DRAW_PERIOD_STATUS, 
	NON_REVOLVING_BALANCE, 
	MAX_VALUATION_CREDIT_LIMIT, 
	ORIGINAL_LOAN_DATE, 
	ORIGINAL_FUNDING_DATE, 
	ORIGINAL_DUE_DATE, 
	ORIGINAL_BALANCE,
	ACQUISITION_DATE, 
	ACQUISITION_BALANCE, 
	SHARE_SECURED_OPTION, 
	SHARE_SECURED_AMOUNT, 
	PAYMENT_METHOD, 
	PAYMENT_COUPON_DATE, 
	PAYMENT_AMOUNT, 
	PAYMENT_PARTIAL_AMOUNT, 
	PAYMENT_CALCULATION_SERIAL, 
	PAYMENT_CALCULATION_STATUS, 
	PAYMENT_CALCULATION_SCH_FREQ, 
	PAYMENT_CALCULATION_SCH_FREQ_1, 
	PAYMENT_CALCULATION_SCH_PERIOD, 
	PAYMENT_CALCULATION_SCH_DATE, 
	PAYMENT_COUNT_SCHEDULED, 
	PAYMENT_COUNT_MADE, 
	PAYMENT_COUNT_DQ_UNDER_30, 
	PAYMENT_COUNT_DQ_30_TO_59,
	PAYMENT_COUNT_DQ_60_TO_89, 
	PAYMENT_COUNT_DQ_90_TO_119, 
	PAYMENT_COUNT_DQ_120_AND_UP, 
	PAYMENT_LAST_DATE, 
	PAYMENT_FREQUENCY, 
	PAYMENT_FREQUENCY_DAY_1, 
	PAYMENT_FREQUENCY_DAY_2, 
	PAYMENT_SKIP_COUNT, 
	PAYMENT_SKIP_START_MONTH, 
	PAYMENT_SKIP_START_DAY, 
	PAYMENT_AHEAD, 
	PAYMENT_AHEAD_COUNT, 
	PAYMENT_DUE_DATE, 
	ACH_PAYMENT_LAST_AMOUNT, 
	ACH_PAYMENT_LAST_DATE, 
	BALLOON_DATE, 
	BALLOON_AMOUNT, 
	INTEREST_PAID_TOTAL, 
	INTEREST_UNPAID, 
	INTEREST_ONLY_UNPAID, 
	INTEREST_PREPAID, 
	INTEREST_CALCULATION_DATE, 
	INTEREST_RATE, 
	INTEREST_APR, 
	INTEREST_RATE_VAR_OPT, 
	INTEREST_RATE_INDEX_SERIAL, 
	INTEREST_RATE_MARGIN, 
	INTEREST_RATE_DISCOUNT, 
	INTEREST_RATE_RISK_PREMIUM, 
	INTEREST_RATE_MINIMUM, 
	INTEREST_RATE_MAXIMUM, 
	INTEREST_RATE_CHG_START_DATE, 
	INTEREST_RATE_CHG_SCH_FREQ, 
	INTEREST_RATE_CHG_SCH_FREQ_1, 
	INTEREST_RATE_CHG_SCH_FREQ_2, 
	INTEREST_RATE_CHG_SCH_PERIOD, 
	INTEREST_RATE_CHG_SCH_DATE, 
	INTEREST_RATE_CHG_SCH_RND_INC, 
	INTEREST_RATE_CHG_SCH_RND_OPT, 
	INTEREST_RATE_CAP_FREQUENCY, 
	INTEREST_RATE_CAP_PERIOD, 
	INTEREST_RATE_CAP_DIRECTION, 
	INTEREST_RATE_CAP_START_DATE, 
	INTEREST_RATE_CAP_START_RATE, 
	INTEREST_RATE_CAP, 
	INTEREST_RATE_ADJUSTMENT, 
	INTEREST_RATE_ADJ_RSN_SERIAL, 
	LATE_FEE_UNPAID, 
	LATE_FEE_CALCULATION_SERIAL, 
	LATE_FEE_CALCULATION_DATE, 
	LATE_FEE_CALCULATION_ACCR, 
	MAINTENANCE_FEE_SERIAL, 
	MAINTENANCE_FEE_EFFECT_DATE, 
	MAINTENANCE_FEE_EXPIRE_DATE, 
	MAINTENANCE_FEE_UNPAID, 
	IMPOUND_AMOUNT, 
	IMPOUND_PARTIAL_AMOUNT, 
	IMPOUND_SHARE_SERIAL, 
	FASB_91_TYPE_SERIAL, 
	FASB_91_ORIGINAL_APR, 
	FASB_91_EFFECTIVE_APR, 
	FASB_91_UNAMORTIZED_FEES, 
	FASB_91_AMORTIZATION_AMOUNT, 
	FASB_91_FUNDING_OPTION, 
	MAIL_PERSON_ADDR_LINK_SERIAL, 
	STMT_MAIL_GROUP_SERIAL, 
	STMT_CUTOFF_GROUP_SERIAL, 
	STMT_CUTOFF_LAST_DATE, 
	STMT_CUTOFF_LAST_TRAN_SERIAL, 
	STMT_CUTOFF_PRIOR_DATE, 
	STMT_CUTOFF_PRIOR_TRAN_SERIAL, 
	STMT_REG_E_COUNT, 
	CC_PURCH_BAL_OLD, 
	CC_PURCH_BAL_NEW, 
	CC_PURCH_AVG_BAL, 
	CC_PURCH_INT_RATE, 
	CC_PURCH_INT_RATE_VAR_OPT, 
	CC_PURCH_INT_CHARGE, 
	CC_PURCH_INT_UNPAID_OLD, 
	CC_PURCH_INT_UNPAID_NEW, 
	CC_PURCH_GRACE_IND_OLD, 
	CC_PURCH_GRACE_IND_NEW, 
	CC_CASH_ADV_BAL_OLD, 
	CC_CASH_ADV_BAL_NEW, 
	CC_CASH_ADV_AVG_BAL, 
	CC_CASH_ADV_INT_RATE, 
	CC_CASH_ADV_INT_RATE_VAR_OPT, 
	CC_CASH_ADV_INT_CHARGE, 
	CC_CASH_ADV_INT_UNPAID_OLD, 
	CC_CASH_ADV_INT_UNPAID_NEW, 
	CC_CASH_ADV_GRACE_IND_OLD, 
	CC_CASH_ADV_GRACE_IND_NEW, 
	CC_BAL_XFR_BAL_OLD, 
	CC_BAL_XFR_BAL_NEW, 
	CC_BAL_XFR_AVG_BAL, 
	CC_BAL_XFR_INT_RATE, 
	CC_BAL_XFR_INT_RATE_VAR_OPT, 
	CC_BAL_XFR_INT_CHARGE, 
	CC_BAL_XFR_INT_UNPAID_OLD, 
	CC_BAL_XFR_INT_UNPAID_NEW, 
	CC_BAL_XFR_GRACE_IND_OLD, 
	CC_BAL_XFR_GRACE_IND_NEW, 
	CC_FEE_BAL_OLD, 
	CC_FEE_BAL_NEW, 
	CC_TOTAL_BAL_OLD, 
	CC_TOTAL_BAL_NEW, 
	CC_FIRST_YEAR_FEES_MAXIMUM,
	CC_FIRST_YEAR_FEES_CHARGED, 
	CC_PENALTY_INT_RATE, 
	PROMO_RATE_TYPE_SERIAL, 
	SEGMENT_COUNT_LIMIT, 
	TAX_PERSON_SERIAL, 
	MLA_LIMITATION, 
	PARTICIPATION_POOL_SERIAL, 
	LIFE_INSURANCE_SERIAL, 
	DISABILITY_INSURANCE_SERIAL, 
	SINGLE_PREMIUM_LIFE, 
	SINGLE_PREMIUM_DISABILITY, 
	INSURANCE_METHOD, 
	INSURANCE_SHARE_SERIAL, 
	ROW_CHANGE_TIMESTAMP, 
	SHARED_COLLATERAL_OPTION, 
	CRED_REP_PRIMARY_CONS_FIN_DATE	
	)
	
	WITH CTE AS

	(	
	SELECT 
	SERIAL,
	MD5(TO_VARCHAR(ARRAY_CONSTRUCT(*))) AS SourceHash2,  -- SOURCE HASH	
	PARENT_SERIAL, 
	STORED_ACCESS_KEY, 
	ORDINAL, 
	LAST_FM_DATE, 
	ID, 
	DESCRIPTION, 
	TYPE_SERIAL, 
	PROCESSING, 
	EXTERNAL_ACCOUNT_NUMBER,
	EXTERNAL_INVESTOR_BANK_CODE, 
	EXTERNAL_INVESTOR_CODE, 
	EXTERNAL_INVESTOR_GROUP_CODE, 
	LAST_IMPORT_DATE, 
	BRANCH_SERIAL, 
	OPEN_DATE, 
	OPENED_BY_USER_SERIAL, 
	CLOSE_DATE, 
	CLOSE_REASON_SERIAL, 
	SHADOW_DATE, 
	SHADOW_BALANCE,
	SHADOW_INTEREST, 
	SHADOW_LATE_FEE, 
	CHARGE_OFF_DATE, 
	CHARGE_OFF_TYPE_SERIAL, 
	CHARGE_OFF_AMOUNT, 
	COLLECTION_STATUS, 
	COLLECTION_HANDLING, 
	COLLECTION_NOTICE_COUNT, 
	COLLECTION_NOTICE_DATE, 
	BANKRUPTCY_INDICATOR, 
	CRED_REP_PRIMARY_ECOA_CODE, 
	CRED_REP_PRIMARY_CONS_INFO_IND,
	CRED_REP_BANKRUPTCY_DATE, 
	CRED_REP_ACCOUNT_TYPE, 
	CRED_REP_PORTFOLIO_TYPE_OVR, 
	CRED_REP_SPEC_COMM_CODE, 
	CRED_REP_COMP_COND_CODE, 
	CRED_REP_FIRST_DQ_DATE, 
	CRED_REP_ACCOUNT_STATUS, 
	CRED_REP_PMT_HISTORY_PROFILE, 
	CRED_REP_LAST_DATE, 
	SHARED_BRANCH_OPTION, 
	NOTE_RESTRICTION, 
	MONETARY_PURGE_DATE, 
	LAST_MONETARY_DATE, 
	LAST_ACTIVITY_DATE, 
	LAST_ADVANCE_DATE,
	MATURITY_DATE, 
	PURPOSE_SERIAL, 
	PROCESSOR_USER_SERIAL, 
	APPROVAL_OFFICER_SERIAL, 
	APPROVAL_DATE, 
	APPLICATION_SERIAL, 
	CREDIT_SCORE_CATEGORY, 
	CREDIT_SCORE, 
	PAPER_GRADE_SERIAL, 
	COLLATERAL_TYPE_SERIAL, 
	NOTE_NUMBER, 
	BALANCE,
	UNAPPLIED_FUNDS_BALANCE, 
	MINIMUM_BALANCE, 
	MINIMUM_ADVANCE, 
	DOWN_PAYMENT, 
	MASTER_LINE_SERIAL, 
	CREDIT_LIMIT, 
	CREDIT_LIMIT_EXPIRATION_DATE, 
	CREDIT_LIMIT_SHARED_GRP_SERIAL, 
	CC_CASH_ADV_LIMIT_PERCENTAGE, 
	CC_CASH_ADV_LIMIT_AMOUNT, 
	POSITIVE_PAY_OPTION, 
	DRAW_PERIOD_EXPIRATION_DATE, 
	DRAW_PERIOD_STATUS, 
	NON_REVOLVING_BALANCE, 
	MAX_VALUATION_CREDIT_LIMIT, 
	ORIGINAL_LOAN_DATE, 
	ORIGINAL_FUNDING_DATE, 
	ORIGINAL_DUE_DATE, 
	ORIGINAL_BALANCE,
	ACQUISITION_DATE, 
	ACQUISITION_BALANCE, 
	SHARE_SECURED_OPTION, 
	SHARE_SECURED_AMOUNT, 
	PAYMENT_METHOD, 
	PAYMENT_COUPON_DATE, 
	PAYMENT_AMOUNT, 
	PAYMENT_PARTIAL_AMOUNT, 
	PAYMENT_CALCULATION_SERIAL, 
	PAYMENT_CALCULATION_STATUS, 
	PAYMENT_CALCULATION_SCH_FREQ, 
	PAYMENT_CALCULATION_SCH_FREQ_1, 
	PAYMENT_CALCULATION_SCH_PERIOD, 
	PAYMENT_CALCULATION_SCH_DATE, 
	PAYMENT_COUNT_SCHEDULED, 
	PAYMENT_COUNT_MADE, 
	PAYMENT_COUNT_DQ_UNDER_30, 
	PAYMENT_COUNT_DQ_30_TO_59,
	PAYMENT_COUNT_DQ_60_TO_89, 
	PAYMENT_COUNT_DQ_90_TO_119, 
	PAYMENT_COUNT_DQ_120_AND_UP, 
	PAYMENT_LAST_DATE, 
	PAYMENT_FREQUENCY, 
	PAYMENT_FREQUENCY_DAY_1, 
	PAYMENT_FREQUENCY_DAY_2, 
	PAYMENT_SKIP_COUNT, 
	PAYMENT_SKIP_START_MONTH, 
	PAYMENT_SKIP_START_DAY, 
	PAYMENT_AHEAD, 
	PAYMENT_AHEAD_COUNT, 
	PAYMENT_DUE_DATE, 
	ACH_PAYMENT_LAST_AMOUNT, 
	ACH_PAYMENT_LAST_DATE, 
	BALLOON_DATE, 
	BALLOON_AMOUNT, 
	INTEREST_PAID_TOTAL, 
	INTEREST_UNPAID, 
	INTEREST_ONLY_UNPAID, 
	INTEREST_PREPAID, 
	INTEREST_CALCULATION_DATE, 
	INTEREST_RATE, 
	INTEREST_APR, 
	INTEREST_RATE_VAR_OPT, 
	INTEREST_RATE_INDEX_SERIAL, 
	INTEREST_RATE_MARGIN, 
	INTEREST_RATE_DISCOUNT, 
	INTEREST_RATE_RISK_PREMIUM, 
	INTEREST_RATE_MINIMUM, 
	INTEREST_RATE_MAXIMUM, 
	INTEREST_RATE_CHG_START_DATE, 
	INTEREST_RATE_CHG_SCH_FREQ, 
	INTEREST_RATE_CHG_SCH_FREQ_1, 
	INTEREST_RATE_CHG_SCH_FREQ_2, 
	INTEREST_RATE_CHG_SCH_PERIOD, 
	INTEREST_RATE_CHG_SCH_DATE, 
	INTEREST_RATE_CHG_SCH_RND_INC, 
	INTEREST_RATE_CHG_SCH_RND_OPT, 
	INTEREST_RATE_CAP_FREQUENCY, 
	INTEREST_RATE_CAP_PERIOD, 
	INTEREST_RATE_CAP_DIRECTION, 
	INTEREST_RATE_CAP_START_DATE, 
	INTEREST_RATE_CAP_START_RATE, 
	INTEREST_RATE_CAP, 
	INTEREST_RATE_ADJUSTMENT, 
	INTEREST_RATE_ADJ_RSN_SERIAL, 
	LATE_FEE_UNPAID, 
	LATE_FEE_CALCULATION_SERIAL, 
	LATE_FEE_CALCULATION_DATE, 
	LATE_FEE_CALCULATION_ACCR, 
	MAINTENANCE_FEE_SERIAL, 
	MAINTENANCE_FEE_EFFECT_DATE, 
	MAINTENANCE_FEE_EXPIRE_DATE, 
	MAINTENANCE_FEE_UNPAID, 
	IMPOUND_AMOUNT, 
	IMPOUND_PARTIAL_AMOUNT, 
	IMPOUND_SHARE_SERIAL, 
	FASB_91_TYPE_SERIAL, 
	FASB_91_ORIGINAL_APR, 
	FASB_91_EFFECTIVE_APR, 
	FASB_91_UNAMORTIZED_FEES, 
	FASB_91_AMORTIZATION_AMOUNT, 
	FASB_91_FUNDING_OPTION, 
	MAIL_PERSON_ADDR_LINK_SERIAL, 
	STMT_MAIL_GROUP_SERIAL, 
	STMT_CUTOFF_GROUP_SERIAL, 
	STMT_CUTOFF_LAST_DATE, 
	STMT_CUTOFF_LAST_TRAN_SERIAL, 
	STMT_CUTOFF_PRIOR_DATE, 
	STMT_CUTOFF_PRIOR_TRAN_SERIAL, 
	STMT_REG_E_COUNT, 
	CC_PURCH_BAL_OLD, 
	CC_PURCH_BAL_NEW, 
	CC_PURCH_AVG_BAL, 
	CC_PURCH_INT_RATE, 
	CC_PURCH_INT_RATE_VAR_OPT, 
	CC_PURCH_INT_CHARGE, 
	CC_PURCH_INT_UNPAID_OLD, 
	CC_PURCH_INT_UNPAID_NEW, 
	CC_PURCH_GRACE_IND_OLD, 
	CC_PURCH_GRACE_IND_NEW, 
	CC_CASH_ADV_BAL_OLD, 
	CC_CASH_ADV_BAL_NEW, 
	CC_CASH_ADV_AVG_BAL, 
	CC_CASH_ADV_INT_RATE, 
	CC_CASH_ADV_INT_RATE_VAR_OPT, 
	CC_CASH_ADV_INT_CHARGE, 
	CC_CASH_ADV_INT_UNPAID_OLD, 
	CC_CASH_ADV_INT_UNPAID_NEW, 
	CC_CASH_ADV_GRACE_IND_OLD, 
	CC_CASH_ADV_GRACE_IND_NEW, 
	CC_BAL_XFR_BAL_OLD, 
	CC_BAL_XFR_BAL_NEW, 
	CC_BAL_XFR_AVG_BAL, 
	CC_BAL_XFR_INT_RATE, 
	CC_BAL_XFR_INT_RATE_VAR_OPT, 
	CC_BAL_XFR_INT_CHARGE, 
	CC_BAL_XFR_INT_UNPAID_OLD, 
	CC_BAL_XFR_INT_UNPAID_NEW, 
	CC_BAL_XFR_GRACE_IND_OLD, 
	CC_BAL_XFR_GRACE_IND_NEW, 
	CC_FEE_BAL_OLD, 
	CC_FEE_BAL_NEW, 
	CC_TOTAL_BAL_OLD, 
	CC_TOTAL_BAL_NEW, 
	CC_FIRST_YEAR_FEES_MAXIMUM,
	CC_FIRST_YEAR_FEES_CHARGED, 
	CC_PENALTY_INT_RATE, 
	PROMO_RATE_TYPE_SERIAL, 
	SEGMENT_COUNT_LIMIT, 
	TAX_PERSON_SERIAL, 
	MLA_LIMITATION, 
	PARTICIPATION_POOL_SERIAL, 
	LIFE_INSURANCE_SERIAL, 
	DISABILITY_INSURANCE_SERIAL, 
	SINGLE_PREMIUM_LIFE, 
	SINGLE_PREMIUM_DISABILITY, 
	INSURANCE_METHOD, 
	INSURANCE_SHARE_SERIAL, 
	ROW_CHANGE_TIMESTAMP, 
	SHARED_COLLATERAL_OPTION, 
	CRED_REP_PRIMARY_CONS_FIN_DATE,	
	ROW_NUMBER() OVER (PARTITION BY SERIAL ORDER BY SERIAL) AS rn -- helps identify mutliple serial number dupes		
	FROM RRCU_STG_DEV.KEYSTONE_CORE.T_KS_LOAN_STG
	)

	SELECT SERIAL, SOURCEHASH2,	PARENT_SERIAL, STORED_ACCESS_KEY, ORDINAL, LAST_FM_DATE, ID, DESCRIPTION, TYPE_SERIAL, PROCESSING, EXTERNAL_ACCOUNT_NUMBER, 
	EXTERNAL_INVESTOR_BANK_CODE, EXTERNAL_INVESTOR_CODE, EXTERNAL_INVESTOR_GROUP_CODE, LAST_IMPORT_DATE, BRANCH_SERIAL, OPEN_DATE, OPENED_BY_USER_SERIAL, CLOSE_DATE, 
	CLOSE_REASON_SERIAL, SHADOW_DATE, SHADOW_BALANCE, SHADOW_INTEREST, SHADOW_LATE_FEE, CHARGE_OFF_DATE, CHARGE_OFF_TYPE_SERIAL, CHARGE_OFF_AMOUNT, COLLECTION_STATUS, 
	COLLECTION_HANDLING, COLLECTION_NOTICE_COUNT, COLLECTION_NOTICE_DATE, BANKRUPTCY_INDICATOR, CRED_REP_PRIMARY_ECOA_CODE, CRED_REP_PRIMARY_CONS_INFO_IND, 
	CRED_REP_BANKRUPTCY_DATE, CRED_REP_ACCOUNT_TYPE, CRED_REP_PORTFOLIO_TYPE_OVR, CRED_REP_SPEC_COMM_CODE, CRED_REP_COMP_COND_CODE, CRED_REP_FIRST_DQ_DATE, 
	CRED_REP_ACCOUNT_STATUS, CRED_REP_PMT_HISTORY_PROFILE, CRED_REP_LAST_DATE, SHARED_BRANCH_OPTION, NOTE_RESTRICTION, MONETARY_PURGE_DATE, LAST_MONETARY_DATE, 
	LAST_ACTIVITY_DATE, LAST_ADVANCE_DATE, MATURITY_DATE, PURPOSE_SERIAL, PROCESSOR_USER_SERIAL, APPROVAL_OFFICER_SERIAL, APPROVAL_DATE, APPLICATION_SERIAL, 
	CREDIT_SCORE_CATEGORY, CREDIT_SCORE, PAPER_GRADE_SERIAL, COLLATERAL_TYPE_SERIAL, NOTE_NUMBER, BALANCE, UNAPPLIED_FUNDS_BALANCE, MINIMUM_BALANCE, MINIMUM_ADVANCE, 
	DOWN_PAYMENT, MASTER_LINE_SERIAL, CREDIT_LIMIT, CREDIT_LIMIT_EXPIRATION_DATE, CREDIT_LIMIT_SHARED_GRP_SERIAL, CC_CASH_ADV_LIMIT_PERCENTAGE, CC_CASH_ADV_LIMIT_AMOUNT, 
	POSITIVE_PAY_OPTION, DRAW_PERIOD_EXPIRATION_DATE, DRAW_PERIOD_STATUS, NON_REVOLVING_BALANCE, MAX_VALUATION_CREDIT_LIMIT, ORIGINAL_LOAN_DATE, ORIGINAL_FUNDING_DATE, 
	ORIGINAL_DUE_DATE, ORIGINAL_BALANCE, ACQUISITION_DATE, ACQUISITION_BALANCE, SHARE_SECURED_OPTION, SHARE_SECURED_AMOUNT, PAYMENT_METHOD, PAYMENT_COUPON_DATE, 
	PAYMENT_AMOUNT, PAYMENT_PARTIAL_AMOUNT, PAYMENT_CALCULATION_SERIAL, PAYMENT_CALCULATION_STATUS, PAYMENT_CALCULATION_SCH_FREQ, PAYMENT_CALCULATION_SCH_FREQ_1, 
	PAYMENT_CALCULATION_SCH_PERIOD, PAYMENT_CALCULATION_SCH_DATE, PAYMENT_COUNT_SCHEDULED, PAYMENT_COUNT_MADE, PAYMENT_COUNT_DQ_UNDER_30, PAYMENT_COUNT_DQ_30_TO_59, 
	PAYMENT_COUNT_DQ_60_TO_89, PAYMENT_COUNT_DQ_90_TO_119, PAYMENT_COUNT_DQ_120_AND_UP, PAYMENT_LAST_DATE, PAYMENT_FREQUENCY, PAYMENT_FREQUENCY_DAY_1, 
	PAYMENT_FREQUENCY_DAY_2, PAYMENT_SKIP_COUNT, PAYMENT_SKIP_START_MONTH, PAYMENT_SKIP_START_DAY, PAYMENT_AHEAD, PAYMENT_AHEAD_COUNT, PAYMENT_DUE_DATE, 
	ACH_PAYMENT_LAST_AMOUNT, ACH_PAYMENT_LAST_DATE, BALLOON_DATE, BALLOON_AMOUNT, INTEREST_PAID_TOTAL, INTEREST_UNPAID, INTEREST_ONLY_UNPAID, INTEREST_PREPAID, 
	INTEREST_CALCULATION_DATE, INTEREST_RATE, INTEREST_APR, INTEREST_RATE_VAR_OPT, INTEREST_RATE_INDEX_SERIAL, INTEREST_RATE_MARGIN, INTEREST_RATE_DISCOUNT, 
	INTEREST_RATE_RISK_PREMIUM, INTEREST_RATE_MINIMUM, INTEREST_RATE_MAXIMUM, INTEREST_RATE_CHG_START_DATE, INTEREST_RATE_CHG_SCH_FREQ, INTEREST_RATE_CHG_SCH_FREQ_1, 
	INTEREST_RATE_CHG_SCH_FREQ_2, INTEREST_RATE_CHG_SCH_PERIOD, INTEREST_RATE_CHG_SCH_DATE, INTEREST_RATE_CHG_SCH_RND_INC, INTEREST_RATE_CHG_SCH_RND_OPT, 
	INTEREST_RATE_CAP_FREQUENCY, INTEREST_RATE_CAP_PERIOD, INTEREST_RATE_CAP_DIRECTION, INTEREST_RATE_CAP_START_DATE, INTEREST_RATE_CAP_START_RATE, INTEREST_RATE_CAP, 
	INTEREST_RATE_ADJUSTMENT, INTEREST_RATE_ADJ_RSN_SERIAL, LATE_FEE_UNPAID, LATE_FEE_CALCULATION_SERIAL, LATE_FEE_CALCULATION_DATE, LATE_FEE_CALCULATION_ACCR, 
	MAINTENANCE_FEE_SERIAL, MAINTENANCE_FEE_EFFECT_DATE, MAINTENANCE_FEE_EXPIRE_DATE, MAINTENANCE_FEE_UNPAID, IMPOUND_AMOUNT, IMPOUND_PARTIAL_AMOUNT, IMPOUND_SHARE_SERIAL, 
	FASB_91_TYPE_SERIAL, FASB_91_ORIGINAL_APR, FASB_91_EFFECTIVE_APR, FASB_91_UNAMORTIZED_FEES, FASB_91_AMORTIZATION_AMOUNT, FASB_91_FUNDING_OPTION, 
	MAIL_PERSON_ADDR_LINK_SERIAL, STMT_MAIL_GROUP_SERIAL, STMT_CUTOFF_GROUP_SERIAL, STMT_CUTOFF_LAST_DATE, STMT_CUTOFF_LAST_TRAN_SERIAL, STMT_CUTOFF_PRIOR_DATE, 
	STMT_CUTOFF_PRIOR_TRAN_SERIAL, STMT_REG_E_COUNT, CC_PURCH_BAL_OLD, CC_PURCH_BAL_NEW, CC_PURCH_AVG_BAL, CC_PURCH_INT_RATE, CC_PURCH_INT_RATE_VAR_OPT, 
	CC_PURCH_INT_CHARGE, CC_PURCH_INT_UNPAID_OLD, CC_PURCH_INT_UNPAID_NEW, CC_PURCH_GRACE_IND_OLD, CC_PURCH_GRACE_IND_NEW, CC_CASH_ADV_BAL_OLD, CC_CASH_ADV_BAL_NEW, 
	CC_CASH_ADV_AVG_BAL, CC_CASH_ADV_INT_RATE, CC_CASH_ADV_INT_RATE_VAR_OPT, CC_CASH_ADV_INT_CHARGE, CC_CASH_ADV_INT_UNPAID_OLD, CC_CASH_ADV_INT_UNPAID_NEW, 
	CC_CASH_ADV_GRACE_IND_OLD, CC_CASH_ADV_GRACE_IND_NEW, CC_BAL_XFR_BAL_OLD, CC_BAL_XFR_BAL_NEW, CC_BAL_XFR_AVG_BAL, CC_BAL_XFR_INT_RATE, CC_BAL_XFR_INT_RATE_VAR_OPT, 
	CC_BAL_XFR_INT_CHARGE, CC_BAL_XFR_INT_UNPAID_OLD, CC_BAL_XFR_INT_UNPAID_NEW, CC_BAL_XFR_GRACE_IND_OLD, CC_BAL_XFR_GRACE_IND_NEW, CC_FEE_BAL_OLD, CC_FEE_BAL_NEW, 
	CC_TOTAL_BAL_OLD, CC_TOTAL_BAL_NEW, CC_FIRST_YEAR_FEES_MAXIMUM, CC_FIRST_YEAR_FEES_CHARGED, CC_PENALTY_INT_RATE, PROMO_RATE_TYPE_SERIAL, SEGMENT_COUNT_LIMIT, 
	TAX_PERSON_SERIAL, MLA_LIMITATION, PARTICIPATION_POOL_SERIAL, LIFE_INSURANCE_SERIAL, DISABILITY_INSURANCE_SERIAL, SINGLE_PREMIUM_LIFE, SINGLE_PREMIUM_DISABILITY, 
	INSURANCE_METHOD, INSURANCE_SHARE_SERIAL, ROW_CHANGE_TIMESTAMP, SHARED_COLLATERAL_OPTION, CRED_REP_PRIMARY_CONS_FIN_DATE	
	FROM CTE
	WHERE rn = 1;

	-- DUPE CHECK / DELETE 
	DELETE FROM RRCU_STG_DEV.KEYSTONE_CORE.T_KS_LOAN_STG_CF USING (
    	WITH CTE_DUP AS
    	(
    	SELECT SERIAL,
	 	ROW_NUMBER () OVER ( PARTITION BY SERIAL ORDER BY SERIAL) AS RN
	 	FROM RRCU_STG_DEV.KEYSTONE_CORE.T_KS_LOAN_STG_CF
    	)
        SELECT SERIAL, RN FROM CTE_DUP
        ) AS CTE_RESULT
	WHERE CTE_RESULT.RN > 1;
	

	-- ADD PRIMARY KEY BACK

	ALTER TABLE RRCU_STG_DEV.KEYSTONE_CORE.T_KS_LOAN_STG_CF ADD PRIMARY KEY (SERIAL);

	-- Expiration for records not coming back into resultset
	UPDATE RRCU_DW_DEV.DW.T_KS_LOAN_DW_CF
	SET LOAN_CURR_IND = 0
	, LOAN_EXP_DT = CURRENT_DATE
	WHERE LOAN_CURR_IND = 1
	AND LOAN_SERIAL NOT IN (SELECT SERIAL FROM RRCU_STG_DEV.KEYSTONE_CORE.T_KS_LOAN_STG_CF);

	DROP TABLE IF EXISTS RRCU_STG_DEV.KEYSTONE_CORE.Update_STG;

	CREATE TEMPORARY TABLE RRCU_STG_DEV.KEYSTONE_CORE.Update_STG(
	LOAN_REC_KEY BIGINT,
	STG_SOURCEHASH2 VARCHAR(32),
	NEW_SOURCEHASH2 VARCHAR(32),
	IS_TYPE2 INT,  -- REPRESENTS TYPE 2
	IS_NEW INT -- INDICATION FOR NEW RECORD TYPE 2
	);


	INSERT INTO RRCU_STG_DEV.KEYSTONE_CORE.Update_STG (
	LOAN_REC_KEY,
	STG_SOURCEHASH2,
	NEW_SOURCEHASH2,
	IS_NEW,
	IS_TYPE2	
	)
	
	WITH CTE_COMPARE AS
	(
	SELECT dim.LOAN_REC_KEY ,  dim.LOAN_SOURCEHASH2, stg.sourcehash2,
	CASE WHEN dim.LOAN_REC_KEY IS NULL THEN 1 ELSE 0 END CASE,
	CASE WHEN dim.LOAN_REC_KEY IS NOT NULL AND stg.SOURCEHASH2 <> dim.LOAN_SOURCEHASH2 THEN 1 ELSE 0 END CASE
	FROM RRCU_STG_DEV.KEYSTONE_CORE.T_KS_LOAN_STG_CF stg
	LEFT OUTER JOIN RRCU_DW_DEV.DW.T_KS_LOAN_DW_CF dim ON dim.LOAN_SERIAL = stg.SERIAL AND dim.LOAN_CURR_IND  = 1
	)
	SELECT *
	FROM CTE_COMPARE;

	UPDATE RRCU_STG_DEV.KEYSTONE_CORE.T_KS_LOAN_STG_CF a
	SET LOAN_REC_KEY = b.LOAN_REC_KEY,
	ISNEW = b.IS_NEW,
	ISTYPE2 = b.IS_TYPE2
	FROM (SELECT LOAN_REC_KEY, IS_NEW, IS_TYPE2, NEW_SOURCEHASH2 FROM RRCU_STG_DEV.KEYSTONE_CORE.Update_STG) b
	WHERE a.SOURCEHASH2 = b.NEW_SOURCEHASH2 AND a.LOAN_REC_KEY IS NULL;

	-- Expiration for records type 2
	
    UPDATE RRCU_DW_DEV.DW.T_KS_LOAN_DW_CF
	SET LOAN_CURR_IND = 0
	, LOAN_EXP_DT = CURRENT_DATE
	WHERE LOAN_CURR_IND = 1
	AND LOAN_SERIAL IN (SELECT SERIAL FROM RRCU_STG_DEV.KEYSTONE_CORE.T_KS_LOAN_STG_CF WHERE ISTYPE2 = 1); 
	

	INSERT INTO RRCU_DW_DEV.DW.T_KS_LOAN_DW_CF
	(
	LOAN_SERIAL, 
	LOAN_CURR_IND, 
	LOAN_EFF_DT, 
	LOAN_EXP_DT, 
	--LOAN_MOD_DT, 
	LOAN_SOURCEHASH2, 
	LOAN_PARENT_SERIAL, 
	LOAN_STORED_ACCESS_KEY, 
	LOAN_ORDINAL, 
	LOAN_LAST_FM_DATE, 
	LOAN_ID, 
	LOAN_DESCRIPTION, 
	LOAN_TYPE_SERIAL, 
	LOAN_PROCESSING, 
	LOAN_EXTERNAL_ACCOUNT_NUMBER, 
	LOAN_EXTERNAL_INVESTOR_BANK_CODE, 
	LOAN_EXTERNAL_INVESTOR_CODE, 
	LOAN_EXTERNAL_INVESTOR_GROUP_CODE, 
	LOAN_LAST_IMPORT_DATE,
	LOAN_BRANCH_SERIAL, 
	LOAN_OPEN_DATE, 
	LOAN_OPENED_BY_USER_SERIAL, 
	LOAN_CLOSE_DATE, 
	LOAN_CLOSE_REASON_SERIAL, 
	LOAN_SHADOW_DATE, 
	LOAN_SHADOW_BALANCE, 
	LOAN_SHADOW_INTEREST, 
	LOAN_SHADOW_LATE_FEE, 
	LOAN_CHARGE_OFF_DATE, 
	LOAN_CHARGE_OFF_TYPE_SERIAL, 
	LOAN_CHARGE_OFF_AMOUNT, 
	LOAN_COLLECTION_STATUS, 
	LOAN_COLLECTION_HANDLING, 
	LOAN_COLLECTION_NOTICE_COUNT, 
	LOAN_COLLECTION_NOTICE_DATE, 
	LOAN_BANKRUPTCY_INDICATOR, 
	LOAN_CRED_REP_PRIMARY_ECOA_CODE, 
	LOAN_CRED_REP_PRIMARY_CONS_INFO_IND, 
	LOAN_CRED_REP_BANKRUPTCY_DATE, 
	LOAN_CRED_REP_ACCOUNT_TYPE, 
	LOAN_CRED_REP_PORTFOLIO_TYPE_OVR, 
	LOAN_CRED_REP_SPEC_COMM_CODE, 
	LOAN_CRED_REP_COMP_COND_CODE, 
	LOAN_CRED_REP_FIRST_DQ_DATE, 
	LOAN_CRED_REP_ACCOUNT_STATUS, 
	LOAN_CRED_REP_PMT_HISTORY_PROFILE, 
	LOAN_CRED_REP_LAST_DATE, 
	LOAN_SHARED_BRANCH_OPTION, 
	LOAN_NOTE_RESTRICTION, 
	LOAN_MONETARY_PURGE_DATE, 
	LOAN_LAST_MONETARY_DATE, 
	LOAN_LAST_ACTIVITY_DATE, 
	LOAN_LAST_ADVANCE_DATE, 
	LOAN_MATURITY_DATE, 
	LOAN_PURPOSE_SERIAL, 
	LOAN_PROCESSOR_USER_SERIAL, 
	LOAN_APPROVAL_OFFICER_SERIAL, 
	LOAN_APPROVAL_DATE, 
	LOAN_APPLICATION_SERIAL, 
	LOAN_CREDIT_SCORE_CATEGORY, 
	LOAN_CREDIT_SCORE, 
	LOAN_PAPER_GRADE_SERIAL, 
	LOAN_COLLATERAL_TYPE_SERIAL, 
	LOAN_NOTE_NUMBER, 
	LOAN_BALANCE, 
	LOAN_UNAPPLIED_FUNDS_BALANCE, 
	LOAN_MINIMUM_BALANCE, 
	LOAN_MINIMUM_ADVANCE, 
	LOAN_DOWN_PAYMENT, 
	LOAN_MASTER_LINE_SERIAL, 
	LOAN_CREDIT_LIMIT, 
	LOAN_CREDIT_LIMIT_EXPIRATION_DATE, 
	LOAN_CREDIT_LIMIT_SHARED_GRP_SERIAL, 
	LOAN_CC_CASH_ADV_LIMIT_PERCENTAGE, 
	LOAN_CC_CASH_ADV_LIMIT_AMOUNT, 
	LOAN_POSITIVE_PAY_OPTION, 
	LOAN_DRAW_PERIOD_EXPIRATION_DATE, 
	LOAN_DRAW_PERIOD_STATUS, 
	LOAN_NON_REVOLVING_BALANCE, 
	LOAN_MAX_VALUATION_CREDIT_LIMIT, 
	LOAN_ORIGINAL_LOAN_DATE, 
	LOAN_ORIGINAL_FUNDING_DATE, 
	LOAN_ORIGINAL_DUE_DATE, 
	LOAN_ORIGINAL_BALANCE, 
	LOAN_ACQUISITION_DATE, 
	LOAN_ACQUISITION_BALANCE, 
	LOAN_SHARE_SECURED_OPTION, 
	LOAN_SHARE_SECURED_AMOUNT, 
	LOAN_PAYMENT_METHOD, 
	LOAN_PAYMENT_COUPON_DATE, 
	LOAN_PAYMENT_AMOUNT, 
	LOAN_PAYMENT_PARTIAL_AMOUNT, 
	LOAN_PAYMENT_CALCULATION_SERIAL, 
	LOAN_PAYMENT_CALCULATION_STATUS, 
	LOAN_PAYMENT_CALCULATION_SCH_FREQ, 
	LOAN_PAYMENT_CALCULATION_SCH_FREQ_1, 
	LOAN_PAYMENT_CALCULATION_SCH_PERIOD, 
	LOAN_PAYMENT_CALCULATION_SCH_DATE, 
	LOAN_PAYMENT_COUNT_SCHEDULED, 
	LOAN_PAYMENT_COUNT_MADE, 
	LOAN_PAYMENT_COUNT_DQ_UNDER_30, 
	LOAN_PAYMENT_COUNT_DQ_30_TO_59, 
	LOAN_LOAN_PAYMENT_COUNT_DQ_60_TO_89, 
	LOAN_PAYMENT_COUNT_DQ_90_TO_119, 
	LOAN_PAYMENT_COUNT_DQ_120_AND_UP, 
	LOAN_PAYMENT_LAST_DATE, 
	LOAN_PAYMENT_FREQUENCY, 
	LOAN_PAYMENT_FREQUENCY_DAY_1, 
	LOAN_PAYMENT_FREQUENCY_DAY_2, 
	LOAN_PAYMENT_SKIP_COUNT, 
	LOAN_PAYMENT_SKIP_START_MONTH, 
	LOAN_PAYMENT_SKIP_START_DAY, 
	LOAN_PAYMENT_AHEAD,
	LOAN_PAYMENT_AHEAD_COUNT, 
	LOAN_PAYMENT_DUE_DATE, 
	LOAN_ACH_PAYMENT_LAST_AMOUNT, 
	LOAN_ACH_PAYMENT_LAST_DATE, 
	LOAN_BALLOON_DATE, 
	LOAN_BALLOON_AMOUNT, 
	LOAN_INTEREST_PAID_TOTAL, 
	LOAN_INTEREST_UNPAID, 
	LOAN_INTEREST_ONLY_UNPAID, 
	LOAN_INTEREST_PREPAID, 
	LOAN_INTEREST_CALCULATION_DATE, 
	LOAN_INTEREST_RATE,
	LOAN_INTEREST_APR, 
	LOAN_INTEREST_RATE_VAR_OPT, 
	LOAN_INTEREST_RATE_INDEX_SERIAL, 
	LOAN_INTEREST_RATE_MARGIN,
	LOAN_INTEREST_RATE_DISCOUNT, 
	LOAN_INTEREST_RATE_RISK_PREMIUM, 
	LOAN_INTEREST_RATE_MINIMUM, 
	LOAN_INTEREST_RATE_MAXIMUM, 
	LOAN_INTEREST_RATE_CHG_START_DATE, 
	LOAN_INTEREST_RATE_CHG_SCH_FREQ, 
	LOAN_INTEREST_RATE_CHG_SCH_FREQ_1, 
	LOAN_INTEREST_RATE_CHG_SCH_FREQ_2, 
	LOAN_INTEREST_RATE_CHG_SCH_PERIOD, 
	LOAN_INTEREST_RATE_CHG_SCH_DATE, 
	LOAN_INTEREST_RATE_CHG_SCH_RND_INC, 
	LOAN_INTEREST_RATE_CHG_SCH_RND_OPT, 
	LOAN_INTEREST_RATE_CAP_FREQUENCY, 
	LOAN_INTEREST_RATE_CAP_PERIOD, 
	LOAN_INTEREST_RATE_CAP_DIRECTION, 
	LOAN_INTEREST_RATE_CAP_START_DATE, 
	LOAN_INTEREST_RATE_CAP_START_RATE, 
	LOAN_INTEREST_RATE_CAP, 
	LOAN_INTEREST_RATE_ADJUSTMENT, 
	LOAN_INTEREST_RATE_ADJ_RSN_SERIAL, 
	LOAN_LATE_FEE_UNPAID, 
	LOAN_LATE_FEE_CALCULATION_SERIAL, 
	LOAN_LATE_FEE_CALCULATION_DATE, 
	LOAN_LATE_FEE_CALCULATION_ACCR, 
	LOAN_MAINTENANCE_FEE_SERIAL, 
	LOAN_MAINTENANCE_FEE_EFFECT_DATE, 
	LOAN_MAINTENANCE_FEE_EXPIRE_DATE, 
	LOAN_MAINTENANCE_FEE_UNPAID, 
	LOAN_IMPOUND_AMOUNT, 
	LOAN_IMPOUND_PARTIAL_AMOUNT, 
	LOAN_IMPOUND_SHARE_SERIAL, 
	LOAN_FASB_91_TYPE_SERIAL, 
	LOAN_FASB_91_ORIGINAL_APR, 
	LOAN_FASB_91_EFFECTIVE_APR, 
	LOAN_FASB_91_UNAMORTIZED_FEES, 
	LOAN_FASB_91_AMORTIZATION_AMOUNT, 
	LOAN_FASB_91_FUNDING_OPTION, 
	LOAN_MAIL_PERSON_ADDR_LINK_SERIAL, 
	LOAN_STMT_MAIL_GROUP_SERIAL, 
	LOAN_STMT_CUTOFF_GROUP_SERIAL, 
	LOAN_STMT_CUTOFF_LAST_DATE, 
	LOAN_STMT_CUTOFF_LAST_TRAN_SERIAL, 
	LOAN_STMT_CUTOFF_PRIOR_DATE, 
	LOAN_STMT_CUTOFF_PRIOR_TRAN_SERIAL, 
	LOAN_STMT_REG_E_COUNT, 
	LOAN_CC_PURCH_BAL_OLD, 
	LOAN_CC_PURCH_BAL_NEW, 
	LOAN_CC_PURCH_AVG_BAL, 
	LOAN_CC_PURCH_INT_RATE, 
	LOAN_CC_PURCH_INT_RATE_VAR_OPT, 
	LOAN_CC_PURCH_INT_CHARGE, 
	LOAN_CC_PURCH_INT_UNPAID_OLD, 
	LOAN_CC_PURCH_INT_UNPAID_NEW, 
	LOAN_CC_PURCH_GRACE_IND_OLD, 
	LOAN_CC_PURCH_GRACE_IND_NEW, 
	LOAN_CC_CASH_ADV_BAL_OLD, 
	LOAN_CC_CASH_ADV_BAL_NEW,
	LOAN_CC_CASH_ADV_AVG_BAL, 
	LOAN_CC_CASH_ADV_INT_RATE, 
	LOAN_CC_CASH_ADV_INT_RATE_VAR_OPT, 
	LOAN_CC_CASH_ADV_INT_CHARGE, 
	LOAN_CC_CASH_ADV_INT_UNPAID_OLD, 
	LOAN_CC_CASH_ADV_INT_UNPAID_NEW, 
	LOAN_CC_CASH_ADV_GRACE_IND_OLD, 
	LOAN_CC_CASH_ADV_GRACE_IND_NEW, 
	LOAN_CC_BAL_XFR_BAL_OLD, 
	LOAN_CC_BAL_XFR_BAL_NEW, 
	LOAN_CC_BAL_XFR_AVG_BAL, 
	LOAN_CC_BAL_XFR_INT_RATE, 
	LOAN_CC_BAL_XFR_INT_RATE_VAR_OPT, 
	LOAN_CC_BAL_XFR_INT_CHARGE, 
	LOAN_CC_BAL_XFR_INT_UNPAID_OLD, 
	LOAN_CC_BAL_XFR_INT_UNPAID_NEW, 
	LOAN_CC_BAL_XFR_GRACE_IND_OLD, 
	LOAN_CC_BAL_XFR_GRACE_IND_NEW,
	LOAN_CC_FEE_BAL_OLD, 
	LOAN_CC_FEE_BAL_NEW, 
	LOAN_CC_TOTAL_BAL_OLD, 
	LOAN_CC_TOTAL_BAL_NEW, 
	LOAN_CC_FIRST_YEAR_FEES_MAXIMUM, 
	LOAN_CC_FIRST_YEAR_FEES_CHARGED, 
	LOAN_CC_PENALTY_INT_RATE, 
	LOAN_PROMO_RATE_TYPE_SERIAL, 
	LOAN_SEGMENT_COUNT_LIMIT, 
	LOAN_TAX_PERSON_SERIAL, 
	LOAN_MLA_LIMITATION, 
	LOAN_PARTICIPATION_POOL_SERIAL, 
	LOAN_LIFE_INSURANCE_SERIAL, 
	LOAN_DISABILITY_INSURANCE_SERIAL, 
	LOAN_SINGLE_PREMIUM_LIFE, 
	LOAN_SINGLE_PREMIUM_DISABILITY, 
	LOAN_INSURANCE_METHOD, 
	LOAN_INSURANCE_SHARE_SERIAL, 
	DW_LOAD_DT
	)

	SELECT 
	stg.SERIAL,
	1,
	CURRENT_DATE,
	NULL,
	stg.SOURCEHASH2,
	PARENT_SERIAL, 
	STORED_ACCESS_KEY, 
	ORDINAL, 
	LAST_FM_DATE, 
	ID, 
	DESCRIPTION, 
	TYPE_SERIAL, 
	PROCESSING, 
	EXTERNAL_ACCOUNT_NUMBER,
	EXTERNAL_INVESTOR_BANK_CODE, 
	EXTERNAL_INVESTOR_CODE, 
	EXTERNAL_INVESTOR_GROUP_CODE, 
	LAST_IMPORT_DATE, 
	BRANCH_SERIAL, 
	OPEN_DATE, 
	OPENED_BY_USER_SERIAL, 
	CLOSE_DATE, 
	CLOSE_REASON_SERIAL, 
	SHADOW_DATE, 
	SHADOW_BALANCE,
	SHADOW_INTEREST, 
	SHADOW_LATE_FEE, 
	CHARGE_OFF_DATE, 
	CHARGE_OFF_TYPE_SERIAL, 
	CHARGE_OFF_AMOUNT, 
	COLLECTION_STATUS, 
	COLLECTION_HANDLING, 
	COLLECTION_NOTICE_COUNT, 
	COLLECTION_NOTICE_DATE, 
	BANKRUPTCY_INDICATOR, 
	CRED_REP_PRIMARY_ECOA_CODE, 
	CRED_REP_PRIMARY_CONS_INFO_IND,
	CRED_REP_BANKRUPTCY_DATE, 
	CRED_REP_ACCOUNT_TYPE, 
	CRED_REP_PORTFOLIO_TYPE_OVR, 
	CRED_REP_SPEC_COMM_CODE, 
	CRED_REP_COMP_COND_CODE, 
	CRED_REP_FIRST_DQ_DATE, 
	CRED_REP_ACCOUNT_STATUS, 
	CRED_REP_PMT_HISTORY_PROFILE, 
	CRED_REP_LAST_DATE, 
	SHARED_BRANCH_OPTION, 
	NOTE_RESTRICTION, 
	MONETARY_PURGE_DATE, 
	LAST_MONETARY_DATE, 
	LAST_ACTIVITY_DATE, 
	LAST_ADVANCE_DATE,
	MATURITY_DATE, 
	PURPOSE_SERIAL, 
	PROCESSOR_USER_SERIAL, 
	APPROVAL_OFFICER_SERIAL, 
	APPROVAL_DATE, 
	APPLICATION_SERIAL, 
	CREDIT_SCORE_CATEGORY, 
	CREDIT_SCORE, 
	PAPER_GRADE_SERIAL, 
	COLLATERAL_TYPE_SERIAL, 
	NOTE_NUMBER, 
	BALANCE,
	UNAPPLIED_FUNDS_BALANCE, 
	MINIMUM_BALANCE, 
	MINIMUM_ADVANCE, 
	DOWN_PAYMENT, 
	MASTER_LINE_SERIAL, 
	CREDIT_LIMIT, 
	CREDIT_LIMIT_EXPIRATION_DATE, 
	CREDIT_LIMIT_SHARED_GRP_SERIAL, 
	CC_CASH_ADV_LIMIT_PERCENTAGE, 
	CC_CASH_ADV_LIMIT_AMOUNT, 
	POSITIVE_PAY_OPTION, 
	DRAW_PERIOD_EXPIRATION_DATE, 
	DRAW_PERIOD_STATUS, 
	NON_REVOLVING_BALANCE, 
	MAX_VALUATION_CREDIT_LIMIT, 
	ORIGINAL_LOAN_DATE, 
	ORIGINAL_FUNDING_DATE, 
	ORIGINAL_DUE_DATE, 
	ORIGINAL_BALANCE,
	ACQUISITION_DATE, 
	ACQUISITION_BALANCE, 
	SHARE_SECURED_OPTION, 
	SHARE_SECURED_AMOUNT, 
	PAYMENT_METHOD, 
	PAYMENT_COUPON_DATE, 
	PAYMENT_AMOUNT, 
	PAYMENT_PARTIAL_AMOUNT, 
	PAYMENT_CALCULATION_SERIAL, 
	PAYMENT_CALCULATION_STATUS, 
	PAYMENT_CALCULATION_SCH_FREQ, 
	PAYMENT_CALCULATION_SCH_FREQ_1, 
	PAYMENT_CALCULATION_SCH_PERIOD, 
	PAYMENT_CALCULATION_SCH_DATE, 
	PAYMENT_COUNT_SCHEDULED, 
	PAYMENT_COUNT_MADE, 
	PAYMENT_COUNT_DQ_UNDER_30, 
	PAYMENT_COUNT_DQ_30_TO_59,
	PAYMENT_COUNT_DQ_60_TO_89, 
	PAYMENT_COUNT_DQ_90_TO_119, 
	PAYMENT_COUNT_DQ_120_AND_UP, 
	PAYMENT_LAST_DATE, 
	PAYMENT_FREQUENCY, 
	PAYMENT_FREQUENCY_DAY_1, 
	PAYMENT_FREQUENCY_DAY_2, 
	PAYMENT_SKIP_COUNT, 
	PAYMENT_SKIP_START_MONTH, 
	PAYMENT_SKIP_START_DAY, 
	PAYMENT_AHEAD, 
	PAYMENT_AHEAD_COUNT, 
	PAYMENT_DUE_DATE, 
	ACH_PAYMENT_LAST_AMOUNT, 
	ACH_PAYMENT_LAST_DATE, 
	BALLOON_DATE, 
	BALLOON_AMOUNT, 
	INTEREST_PAID_TOTAL, 
	INTEREST_UNPAID, 
	INTEREST_ONLY_UNPAID, 
	INTEREST_PREPAID, 
	INTEREST_CALCULATION_DATE, 
	INTEREST_RATE, 
	INTEREST_APR, 
	INTEREST_RATE_VAR_OPT, 
	INTEREST_RATE_INDEX_SERIAL, 
	INTEREST_RATE_MARGIN, 
	INTEREST_RATE_DISCOUNT, 
	INTEREST_RATE_RISK_PREMIUM, 
	INTEREST_RATE_MINIMUM, 
	INTEREST_RATE_MAXIMUM, 
	INTEREST_RATE_CHG_START_DATE, 
	INTEREST_RATE_CHG_SCH_FREQ, 
	INTEREST_RATE_CHG_SCH_FREQ_1, 
	INTEREST_RATE_CHG_SCH_FREQ_2, 
	INTEREST_RATE_CHG_SCH_PERIOD, 
	INTEREST_RATE_CHG_SCH_DATE, 
	INTEREST_RATE_CHG_SCH_RND_INC, 
	INTEREST_RATE_CHG_SCH_RND_OPT, 
	INTEREST_RATE_CAP_FREQUENCY, 
	INTEREST_RATE_CAP_PERIOD, 
	INTEREST_RATE_CAP_DIRECTION, 
	INTEREST_RATE_CAP_START_DATE, 
	INTEREST_RATE_CAP_START_RATE, 
	INTEREST_RATE_CAP, 
	INTEREST_RATE_ADJUSTMENT, 
	INTEREST_RATE_ADJ_RSN_SERIAL, 
	LATE_FEE_UNPAID, 
	LATE_FEE_CALCULATION_SERIAL, 
	LATE_FEE_CALCULATION_DATE, 
	LATE_FEE_CALCULATION_ACCR, 
	MAINTENANCE_FEE_SERIAL, 
	MAINTENANCE_FEE_EFFECT_DATE, 
	MAINTENANCE_FEE_EXPIRE_DATE, 
	MAINTENANCE_FEE_UNPAID, 
	IMPOUND_AMOUNT, 
	IMPOUND_PARTIAL_AMOUNT, 
	IMPOUND_SHARE_SERIAL, 
	FASB_91_TYPE_SERIAL, 
	FASB_91_ORIGINAL_APR, 
	FASB_91_EFFECTIVE_APR, 
	FASB_91_UNAMORTIZED_FEES, 
	FASB_91_AMORTIZATION_AMOUNT, 
	FASB_91_FUNDING_OPTION, 
	MAIL_PERSON_ADDR_LINK_SERIAL, 
	STMT_MAIL_GROUP_SERIAL, 
	STMT_CUTOFF_GROUP_SERIAL, 
	STMT_CUTOFF_LAST_DATE, 
	STMT_CUTOFF_LAST_TRAN_SERIAL, 
	STMT_CUTOFF_PRIOR_DATE, 
	STMT_CUTOFF_PRIOR_TRAN_SERIAL, 
	STMT_REG_E_COUNT, 
	CC_PURCH_BAL_OLD, 
	CC_PURCH_BAL_NEW, 
	CC_PURCH_AVG_BAL, 
	CC_PURCH_INT_RATE, 
	CC_PURCH_INT_RATE_VAR_OPT, 
	CC_PURCH_INT_CHARGE, 
	CC_PURCH_INT_UNPAID_OLD, 
	CC_PURCH_INT_UNPAID_NEW, 
	CC_PURCH_GRACE_IND_OLD, 
	CC_PURCH_GRACE_IND_NEW, 
	CC_CASH_ADV_BAL_OLD, 
	CC_CASH_ADV_BAL_NEW, 
	CC_CASH_ADV_AVG_BAL, 
	CC_CASH_ADV_INT_RATE, 
	CC_CASH_ADV_INT_RATE_VAR_OPT, 
	CC_CASH_ADV_INT_CHARGE, 
	CC_CASH_ADV_INT_UNPAID_OLD, 
	CC_CASH_ADV_INT_UNPAID_NEW, 
	CC_CASH_ADV_GRACE_IND_OLD, 
	CC_CASH_ADV_GRACE_IND_NEW, 
	CC_BAL_XFR_BAL_OLD, 
	CC_BAL_XFR_BAL_NEW, 
	CC_BAL_XFR_AVG_BAL, 
	CC_BAL_XFR_INT_RATE, 
	CC_BAL_XFR_INT_RATE_VAR_OPT, 
	CC_BAL_XFR_INT_CHARGE, 
	CC_BAL_XFR_INT_UNPAID_OLD, 
	CC_BAL_XFR_INT_UNPAID_NEW, 
	CC_BAL_XFR_GRACE_IND_OLD, 
	CC_BAL_XFR_GRACE_IND_NEW, 
	CC_FEE_BAL_OLD, 
	CC_FEE_BAL_NEW, 
	CC_TOTAL_BAL_OLD, 
	CC_TOTAL_BAL_NEW, 
	CC_FIRST_YEAR_FEES_MAXIMUM,
	CC_FIRST_YEAR_FEES_CHARGED, 
	CC_PENALTY_INT_RATE, 
	PROMO_RATE_TYPE_SERIAL, 
	SEGMENT_COUNT_LIMIT, 
	TAX_PERSON_SERIAL, 
	MLA_LIMITATION, 
	PARTICIPATION_POOL_SERIAL, 
	LIFE_INSURANCE_SERIAL, 
	DISABILITY_INSURANCE_SERIAL, 
	SINGLE_PREMIUM_LIFE, 
	SINGLE_PREMIUM_DISABILITY, 
	INSURANCE_METHOD, 
	INSURANCE_SHARE_SERIAL, 
	CURRENT_DATE
	FROM RRCU_STG_DEV.KEYSTONE_CORE.T_KS_LOAN_STG_CF stg
		WHERE ISNEW = 1 OR ISTYPE2 = 1;

	-- Business rules around dates for current records
	UPDATE RRCU_DW_DEV.DW.T_KS_LOAN_DW_CF
	SET LOAN_CURR_IND = 0
	, LOAN_EXP_DT = CURRENT_DATE
	WHERE LOAN_CLOSE_DATE <= CURRENT_DATE
	AND LOAN_CURR_IND = 1;

	UPDATE RRCU_DW_DEV.DW.T_KS_LOAN_DW_CF
	SET LOAN_CURR_IND = 0
	, LOAN_EXP_DT = CURRENT_DATE
	WHERE LOAN_MATURITY_DATE <= CURRENT_DATE
	AND LOAN_CURR_IND = 1;

	UPDATE RRCU_DW_DEV.DW.T_KS_LOAN_DW_CF
	SET LOAN_CURR_IND = 0
	, LOAN_EXP_DT = CURRENT_DATE
	WHERE LOAN_CHARGE_OFF_DATE  <= CURRENT_DATE
	AND LOAN_CURR_IND = 1;

END;
$$
;
