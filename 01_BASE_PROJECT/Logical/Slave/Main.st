
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
		
	CASE State OF
		0://Initiation
			
			Done_Cut 	:= FALSE;
			Do_Cut 		:= FALSE;
			State 		:= 1;
		
		1://Standstill
			
			IF NOT Error_Command AND Start_Command AND Do_Cut AND Man_Mode_OFF THEN
				S_Velocity 	:= Cutter_Speed;
				State 		:= 2;     //Uncomment for Cutter in Cam similar Mechanism
				//State 		:= 4;   //Uncomment for Cutter in Lead Screw Mechanism
			END_IF
			
			IF Manual_Mode_Trigger THEN
				State := 6;
			END_IF
		
		2://Cutting Considering it as a Cam cutter
			S_Move_Velocity := FALSE;
			S_Move_Absolute := TRUE;
			S_Move_Additive := FALSE;
			S_Stop 			:= FALSE;
			S_Position 		:= Cut_depth;
			S_Direction 	:= 0;
			
			IF S_Actual_Position = 0.0 THEN
				S_Move_Absolute_Done := FALSE;
			END_IF
			
			IF S_Move_Absolute_Done THEN
				State 			:= 3;
				S_Move_Velocity := FALSE;
				S_Move_Absolute := FALSE;
				S_Move_Additive := FALSE;
				S_Stop 			:= FALSE;
			END_IF
			
			IF Stop_Command OR Error_Command OR NOT Do_Cut THEN
				State 			:= 1;
				S_Move_Velocity := FALSE;
				S_Move_Absolute := FALSE;
				S_Move_Additive := FALSE;
				S_Stop 			:= FALSE;
			END_IF
		
		3://Retracting Considering it as a Cam cutter
			S_Move_Velocity := FALSE;
			S_Move_Absolute := TRUE;
			S_Move_Additive := FALSE;
			S_Stop 			:= FALSE;
			S_Position 		:= 0.0;
			S_Direction 	:= 1;
			
			IF S_Actual_Position <> 0.0 THEN
				S_Move_Absolute_Done := FALSE;
			END_IF
			
		
			IF S_Move_Absolute_Done THEN
				State 			:= 1;
				Do_Cut 			:= FALSE;
				Done_Cut 		:= TRUE;
				S_Move_Velocity := FALSE;
				S_Move_Absolute := FALSE;
				S_Move_Additive := FALSE;
				S_Stop 			:= FALSE;
			END_IF
			
			IF Stop_Command OR Error_Command OR NOT Do_Cut THEN
				State 			:= 1;
				S_Move_Velocity := FALSE;
				S_Move_Absolute := FALSE;
				S_Move_Additive := FALSE;
				S_Stop 			:= FALSE;
			END_IF
		
		4://Cutting Considering a lead Screw Cutter
			S_Move_Velocity := FALSE;
			S_Move_Absolute := FALSE;
			S_Move_Additive := TRUE;
			S_Stop 			:= FALSE;
			S_Distance 		:= Cut_depth;
			
			IF S_Actual_Position = 0.0 THEN
				S_Move_Additive_Done := FALSE;
			END_IF
			
			IF S_Move_Additive_Done THEN
				State 			:= 5;
				S_Move_Velocity := FALSE;
				S_Move_Absolute := FALSE;
				S_Move_Additive := FALSE;
				S_Stop 			:= FALSE;
			END_IF
			
			IF Stop_Command OR Error_Command OR NOT Do_Cut THEN
				State 			:= 1;
				S_Move_Velocity := FALSE;
				S_Move_Absolute := FALSE;
				S_Move_Additive := FALSE;
				S_Stop 			:= FALSE;
			END_IF
		
		
		5://Retracting Considering a lead Screw Cutter
			S_Move_Velocity := FALSE;
			S_Move_Absolute := FALSE;
			S_Move_Additive := TRUE;
			S_Stop 			:= FALSE;
			S_Distance 		:= -Cut_depth;
			
			IF S_Actual_Position <> 0.0 THEN
				S_Move_Additive_Done := FALSE;
			END_IF
			
		
			IF S_Move_Additive_Done THEN
				State 			:= 1;
				Do_Cut 			:= FALSE;
				Done_Cut 		:= TRUE;
				S_Move_Velocity := FALSE;
				S_Move_Absolute := FALSE;
				S_Move_Additive := FALSE;
				S_Stop 			:= FALSE;
			END_IF
			
			IF Stop_Command OR Error_Command OR NOT Do_Cut THEN
				State 			:= 1;
				S_Move_Velocity := FALSE;
				S_Move_Absolute := FALSE;
				S_Move_Additive := FALSE;
				S_Stop 			:= FALSE;
			END_IF
		
		6: //Running in Manual Mode
			Power_Axis 		:= TRUE;
			Man_Mode_OFF 	:= FALSE;
			S_Move_Velocity := TRUE;
			S_Move_Additive := FALSE;
			S_Move_Absolute := FALSE;
			S_Stop 			:= FALSE;
			
			S_Velocity 		:= Blade_Pos;
			S_Direction 	:= 0;
			
			IF S_Velocity < 0 THEN
				S_Velocity 	:= -Blade_Pos;
				S_Direction := 1;
			END_IF 
			IF Error_Command THEN
				State := 1;
			END_IF
			
			IF NOT Manual_Mode_Trigger THEN
				S_Move_Absolute_Done 	:= FALSE;
				State 					:= 7;
			END_IF	
		
		7: //Sending Cutter Back to Original Position
			IF S_Actual_Position <> 0.0 THEN
				S_Velocity 		:= 50;
				S_Move_Velocity := FALSE;
				S_Move_Absolute := TRUE;
				S_Move_Additive := FALSE;
				S_Stop 			:= FALSE;
				S_Position 		:= 0.0;
				S_Direction 	:= 1;			
				
				IF Error_Command THEN
					State := 1;
				END_IF
			END_IF
			IF S_Actual_Position = 0.0 THEN
				Man_Mode_OFF 	:= TRUE;
				State 			:= 1;
				Power_Axis 		:= FALSE;
				S_Move_Velocity := FALSE;
				S_Move_Absolute := FALSE;
				S_Move_Additive := FALSE;
				S_Stop 			:= FALSE;
			END_IF
			
			IF Error_Command THEN
				State := 1;
			END_IF
		
	END_CASE
	
	
	//Calling FSM_AXIS Function
	Slave(	Axis_Name 		:= ADR(gAxis02), 
			Acceleration 	:= 5000, 
			Deceleration 	:= 5000, 
			Position 		:= S_Position, 
			Distance 		:= S_Distance,
			Velocity 		:= S_Velocity, 
			Direction 		:= S_Direction, 
			Home 			:= Home_Axis, 
			Power 			:= Power_Axis, 
			Move_Velocity 	:= S_Move_Velocity, 
			Move_Absolute 	:= S_Move_Absolute,
			Move_Additive 	:= S_Move_Additive, 
			Stop 			:= S_Stop, 
			Reset_Error 	:= Reset_Command);
	S_Active 				:= Slave.Active;
	S_Actual_Position 		:= Slave.Actual_Position;
	IF State = 3 OR State = 5 THEN
		S_Actual_Velocity := -Slave.Actual_Velocity;
	ELSE
		S_Actual_Velocity := Slave.Actual_Velocity;
	END_IF
	
	S_Move_Absolute_Done 	:= Slave.Move_Abs_Done;
	S_Move_Additive_Done 	:= Slave.Move_Add_Done;
	S_Homed 				:= Slave.Is_Homed;
	S_Powered 				:= Slave.Power_ON;
	S_Stoped 				:= Slave.Stop_Done;
	S_Error 				:= Slave.Error;
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

