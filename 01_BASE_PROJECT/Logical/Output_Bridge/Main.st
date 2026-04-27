
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	//Since when the motor not running it gives grabade values.
	IF NOT Start_Command THEN
		M_Actual_Velocity := 0;
		S_Actual_Velocity := 0;
	END_IF
		
	
	IF DiagCpuIsSimulated() THEN
		ComTCP_SimOutputs.Green_light_Key 	:= DI3.LED_Light;
		ComTCP_SimOutputs.Stop_light_Key 	:= DI4.LED_Light; 
		ComTCP_SimOutputs.Yellow_light_Key 	:= DI5.LED_Light; 
		ComTCP_SimOutputs.White_light_Key	:= DI6.LED_Light; //it will display red on real setup
		LED_DI1_HMI 						:= DI1.LED_Light;
		LED_DI2_HMI 						:= DI2.LED_Light;
		LED_DI3_HMI 						:= DI3.LED_Light;
		LED_DI4_HMI 						:= DI4.LED_Light;
		LED_DI5_HMI 						:= DI5.LED_Light;
		LED_DI6_HMI 						:= DI6.LED_Light;
		Dis_Conv_Speed_HMI 					:= M_Actual_Velocity/10;
		Dis_Cut_Speed_HMI 					:= S_Actual_Velocity/10;
		Dis_Cut_Pos_HMI 					:= REAL_TO_INT(Cut_Pos);
		Dis_Cut_Depth_HMI 					:= REAL_TO_INT(Cut_depth);
		
		
		//Master
		ComTCP_SimOutputs.Shaft_0_ACT_POS 	:= M_Actual_Position;
		
		//Slave
		ComTCP_SimOutputs.Shaft_1_ACT_POS 	:= S_Actual_Position;
		
		
		
	ELSE
		LED_DI1_HMI 		:= DI1.LED_Light;
		LED_DI2_HMI 		:= DI2.LED_Light;
		LED_DI3_HMI 		:= DI3.LED_Light;
		LED_DI4_HMI 		:= DI4.LED_Light;
		LED_DI5_HMI 		:= DI5.LED_Light;
		LED_DI6_HMI 		:= DI6.LED_Light;
		Dis_Conv_Speed_HMI 	:= M_Actual_Velocity/10;
		Dis_Cut_Speed_HMI 	:= S_Actual_Velocity/10;
		Dis_Cut_Pos_HMI 	:= REAL_TO_INT(Cut_Pos);
		Dis_Cut_Depth_HMI 	:= REAL_TO_INT(Cut_depth);
		
		//Hardware
		Display 			:= REAL_TO_INT((M_Actual_Velocity/10));
		
	END_IF

END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

