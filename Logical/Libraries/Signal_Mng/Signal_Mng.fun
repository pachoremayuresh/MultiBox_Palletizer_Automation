
FUNCTION_BLOCK Signal_Mng
	VAR_INPUT
		Operation_Type : INT;
		Signal_Type : DINT := 0;
		Signal_Code : INT := 0;
		Signal_Output : DWORD := 0;
		Activation_Signal : BOOL := FALSE;
		Auto_Reset_Signal : BOOL := FALSE;
		Reset : BOOL;
		Key_Reset : BOOL;
	END_VAR
	VAR_OUTPUT
		Signal_Outputs : DWORD;
		Signal_Priority_Code : WORD;
		Reset_Enable : BOOL;
		Aux_Reset_Enable : BOOL;
		Signal_Type_Alarm : BOOL;
		Signal_Type_Anomaly : BOOL;
		Signal_Type_Warning : BOOL;
		Signal_Type_Information : BOOL;
		Number_of_Alarms : INT;
		Number_of_Anomalies : INT;
		Number_of_Warnings : INT;
		Number_of_Information : INT;
		Active_Signal_Codes : ARRAY[1..30] OF INT;
		Number_of_Active_Alarms : INT := 0;
		Number_of_Active_Anomalies : INT := 0;
		Number_of_Active_Warning : INT := 0;
		Number_of_Active_Information : INT := 0;
		Signal_Mng_Error : BOOL;
		First_Signal_Index : INT;
		First_Active_Signal_Index : INT;
		Second_Active_Signal_Index : INT;
		Third_Active_Signal_Index : INT;
		Fourth_Active_Signal_Index : INT;
	END_VAR
	VAR
		Reset_Signals_Enable : BOOL;
		Aux_Reset_Activation : BOOL;
		Reset_Activation : BOOL;
		Signal_Request : BOOL;
		Signal_Ack_Request : BOOL;
		Signals : ARRAY[1..23] OF BOOL;
		Last_Signal_Index : INT;
		Active_Signal_Request : BOOL;
		Active_Signal_Request_Ack : BOOL;
		Last_Active_Signal_Index : INT;
		Reset_Old : BOOL;
		Key_Reset_Old : BOOL;
		Index : INT;
		Base_Index : INT;
		Condition : BOOL := FALSE;
		i : INT;
		Last_Information_Index : INT;
		Last_Anomaly_Index : INT;
		Last_Warning_Index : INT;
		Aux_Reset_Required : BOOL;
		d : INT := 1;
		Active_Signal : ARRAY[0..4] OF INT;
	END_VAR
END_FUNCTION_BLOCK
