
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	IF (Operation_Type = Init) THEN
		Signal_Management (Operation_Type 	:= Init);
		Signal_Management (Operation_Type 	:= Start_Config); 
		Signal_Management.Operation_Type 	:= Config;
		Operation_Type := Run;
	ELSE
		Signal_Management (Operation_Type 	:= Start_Gen); 
		Signal_Management.Operation_Type 	:= Generation;
	END_IF;
	
	Signal_Management (	Signal_Type 		:= Alarm,
						Signal_Code 		:= m_On_Phase_Stop_Requested,
						Signal_Output 		:= S_On_Phase_Stop,
						Activation_Signal 	:= On_Phase_Stop_HMI);
	
	Signal_Management (	Signal_Type			:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Emergency_Stop_Requested,
						Signal_Output 		:= S_Emergency_Stop,
						Activation_Signal 	:= Emergency_Stop_HMI);

	
	// FEEDER
	
	// Conveyor 1
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Conveyor_1_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Conveyor_1_Fault);
	
	// Pusher
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Feeder_Pusher_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Feeder_Pusher_Fault);
	
	// conveyor 2
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Conveyor_2_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Conveyor_2_Fault);
	
	// Turnpusher
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Turn_Pusher_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Turn_Pusher_Fault);
	
	// conveyor 3
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Conveyor_3_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Conveyor_3_Fault);
	
	// Carriage
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Carriage_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Carriage_Fault);
	
	
	// CRANE
	
	// Box crane
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Box_Crane_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Box_Crane_Fault);
	
	
	// Gantry crane
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Gantry_Crane_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Gantry_Crane_Fault);
	
	
	// vacuum
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Vacuum_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Vacuum_Fault);
	
	// cartboard
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Cartboard_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Cartboard_Fault);
	
	//Pusher X
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Crane_Pusher_x_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Crane_Pusher_x_Fault);
	
	//pusher Z
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Crane_Pusher_z_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Crane_Pusher_z_Fault);
	
	
	// slideRail
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Box_Holder_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Box_Holder_Fault);
	
	
	// PALLET
	
	//Lifter
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Pallet_Lifter_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Pallet_Lifter_Fault);
	
	// fork
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Pallet_Fork_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Pallet_Fork_Fault);
	
	//conveyor 1
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Conveyor_4_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Conveyor_4_Fault);
		
	// conveyor 2
	Signal_Management (	Signal_Type 		:= Alarm OR Aux_Reset,
						Signal_Code 		:= m_Conveyor_5_Fault,
						Signal_Output 		:= S_Immediate_Stop,
						Activation_Signal 	:= e_Conveyor_5_Fault);
	
	// PALLET ALMOST OVER
	Signal_Management (	Signal_Type 		:= Warning,
						Signal_Code 		:= m_Pallets_Almost_Over,
						Signal_Output 		:= S_Machine_Out_Of_Phase,
						Activation_Signal 	:= (Pallet_Counter = 1));
	
	// PALLET OVER
	Signal_Management (	Signal_Type 		:= Alarm,
						Signal_Code 		:= m_Pallets_Over,
						Signal_Output 		:= S_On_Phase_Stop,
						Activation_Signal 	:= (Pallet_Counter = 0));
		
	// CARTBOARD ALMOST OVER
	Signal_Management (	Signal_Type 		:= Warning,
						Signal_Code 		:= m_Cartboard_Almost_Over,
						Signal_Output 		:= S_Materials_Run_Out_Lamp,
						Activation_Signal 	:= (Crane_Cartboard_Counter = 1));

	// CARTBOARD OVER
	Signal_Management (	Signal_Type 		:= Alarm,
						Signal_Code 		:= m_Cartboard_Over,
						Signal_Output 		:= S_On_Phase_Stop,
						Activation_Signal 	:= (Crane_Cartboard_Counter = 0));
		
	
	Output_Signals 			:= Signal_Management.Signal_Outputs;
	
	IF (Operation_Type = Run) THEN
		Signal_Management (Operation_Type := Run); (* outputs selection *)
	END_IF;

	Emergency_Stop 			:= ((Output_Signals AND S_Emergency_Stop) = S_Emergency_Stop);
	
	IF Emergency_Stop THEN
		Immediate_Stop		:= FALSE;
		On_Phase_Stop		:= FALSE;
	END_IF
	
	IF NOT Emergency_Stop THEN
		Immediate_Stop 		:= ((Output_Signals AND S_Immediate_Stop) = S_Immediate_Stop);
		On_Phase_Stop		:= FALSE;
		IF NOT Immediate_Stop THEN
			On_Phase_Stop 	:= ((Output_Signals AND S_On_Phase_Stop) = S_On_Phase_Stop);
		END_IF;
	END_IF
		
	Out_Of_Material		:= ((((Output_Signals AND S_Materials_Run_Out_Lamp) = S_Materials_Run_Out_Lamp)) OR (((Output_Signals AND S_Machine_Out_Of_Phase) = S_Machine_Out_Of_Phase)));
	
	
	Priority_1_HMI 		:= Fault[Signal_Management.First_Active_Signal_Index];
	Priority_2_HMI 		:= Fault[Signal_Management.Second_Active_Signal_Index];
	Priority_3_HMI 		:= Fault[Signal_Management.Third_Active_Signal_Index];
	Priority_4_HMI 		:= Fault[Signal_Management.Fourth_Active_Signal_Index];
	
	Aux_Reset_Unlocked 	:= Signal_Management.Aux_Reset_Enable;
	IF Aux_Reset_Unlocked THEN
		Aux_Unlocked	( LED_State := 'blink');
	ELSIF NOT Aux_Reset_Unlocked THEN
		Aux_Unlocked	( LED_State := 'off');
	END_IF
	
	Reset_Unlocked 		:= Signal_Management.Reset_Enable;
	IF Reset_Unlocked THEN
		R_Unlocked		( LED_State := 'blink');
	ELSIF NOT Reset_Unlocked THEN
		R_Unlocked		( LED_State := 'off');
	END_IF
	
	IF Signal_Management.First_Active_Signal_Index > 0 AND NOT (Signal_Management.First_Active_Signal_Index = 12 OR Signal_Management.First_Active_Signal_Index = 13 OR Signal_Management.First_Active_Signal_Index = 14 OR Signal_Management.First_Active_Signal_Index = 15) THEN
		Alarm_Detected( LED_State := 'blink');
	ELSIF Signal_Management.First_Active_Signal_Index > 0 AND (Signal_Management.First_Active_Signal_Index = 12 OR Signal_Management.First_Active_Signal_Index = 15) AND NOT (Signal_Management.First_Active_Signal_Index = 13 OR Signal_Management.First_Active_Signal_Index = 14) THEN
		Warning_Detected( LED_State := 'blink');
	ELSE
		Warning_Detected( LED_State := 'off');
		Alarm_Detected( LED_State := 'off');
		
	END_IF
		
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

