
FUNCTION_BLOCK Gen_Device
	
	//Clock Handling
	
	IF (Dev_Clock AND (Dev_Timer > 0)) THEN
		Dev_Timer := Dev_Timer - 1;
	END_IF
	
	
	//Device Initialization Handling
	
	CASE (Dev_Type AND Dev_Feedback_Mask) OF
		
		Dev_With_Enable_Feedback:
			Dev_Disabled_Sensor	:= NOT Dev_Enabled_Sensor AND 
			((Dev_State 		 = Dev_Disabled_State) OR 
			(Dev_State 			 = Dev_Disable_Phase_State AND Dev_Timeout));
			
			Dev_Disable 		:= NOT Dev_Enable AND
			((Dev_State			 = Dev_Disabled_State) OR 
			(Dev_State 			 = Dev_Disable_Phase_State AND Dev_Timeout));
			
		Dev_With_Disable_Feedback:
			Dev_Enable 		:= NOT Dev_Disable AND
			((Dev_State 		 = Dev_Enabled_State) OR
			(Dev_State 			 = Dev_Enable_Phase_State AND Dev_Timeout));

			Dev_Enabled_Sensor 	:= NOT Dev_Disabled_Sensor AND
			((Dev_State 		 = Dev_Enabled_State) OR
			(Dev_State 			 = Dev_Enable_Phase_State AND Dev_Timeout));
						
		Dev_Without_Feedback:
			Dev_Enable 		:= (Dev_State = Dev_Enabled_State) OR
			(Dev_State 			 = Dev_Enable_Phase_State AND Dev_Timeout);
			Dev_Disable 		:= (Dev_State = Dev_Disabled_State) OR
			(Dev_State 			 = Dev_Disable_Phase_State AND Dev_Timeout);

			Dev_Enabled_Sensor  := (Dev_State = Dev_Enabled_State) OR
			((Dev_State 		 = Dev_Enable_Phase_State) AND Dev_Timeout);
			Dev_Disabled_Sensor := (Dev_State = Dev_Disabled_State) OR
			((Dev_State			 = Dev_Disable_Phase_State) AND Dev_Timeout);
	END_CASE
		
	// Device Sensor Handler
	IF (Dev_Operation = INIT) THEN
		
		CASE (Dev_Type AND Dev_Feedback_Mask) OF
			Dev_With_Enable_Feedback:
				Dev_Disable 	:= NOT Dev_Enable;
			
			Dev_With_Disable_Feedback:
				Dev_Enable 	:=  NOT Dev_Disable;
			
			Dev_Without_Feedback:
				Dev_Enable 	:= Dev_Enable_Preset;
				Dev_Disable 	:= NOT Dev_Enable;			
		END_CASE
		
		Dev_Enable_Request 		:= FALSE;
		Dev_Disable_Request 	:= FALSE;
		IF (Dev_Enable_Preset) THEN
			Dev_Enabled 			:= TRUE;
			Dev_Timer 			:= Dev_Enable_Time;
			IF NOT (Dev_Disable AND Dev_Enable) THEN
				Dev_State 		:= Dev_Enable_Phase_State;
			ELSE
				Dev_State 		:= Dev_Enabled_State;
			END_IF
			Dev_Not_Initialized := NOT Dev_Enable OR Dev_Disable;
			
		ELSE
			Dev_Enabled			:= FALSE;
			Dev_Timer 			:= Dev_Disable_Time;
			IF NOT (Dev_Disable AND Dev_Enable) THEN
				Dev_State 		:= Dev_Disable_Phase_State;
			ELSE
				Dev_State 		:= Dev_Disabled_State;
			END_IF
			Dev_Not_Initialized := (Dev_Enable OR NOT Dev_Disable);
			
		END_IF
	END_IF
	
	// Device Control Handling
	
	CASE (Dev_State) OF
		
		Dev_Disabled_State:
			Dev_Disable_Request := FALSE;
			IF Dev_Enable_Request THEN
				Dev_Enabled 		:= TRUE;
				Dev_Timer 		:= Dev_Enable_Time;
				Dev_State 		:= Dev_Enable_Phase_State;
			END_IF
			
		Dev_Enable_Phase_State:
			IF Dev_Disable_Request THEN
				Dev_Enable_Request 	:= FALSE;
				Dev_Enabled 			:= FALSE;
				Dev_Timer 			:= Dev_Disable_Time;
				Dev_State 			:= Dev_Disable_Phase_State;
			END_IF
			
			IF Dev_Enabled_Sensor THEN
				Dev_Enable_Request 	:= FALSE;
				Dev_Timer 			:= 0;
				Dev_State 			:= Dev_Enabled_State;
			END_IF
			
		Dev_Enabled_State:
			Dev_Enable_Request	:= FALSE;
			IF Dev_Disable_Request THEN
				Dev_Enabled 		:= FALSE;
				Dev_Timer 		:= Dev_Disable_Time;
				Dev_State 		:= Dev_Disable_Phase_State;
			END_IF
			
		Dev_Disable_Phase_State:
			IF Dev_Enable_Request THEN
				Dev_Disable_Request := FALSE;
				Dev_Enabled 			:= TRUE;
				Dev_Timer 			:= Dev_Enable_Time;
				Dev_State 			:= Dev_Enable_Phase_State;
			END_IF
			
			IF Dev_Disabled_Sensor THEN
				Dev_Disable_Request := FALSE;
				Dev_Timer 			:= 0;
				Dev_State 			:= Dev_Disabled_State;
			END_IF
	END_CASE
	
	// Device Diagnostic Handling
	
	Dev_Timeout 				:= (Dev_Timer = 0);
	Dev_Disabled_Sensor_Fault 	:= ((NOT Dev_Enabled AND NOT Dev_Disabled_Sensor AND NOT Dev_Enabled_Sensor) OR (Dev_Enabled AND Dev_Disabled_Sensor AND Dev_Enabled_Sensor)) AND Dev_Timeout;
	Dev_Enabled_Sensor_Fault 	:= ((NOT Dev_Enabled AND Dev_Disabled_Sensor AND Dev_Enabled_Sensor) OR (Dev_Enabled AND NOT Dev_Disabled_Sensor AND NOT Dev_Enabled_Sensor)) AND Dev_Timeout;
	Dev_Actuator_Fault 			:= ((NOT Dev_Enabled AND NOT Dev_Disabled_Sensor AND Dev_Enabled_Sensor) OR (Dev_Enabled AND Dev_Disabled_Sensor AND NOT Dev_Enabled_Sensor)) AND Dev_Timeout;
	Dev_Fault 					:= Dev_Disabled_Sensor_Fault OR Dev_Enabled_Sensor_Fault OR Dev_Actuator_Fault;
	
	// Device Actuators Handling
	
	CASE (Dev_Type AND Dev_Actuation_Mask) OF
		
		Dev_With_Double_Actuation:
			Dev_Disabled := NOT Dev_Enabled;
		
		Dev_With_DA_No_Retain:
			Dev_Enabled 	:= Dev_Enabled AND (Dev_State = Dev_Enable_Phase_State);
			Dev_Disabled := NOT Dev_Enabled AND (Dev_State = Dev_Disable_Phase_State);
			
	END_CASE
	
	
		
END_FUNCTION_BLOCK

