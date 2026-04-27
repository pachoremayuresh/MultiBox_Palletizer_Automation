
FUNCTION_BLOCK Gen_Axis

	CASE Axis_State OF
		
		Axis_Check_Command:
			
			IF Axis_Command 	 = Axis_Idle THEN
				Axis_In_Pos 	:= FALSE;
				Axis_In_Vel 	:= FALSE;
				Axis_Timer 		:= Axis_Dev_Timer;
				Axis_Dev_Fault 	:= FALSE;
			END_IF
			
			IF Axis_Command 		 = Axis_Change_Position THEN
				Axis_TGT_Position 	:= New_Set_Point;
				Axis_State 			:= Axis_Wait_TGT_Position;
			END_IF
			
			IF Axis_Command 		 = Axis_Change_Velocity THEN
				Axis_TGT_Velocity 	:= New_Set_Point;
				Axis_State 			:= Axis_Wait_TGT_Velocity;
			END_IF
			
			IF Axis_Command 		 = Axis_Emergency_Stop_Request THEN
				Axis_TGT_Position 	:= Axis_Act_Position;
				Axis_TGT_Velocity 	:= 0;
				IF (Axis_Act_Position = Axis_TGT_Position AND Axis_Act_Velocity = Axis_TGT_Velocity) THEN
					Axis_In_Pos 	:= TRUE;
					Axis_In_Vel 	:= TRUE;
					Axis_State 		:= Axis_Check_Command;
				END_IF
			END_IF
			
		Axis_Wait_TGT_Position:
			
			IF (Axis_Act_Position = New_Set_Point AND Axis_TGT_Sensor) THEN
				Axis_In_Pos 	:= TRUE;
				Axis_State 		:= Axis_Check_Command;
			END_IF
			
			Axis_Timer := Axis_Timer - 1;
			
			IF Axis_Timer = 0 THEN
				Axis_Dev_Fault 	:= TRUE;
				Axis_State 		:= Axis_Fault_State;
			END_IF
			
		Axis_Wait_TGT_Velocity:
			
			IF Axis_Act_Velocity = New_Set_Point THEN
				Axis_In_Vel 	:= TRUE;
				Axis_State 		:= Axis_Check_Command;
			END_IF
			
			Axis_Timer := Axis_Timer - 1;
			
			IF Axis_Timer = 0 THEN
				Axis_Dev_Fault 	:= TRUE;
				Axis_State 		:= Axis_Fault_State;
			END_IF
			
		Axis_Fault_State:
			
			IF Axis_Reset THEN
				Axis_Dev_Fault 	:= FALSE;
				Axis_State 		:= Axis_Check_Command;
			END_IF
			
	END_CASE

END_FUNCTION_BLOCK
