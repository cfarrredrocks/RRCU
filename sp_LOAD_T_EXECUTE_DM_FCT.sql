--==================================================================================================
--Author: Farr, C
--Create Date:	2024-04-22  	
--Object Name:	sp_LOAD_T_EXECUTE_DM_FCT
--Description:  Data Warehouse Run
--***********************************************************************************************************************
--Date			Trello#					ChangedBy						Description 
------------------------------------------------------------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE RRCU_DW_DEV.DM.sp_LOAD_T_EXECUTE_DM_FCT ()
RETURNS VARCHAR NOT NULL
LANGUAGE SQL

AS
$$

BEGIN 
	
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



