
FUNCTION_BLOCK Gen_Device (*Library for all the devices which have BOOL inputs*)
	VAR_INPUT
		Dev_Operation : {REDUND_UNREPLICABLE} INT;
		Dev_Type : {REDUND_UNREPLICABLE} INT;
		Dev_Enabled_Sensor : {REDUND_UNREPLICABLE} BOOL;
		Dev_Disabled_Sensor : {REDUND_UNREPLICABLE} BOOL;
		Dev_Clock : {REDUND_UNREPLICABLE} BOOL;
		Dev_Enable_Time : {REDUND_UNREPLICABLE} INT;
		Dev_Disable_Time : {REDUND_UNREPLICABLE} INT;
		Dev_Diagnose_Enable : {REDUND_UNREPLICABLE} BOOL;
		Dev_Enable_Preset : {REDUND_UNREPLICABLE} BOOL;
		Dev_Enable : {REDUND_UNREPLICABLE} BOOL;
		Dev_Disable : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
	VAR_OUTPUT
		Dev_Enabled : BOOL;
		Dev_Disabled : BOOL;
		Dev_Enabled_Sensor_Fault : BOOL;
		Dev_Disabled_Sensor_Fault : BOOL;
		Dev_Actuator_Fault : BOOL;
		Dev_Fault : BOOL;
		Dev_Not_Initialized : BOOL;
	END_VAR
	VAR_IN_OUT
		Dev_Enable_Request : BOOL;
		Dev_Disable_Request : BOOL;
	END_VAR
	VAR
		Dev_State : {REDUND_UNREPLICABLE} DeviceStateType;
		Dev_Timer : {REDUND_UNREPLICABLE} INT;
		Dev_Timeout : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
	VAR CONSTANT
		INIT : INT := 0;
		RUN : INT := 1;
	END_VAR
END_FUNCTION_BLOCK
