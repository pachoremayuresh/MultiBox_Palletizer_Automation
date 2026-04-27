
TYPE
	Feeder_State : 
		(
		Feeder_Stop_Seq := 1,
		Feeder_Stop_Done := 2,
		Reset_Feeder_Config := 3,
		Restore_Feeder_Config_1 := 4,
		Restore_Feeder_Config_2 := 5,
		Restore_Feeder_Config_3 := 6,
		Wait_Start := 7,
		Wait_Conveyor_1_Active := 8,
		Wait_Pusher_Position := 9,
		Layer_Check := 10,
		Line_Check := 11,
		Wait_IR_Sensor_2 := 12,
		Box_In_Pos := 13,
		Wait_Conveyor_Stop := 14,
		Feeder_Idle := 15,
		Carriage_FWD_Pos := 16,
		Carriage_BWD_Pos := 17,
		Wait_Start_Pos := 18
		);
END_TYPE
