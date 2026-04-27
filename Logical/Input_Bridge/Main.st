
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	// Feeder Input Variables
	IR_Sensor_1(Sensor_Raw 	:= ComTCP_SimInputs.laser_sensor_IR,
				threshold_B := 10,
				Is_Bool 	:= TRUE);
	IR_Sensor_2(Sensor_Raw 	:= ComTCP_SimInputs.laser_sensor2_IR,
				threshold_B := 2,
				Is_Bool 	:= TRUE);
	Carriage(	Sensor_Data := ComTCP_SimInputs.carriage_2_AXIS,
				threshold_F := 0.8,
				Is_Bool 	:= FALSE);
	CarriageB(	Sensor_Raw 	:= ComTCP_SimInputs.carriage_2_RCHD,
				threshold_B := 10,
				Is_Bool 	:= TRUE);
	Pusher_1_B( Sensor_Raw 	:= ComTCP_SimInputs.pusher_LBK,
				threshold_B := 10,
				Is_Bool 	:= TRUE);
	Pusher_1_F(	Sensor_Raw 	:= ComTCP_SimInputs.pusher_LFR,
				threshold_B := 10,
				Is_Bool 	:= TRUE);
	Turn_Push_B(Sensor_Raw 	:= ComTCP_SimInputs.turnpusher_LBK,
				threshold_B := 10,
				Is_Bool 	:= TRUE);
	Turn_Push_F(Sensor_Raw 	:= ComTCP_SimInputs.turnpusher_LFR,
				threshold_B := 10,
				Is_Bool 	:= TRUE);
	
	//Filtered Data
	I_IR_Sensor_1 			:= IR_Sensor_1.Sensor_Filtered; //First Laser Sensor;
	I_IR_Sensor_2 			:= IR_Sensor_2.Sensor_Filtered; //Second Leser Sensor;
	I_Carriage_Push_Act_Pos := Carriage.Sensor_Data_Filtered; //Actual postion of Group box pusher;
	I_Carriage_Push_Tar_Rec := CarriageB.Sensor_Filtered; //Group box reached target;
	I_Pusher_1_B 			:= Pusher_1_B.Sensor_Filtered; //Pusher 1 Back Position;
	I_Pusher_1_F 			:= Pusher_1_F.Sensor_Filtered; //Pusher 1 Front Position;
	I_Turn_Push_B 			:= Turn_Push_B.Sensor_Filtered; //Turn Pusher back position;
	I_Turn_Push_F 			:= Turn_Push_F.Sensor_Filtered; //Turn Pusher Front position;
	
	//Crane Input Variables
	Gantry_Crane(	Sensor_Data := ComTCP_SimInputs.gantry_crane_AXIS,
					threshold_F := 0.99,
					Is_Bool 	:= FALSE);
	Box_Crane(		Sensor_Data := ComTCP_SimInputs.box_crane_AXIS,
					threshold_F := 0.99,
					Is_Bool 	:= FALSE);
	Vacuum(			Sensor_Raw 	:= ComTCP_SimInputs.vaccum_box_crane_VACUUM,
					threshold_B := 10,
					Is_Bool 	:= TRUE);
	//Filtered Data
	I_Gantry_Crane_Act_Pos 		:= Gantry_Crane.Sensor_Data_Filtered; //Gantry Crane Actual Position;
	I_Box_Crane_Act_Pos 		:= Box_Crane.Sensor_Data_Filtered; // Box Crane Actual Position;
	I_Vacuum_retention_act 		:= Vacuum.Sensor_Filtered; //Vacuum capfor cartboard retention active;
	
	//Pallet Handler Input Variables
	Pallet_lift(	Sensor_Data := ComTCP_SimInputs.pallet_lifter_AXIS,
					threshold_F := 0.8,
					Is_Bool 	:= FALSE);
	Pallet_holder(	Sensor_Raw 	:= ComTCP_SimInputs.pallet_fork_left_FB,
					threshold_B := 10,
					Is_Bool 	:= TRUE);
	IR_Sensor_3(	Sensor_Raw 	:= ComTCP_SimInputs.pallet_light_barrier_1_IR,
					threshold_B := 1,
					Is_Bool 	:= TRUE);
	IR_Sensor_4(	Sensor_Raw 	:= ComTCP_SimInputs.pallet_light_barrier_2_IR,
					threshold_B := 1,
					Is_Bool 	:= TRUE);
	//Filtered Data
	I_Pallet_lift_Act_Pos 		:= Pallet_lift.Sensor_Data_Filtered; //Pallet lifter actual position;
	I_Pallet_holder_State 		:= Pallet_holder.Sensor_Filtered; //pallet fork open;
	I_IR_Sensor_3 				:= IR_Sensor_3.Sensor_Filtered; //pallet present before assembly;
	I_IR_Sensor_4 				:= IR_Sensor_4.Sensor_Filtered; //pallet present after assembly;
	
	//HMI Main Input parameters
	Service_Mode := Service_Mode_HMI; 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

