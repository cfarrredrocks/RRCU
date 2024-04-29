--==================================================================================================
--Author: Farr, C
--Create Date:	2024-04-22  	
--Object Name:	sp_LOAD_T_EXECUTE_DW
--Description:  Data Warehouse Run
--***********************************************************************************************************************
--Date			Trello#					ChangedBy						Description 
------------------------------------------------------------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE RRCU_STG_DEV.KEYSTONE_CORE.sp_LOAD_T_EXECUTE_DW ()
RETURNS VARCHAR NOT NULL
LANGUAGE SQL

AS
$$

BEGIN 
	
------------------------------------------------------------------------------------
-- Execute DW Foundation  (22)
------------------------------------------------------------------------------------

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_AC_NOTE_STG();  -- DONE   4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_ACCOUNT_STG();  -- DONE  4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_ACCOUNT_ELIGIBILITY_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_ACCOUNT_CLOSE_REASON_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_KS_ADDRESS_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_KS_PERSON_ADDRESS_LINK_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_KS_PERSON_CONTACT_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_KS_PERSON_ID_STG();    -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_PERSON_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_USER_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.sp_LOAD_T_LN_TYPE_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_LOAN_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_LOAN_REQUEST_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.sp_LOAD_T_SH_TYPE_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.sp_LOAD_T_SHARE_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.sp_LOAD_T_RENTAL_TYPE_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_RENTAL_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_BRANCH_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_COLLATERAL_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_CU_LOANPROMOCODE_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_CU_SHAREPROMOCODE_STG();  -- DONE 4/19

CALL RRCU_STG_DEV.KEYSTONE_CORE.SP_LOAD_T_LR_DEBT_RATIO_STG();  -- DONE 4/19

------------------------------------------------------------------------------------
-- Execute DIMS
------------------------------------------------------------------------------------

CALL RRCU_DW_DEV.DM.SP_LOAD_T_ACCOUNT_DIM();  -- DONE 4/19

CALL RRCU_DW_DEV.DM.SP_LOAD_T_PERSON_DIM();  -- DONE 4/19

CALL RRCU_DW_DEV.DM.sp_LOAD_T_PRODUCT_GROUP_DIM();  -- DONE 4/19

CALL RRCU_DW_DEV.DM.SP_LOAD_T_PRODUCT_DIM();  -- DONE 4/19

-- MISSING RRCU_DW_DEV.DM.T_PERSON_CONTACT_DIM()

------------------------------------------------------------------------------------
-- Execute FACT
------------------------------------------------------------------------------------

CALL RRCU_DW_DEV.DM.sp_LOAD_T_PRODUCT_FACT();  -- DONE 4/19

END;
$$
;

