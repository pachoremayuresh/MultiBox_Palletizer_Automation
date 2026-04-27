
FUNCTION_BLOCK S_filter
	VAR_INPUT
		Sensor_Raw : BOOL;
		Sensor_Data : REAL;
		threshold_F : REAL;
		threshold_B : INT;
		Is_Bool : BOOL;
	END_VAR
	VAR_OUTPUT
		Sensor_Filtered : BOOL;
		Sensor_Data_Filtered : REAL;
	END_VAR
	VAR
		last_State : BOOL := FALSE;
		counter : INT := 0;
		init : BOOL := FALSE;
	END_VAR
END_FUNCTION_BLOCK
