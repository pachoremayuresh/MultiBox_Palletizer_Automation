
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	// Feeder Output Variables
	ComTCP_SimOutputs.conveyor_if_FWD 			:= O_Conveyor_1; //Conveyor_if control
	ComTCP_SimOutputs.pusher_FW 				:= O_Pusher_1; //pusher control
	ComTCP_SimOutputs.conveyer_turn1_FWD 		:= O_Conveyor_2; //conveyor_turn1 control
	ComTCP_SimOutputs.conveyer_end_FWD 			:= O_Conveyor_3; //conveyor_end control
	ComTCP_SimOutputs.turnpusher_FWD 			:= O_Turn_Pusher_ON; //turnpusher Forward
	ComTCP_SimOutputs.turnpusher_BWD 			:= O_Turn_Pusher_OFF; //turnpusher Backward
	ComTCP_SimOutputs.carriage_2_TGT_POS		:= O_Carriage_Tar_Pos; //Set Target Position for carriage
	
	//Crane Output Variables
	ComTCP_SimOutputs.gantry_crane_TGT_POS 		:= O_Gantry_Crane_Tar_Pos; //Set Gantry Crane Target Position
	ComTCP_SimOutputs.box_crane_TGT_POS 		:= O_Box_Crane_Tar_Pos; //Set Box Crane Target Position
	ComTCP_SimOutputs.cartboard_TRIG 			:= O_Cartboard_Trig; //release of first cartboard in the pile.
	ComTCP_SimOutputs.vaccum_box_crane_GRIP 	:= O_Vacuum_Grip_act; //holding the cartboard using vaccum
	ComTCP_SimOutputs.slide_rail_right_EN 		:= O_Box_Holder; //Hold box during the crane motion
	ComTCP_SimOutputs.pusher_z_EN 				:= O_Pusher_z; // move down layer pusher
	ComTCP_SimOutputs.pusher_x_EN 				:= O_Pusher_x; //move forward layer pusher
	
	//Pallet Handler Output Variables
	ComTCP_SimOutputs.pallet_lifter_TGT_POS 	:= O_Pallet_lift_Tar_Pos; //pallet lifter target position;
	ComTCP_SimOutputs.pallet_fork_left_EN 		:= O_Pallet_Holder; //Command to open fork;
	ComTCP_SimOutputs.pallet_conveyor_1_FWD 	:= O_Conveyor_4; //Controlling Pallet Conveyor 4;
	ComTCP_SimOutputs.pallet_conveyor_2_ACT_VEL := O_Conveyor_5_vel; //Controlling Pallet Conveyor 5 with velocity; 
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

