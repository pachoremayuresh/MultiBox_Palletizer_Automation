
FUNCTION_BLOCK FSM_AXIS
	
	CASE State OF
		0://Initiation
			Power_ON := FALSE;
			
			IF RS_Valid AND RS_Disabled THEN
				State 	:= 2;
				Active 	:= TRUE;
			END_IF
			
			IF RS_Errorstop AND RS_Valid THEN
				State 	:= 1;
			END_IF
					
		1://Error
			V_Execute 	:= FALSE;
			Add_Execute := FALSE;
			A_Execute 	:= FALSE;
			
			IF Reset_Error THEN
				R_Execute := TRUE;
				IF R_Done AND P_Status THEN
					State := 3;
				END_IF
				IF R_Done AND NOT P_Status THEN
					State := 2;
				END_IF
			END_IF
					
		2://Disabled
			P_Enable := FALSE;
			Power_ON := FALSE;
			
			IF Error THEN
				State := 1;
			ELSIF Home THEN
				State := 4;
			ELSIF Power THEN
				State := 3;
			END_IF
					
		3://StandStill
					
			P_Enable := TRUE;
			Power_ON := TRUE;
			
			IF Error THEN
				State 			:= 1;
			ELSIF Home AND NOT Is_Homed THEN
				State 			:= 4;
			ELSIF NOT Power THEN
				State 			:= 2;
			ELSIF Move_Velocity THEN
				Move_Abs_Done 	:= FALSE;
				Move_Add_Done 	:= FALSE;
				Stop_Done 		:= FALSE;
				State 			:= 5;
			ELSIF Move_Additive AND NOT Move_Additive_Old THEN
				Move_Abs_Done 	:= FALSE;
				Move_Add_Done 	:= FALSE;
				Stop_Done 		:= FALSE;
				State 			:= 6;
			ELSIF Move_Absolute AND NOT Move_Absolute_Old THEN
				Move_Abs_Done 	:= FALSE;
				Move_Add_Done 	:= FALSE;
				Stop_Done 		:= FALSE;
				State 			:= 7;
			ELSIF Stop THEN
				State 			:= 8;
			END_IF
					
		4://Homing Axis
			
			H_Execute := TRUE;
			IF Error THEN
				State 		:= 1;
				H_Execute 	:= FALSE;
			ELSIF H_Done AND Power THEN
				State 		:= 3;
				H_Execute 	:= FALSE;
				Is_Homed 	:= TRUE;
			ELSIF H_Done AND NOT Power THEN
				State 		:= 2;
				H_Execute 	:= FALSE;
				Is_Homed 	:= TRUE;
			END_IF

		5://Moving Axis in Velocity mode
			
			P_Enable 	:= TRUE;
			V_Execute 	:= TRUE;
			IF Old_Velocity <> Velocity THEN
				V_Execute := FALSE;
			END_IF
						
			IF Error THEN
				State := 1;
			ELSIF Move_Additive THEN
				State := 6;
			ELSIF Move_Absolute THEN
				State := 7;
			ELSIF NOT Power OR Stop THEN
				State := 8;
			END_IF
									
		6://Moving Axis in Additive mode
											
			P_Enable 	:= TRUE;
			Add_Execute := TRUE;
			
			IF Error THEN
				State 			:= 1;
			END_IF
			IF NOT Power OR Stop THEN
				State 			:= 8;
				Add_Execute 	:= FALSE;
			END_IF
			IF Add_Done THEN
				Move_Add_Done 	:= TRUE;
				Add_Execute 	:= FALSE;
				State 			:= 3;
			END_IF
											
		7://Moving Axis in Absolute Mode
			
			P_Enable 	:= TRUE;
			A_Execute 	:= TRUE;
			
			IF Error THEN
				State 			:= 1;
			END_IF
			IF NOT Power OR Stop THEN
				State 			:= 8;
				A_Execute 		:= FALSE;
			END_IF
			IF A_Done THEN
				Move_Abs_Done 	:= TRUE;
				A_Execute 		:= FALSE;
				State 			:= 3;
			END_IF
						
										
		8://Stopping Axis
		
			P_Enable 	:= TRUE;
			S_Execute 	:= TRUE;
			
			IF Error THEN
				State 		:= 1;
			END_IF
			IF S_Done THEN
				V_Execute 	:= FALSE;
				S_Execute 	:= FALSE;
				Stop_Done 	:= TRUE;
				State 		:= 3;
			END_IF
			IF RS_Errorstop AND RS_Valid THEN
				S_Execute 	:= FALSE;
				State 		:= 1;
			END_IF
			
	END_CASE
	
	Move_Absolute_Old 		:= Move_Absolute;
	Move_Additive_Old 		:= Move_Additive;
	Old_Velocity 			:= Velocity;
	
	//Calling all PLCopen function blocks used 
	//Read Status
	MCRS(	Axis 			:= Axis_Name, 
			Enable 			:= TRUE); 
	RS_Valid 				:= MCRS.Valid;
	RS_Error 				:= MCRS.Error; 
	RS_Errorstop 			:= MCRS.Errorstop;
	RS_Disabled 			:= MCRS.Disabled;
	//Power
	MCP(	Axis 			:= Axis_Name, 
			Enable 			:= P_Enable);
	P_Status 				:= MCP.Status; 
	P_Error 				:= MCP.Error;
	//Home
	MCH(	Axis 			:= Axis_Name, 
			Execute 		:= H_Execute);
	H_Done 					:= MCH.Done;
	H_Error					:= MCH.Error;
	//Stop
	MCS(	Axis 			:= Axis_Name, 
			Execute 		:= S_Execute, 
			Deceleration 	:= Deceleration);
	S_Done 					:= MCS.Done;
	S_Error 				:= MCS.Error;
	//Reset
	MCR(	Axis 			:= Axis_Name,
			Execute			:= R_Execute);
	R_Done 					:= MCR.Done;
	R_Error 				:= MCR.Error;
	//Read Actual Position
	MCRAP(	Axis 			:= Axis_Name,
			Enable 			:= TRUE);
	RAP_Valid 				:= MCRAP.Valid;
	RAP_Error 				:= MCRAP.Error;
	Actual_Position 		:= MCRAP.Position;
	//Read Actual Velocity
	MCRAV(	Axis 			:= Axis_Name, 
			Enable 			:= TRUE); 
	RAV_Valid 				:= MCRAV.Valid; 
	RAV_Error 				:= MCRAV.Error;
	Actual_Velocity 		:= MCRAV.Velocity;
	//Move Velocity
	MCMV(	Axis 			:= Axis_Name, 
			Execute 		:= V_Execute, 
			Velocity 		:= Velocity, 
			Acceleration 	:= Acceleration, 
			Deceleration 	:= Deceleration, 
			Direction 		:= Direction);
	V_Error 				:= MCMV.Error;
	//Move Additive
	MCMAdd(	Axis 			:= Axis_Name, 
			Execute 		:= Add_Execute, 
			Distance 		:= Distance, 
			Velocity 		:= Velocity, 
			Acceleration 	:= Acceleration, 
			Deceleration 	:= Deceleration);
	Add_Done 				:= MCMAdd.Done;
	Add_Error 				:= MCMAdd.Error;
	//Move Absolute
	MCMA(	Axis 			:= Axis_Name, 
			Execute 		:= A_Execute, 
			Position 		:= Position, 
			Velocity 		:= Velocity, 
			Acceleration 	:= Acceleration, 
			Deceleration 	:= Deceleration, 
			Direction 		:= Direction);
	A_Done 					:= MCMA.Done;
	A_Error 				:= MCMA.Error;
	
	Error := RS_Error OR P_Error OR H_Error OR S_Error OR R_Error OR RAP_Error OR RAV_Error OR V_Error OR Add_Error OR A_Error;
	
	

END_FUNCTION_BLOCK

