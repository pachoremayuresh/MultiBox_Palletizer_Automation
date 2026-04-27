

PROGRAM _INIT
	(* Insert code here *)
	//Initial Parameters
		
	Conv_Speed 		:= 100;
	Cut_Pos 		:= 50;
	Cutter_Speed 	:= 20;
	Cut_depth 		:= 50;

END_PROGRAM

PROGRAM _CYCLIC
	
	IF DiagCpuIsSimulated() THEN
		(* For Simulation *)
		//Operator
		//LED_IO Bridge
		Start_Trigger 			:= ComTCP_SimInputs.Start_Button_ButtonPress 		OR Start_Button_HMI;
		Stop_Trigger 			:= ComTCP_SimInputs.Stop_Button_ButtonPress 		OR Stop_Button_HMI;
		Error_Trigger 			:= ComTCP_SimInputs.Emergency_Button_ButtonToggle 	OR Emergancy_Button_HMI OR M_Error OR S_Error;
		Reset_Trigger 			:= ComTCP_SimInputs.White_Button_ButtonPress 		OR Reset_Button_HMI;
		Sensor_Trigger 			:= ComTCP_SimInputs.Yellow_Button_ButtonPress 		OR Sensor_Button_HMI;
		Conv_Lock_HMI_Trigger 	:= Conv_Lock_HMI;
		Cutter_Lock_HMI_Trigger := Cutter_Lock_HMI;
	
		IF Conv_Lock_HMI_Trigger THEN
			IF Conv_Speed_HMI < 10 THEN
				Conv_Speed 	:= 10;
			ELSE
				Conv_Speed 	:= Conv_Speed_HMI;
			END_IF
			IF Cutting_Pos_HMI < 10 THEN
				Cut_Pos 	:= 10;
			ELSE
				Cut_Pos 	:= Cutting_Pos_HMI;
			END_IF
		END_IF
		
		IF Cutter_Lock_HMI_Trigger THEN
			IF Cutter_Speed_HMI < 10 THEN
				Cutter_Speed 	:= 10;
			ELSE
				Cutter_Speed 	:= Cutter_Speed_HMI;
			END_IF
			IF Cutting_Depth_HMI < 10 THEN
				Cut_depth 		:= 10;
			ELSE
				Cut_depth 		:= Cutting_Depth_HMI;
			END_IF
		END_IF
			
		//Manual Motion
		Manual_Mode_Trigger := Man_Mode_HMI;
		Slow_Blade_Trigger 	:= Slow_Blade_HMI;
		Slow_Conv_Trigger 	:= Slow_Conv_HMI;
		IF Slow_Blade_Trigger THEN
			Blade_Pos := Blade_Man_HMI * 0.01 * 1000;
		ELSE
			Blade_Pos := Blade_Man_HMI * 1000;
		END_IF
		
		IF Slow_Conv_Trigger THEN
			Conv_Pos := Conv_Man_HMI * 0.01 *1000;
		ELSE
			Conv_Pos := Conv_Man_HMI * 1000;
		END_IF
		
	ELSE
		(* For Actual Setup *)
		Start_Trigger 			:= Start_Button OR Start_Button_HMI;
		Stop_Trigger 			:= Stop_Button OR Stop_Button_HMI;
		Error_Trigger 			:= Emergancy_Button_HMI OR M_Error OR S_Error;
		Reset_Trigger 			:= Reset_Button OR Reset_Button_HMI;
		Sensor_Trigger 			:= Sensor_Button OR Sensor_Button_HMI;
		Conv_Lock_HMI_Trigger 	:= Conv_Lock_HMI;
		Cutter_Lock_HMI_Trigger := Cutter_Lock_HMI;
		Conv_Lock_Trigger 		:= Conv_Lock;
		Cutter_Lock_Trigger 	:= Cutter_Lock;
		Over_Ride_Trigger 		:= Over_Ride_HMI;
		IF Over_Ride_Trigger THEN
			IF Conv_Lock_HMI_Trigger THEN
				IF Conv_Speed_HMI < 10 THEN
					Conv_Speed 	:= 10;
				ELSE
					Conv_Speed 	:= Conv_Speed_HMI;
				END_IF
				IF Cutting_Pos_HMI < 10 THEN
					Cut_Pos 	:= 10;
				ELSE
					Cut_Pos 	:= Cutting_Pos_HMI;
				END_IF
			END_IF
			IF Cutter_Lock_HMI_Trigger THEN
				IF Cutter_Speed_HMI < 10 THEN
					Cutter_Speed 	:= 10;
				ELSE
					Cutter_Speed 	:= Cutter_Speed_HMI;
				END_IF
				IF Cutting_Depth_HMI < 10 THEN
					Cut_depth 		:= 10;
				ELSE
					Cut_depth 		:= Cutting_Depth_HMI;
				END_IF
			END_IF
		ELSE
			IF Conv_Lock_Trigger AND NOT Cutter_Lock_Trigger THEN
				Conv_Speed 			:= (Speed*3000/32767);
				IF Speed < 10 THEN
					Conv_Speed 		:= 10;
				END_IF
				Cut_Pos 			:= (Position*1000/32767);
				IF Position < 10 THEN
					Cut_Pos 		:= 10;
				END_IF
				
			ELSIF Cutter_Lock_Trigger AND NOT Conv_Lock_Trigger THEN
				Cutter_Speed 		:= (Speed*3000/32767);
				IF Speed < 10 THEN
					Cutter_Speed 	:= 10;
				END_IF
				Cut_depth 			:= (Position*360/32767);
				IF Position < 10 THEN
					Cut_depth 		:= 10;
				END_IF
			ELSIF Conv_Lock_Trigger AND Cutter_Lock_Trigger THEN
				Error_Trigger 	:= TRUE;
			END_IF
		END_IF
					
		//Manual Motion
		Manual_Mode_Trigger := Man_Mode_HMI;
		Slow_Blade_Trigger 	:= Slow_Blade_HMI;
		Slow_Conv_Trigger 	:= Slow_Conv_HMI;
		IF Slow_Blade_Trigger THEN
			Blade_Pos 	:= Blade_Man_HMI * 0.01 * 1000;
		ELSE
			Blade_Pos 	:= Blade_Man_HMI*1000;
		END_IF
		
		IF Slow_Conv_Trigger THEN
			Conv_Pos 	:= Conv_Man_HMI * 0.01 * 1000;
		ELSE
			Conv_Pos 	:= Conv_Man_HMI*1000;
		END_IF
	END_IF
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM


