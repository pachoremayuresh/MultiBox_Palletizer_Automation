
TYPE
	Crane_State : 
		(
		Crane_Stop_Seq := 1,
		Crane_Stop_Done := 2,
		Reset_Crane_Config := 3,
		Restore_Crane_Config_1 := 4,
		Restore_Crane_Config_2 := 5,
		Restore_Crane_Config_3 := 6,
		Wait_Start := 7,
		Wait_Gantry_Crane_Start_Pos := 8,
		Wait_Cartboard_Load_Pos := 9,
		Wait_Cartboard_Load := 10,
		Wait_Box_Crane_Start_Pos := 11,
		Wait_Pusher_Z_Start_Pos_Down := 12,
		Wait_Pusher_X_Start_Pos_FWD := 13,
		Lock_Cartboard := 14,
		Wait_Boxes := 15,
		Wait_SlideRail_Hold := 16,
		Wait_Pusher_Z_Push_Pos_Up := 17,
		Wait_Pusher_X_Push_Pos_BKW := 18,
		Crane_Idle := 19,
		Wait_Pusher_Z_Push_Pos_Down := 20,
		Wait_Box_Crane_Cartboard_Pos := 21,
		Wait_Gantry_Crane_Cartboard_Pos := 22,
		Place_Cartboard := 23,
		Place_Boxes := 24,
		Open_SlideRail := 25,
		Pusher_FWD := 26
		);
END_TYPE
