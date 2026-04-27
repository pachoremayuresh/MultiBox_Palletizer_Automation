
FUNCTION_BLOCK FSM_LED
	VAR_INPUT
		LED_State : STRING[80];
	END_VAR
	VAR_OUTPUT
		LED_Light : BOOL;
	END_VAR
	VAR
		Timer : TON;
		State : INT := 0;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FSM_AXIS (*For Motion of the motors*)
	VAR_INPUT
		Axis_Name : UDINT;
		Deceleration : REAL;
		Velocity : REAL;
		Acceleration : REAL;
		Direction : USINT;
		Distance : REAL;
		Position : REAL;
		Home : BOOL;
		Power : BOOL;
		Move_Velocity : BOOL;
		Move_Absolute : BOOL;
		Move_Additive : BOOL;
		Stop : BOOL;
		Reset_Error : BOOL;
	END_VAR
	VAR_OUTPUT
		Actual_Position : REAL;
		Actual_Velocity : REAL;
		Active : BOOL;
		Power_ON : BOOL;
		Stop_Done : BOOL;
		Is_Homed : BOOL;
		Move_Abs_Done : BOOL;
		Move_Add_Done : BOOL;
		Error : BOOL; (*Code Parameters*)
	END_VAR
	VAR
		MCRS : MC_ReadStatus; (*List of all the PLCOpen libraries*)
		RS_Valid : BOOL;
		RS_Error : BOOL;
		RS_Errorstop : BOOL;
		RS_Disabled : BOOL;
		MCP : MC_Power;
		P_Enable : BOOL;
		P_Status : BOOL;
		P_Error : BOOL;
		MCH : MC_Home;
		H_Execute : BOOL;
		H_Done : BOOL;
		H_Error : BOOL;
		MCS : MC_Stop;
		S_Execute : BOOL;
		S_Done : BOOL;
		S_Error : BOOL;
		MCR : MC_Reset;
		R_Execute : BOOL;
		R_Done : BOOL;
		R_Error : BOOL;
		MCRAP : MC_ReadActualPosition;
		RAP_Valid : BOOL;
		RAP_Error : BOOL;
		MCRAV : MC_ReadActualVelocity;
		RAV_Valid : BOOL;
		RAV_Error : BOOL;
		MCMV : MC_MoveVelocity;
		V_Execute : BOOL;
		V_Error : BOOL;
		MCMAdd : MC_MoveAdditive;
		Add_Execute : BOOL;
		Add_Done : BOOL;
		Add_Error : BOOL;
		MCMA : MC_MoveAbsolute;
		A_Execute : BOOL;
		A_Done : BOOL;
		A_Error : BOOL;
		State : INT := 0;
		Move_Absolute_Old : BOOL;
		Move_Additive_Old : BOOL;
		Old_Velocity : REAL;
	END_VAR
END_FUNCTION_BLOCK
