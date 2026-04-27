
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	(* Insert code here *)
	CASE State OF
		0: //Initiation
			DI1(LED_State := 'off');
			DI2(LED_State := 'off');
			DI3(LED_State := 'off');
			DI4(LED_State := 'off');
			DI5(LED_State := 'off');
			DI6(LED_State := 'off');
			
			IF M_Active AND Man_Mode_OFF THEN
				State := 2;
			END_IF
			
		1: //Error
			
			DI1(LED_State := 'off');
			DI2(LED_State := 'off');
			DI3(LED_State := 'off');
			DI4(LED_State := 'off');
			DI5(LED_State := 'off');
			DI6(LED_State := 'blink');
			
			Error_Command 	:= TRUE;
			Start_Command 	:= FALSE;
			Stop_Command 	:= TRUE;
			Power_Axis 		:= FALSE;
			
			IF Reset_Trigger AND Error_Trigger THEN
				Reset_Command 	:= TRUE;
				Error_Command 	:= FALSE;			
			ELSIF Reset_Trigger AND NOT Error_Trigger THEN
				Reset_Command 	:= FALSE;
				Error_Command 	:= FALSE;
				State 			:= 2;
			END_IF
			
		2: //Disabled

			IF Error_Trigger THEN
				State 		:= 1;
			ELSIF Reset_Trigger THEN
				Power_Axis 	:= TRUE;
			END_IF
				
			DI1(LED_State := 'on');
			DI2(LED_State := 'on');
			DI3(LED_State := 'on');
			DI4(LED_State := 'on');
			DI5(LED_State := 'on');
			DI6(LED_State := 'on');
			
			IF M_Powered AND M_Homed THEN
				State := 4;
			ELSIF M_Powered AND NOT M_Homed THEN
				State := 3;
			END_IF
			IF NOT Man_Mode_OFF THEN
				State := 0;
			END_IF	
		
		3: //Homing
			DI1(LED_State := 'blink');
			DI2(LED_State := 'blink');
			DI3(LED_State := 'blink');
			DI4(LED_State := 'blink');
			DI5(LED_State := 'blink');
			DI6(LED_State := 'blink');
			
			Home_Axis := TRUE;
			
			IF Error_Trigger THEN
				State 		:= 1;
			ELSIF M_Homed THEN
				Home_Axis 	:= FALSE;
				State 		:= 4;
			END_IF
			
			IF NOT Man_Mode_OFF THEN
				State := 0;
			END_IF
			
		
		4://Ready
			IF NOT (Conv_Lock_Trigger OR Conv_Lock_HMI_Trigger) THEN
				DI1(LED_State := 'off');
			END_IF
			IF NOT (Cutter_Lock_Trigger OR Cutter_Lock_HMI_Trigger) THEN
				DI2(LED_State := 'off');
			END_IF
			IF (Conv_Lock_Trigger OR Conv_Lock_HMI_Trigger) THEN
				DI1(LED_State := 'on');
			END_IF
			IF (Cutter_Lock_Trigger OR Cutter_Lock_HMI_Trigger) THEN
				DI2(LED_State := 'on');
			END_IF
			
			DI3(LED_State := 'blink');
			DI4(LED_State := 'off');
			DI5(LED_State := 'off');
			DI6(LED_State := 'off');
			
			Power_Axis := TRUE;
			
			IF Error_Trigger THEN
				State := 1;
			ELSIF Start_Trigger AND NOT Error_Trigger THEN
				State := 5;
			END_IF
			IF NOT Man_Mode_OFF THEN
				State := 0;
			END_IF
				
		5://Run
			IF NOT (Conv_Lock_Trigger OR Conv_Lock_HMI_Trigger) THEN
				DI1(LED_State := 'off');
			END_IF
			IF NOT (Cutter_Lock_Trigger OR Cutter_Lock_HMI_Trigger) THEN
				DI2(LED_State := 'off');
			END_IF
			IF (Conv_Lock_Trigger OR Conv_Lock_HMI_Trigger) THEN
				DI1(LED_State := 'on');
			END_IF
			IF (Cutter_Lock_Trigger OR Cutter_Lock_HMI_Trigger) THEN
				DI2(LED_State := 'on');
			END_IF
			
			DI3(LED_State := 'on');
			DI4(LED_State := 'on');
			DI5(LED_State := 'off');
			DI6(LED_State := 'off');
			
			Start_Command 	:= TRUE;
			Stop_Command 	:= FALSE;
			
			IF Error_Trigger THEN
				State := 1;
			ELSIF Sensor_Trigger THEN
				State := 8;
			ELSIF Stop_Trigger THEN
				Stop_Command 	:= TRUE;
				State 			:= 10;
			END_IF
			IF NOT Man_Mode_OFF THEN
				State := 0;
			END_IF
		
	
		8://Sensor Triggered
			IF NOT (Conv_Lock_Trigger OR Conv_Lock_HMI_Trigger) THEN
				DI1(LED_State := 'off');
			END_IF
			IF NOT (Cutter_Lock_Trigger OR Cutter_Lock_HMI_Trigger) THEN
				DI2(LED_State := 'off');
			END_IF
			IF (Conv_Lock_Trigger OR Conv_Lock_HMI_Trigger) THEN
				DI1(LED_State := 'on');
			END_IF
			IF (Cutter_Lock_Trigger OR Cutter_Lock_HMI_Trigger) THEN
				DI2(LED_State := 'on');
			END_IF
			
			
			DI3(LED_State := 'on');
			DI4(LED_State := 'on');
			DI5(LED_State := 'on');
			DI6(LED_State := 'off');
			
			IF Do_Cut THEN
				State := 9;
			ELSIF Stop_Trigger THEN
				Stop_Command 	:= TRUE;
				State 			:= 10;
			END_IF
			
			IF Error_Trigger THEN
				State := 1;
			END_IF
			
		
		9://Cutting in Operation
			IF NOT (Conv_Lock_Trigger OR Conv_Lock_HMI_Trigger) THEN
				DI1(LED_State := 'off');
			END_IF
			IF NOT (Cutter_Lock_Trigger OR Cutter_Lock_HMI_Trigger) THEN
				DI2(LED_State := 'off');
			END_IF
			IF (Conv_Lock_Trigger OR Conv_Lock_HMI_Trigger) THEN
				DI1(LED_State := 'on');
			END_IF
			IF (Cutter_Lock_Trigger OR Cutter_Lock_HMI_Trigger) THEN
				DI2(LED_State := 'on');
			END_IF
			
			
			DI3(LED_State := 'on');
			DI4(LED_State := 'on');
			DI5(LED_State := 'blink');
			DI6(LED_State := 'off');
			
			IF Done_Cut THEN
				State := 5;
			ELSIF Stop_Trigger THEN
				Stop_Command 	:= TRUE;
				State 			:= 10;
			END_IF	
			
			IF Error_Trigger THEN
				State := 1;
			END_IF
		
		10://Stop
		
			Start_Command := FALSE;
			
			IF Error_Trigger THEN
				State := 1;
			ELSIF M_Stoped THEN
				State := 4;
			END_IF
			IF NOT Man_Mode_OFF THEN
				State := 0;
			END_IF
			
	END_CASE
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

