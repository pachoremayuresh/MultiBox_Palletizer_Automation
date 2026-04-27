
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	CASE State OF
		0: //Initiation
			DI1(LED_State := 'off');
			DI2(LED_State := 'off');
			DI3(LED_State := 'off');
			DI4(LED_State := 'off');
			DI5(LED_State := 'off');
			DI6(LED_State := 'off');
			
			IF M_Active AND S_Active AND Man_Mode_OFF THEN
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
			
			IF Reset_Trigger THEN
				Reset_Command 	:= TRUE;
				IF NOT Error_Trigger THEN
					Reset_Command 	:= FALSE;
					State 			:= 2;
				END_IF
			END_IF
			
			
		2: //Disabled
		
			DI1(LED_State := 'on');
			DI2(LED_State := 'on');
			DI3(LED_State := 'on');
			DI4(LED_State := 'on');
			DI5(LED_State := 'on');
			DI6(LED_State := 'on');
				
			IF Reset_Trigger THEN
				Power_Axis 	:= TRUE;
			END_IF	
			
			IF Error_Trigger THEN
				State := 1;
			END_IF
			
			IF M_Powered AND S_Powered AND NOT (M_Homed AND S_Homed) THEN
				State := 3;
			END_IF
			
			IF M_Powered AND S_Powered AND M_Homed AND S_Homed THEN
				State := 4;
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
			
			IF M_Homed AND S_Homed THEN
				Home_Axis 	:= FALSE;
				State 		:= 4;
			END_IF
			
			IF Error_Trigger THEN
				State := 1;
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
			
			Error_Command 	:= FALSE;
			Power_Axis 		:= TRUE;
			
			IF Start_Trigger AND NOT Error_Trigger THEN
				State := 5;
			END_IF
						
			IF Error_Trigger THEN
				State := 1;
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
			Power_Axis 		:= TRUE;
			
			IF Error_Trigger THEN
				State := 1;
			END_IF

			IF Stop_Trigger AND NOT Error_Trigger THEN
				State := 6;
			END_IF
			
			IF NOT Man_Mode_OFF THEN
				State := 0;
			END_IF
		
		6://Stop
		
			Start_Command 	:= FALSE;
			Stop_Command 	:= TRUE;
			
			IF M_Stoped THEN
				Stop_Command 	:= FALSE;
				State 			:= 4;
			END_IF
			
			IF Error_Trigger THEN
				State := 1;
			END_IF
			
			IF NOT Man_Mode_OFF THEN
				State := 0;
			END_IF
				
			
	END_CASE
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

