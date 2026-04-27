
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	CASE State OF
		0://Initialization
			
			IF M_Active AND M_Homed AND M_Powered THEN
				State := 2;
			END_IF
			IF Manual_Mode_Trigger THEN
				State := 5;
			END_IF
		
		1://Error and Stopping
			
			M_Move_Velocity := FALSE;
			M_Move_Additive := FALSE;
			M_Move_Absolute := FALSE;
			M_Stop 			:= TRUE;
			
			IF M_Stoped THEN
				M_Move_Velocity := FALSE;
				M_Move_Additive := FALSE;
				M_Move_Absolute := FALSE;
				M_Stop 			:= FALSE;
				State 			:= 2;
			END_IF
			
		2://Standstill
			
			IF NOT Error_Command AND Start_Command AND Man_Mode_OFF AND (NOT Do_Cut OR Done_Cut) THEN
				State := 3;
			END_IF
			IF Manual_Mode_Trigger THEN
				State := 5;
			END_IF
			
			
		3://Moving Conveyor
			M_Velocity 		:= Conv_Speed;
			M_Move_Velocity := TRUE;
			M_Move_Additive := FALSE;
			M_Move_Absolute := FALSE;
			M_Stop 			:= FALSE;
			
			Do_Cut 		:= FALSE;
			Done_Cut 	:= FALSE;
			
			IF Stop_Command OR Error_Command THEN
				State := 1;
			ELSIF Sensor_Trigger THEN
				State := 4;
			ELSIF Manual_Mode_Trigger THEN
				State := 5;
			END_IF
			
		4://Reaching Cutting Position
			M_Distance 		:= Cut_Pos;
			M_Velocity 		:= Conv_Speed;
			M_Move_Velocity := FALSE;
			M_Move_Additive := TRUE;
			M_Move_Absolute := FALSE;
			M_Stop 			:= FALSE;
			
			IF M_Move_Additive_Done THEN
				State 			:= 1;
				Do_Cut 			:= TRUE;
				M_Move_Velocity := FALSE;
				M_Move_Additive := FALSE;
				M_Move_Absolute := FALSE;
				M_Stop 			:= FALSE;
				one_time 		:= FALSE;
			END_IF
			
			IF Stop_Command OR Error_Command THEN
				State := 1;
			END_IF
			
			IF Done_Cut AND NOT (Stop_Command OR Error_Command) THEN
				State := 2;
			END_IF
			
			IF Manual_Mode_Trigger THEN
				State := 5;
			END_IF
		
		5://Running in Manual Mode
			Power_Axis 		:= TRUE;
			Man_Mode_OFF 	:= FALSE;
			M_Move_Velocity := TRUE;
			M_Move_Additive := FALSE;
			M_Move_Absolute := FALSE;
			M_Stop 			:= FALSE;
			
			M_Velocity 		:= Conv_Pos;
			M_Direction 	:= 0;
			IF M_Velocity < 0 THEN
				M_Velocity 	:= -Conv_Pos;
				M_Direction := 1;
			END_IF 
			IF NOT Manual_Mode_Trigger THEN
				Power_Axis 		:= FALSE;
				Start_Command 	:= FALSE;
				M_Move_Velocity := FALSE;
				M_Move_Additive := FALSE;
				M_Move_Absolute := FALSE;
				M_Stop 			:= FALSE;
				State 			:= 2;
			END_IF
			
			IF Error_Command THEN
				State := 1;
			END_IF

	END_CASE		
	
	//Calling FSM_AXIS Function
	Master(	Axis_Name 		:= ADR(gAxis01), 
			Acceleration 	:= 5000, 
			Deceleration 	:= 5000, 
			Position 		:= M_Position, 
			Distance 		:= M_Distance, 
			Velocity 		:= M_Velocity, 
			Direction 		:= M_Direction, 
			Home 			:= Home_Axis, 
			Power 			:= Power_Axis, 
			Move_Velocity 	:= M_Move_Velocity, 
			Move_Absolute 	:= M_Move_Absolute, 
			Move_Additive 	:= M_Move_Additive, 
			Stop 			:= M_Stop, 
			Reset_Error 	:= Reset_Command);
	M_Active 				:= Master.Active;
	M_Actual_Position		:= Master.Actual_Position;
	M_Actual_Velocity 		:= Master.Actual_Velocity;
	M_Move_Absolute_Done 	:= Master.Move_Abs_Done;
	M_Move_Additive_Done 	:= Master.Move_Add_Done;
	M_Homed 				:= Master.Is_Homed;
	M_Powered 				:= Master.Power_ON;
	M_Stoped 				:= Master.Stop_Done;
	M_Error 				:= Master.Error;
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

