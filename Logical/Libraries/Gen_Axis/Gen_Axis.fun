
FUNCTION_BLOCK Gen_Axis
	VAR_INPUT
		Axis_Command : WORD := 95;
		Axis_Act_Position : REAL;
		Axis_Act_Velocity : REAL;
		New_Set_Point : REAL;
		Axis_Dev_Timer : INT;
		Axis_TGT_Sensor : BOOL;
		Axis_Reset : BOOL;
	END_VAR
	VAR_OUTPUT
		Axis_TGT_Velocity : REAL;
		Axis_TGT_Position : REAL;
		Axis_In_Pos : BOOL;
		Axis_In_Vel : BOOL;
		Axis_Dev_Fault : BOOL;
	END_VAR
	VAR
		Axis_State : AxisStateType := Axis_Check_Command;
		Axis_Timer : INT;
	END_VAR
END_FUNCTION_BLOCK
