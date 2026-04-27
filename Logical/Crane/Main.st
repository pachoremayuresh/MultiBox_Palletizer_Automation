
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	CASE State OF
		0: //
			
			IF Service_Mode THEN
				State := 1;
			END_IF
			
			CASE Crane_Current_State OF
				
				Crane_Stop_Seq:
					C_Current_State 			:= 'Crane Stop Sequence';
					Start_Crane 				:= FALSE;
					Gantry_Crane.Axis_Command 	:= Emergency_Stop_Req;
					Box_Crane.Axis_Command 		:= Emergency_Stop_Req;
					Crane_Current_State 		:= Crane_Stop_Done;
					
				Crane_Stop_Done:
					C_Current_State := 'Crane Stop Done';
					IF (Gantry_Crane_Pos_Reached AND Box_Crane_Pos_Reached) THEN
						Gantry_Crane.Axis_Command 	:= Idle;
						Box_Crane.Axis_Command 		:= Idle;
						C_Emergency_Stop 			:= FALSE;
						C_Immediate_Stop 			:= FALSE;
						C_On_Phase_Stop 			:= FALSE;
						Stop_Req 					:= TRUE;
						Crane_Current_State 		:= Wait_Start;
					END_IF	
					
				Reset_Crane_Config:
					C_Current_State := 'Reset Crane Configuration';
					IF NOT C_Reset_Config THEN
						Crane_Current_State := Wait_Start;
					END_IF
					
					IF (Gantry_Crane_Pos_Reached AND Box_Crane_Pos_Reached AND NOT Box_Holder_Dis_Req AND NOT Pusher_X_En_Req AND NOT Pusher_Z_En_Req AND NOT Vacuum_Dis_Req AND NOT Cartboard_Dis_Req) THEN
						Gantry_Crane.Axis_Command 	:= Idle;
						Box_Crane.Axis_Command 		:= Idle;
						FOR a := 0 TO 9 DO
							En_Dis_Array[a] := FALSE;
						END_FOR;
						C_Reset_Config 		:=FALSE;
						Crane_Current_State := Wait_Start;
					END_IF
									
				Restore_Crane_Config_1:
					C_Current_State 			:= 'Restore Crane Configuration 1';
					Gantry_Crane.Axis_Command 	:= Idle;
					Box_Crane.Axis_Command 		:= Idle;
					FOR a := 0 TO 9 DO
						IF En_Dis_Array[a] THEN
							CASE a OF 
								0:
									Vacuum_En_Req 		:= TRUE;
								1:
									Vacuum_Dis_Req 		:= TRUE;
								2:
									Cartboard_En_Req 	:= TRUE;
								3:
									Cartboard_Dis_Req 	:= TRUE;
								4:
									Box_Holder_En_Req 	:= TRUE;
								5:
									Box_Holder_Dis_Req 	:= TRUE;
								6:
									Pusher_Z_En_Req 	:= TRUE;
								7:
									Pusher_Z_Dis_Req 	:= TRUE;
								8:
									Pusher_X_En_Req 	:= TRUE;
								9:
									Pusher_X_Dis_Req 	:= TRUE;
							END_CASE
						END_IF
					END_FOR
					En_Dis_Counter 		:= 70;
					Crane_Current_State := Restore_Crane_Config_2;							
					
				Restore_Crane_Config_2:
					C_Current_State := 'Restore Crane Configuration 2';
					FOR a := 0 TO 9 DO
						IF En_Dis_Array[a] THEN
							CASE a OF
								0:
									IF NOT Vacuum_En_Req THEN
										En_Dis_Array[a] := FALSE;
									END_IF
								1:
									IF NOT Vacuum_Dis_Req THEN
										En_Dis_Array[a] := FALSE;
									END_IF
									
								2:
									IF NOT Cartboard_En_Req THEN
										En_Dis_Array[a] := FALSE;
									END_IF
									
								3:
									IF NOT Cartboard_Dis_Req THEN
										En_Dis_Array[a] := FALSE;
									END_IF
									
								4:
									IF NOT Box_Holder_En_Req THEN
										En_Dis_Array[a] := FALSE;
									END_IF
									
								5:
									IF NOT Box_Holder_Dis_Req THEN
										En_Dis_Array[a] := FALSE;
									END_IF
									
								6:
									IF NOT Pusher_Z_En_Req THEN
										En_Dis_Array[a] := FALSE;
									END_IF
									
								7:
									IF NOT Pusher_Z_Dis_Req THEN
										En_Dis_Array[a] := FALSE;
									END_IF
									
								8:
									IF NOT Pusher_X_En_Req THEN
										En_Dis_Array[a] := FALSE;
									END_IF
									
								9:
									IF NOT Pusher_X_Dis_Req THEN
										En_Dis_Array[a] := FALSE;
									END_IF
							END_CASE
						END_IF
					END_FOR
					En_Dis_Counter := En_Dis_Counter - 1;
					
					IF En_Dis_Counter = 0 THEN
						IF Check_Pos[0] THEN
							Gantry_Crane_Tar_Pos 		:= Old_Pos[0];
							Gantry_Crane.Axis_Command 	:= Change_Pos;
						END_IF
						
						IF Check_Pos[1] THEN
							Box_Crane_Tar_Pos 		:= Old_Pos[1];
							Box_Crane.Axis_Command 	:= Change_Pos;
						END_IF
						Crane_Current_State := Restore_Crane_Config_3;
					END_IF
										
				Restore_Crane_Config_3:
					C_Current_State := 'Restore Crane Configuration 3';
					IF (Gantry_Crane_Pos_Reached AND Check_Pos[0]) THEN
						Gantry_Crane_Pos_Restored := TRUE;
						Gantry_Crane.Axis_Command := Idle;
					END_IF
					
					IF (Box_Crane_Pos_Reached AND Check_Pos[1]) THEN
						Box_Crane_Pos_Restored := TRUE;
						Box_Crane.Axis_Command := Idle;
					END_IF
					
					IF (NOT Check_Pos[0] OR Gantry_Crane_Pos_Restored) AND (NOT Check_Pos[1] OR Box_Crane_Pos_Restored) THEN
						Stop_Req 			:= FALSE;
						C_Restart 			:= FALSE;
						Crane_Current_State := Old_State;
					END_IF
					
				Wait_Start:
					C_Current_State := 'Wait Start';
					IF C_Restart THEN
						Crane_Current_State := Restore_Crane_Config_1;
					END_IF
					
					IF C_Reset_Config THEN
						Crane_Cartboard_Counter 	:= 28;
						C_Ready						:= FALSE;
						Hold_Boxes 					:= FALSE;
						Load_Boxes_On_The_P 		:= FALSE;
						Boxes_On_The_P 				:= FALSE;
						Box_Holder_Dis_Req 			:= TRUE;
						Pusher_Z_En_Req				:= TRUE;
						Pusher_X_En_Req				:= TRUE; 
						Vacuum_Dis_Req 				:= TRUE;
						Cartboard_Dis_Req 			:= TRUE;
						Gantry_Crane_Tar_Pos 		:= 0;
						Gantry_Crane.Axis_Command 	:= Change_Pos;
						Box_Crane_Tar_Pos			:= 0;
						Box_Crane.Axis_Command		:= Change_Pos;
						Crane_Current_State			:= Reset_Crane_Config;
					END_IF
					
					IF (Start_Crane AND NOT C_Reset_Config AND NOT C_Restart) THEN
						Gantry_Crane_Tar_Pos 		:= 0;
						Gantry_Crane.Axis_Command 	:= Change_Pos;
						Crane_Current_State 		:= Wait_Gantry_Crane_Start_Pos;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop AND NOT Stop_Req THEN
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop AND Stop_Req THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
				Wait_Gantry_Crane_Start_Pos:
					C_Current_State := 'Wait Gantry Crane Start In Position';
					IF (Gantry_Crane_Pos_Reached OR Gantry_Crane_Pos_Restored) THEN
						Check_Pos[0] 				:= FALSE;
						Gantry_Crane_Pos_Restored 	:= FALSE;
						Gantry_Crane.Axis_Command 	:= Idle;
						Box_Crane_Tar_Pos 			:= -0.195;
						Box_Crane.Axis_Command 		:= Change_Pos;
						Crane_Current_State 		:= Wait_Cartboard_Load_Pos;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						Check_Pos[0] 		:= TRUE;
						Old_Pos[0] 			:= 0;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF					
					
				Wait_Cartboard_Load_Pos:
					C_Current_State := 'Wait Cardboard Load In Position';
					IF (Box_Crane_Pos_Reached OR Box_Crane_Pos_Restored) THEN
						Check_Pos[1] 			:= FALSE;	
						Box_Crane_Pos_Restored 	:= FALSE;
						Box_Crane.Axis_Command 	:= Idle;
						Vacuum_En_Req 			:= TRUE;
						Cartboard_En_Req 		:= TRUE;
						Crane_Current_State 	:= Wait_Cartboard_Load;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						Check_Pos[1] 		:= TRUE;
						Old_Pos[1] 			:= -0.195;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
							
				Wait_Cartboard_Load:
					C_Current_State := 'Wait Cardboard Load';
					IF (NOT Vacuum_En_Req AND NOT Cartboard_En_Req) THEN
						Box_Crane_Tar_Pos 		:= 0;
						Box_Crane.Axis_Command 	:= Change_Pos;
						Crane_Current_State 	:= Wait_Box_Crane_Start_Pos;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						En_Dis_Array[0] 	:= TRUE;
						En_Dis_Array[2] 	:= TRUE;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
				Wait_Box_Crane_Start_Pos:
					C_Current_State := 'Wait Box Crane Start In Position';
					IF (Box_Crane_Pos_Reached OR Box_Crane_Pos_Restored) THEN
						Check_Pos[1] 			:= FALSE;
						Box_Crane_Pos_Restored 	:= FALSE;
						Box_Crane.Axis_Command 	:= Idle;
						Pusher_Z_En_Req 		:= TRUE;
						Crane_Current_State 	:= Wait_Pusher_Z_Start_Pos_Down;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						Check_Pos[1] 		:= TRUE;
						Old_Pos[1] 			:= 0;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
				Wait_Pusher_Z_Start_Pos_Down:
					C_Current_State := 'Wait Pusher Z Start In Position Down';
					IF NOT Pusher_Z_En_Req THEN
						Pusher_X_En_Req 	:= TRUE;
						Crane_Current_State := Wait_Pusher_X_Start_Pos_FWD;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						En_Dis_Array[6] 	:= TRUE;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF	
					
				Wait_Pusher_X_Start_Pos_FWD:
					C_Current_State := 'Wait Pusher X Start In Position Forward';
					IF NOT Pusher_X_En_Req THEN
						Cartboard_Dis_Req 	:= TRUE;
						Crane_Current_State := Lock_Cartboard;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						En_Dis_Array[8] 	:= TRUE;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
				Lock_Cartboard:
					C_Current_State := 'Lock Cardboard';
					IF NOT Cartboard_Dis_Req THEN
						Crane_Cartboard_Counter := Crane_Cartboard_Counter - 1;
						C_Ready 				:= TRUE;
						Crane_Current_State 	:= Wait_Boxes;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						En_Dis_Array[3] 	:= TRUE;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
				Wait_Boxes:
					C_Current_State := 'Wait Boxes';
					IF Hold_Boxes THEN
						Box_Holder_En_Req 	:= TRUE;
						Crane_Current_State := Wait_SlideRail_Hold;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop OR C_On_Phase_Stop THEN
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
				Wait_SlideRail_Hold:
					C_Current_State := 'Wait SlideRail Hold';
					IF NOT Box_Holder_En_Req THEN
						Pusher_Z_Dis_Req 	:= TRUE;
						Crane_Current_State := Wait_Pusher_Z_Push_Pos_Up;
					END_IF
										
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						En_Dis_Array[4] 	:= TRUE;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
										
				Wait_Pusher_Z_Push_Pos_Up:
					C_Current_State := 'Wait Pusher Z Push Position Up';
					IF NOT Pusher_Z_Dis_Req THEN
						Pusher_X_Dis_Req 	:= TRUE;
						Crane_Current_State := Wait_Pusher_X_Push_Pos_BKW;
					END_IF
										
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						En_Dis_Array[7] 	:= TRUE;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
										
				Wait_Pusher_X_Push_Pos_BKW:
					C_Current_State := 'Wait Pusher Z Push Position Backward';
					IF NOT Pusher_X_Dis_Req THEN
						Pusher_Z_En_Req 	:= TRUE;
						Crane_Current_State := Crane_Idle;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						En_Dis_Array[9] 	:= TRUE;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
				Crane_Idle:
					C_Current_State := 'Crane Idle';
					IF (Load_Boxes_On_The_P AND NOT Pusher_Z_En_Req) THEN
						Crane_Current_State := Wait_Pusher_Z_Push_Pos_Down;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						En_Dis_Array[6] 	:= TRUE;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
				Wait_Pusher_Z_Push_Pos_Down:
					C_Current_State := 'Wait Pusher Z Push Position Down';
					IF NOT Second_Layer THEN
						Box_Crane_Tar_Pos 		:= -0.2;
						Box_Crane.Axis_Command 	:= Change_Pos;
						Crane_Current_State 	:= Wait_Box_Crane_Cartboard_Pos;
					END_IF
					
					IF Second_Layer THEN
						Box_Crane_Tar_Pos 		:= 0.01;
						Box_Crane.Axis_Command 	:= Change_Pos;
						Crane_Current_State 	:= Wait_Box_Crane_Cartboard_Pos;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
				Wait_Box_Crane_Cartboard_Pos:
					C_Current_State := 'Wait Box Crane Cardboard In Position';
					IF (Box_Crane_Pos_Reached OR Box_Crane_Pos_Restored) THEN
						Check_Pos[1] 				:= FALSE;
						Box_Crane_Pos_Restored 		:= FALSE;
						Box_Crane.Axis_Command 		:= Idle;
						Gantry_Crane_Tar_Pos 		:= -1.11;
						Gantry_Crane.Axis_Command 	:= Change_Pos;
						Crane_Current_State 		:= Wait_Gantry_Crane_Cartboard_Pos;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						Check_Pos[1] := TRUE;
						IF NOT Second_Layer THEN
							Old_Pos[1] := -0.2;
						END_IF
						IF Second_Layer THEN
							Old_Pos[1] := 0.01;
						END_IF
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
				Wait_Gantry_Crane_Cartboard_Pos:
					C_Current_State := 'Wait Gantry Crane Cardboard In Position';
					IF (Gantry_Crane_Pos_Reached OR Gantry_Crane_Pos_Restored) THEN
						Check_Pos[0] 				:= FALSE;
						Gantry_Crane_Pos_Restored 	:= FALSE;
						Gantry_Crane.Axis_Command 	:= Idle;
						Vacuum_Dis_Req 				:= TRUE;
						Crane_Current_State 		:= Place_Cartboard;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						Check_Pos[0] 		:= TRUE;
						Old_Pos[0] 			:= -1.11;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
				Place_Cartboard:
					C_Current_State := 'Place Cardboard';
					IF NOT Vacuum_Dis_Req THEN
						Gantry_Crane_Tar_Pos 		:= -1.3;
						Gantry_Crane.Axis_Command 	:= Change_Pos;
						Crane_Current_State 		:= Place_Boxes;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						En_Dis_Array[1] 	:= TRUE;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
				Place_Boxes:
					C_Current_State := 'Place Boxes';
					IF (Gantry_Crane_Pos_Reached OR Gantry_Crane_Pos_Restored) THEN
						Check_Pos[0] := FALSE;
						Gantry_Crane_Pos_Restored := FALSE;
						Gantry_Crane.Axis_Command := Idle;
						Box_Holder_Dis_Req := TRUE;
						Crane_Current_State := Open_SlideRail;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						Check_Pos[0] 		:= TRUE;
						Old_Pos[0] 			:= -1.3;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
				Open_SlideRail:
					C_Current_State := 'Open SlideRail';
					IF NOT Box_Holder_Dis_Req THEN
						Pusher_X_En_Req 			:= TRUE;
						Gantry_Crane_Tar_Pos 		:= 0;
						Gantry_Crane.Axis_Command 	:= Change_Pos;
						Crane_Current_State 		:= Pusher_FWD;
					END_IF
					
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						En_Dis_Array[5] 	:= TRUE;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
				Pusher_FWD:
					C_Current_State := 'Pusher Forward';
					IF (NOT Pusher_X_En_Req AND (Gantry_Crane_Pos_Reached OR Gantry_Crane_Pos_Restored)) THEN
						Check_Pos[0] 				:= FALSE;
						Gantry_Crane_Pos_Restored 	:= FALSE;
						Gantry_Crane.Axis_Command 	:= Idle;
						Boxes_On_The_P 				:= TRUE;
						Crane_Current_State 		:= Wait_Start;
					END_IF
				
					IF C_Emergency_Stop THEN
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
					IF C_Immediate_Stop THEN
						En_Dis_Array[8] 	:= TRUE;
						Check_Pos[0] 		:= TRUE;
						Old_Pos[0] 			:= 0;
						Old_State 			:= Crane_Current_State;
						Crane_Current_State := Crane_Stop_Seq;
					END_IF
					
			END_CASE
			
			Gantry_Crane(	Axis_Act_Position 	:= I_Gantry_Crane_Act_Pos,
							New_Set_Point 		:= Gantry_Crane_Tar_Pos,
							Axis_Dev_Timer 		:= 400,
							Axis_TGT_Sensor 	:= TRUE);
			O_Gantry_Crane_Tar_Pos 		:= Gantry_Crane.Axis_TGT_Position;
			Gantry_Crane_Pos_Reached 	:= Gantry_Crane.Axis_In_Pos;
			e_Gantry_Crane_Fault 		:= (*Gantry_Crane.Axis_Dev_Fault OR*) Gantry_Crane_Fault_HMI;
		
			Box_Crane(	Axis_Act_Position 	:= I_Box_Crane_Act_Pos,
						New_Set_Point 		:= Box_Crane_Tar_Pos,
						Axis_Dev_Timer 		:= 400,
						Axis_TGT_Sensor 	:= TRUE);
			O_Box_Crane_Tar_Pos 	:= Box_Crane.Axis_TGT_Position;
			Box_Crane_Pos_Reached 	:= Box_Crane.Axis_In_Pos;
			e_Box_Crane_Fault 		:= (*Box_Crane.Axis_Dev_Fault OR*) Box_Crane_Fault_HMI;
	
			Cartboard(	Dev_Operation 		:= Operation_Type,
						Dev_Type 			:= Dev_Without_Feedback OR Dev_With_Single_Actuation,
						Dev_Clock 			:= TRUE,
						Dev_Enable_Time 	:= Cartboard_En_Time,
						Dev_Disable_Time 	:= Cartboard_Dis_Time,
						Dev_Diagnose_Enable := TRUE,
						Dev_Enable_Preset 	:= FALSE,
						Dev_Enable_Request 	:= Cartboard_En_Req,
						Dev_Disable_Request := Cartboard_Dis_Req);
			O_Cartboard_Trig 	:= Cartboard.Dev_Enabled;
			e_Cartboard_Fault 	:= (*Cartboard.Dev_Actuator_Fault OR*) Cartboard_Fault_HMI;
				
			Vacuum(	Dev_Operation 		:= Operation_Type,
					Dev_Type 			:= Dev_With_Enable_Feedback OR Dev_With_Single_Actuation,
					Dev_Enabled_Sensor 	:= I_Vacuum_retention_act,
					Dev_Clock 			:= TRUE,
					Dev_Enable_Time 	:= Vacuum_En_Time,
					Dev_Disable_Time 	:= Vacuum_Dis_Time,
					Dev_Diagnose_Enable := TRUE,
					Dev_Enable_Preset 	:= FALSE,
					Dev_Enable_Request 	:= Vacuum_En_Req,
					Dev_Disable_Request := Vacuum_Dis_Req);
			O_Vacuum_Grip_act 	:= Vacuum.Dev_Enabled;
			e_Vacuum_Fault 		:= (*Vacuum.Dev_Actuator_Fault OR Vacuum.Dev_Enabled_Sensor_Fault OR*) Vacuum_Fault_HMI;
		
			Box_Holder(	Dev_Operation 		:= Operation_Type,
						Dev_Type 			:= Dev_Without_Feedback OR Dev_With_Single_Actuation,
						Dev_Clock 			:= TRUE,
						Dev_Enable_Time 	:= Box_Holder_En_Time,
						Dev_Disable_Time 	:= Box_Holder_Dis_Time,
						Dev_Diagnose_Enable := TRUE,
						Dev_Enable_Preset 	:= FALSE,
						Dev_Enable_Request 	:= Box_Holder_En_Req,
						Dev_Disable_Request := Box_Holder_Dis_Req);
			O_Box_Holder := Box_Holder.Dev_Enabled;
			e_Box_Holder_Fault 	:= (*Box_Holder.Dev_Actuator_Fault OR*) Box_Holder_Fault_HMI;
						
			Pusher_X(	Dev_Operation 		:= Operation_Type,
						Dev_Type 			:= Dev_Without_Feedback OR Dev_With_Single_Actuation,
						Dev_Clock 			:= TRUE,
						Dev_Enable_Time 	:= Pusher_X_En_Time,
						Dev_Disable_Time 	:= Pusher_X_Dis_Time,
						Dev_Diagnose_Enable := TRUE,
						Dev_Enable_Preset 	:= FALSE,
						Dev_Enable_Request 	:= Pusher_X_En_Req,
						Dev_Disable_Request := Pusher_X_Dis_Req);
			O_Pusher_x 				:= Pusher_X.Dev_Enabled;
			e_Crane_Pusher_x_Fault 	:= (*Pusher_X.Dev_Actuator_Fault OR*) Crane_Pusher_X_Fault_HMI;
			
			Pusher_Z(	Dev_Operation 		:= Operation_Type,
						Dev_Type 			:= Dev_Without_Feedback OR Dev_With_Single_Actuation,
						Dev_Clock 			:= TRUE,
						Dev_Enable_Time 	:= Pusher_Z_En_Time,
						Dev_Disable_Time 	:= Pusher_Z_Dis_Time,
						Dev_Diagnose_Enable := TRUE,
						Dev_Enable_Preset 	:= FALSE,
						Dev_Enable_Request 	:= Pusher_Z_En_Req,
						Dev_Disable_Request := Pusher_Z_Dis_Req);
			O_Pusher_z 				:= Pusher_Z.Dev_Enabled;
			e_Crane_Pusher_z_Fault	:= (*Pusher_Z.Dev_Actuator_Fault OR*) Crane_Pusher_Z_Fault_HMI;
			
		1: //Service Mode
		//Actuation Servicing
			IF NOT Service_Mode THEN
				State := 0;
			END_IF
				
			O_Vacuum_Grip_act 	:= vaccume_box_crane_grip_HMI;
			O_Cartboard_Trig 	:= Cartboard_Trig_HMI;
			O_Box_Holder := Slide_rail_right_EN_HMI;
			O_Pusher_z 			:= pusher_z_EN_HMI;
			O_Pusher_x 			:= pusher_x_EN_HMI;
		
			IF gantry_crane_Origin_pos_HMI THEN
				O_Gantry_Crane_Tar_Pos 	:= 0;
			ELSIF gantry_crane_TGT_pos_HMI THEN
				O_Gantry_Crane_Tar_Pos 	:= gantry_crane_TGT_HMI;
			END_IF
			gantry_crane_TGT_dis_HMI 	:= gantry_crane_TGT_HMI;
	
			IF box_crane_Origin_pos_HMI THEN
				O_Box_Crane_Tar_Pos := 0;
			ELSIF box_crane_TGT_pos_HMI THEN
				O_Box_Crane_Tar_Pos := box_crane_TGT_HMI;
			END_IF
			box_crane_TGT_dis_HMI 	:= box_crane_TGT_HMI;
	
			vaccume_box_crane_state_HMI := I_Vacuum_retention_act;
			gantry_crane_Act_Pos_HMI 	:= I_Gantry_Crane_Act_Pos;
			box_crane_Act_Pos_HMI 		:= I_Box_Crane_Act_Pos;
		
	END_CASE
	
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

