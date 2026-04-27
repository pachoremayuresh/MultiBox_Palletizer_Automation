
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	CASE State OF
		0://
			IF Service_Mode THEN
				State := 1;
			END_IF
			
			CASE Pallet_Current_State OF
				Pallet_Stop_Seq:
					P_Current_State 			:= 'Pallet Stop Sequence';
					Start_Pallet 				:= FALSE;
					P_Conv_1_Dis_Req 			:= TRUE;
					Pallet_Lifter.Axis_Command 	:= Emergency_Stop_Req;
					Pallet_Conv_2.Axis_Command 	:= Emergency_Stop_Req;
					Pallet_Current_State 		:= Pallet_Stop_Done;				
					
				Pallet_Stop_Done:
					P_Current_State := 'Pallet Stop Done';
					IF (NOT P_Conv_1_Dis_Req AND Pallet_Lifter_Pos_Reached AND Pallet_Conv_2_Vel_Reached) THEN
						Pallet_Lifter.Axis_Command 	:= Idle;
						Pallet_Conv_2.Axis_Command 	:= Idle;
						P_Emergency_Stop 			:= FALSE;
						P_Immediate_Stop 			:= FALSE;
						P_On_Phase_Stop 			:= FALSE;
						Stop_Req 					:= TRUE;
						Pallet_Current_State 		:= Wait_Start;
					END_IF
										
				Reset_Pallet_Config_1:
					P_Current_State := 'Reset Pallet Configuration 1';
					IF NOT P_Reset_Config THEN
						Pallet_Current_State := Wait_Start;
					END_IF
					
					IF Pallet_Lifter_Pos_Reached THEN
						Pallet_Lifter.Axis_Command 	:= Idle;
						P_Fork_Dis_Req 				:= TRUE;
						Pallet_Current_State 		:= Reset_Pallet_Config_2;
					END_IF
					
				Reset_Pallet_Config_2:
					P_Current_State := 'Reset Pallet Configuration 2';
					IF NOT P_Fork_Dis_Req THEN
						Pallet_Lifter_Tar_Pos 		:= 0;
						Pallet_Lifter.Axis_Command 	:= Change_Pos;
						Pallet_Current_State 		:= Reset_Pallet_Config_3;
					END_IF				
					
				Reset_Pallet_Config_3:
					P_Current_State := 'Reset Pallet Configuration 3';
					IF Pallet_Lifter_Pos_Reached THEN
						Pallet_Lifter.Axis_Command := Idle;
						FOR a := 0 TO 3 DO
							En_Dis_Array[a] 	:= FALSE;
						END_FOR
						P_Reset_Config 			:= FALSE;
						Pallet_Current_State 	:= Wait_Start;
					END_IF
										
				Restore_Pallet_Config_1:
					P_Current_State 			:= 'Restore Pallet Configuration 1';
					Pallet_Lifter.Axis_Command 	:= Idle;
					Pallet_Conv_2.Axis_Command 	:= Idle;
					FOR a := 0 TO 3 DO
						IF En_Dis_Array[a] THEN
							CASE a OF 
								0:
									P_Fork_En_Req 		:= TRUE;
								1:
									P_Fork_Dis_Req 		:= TRUE;
								2:
									P_Conv_1_En_Req 	:= TRUE;
								3:
									P_Conv_1_Dis_Req 	:= TRUE;
							END_CASE
						END_IF
					END_FOR
					En_Dis_Counter 			:= 70;
					Pallet_Current_State 	:= Restore_Pallet_Config_2;			
					
				Restore_Pallet_Config_2:
					P_Current_State := 'Restore Pallet Configuration 2';
					FOR a := 0 TO 3 DO
						IF En_Dis_Array[a] THEN
							CASE a OF
								0:
									IF NOT P_Fork_En_Req THEN
										En_Dis_Array[a] 	:= FALSE;
									END_IF
									
								1:
									IF NOT P_Fork_Dis_Req THEN
										En_Dis_Array[a] 	:= FALSE;
									END_IF
									
								2:
									IF NOT P_Conv_1_En_Req THEN
										En_Dis_Array[a] 	:= FALSE;
									END_IF
									
								3:
									IF NOT P_Conv_1_Dis_Req THEN
										En_Dis_Array[a] 	:= FALSE;
									END_IF
							END_CASE
						END_IF
					END_FOR
					En_Dis_Counter := En_Dis_Counter - 1;
					
					IF En_Dis_Counter = 0 THEN
						IF Check_Pos THEN
							Pallet_Lifter_Tar_Pos 		:= Old_Pos;
							Pallet_Lifter.Axis_Command 	:= Change_Pos;
						END_IF
						
						IF Check_Vel THEN
							Pallet_Conv_2_Tar_Vel 		:= Old_Vel;
							Pallet_Conv_2.Axis_Command 	:= Change_Vel;
						END_IF
						Pallet_Current_State := Restore_Pallet_Config_3;
					END_IF
										
				Restore_Pallet_Config_3:
					P_Current_State := 'Restore Pallet Configuration 3';
					IF (Pallet_Lifter_Pos_Reached AND Check_Pos) THEN
						Pallet_Lifter_Pos_Restored := TRUE;
						Pallet_Lifter.Axis_Command := Idle;
					END_IF
					IF (Pallet_Conv_2_Vel_Reached AND Check_Vel) THEN
						Pallet_Conv_2_Vel_Restored := TRUE;
						Pallet_Conv_2.Axis_Command := Idle;
					END_IF
					IF (NOT Check_Pos OR Pallet_Lifter_Pos_Reached) AND (NOT Check_Vel OR Pallet_Conv_2_Vel_Reached) THEN
						Stop_Req 				:= FALSE;
						P_Restart 				:= FALSE;
						Pallet_Current_State 	:= Old_State;
					END_IF
										
				Wait_Start:
					P_Current_State := 'Wait Start';
					IF P_Restart THEN
						Pallet_Current_State := Restore_Pallet_Config_1;
					END_IF
					
					IF P_Reset_Config THEN
						Pallet_Counter 	:= 5;
						P_Ready 		:= FALSE;
						P_Exit_En 		:= FALSE;
						P_Exit_Done 	:= FALSE;
						IF Pallet_Fork.Dev_Disabled THEN
							Pallet_Lifter_Tar_Pos 		:= 0;
							Pallet_Lifter.Axis_Command 	:= Change_Pos;
							Pallet_Current_State 		:= Reset_Pallet_Config_3;
						ELSE
							Pallet_Lifter_Tar_Pos 		:= -0.258;
							Pallet_Lifter.Axis_Command 	:= Change_Pos;
							Pallet_Current_State 		:= Reset_Pallet_Config_1;
						END_IF
					END_IF
					
					IF (Start_Pallet AND NOT P_Reset_Config AND NOT P_Restart) THEN
						Pallet_Lifter_Tar_Pos 		:= -0.258;
						Pallet_Lifter.Axis_Command 	:= Change_Pos;
						Pallet_Current_State 		:= Wait_Lifter_Down;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop AND NOT Stop_Req THEN
						IF Pallet_On_Conv_2 THEN
							Check_Vel 			:= TRUE;
							Old_Vel 			:= 0.3;
							Pallet_On_Conv_2 	:= FALSE;
						END_IF
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop AND Stop_Req THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
										
				Wait_Lifter_Down:
					P_Current_State := 'Wait Lifter Down';
					IF (Pallet_Lifter_Pos_Reached OR Pallet_Lifter_Pos_Restored) THEN
						Check_Pos 					:= FALSE;
						Pallet_Lifter_Pos_Restored 	:= FALSE;
						Pallet_Lifter.Axis_Command 	:= Idle;
						P_Fork_En_Req 				:= TRUE;
						Pallet_Current_State 		:= Pallet_Fork_Open;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop OR P_On_Phase_Stop THEN
						IF Pallet_On_Conv_2 THEN
							Check_Vel 			:= TRUE;
							Old_Vel 			:= 0.3;
							Pallet_On_Conv_2 	:= FALSE;
						END_IF
						Check_Pos 				:= TRUE;
						Old_Pos 				:= -0.258;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Pallet_Fork_Open:
					P_Current_State := 'Pallet Fork Open';
					IF NOT P_Fork_En_Req THEN
						Pallet_Lifter_Tar_Pos 		:= -0.12;
						Pallet_Lifter.Axis_Command 	:= Change_Pos;
						Pallet_Current_State 		:= Wait_Lifter_Up;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop THEN
						IF Pallet_On_Conv_2 THEN
							Check_Vel 			:= TRUE;
							Old_Vel 			:= 0.3;
							Pallet_On_Conv_2 	:= FALSE;
						END_IF
						En_Dis_Array[0] 		:= TRUE;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Wait_Lifter_Up:
					P_Current_State := 'Wait Lifter Up';
					IF (Pallet_Lifter_Pos_Reached OR Pallet_Lifter_Pos_Restored) THEN
						Check_Pos 					:= FALSE;
						Pallet_Lifter_Pos_Restored 	:= FALSE;
						Pallet_Lifter.Axis_Command 	:= Idle;
						P_Fork_Dis_Req 				:= TRUE;
						Pallet_Current_State 		:= Pallet_Fork_Close;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop THEN
						Check_Pos 				:= TRUE;
						Old_Pos 				:= -0.12;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Pallet_Fork_Close:
					P_Current_State := 'Pallet Fork Close';
					IF NOT P_Fork_Dis_Req THEN
						Pallet_Lifter_Tar_Pos 		:= 0.0;
						Pallet_Lifter.Axis_Command 	:= Change_Pos;
						Pallet_Current_State 		:= Wait_Lifter_Idle;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop THEN
						En_Dis_Array[1] 		:= TRUE;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Wait_Lifter_Idle:
					P_Current_State := 'Wait Lifter Idle';
					IF (Pallet_Lifter_Pos_Reached OR Pallet_Lifter_Pos_Restored) THEN
						Check_Pos 					:= FALSE;
						Pallet_Lifter_Pos_Restored 	:= FALSE;
						Pallet_Lifter.Axis_Command 	:= Idle;
						Pallet_Counter 				:= Pallet_Counter - 1; 
						P_Conv_1_En_Req 			:= TRUE;
						Pallet_Current_State 		:= Wait_Pallet_Conv_1_Moving;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop THEN
						Check_Pos 				:= TRUE;
						Old_Pos 				:= 0.0;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Wait_Pallet_Conv_1_Moving:
					P_Current_State := 'Wait Pallet Conveyor 1 Moving';
					IF NOT P_Conv_1_En_Req THEN
						Pallet_Conv_2_Tar_Vel 		:= 0.5;
						Pallet_Conv_2.Axis_Command 	:= Change_Vel;
						Pallet_Current_State 		:= Wait_Pallet_Conv_2_Moving;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop THEN
						En_Dis_Array[2] 		:= TRUE;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Wait_Pallet_Conv_2_Moving:
					P_Current_State := 'Wait Pallet Conveyor 2 Moving';
					IF (Pallet_Conv_2_Vel_Reached OR Pallet_Conv_2_Vel_Restored) THEN
						Check_Vel 					:= FALSE;
						Pallet_Conv_2_Vel_Restored 	:= FALSE;
						Pallet_Conv_2.Axis_Command 	:= Idle;
						Pallet_Current_State 		:= Wait_Pallet_Light_Barrier_2;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop THEN
						En_Dis_Array[2] 		:= TRUE;
						Check_Vel 				:= TRUE;
						Old_Vel 				:= 0.5;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Wait_Pallet_Light_Barrier_2:
					P_Current_State := 'Wait Pallet Light Barrier 2';
					IF I_IR_Sensor_4 AND (Pallet_Conv_2_Vel_Restored OR NOT Check_Vel) THEN
						Check_Vel 					:= FALSE;
						Pallet_Conv_2_Vel_Restored 	:= FALSE;
						P_Conv_1_Dis_Req 			:= TRUE;
						Pallet_Current_State 		:= Wait_Stop_Pallet_Conv_1;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop THEN
						En_Dis_Array[2] 		:= TRUE;
						Check_Vel 				:= TRUE;
						Old_Vel 				:= 0.5;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Wait_Stop_Pallet_Conv_1:
					P_Current_State := 'Wait Stop Pallet Conveyor 1';
					IF NOT P_Conv_1_Dis_Req AND (Pallet_Conv_2_Vel_Restored OR NOT Check_Vel) THEN
						Check_Vel 					:= FALSE;
						Pallet_Conv_2_Vel_Restored 	:= FALSE;
						Pallet_Conv_2_Tar_Vel 		:= 0.1;
						Pallet_Conv_2.Axis_Command 	:= Change_Vel;
						Pallet_Current_State 		:= Wait_Conv_2_Slow_Down;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop THEN
						En_Dis_Array[3] 		:= TRUE;
						Check_Vel 				:= TRUE;
						Old_Vel 				:= 0.5;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Wait_Conv_2_Slow_Down:
					P_Current_State := 'Wait Pallet Conveyor 2 Slow Down';
					IF (Pallet_Conv_2_Vel_Reached OR Pallet_Conv_2_Vel_Restored) THEN
						Check_Vel 					:= FALSE;
						Pallet_Conv_2_Vel_Restored 	:= FALSE;
						Pallet_Conv_2.Axis_Command 	:= Idle;
						Pallet_Current_State 		:= Wait_Pallet_Light_Barrier_1;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop THEN
						En_Dis_Array[3] 		:= TRUE;
						Check_Vel 				:= TRUE;
						Old_Vel 				:= 0.1;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Wait_Pallet_Light_Barrier_1:
					P_Current_State := 'Wait Pallet Light Barrier 1';
					IF I_IR_Sensor_3 AND (Pallet_Conv_2_Vel_Restored OR NOT Check_Vel) THEN
						Check_Vel 					:= FALSE;
						Pallet_Conv_2_Vel_Restored 	:= FALSE;
						Pallet_Conv_2_Tar_Vel 		:= 0.0;
						Pallet_Conv_2.Axis_Command 	:= Change_Vel;
						Pallet_Current_State 		:= Wait_Stop_Pallet_Conv_2;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop THEN
						Check_Vel 				:= TRUE;
						Old_Vel 				:= 0.1;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Wait_Stop_Pallet_Conv_2:
					P_Current_State := 'Wait Stop Pallet Conveyor 2';
					IF (Pallet_Conv_2_Vel_Reached OR Pallet_Conv_2_Vel_Restored) THEN
						Check_Vel 					:= FALSE;
						Pallet_Conv_2_Vel_Restored 	:= FALSE;
						Pallet_Conv_2.Axis_Command 	:= Idle;
						P_Ready 					:= TRUE;
						Pallet_Current_State 		:= Wait_Boxes;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop THEN
						Check_Vel 				:= TRUE;
						Old_Vel 				:= 0.0;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Wait_Boxes:
					P_Current_State := 'Wait Boxes';
					IF P_Exit_En THEN
						Pallet_Conv_2_Tar_Vel 		:= 0.2;
						Pallet_Conv_2.Axis_Command 	:= Change_Vel;
						Pallet_Current_State 		:= Wait_Restart_Conv_2;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop OR P_On_Phase_Stop THEN
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Wait_Restart_Conv_2:
					P_Current_State := 'Wait Pallet Conveyor 2 Restart';
					IF (Pallet_Conv_2_Vel_Reached OR Pallet_Conv_2_Vel_Restored) THEN
						Check_Vel 					:= FALSE;
						Pallet_Conv_2_Vel_Restored 	:= FALSE;
						Pallet_Conv_2.Axis_Command 	:= Idle;
						Pallet_Current_State 		:= Wait_NOT_Pallet_Light_Barrier_2;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop THEN
						Check_Vel 				:= TRUE;
						Old_Vel 				:= 0.2;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Wait_NOT_Pallet_Light_Barrier_2:
					P_Current_State := 'Wait NOT Pallet Light Barrier 2';
					IF NOT I_IR_Sensor_4 AND (Pallet_Conv_2_Vel_Restored OR NOT Check_Vel) THEN
						Check_Vel 					:= FALSE;
						Pallet_Conv_2_Vel_Restored 	:= FALSE;
						Pallet_Conv_2_Tar_Vel 		:= 0.3;
						Pallet_Conv_2.Axis_Command 	:= Change_Vel;
						Pallet_Current_State 		:= Wait_Exit_Velocity;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop THEN
						Check_Vel 				:= TRUE;
						Old_Vel 				:= 0.2;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
					
				Wait_Exit_Velocity:
					P_Current_State := 'Wait Pallet Conveyor 2 Exit Velocity';
					IF (Pallet_Conv_2_Vel_Reached OR Pallet_Conv_2_Vel_Restored) THEN
						Check_Vel 					:= FALSE;
						Pallet_Conv_2_Vel_Restored 	:= FALSE;
						Pallet_Conv_2.Axis_Command 	:= Idle;
						Pallet_On_Conv_2 			:= TRUE;
						P_Exit_Done 				:= TRUE;
						Pallet_Current_State 		:= Wait_Start;
					END_IF
					
					IF P_Emergency_Stop THEN
						Pallet_Current_State := Pallet_Stop_Seq;
					END_IF
					
					IF P_Immediate_Stop THEN
						Check_Vel 				:= TRUE;
						Old_Vel 				:= 0.3;
						Old_State 				:= Pallet_Current_State;
						Pallet_Current_State 	:= Pallet_Stop_Seq;
					END_IF
			END_CASE
			
			Pallet_Lifter(	Axis_Act_Position 	:= I_Pallet_lift_Act_Pos,
							New_Set_Point 		:= Pallet_Lifter_Tar_Pos,
							Axis_Dev_Timer 		:= 400,
							Axis_TGT_Sensor 	:= TRUE);
			O_Pallet_lift_Tar_Pos 		:= Pallet_Lifter.Axis_TGT_Position;
			Pallet_Lifter_Pos_Reached 	:= Pallet_Lifter.Axis_In_Pos;
			e_Pallet_Lifter_Fault 		:= (*Pallet_Lifter.Axis_Dev_Fault OR*) Pallet_Lifter_Fault_HMI;
			
			Pallet_Fork(Dev_Operation 		:= Operation_Type,
						Dev_Type 			:= Dev_With_Enable_Feedback OR Dev_With_Single_Actuation,
						Dev_Enabled_Sensor 	:= I_Pallet_holder_State,
						Dev_Clock 			:= TRUE,
						Dev_Enable_Time 	:= Pallet_Fork_En_Time,
						Dev_Disable_Time 	:= Pallet_Fork_Dis_Time,
						Dev_Diagnose_Enable := TRUE,
						Dev_Enable_Preset 	:= FALSE,
						Dev_Enable_Request 	:= P_Fork_En_Req,
						Dev_Disable_Request := P_Fork_Dis_Req);
			O_Pallet_Holder 	:= Pallet_Fork.Dev_Enabled;
			e_Pallet_Fork_Fault := (*Pallet_Fork.Dev_Actuator_Fault OR Pallet_Fork.Dev_Disabled_Sensor_Fault OR *)Pallet_Fork_Fault_HMI;
			
			Pallet_Conv_1(	Dev_Operation 		:= Operation_Type,
							Dev_Type 			:= Dev_Without_Feedback OR Dev_With_Single_Actuation,
							Dev_Clock 			:= TRUE,
							Dev_Enable_Time 	:= Pallet_Conv_1_En_Time,
							Dev_Disable_Time 	:= Pallet_Conv_1_Dis_Time,
							Dev_Diagnose_Enable := TRUE,
							Dev_Enable_Preset 	:= FALSE,
							Dev_Enable_Request 	:= P_Conv_1_En_Req,
							Dev_Disable_Request := P_Conv_1_Dis_Req);
			O_Conveyor_4 		:= Pallet_Conv_1.Dev_Enabled;
			e_Conveyor_4_Fault 	:= (*Pallet_Conv_1.Dev_Actuator_Fault OR *)Pallet_Conv_1_Fault_HMI;
			
			Pallet_Conv_2(	Axis_Act_Velocity := O_Conveyor_5_vel,
							New_Set_Point := Pallet_Conv_2_Tar_Vel,
							Axis_Dev_Timer := 400);
			O_Conveyor_5_vel 			:= Pallet_Conv_2.Axis_TGT_Velocity;
			Pallet_Conv_2_Vel_Reached 	:= Pallet_Conv_2.Axis_In_Vel;
			e_Conveyor_5_Fault 			:= (*Pallet_Conv_2.Axis_Dev_Fault OR*) Pallet_Conv_2_Fault_HMI;
			
			
		1: //Service Mode
			//Actuation Servicing
			IF NOT Service_Mode THEN
				State := 0;
			END_IF
	
			O_Pallet_Holder := Pallet_fork_HMI;
			O_Conveyor_4 	:= Conveyor_4_HMI;
			
				IF NOT O_Conveyor_4 THEN
				O_Conveyor_4 := Conveyor_4_Jog_HMI;
			END_IF
	
			IF Conveyor_5_S1_HMI THEN
				Conveyor_5_S2_HMI 	:= FALSE;
				O_Conveyor_5_vel 	:= 0.5;
			ELSIF Conveyor_5_S2_HMI THEN
				Conveyor_5_S1_HMI 	:= FALSE;
				O_Conveyor_5_vel 	:= 0.1;
			ELSIF NOT (Conveyor_5_S1_HMI AND Conveyor_5_S2_HMI) THEN
				O_Conveyor_5_vel 	:= 0;
			END_IF
	
			IF Pallet_Lifter_Origin_pos_HMI THEN
				O_Pallet_lift_Tar_Pos 	:= 0;
			ELSIF Pallet_Lifter_TGT_pos_HMI THEN
				O_Pallet_lift_Tar_Pos 	:= Pallet_Lifter_TGT_HMI;
			END_IF
			Pallet_Lifter_TGT_dis_HMI 	:= Pallet_Lifter_TGT_HMI;
	
			Pallet_Lifter_Act_Pos_HMI 	:= I_Pallet_lift_Act_Pos;
			Pallet_Holder_State_HMI 	:= I_Pallet_holder_State; 
			IR_3_HMI 					:= I_IR_Sensor_3;
			IR_4_HMI 					:= I_IR_Sensor_4;
		
	END_CASE
	
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

