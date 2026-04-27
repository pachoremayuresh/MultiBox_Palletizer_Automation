
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
			
			CASE Feeder_Current_State OF
				
				Feeder_Stop_Seq:
					F_Current_State			:= 'Feeder Stop Sequence';
					Start_Feeder 			:= FALSE;
					Conv_1_dis_req 			:= TRUE;
					Conv_2_dis_req 			:= TRUE;
					Conv_3_dis_req 			:= TRUE;
					Carriage.Axis_Command 	:= Emergency_Stop_Req;
					Feeder_Current_State 	:= Feeder_Stop_Done;
					
				Feeder_Stop_Done:
					F_Current_State			:= 'Feeder Stop Done';
					IF (NOT Conv_1_dis_req AND NOT Conv_2_dis_req AND NOT Conv_3_dis_req AND Carriage_Pos_Reached)THEN
						Carriage.Axis_Command 	:= Idle;
						F_Emergency_Stop 		:= FALSE;
						F_Immediate_Stop 		:= FALSE;
						F_On_Phase_Stop 		:= FALSE;
						Stop_Request 			:= TRUE;
						Feeder_Current_State 	:= Wait_Start;
					END_IF
					
				Reset_Feeder_Config:
					F_Current_State	:= 'Reset Feeder Configuration';
					IF NOT F_Reset_Config THEN
						Feeder_Current_State 	:= Wait_Start;
					END_IF
					
					IF (Carriage_Pos_Reached AND NOT Pusher_dis_req AND NOT Turnpusher_dis_req) THEN
						Carriage.Axis_Command 	:= Idle;
						Sensor_Memory[0] 		:= FALSE;
						Sensor_Memory[1] 		:= FALSE;
						Sensor_Reached[0] 		:= FALSE;
						Sensor_Reached[1] 		:= FALSE;
						FOR a := 0 TO 9 DO
							En_Dis_Array[a] 	:= FALSE;
						END_FOR
						F_Reset_Config			:= FALSE;
						Feeder_Current_State 	:= Wait_Start;
					END_IF
					
				Restore_Feeder_Config_1:
					F_Current_State			:= 'Restore Feeder Configuration 1';
					Carriage.Axis_Command 	:= Idle;
					FOR a := 0 TO 9 DO
						IF En_Dis_Array[a] THEN
							CASE a OF
								0:
									Conv_1_en_req 		:= TRUE;
								1:
									Conv_1_dis_req 		:= TRUE;
								2:
									Conv_2_en_req 		:= TRUE;
								3:
									Conv_2_dis_req 		:= TRUE;
								4:
									Conv_3_en_req 		:= TRUE;
								5:
									Conv_3_dis_req 		:= TRUE;
								6:
									Pusher_en_req 		:= TRUE;
								7:
									Pusher_dis_req 		:= TRUE;
								8:
									Turnpusher_en_req 	:= TRUE;
								9:
									Turnpusher_dis_req 	:= TRUE;
																
							END_CASE
						END_IF
					END_FOR
					En_Dis_Counter 			:= 70;	
					Feeder_Current_State 	:= Restore_Feeder_Config_2;
					
				Restore_Feeder_Config_2:
					F_Current_State	:= 'Restore Feeder Configuration 2';
					FOR a := 0 TO 9 DO
						IF En_Dis_Array[a] THEN
							CASE a OF
								0:
									IF NOT Conv_1_en_req THEN
										En_Dis_Array [a] := TRUE;
									END_IF
									
								1:
									IF NOT Conv_1_dis_req THEN
										En_Dis_Array [a] := TRUE;
									END_IF
									
								2:
									IF NOT Conv_2_en_req THEN
										En_Dis_Array [a] := TRUE;
									END_IF
									
								3:
									IF NOT Conv_2_dis_req THEN 		
										En_Dis_Array [a] := TRUE;
									END_IF
									
								4:
									IF NOT Conv_3_en_req THEN
										En_Dis_Array [a] := TRUE;
									END_IF
									
								5:
									IF NOT Conv_3_dis_req THEN
										En_Dis_Array [a] := TRUE;
									END_IF
									
								6:
									IF NOT Pusher_en_req THEN
										En_Dis_Array [a] := TRUE;
									END_IF
									
								7:
									IF NOT Pusher_dis_req THEN
										En_Dis_Array [a] := TRUE;
									END_IF
									
								8:
									IF NOT Turnpusher_en_req THEN
										En_Dis_Array [a] := TRUE;
									END_IF
									
								9:
									IF NOT Turnpusher_dis_req THEN
										En_Dis_Array [a] := TRUE;
									END_IF
							END_CASE
						END_IF
					END_FOR
					
					En_Dis_Counter := En_Dis_Counter - 1;
					
					IF En_Dis_Counter = 0 THEN
						IF Check_Pos THEN
							Carriage_Tar_Pos 		:= Old_Pos;
							Carriage.Axis_Command 	:= Change_Pos;
						END_IF
						Feeder_Current_State 		:= Restore_Feeder_Config_3;
					END_IF
					
				Restore_Feeder_Config_3:
					F_Current_State	:= 'Restore Feeder Configuration 3';
					IF (Carriage_Pos_Reached AND Check_Pos) THEN
						Carriage.Axis_Command := Idle;
						Carriage_Pos_Restored := TRUE;
					END_IF
					IF (NOT Check_Pos OR Carriage_Pos_Restored) THEN
						Stop_Request				:= FALSE;
						F_Restart 				:= FALSE;
						Feeder_Current_State 	:= Feeder_Old_State;
					END_IF
					
				Wait_Start:
					F_Current_State	:= 'Wait Start';
					IF F_Restart THEN					
						Feeder_Current_State 	:= Restore_Feeder_Config_1;
					END_IF
					
					IF F_Reset_Config THEN
						Box_Counter 			:= 0;
						F_Ready 				:= FALSE;
						C_Layer_Counter 		:= FALSE;
						Second_Layer 			:= FALSE;
						Load_Boxes_On_The_C 	:= FALSE;
						Boxes_On_The_C 			:= FALSE;
						Pusher_dis_req 			:= TRUE;
						Turnpusher_dis_req 		:= TRUE;
						Carriage_Tar_Pos 		:= 0;
						Carriage.Axis_Command 	:= Change_Pos;
						Feeder_Current_State 	:= Reset_Feeder_Config;
					END_IF
					
					IF (Start_Feeder AND NOT F_Reset_Config AND NOT F_Restart) THEN
						Conv_1_en_req 			:= TRUE;
						Feeder_Current_State 	:= Wait_Conveyor_1_Active;
					END_IF
					
					IF F_Emergency_Stop THEN
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
					IF F_Immediate_Stop AND NOT Stop_Request THEN
						Feeder_Old_State 		:= Feeder_Current_State;
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
					IF F_Immediate_Stop AND Stop_Request THEN
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF					
					
				Wait_Conveyor_1_Active:
					F_Current_State	:= 'Wait Conveyor 1 Active';
					IF NOT Conv_1_en_req THEN
						Feeder_Current_State	:= Wait_Pusher_Position;
					END_IF;
					
					IF F_Emergency_Stop THEN
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
					IF F_Immediate_Stop THEN
						En_Dis_Array[0] 		:= TRUE;
						Feeder_Old_State 		:= Feeder_Current_State;
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
				Wait_Pusher_Position:
					F_Current_State	:= 'Wait Pusher in Position';
					IF (I_IR_Sensor_1 OR (Sensor_Reached[0] AND Sensor_Memory[0])) THEN
						Sensor_Reached[0] 		:= FALSE;
						Sensor_Memory[0] 		:= FALSE;
						Conv_1_dis_req 			:= TRUE;
						Conv_2_en_req 			:= TRUE;
						Conv_3_en_req 			:= TRUE;
						Feeder_Current_State 	:= Layer_Check;
					END_IF
					
					IF F_Emergency_Stop THEN
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
			
					IF F_Immediate_Stop THEN
						Sensor_Memory[0] 		:= TRUE;
						En_Dis_Array[0] 		:= TRUE;
						Feeder_Old_State 		:= Feeder_Current_State;
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
				Layer_Check:
					F_Current_State	:= 'Layer Check';
					IF (NOT Conv_1_dis_req AND NOT Conv_2_en_req AND NOT Conv_3_en_req) THEN
						IF NOT C_Layer_Counter THEN
							IF Box_Counter < 8 THEN
								Turnpusher_dis_req 		:= TRUE;
								Pusher_en_req 			:= TRUE;
								Main_Line 				:= TRUE;
								Feeder_Current_State 	:= Line_Check;
							END_IF
							IF Box_Counter >= 8 THEN
								Turnpusher_en_req 		:= TRUE;
								Pusher_en_req 			:= TRUE;
								Main_Line 				:= FALSE;
								Feeder_Current_State 	:= Line_Check;
							END_IF
						END_IF
						
						IF C_Layer_Counter THEN
							IF Box_Counter < 6 THEN
								Turnpusher_en_req 		:= TRUE;
								Pusher_en_req 			:= TRUE;
								Main_Line 				:= FALSE;
								Feeder_Current_State 	:= Line_Check;
							END_IF
							IF Box_Counter >= 6 THEN
								Turnpusher_dis_req 		:= TRUE;
								Pusher_en_req 			:= TRUE;
								Main_Line 				:= TRUE;
								Feeder_Current_State 	:= Line_Check;
							END_IF
						END_IF
					END_IF		
							
					IF F_Emergency_Stop THEN
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
					IF F_Immediate_Stop THEN
						En_Dis_Array[1] 		:= TRUE;
						En_Dis_Array[2] 		:= TRUE;
						En_Dis_Array[4] 		:= TRUE;
						Feeder_Old_State 		:= Feeder_Current_State;
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
				Line_Check:
					F_Current_State	:= 'Line Check';
					IF (NOT Turnpusher_dis_req AND NOT Pusher_en_req AND Main_Line) THEN
						Pusher_dis_req 			:= TRUE;
						Feeder_Current_State 	:= Wait_IR_Sensor_2;
					END_IF
					
					IF (NOT Turnpusher_en_req AND NOT Pusher_en_req AND NOT Main_Line) THEN
						Pusher_dis_req 			:= TRUE;
						Feeder_Current_State 	:= Wait_IR_Sensor_2;
					END_IF
					
					IF F_Emergency_Stop THEN
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
					IF F_Immediate_Stop THEN
						Sensor_Memory[1] 		:= TRUE;
						En_Dis_Array[2] 		:= TRUE;
						En_Dis_Array[4] 		:= TRUE;
						En_Dis_Array[6] 		:= TRUE;
						IF Main_Line THEN
							En_Dis_Array[9] 	:= TRUE;
						END_IF
						IF NOT Main_Line THEN
							En_Dis_Array[8] 	:= TRUE;
						END_IF
						Feeder_Old_State 		:= Feeder_Current_State;
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
				Wait_IR_Sensor_2:
					F_Current_State	:= 'Wait IR Sensor 2';
					IF ((I_IR_Sensor_2 OR (Sensor_Reached[1] AND Sensor_Memory[1])) AND NOT Pusher_dis_req) THEN
						Sensor_Reached[1] 		:= FALSE;
						Sensor_Memory[1] 		:= FALSE;
						Box_Counter 			:= Box_Counter + 1;
						Feeder_Current_State 	:= Box_In_Pos;
					END_IF
					
					IF F_Emergency_Stop THEN
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
					IF F_Immediate_Stop THEN
						Sensor_Memory[1] 		:= TRUE;
						En_Dis_Array[2] 		:= TRUE;
						En_Dis_Array[4] 		:= TRUE;
						En_Dis_Array[7] 		:= TRUE;
						Feeder_Old_State 		:= Feeder_Current_State;
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
				Box_In_Pos:
					F_Current_State	:= 'Box In Position';
					IF NOT C_Layer_Counter THEN
						IF (Box_Counter = 8 OR Box_Counter = 11 OR Box_Counter = 14) THEN
							Conv_2_dis_req 			:= TRUE;
							Feeder_Current_State 	:= Wait_Conveyor_Stop;
						ELSE
							Feeder_Current_State 	:= Wait_Start;
						END_IF
					END_IF
					
					IF C_Layer_Counter THEN
						IF (Box_Counter = 3 OR Box_Counter = 6 OR Box_Counter = 14) THEN
							Conv_2_dis_req 			:= TRUE;
							Feeder_Current_State 	:= Wait_Conveyor_Stop;
						ELSE
							Feeder_Current_State 	:= Wait_Start;
						END_IF
					END_IF
										
					IF F_Emergency_Stop THEN
						Feeder_Current_State 		:= Feeder_Stop_Seq;
					END_IF
					
					IF F_Immediate_Stop THEN
						En_Dis_Array[2] 		:= TRUE;
						En_Dis_Array[4] 		:= TRUE;
						Feeder_Old_State 		:= Feeder_Current_State;
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
				Wait_Conveyor_Stop:
					F_Current_State	:= 'Wait Conveyor Stop';
					IF NOT Conv_2_dis_req THEN
						IF Box_Counter = 14 THEN
							Feeder_Current_State 	:= Feeder_Idle;
						END_IF
						IF Box_Counter < 14 THEN
							End_Layer := FALSE;
							Carriage_Tar_Pos 		:= 0.44;
							Carriage.Axis_Command 	:= Change_Pos;
							Feeder_Current_State 	:= Carriage_FWD_Pos;
						END_IF
					END_IF
					
					IF F_Emergency_Stop THEN
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
					IF F_Immediate_Stop THEN
						En_Dis_Array[3] 		:= TRUE;
						En_Dis_Array[4] 		:= TRUE;
						Feeder_Old_State 		:= Feeder_Current_State;
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF

				Feeder_Idle:
					F_Current_State	:= 'Feeder Idle';
					F_Ready 		:= TRUE;
					IF C_Layer_Counter THEN
						Second_Layer := TRUE;
					END_IF
					
					IF Load_Boxes_On_The_C THEN
						End_Layer 				:= TRUE;
						C_Layer_Counter 		:= NOT C_Layer_Counter;
						Carriage_Tar_Pos 		:= 1.1;
						Carriage.Axis_Command 	:= Change_Pos;
						Feeder_Current_State 	:= Carriage_FWD_Pos;
					END_IF
					
					IF F_Emergency_Stop THEN
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
					IF F_Immediate_Stop OR F_On_Phase_Stop THEN
						En_Dis_Array[4] 		:= TRUE;
						Feeder_Old_State 		:= Feeder_Current_State;
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
				Carriage_FWD_Pos:
					F_Current_State	:= 'Carriage In Forward Position';
					IF (Carriage_Pos_Reached OR Carriage_Pos_Restored) THEN
						Check_Pos 				:= FALSE;
						Carriage_Pos_Restored 	:= FALSE;
						Carriage.Axis_Command 	:= Idle;
						Feeder_Current_State 	:= Carriage_BWD_Pos;
					END_IF
					
					IF F_Emergency_Stop THEN
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
					IF F_Immediate_Stop THEN
						En_Dis_Array[4] 		:= TRUE;
						IF End_Layer THEN
							Check_Pos 	:= TRUE;
							Old_Pos 	:= 1.1;
						END_IF
						IF NOT End_Layer THEN
							Check_Pos 	:= TRUE;
							Old_Pos 	:= 0.44;
						END_IF
						Feeder_Old_State 		:= Feeder_Current_State;
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
				Carriage_BWD_Pos:
					F_Current_State	:= 'Carriage in Backward Position';
					IF NOT Carriage.Axis_In_Pos THEN
						Carriage_Tar_Pos 		:= 0.0;
						Carriage.Axis_Command 	:= Change_Pos;
						Feeder_Current_State 	:= Wait_Start_Pos;
					END_IF
					
					IF F_Emergency_Stop THEN
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
					IF F_Immediate_Stop THEN
						En_Dis_Array[4] 		:= TRUE;
						Feeder_Old_State 		:= Feeder_Current_State;
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
				Wait_Start_Pos:
					F_Current_State	:= 'Wait State Position';
					IF Box_Counter = 14 THEN
						Boxes_On_The_C 		:= TRUE;
						Box_Counter 		:= 0;
					END_IF
					
					IF (Carriage_Pos_Reached OR Carriage_Pos_Restored) THEN
						Check_Pos 				:= FALSE;
						Carriage_Pos_Restored 	:= FALSE;
						Carriage.Axis_Command 	:= Idle;
						Feeder_Current_State 	:= Wait_Start;
					END_IF
					
					IF F_Emergency_Stop THEN
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
					IF F_Immediate_Stop THEN
						En_Dis_Array[4] 		:= TRUE;
						Check_Pos 				:= TRUE;
						Old_Pos 				:= 0;
						Feeder_Old_State 		:= Feeder_Current_State;
						Feeder_Current_State 	:= Feeder_Stop_Seq;
					END_IF
					
			END_CASE
			
			IF I_IR_Sensor_1 THEN
				Sensor_Reached[0] := TRUE;
			END_IF
			
			IF I_IR_Sensor_2 THEN
				Sensor_Reached[1] := TRUE;
			END_IF
			
			//Conveyor_IF
			Conveyor_1(	Dev_Operation 		:= Operation_Type,
						Dev_Type 			:= Dev_Without_Feedback OR Dev_With_Single_Actuation,
						Dev_Clock 			:= TRUE,
						Dev_Enable_Time 	:= Conv_1_En_Time,
						Dev_Disable_Time	:= Conv_1_Dis_Time,
						Dev_Diagnose_Enable := TRUE,
						Dev_Enable_Preset 	:= FALSE,
						Dev_Enable_Request 	:= Conv_1_en_req,
						Dev_Disable_Request := Conv_1_dis_req);
			O_Conveyor_1		:= Conveyor_1.Dev_Enabled;
			e_Conveyor_1_Fault 	:= (*Conveyor_1.Dev_Actuator_Fault OR*) Conveyor_1_Fault_HMI;
			
			//Conveyor_Turn1
			Conveyor_2(	Dev_Operation 		:= Operation_Type,
						Dev_Type 			:= Dev_Without_Feedback OR Dev_With_Single_Actuation,
						Dev_Clock 			:= TRUE,
						Dev_Enable_Time 	:= Conv_2_En_Time,
						Dev_Disable_Time	:= Conv_2_Dis_Time,
						Dev_Diagnose_Enable := TRUE,
						Dev_Enable_Preset 	:= FALSE,
						Dev_Enable_Request 	:= Conv_2_en_req,
						Dev_Disable_Request := Conv_2_dis_req);
			O_Conveyor_2 		:= Conveyor_2.Dev_Enabled;
			e_Conveyor_2_Fault 	:= (*Conveyor_2.Dev_Actuator_Fault OR*) Conveyor_2_Fault_HMI;
			
			//Pusher
			Pusher_1(	Dev_Operation 		:= Operation_Type,
						Dev_Type 			:= Dev_With_Double_Feedback OR Dev_With_Single_Actuation,
						Dev_Enabled_Sensor 	:= I_Pusher_1_F,
						Dev_Disabled_Sensor := I_Pusher_1_B,
						Dev_Clock 			:= TRUE,
						Dev_Enable_Time 	:= Pusher_1_En_Time,
						Dev_Disable_Time	:= Pusher_1_Dis_Time,
						Dev_Diagnose_Enable := TRUE,
						Dev_Enable_Preset 	:= FALSE,
						Dev_Enable_Request 	:= Pusher_en_req,
						Dev_Disable_Request := Pusher_dis_req);
			O_Pusher_1 				:= Pusher_1.Dev_Enabled;
			e_Feeder_Pusher_Fault 	:= (*Pusher_1.Dev_Fault OR*) Pusher_1_Fault_HMI;
			
			//Conveoyr_end
			Conveyor_3(	Dev_Operation 		:= Operation_Type,
						Dev_Type 			:= Dev_Without_Feedback OR Dev_With_Single_Actuation,
						Dev_Clock 			:= TRUE,
						Dev_Enable_Time 	:= Conv_3_En_Time,
						Dev_Disable_Time	:= Conv_3_Dis_Time,
						Dev_Diagnose_Enable := TRUE,
						Dev_Enable_Preset 	:= FALSE,
						Dev_Enable_Request 	:= Conv_3_en_req,
						Dev_Disable_Request := Conv_3_dis_req);
			O_Conveyor_3 		:= Conveyor_3.Dev_Enabled;
			e_Conveyor_3_Fault 	:= (*Conveyor_3.Dev_Actuator_Fault OR*) Conveyor_3_Fault_HMI;
			
			//Turn_Pusher
			Turn_Pusher(	Dev_Operation 		:= Operation_Type,
							Dev_Type 			:= Dev_With_Double_Feedback OR Dev_With_Double_Actuation,
							Dev_Enabled_Sensor 	:= I_Turn_Push_B,
							Dev_Disabled_Sensor := I_Turn_Push_F,
							Dev_Clock 			:= TRUE,
							Dev_Enable_Time 	:= Turn_Pusher_En_Time,
							Dev_Disable_Time	:= Turn_Pusher_Dis_Time,
							Dev_Diagnose_Enable := TRUE,
							Dev_Enable_Preset 	:= FALSE,
							Dev_Enable_Request 	:= Turnpusher_en_req,
							Dev_Disable_Request := Turnpusher_dis_req);
			O_Turn_Pusher_OFF		:= Turn_Pusher.Dev_Enabled;
			O_Turn_Pusher_ON		:= Turn_Pusher.Dev_Disabled;
			e_Turn_Pusher_Fault 	:= (*Turn_Pusher.Dev_Fault OR*) Turn_Pusher_Fault_HMI;
			
			//Carriage
			Carriage(	Axis_Act_Position 	:= I_Carriage_Push_Act_Pos,
						New_Set_Point 		:= Carriage_Tar_Pos,
						Axis_Dev_Timer 		:= 400,
						Axis_TGT_Sensor 	:= I_Carriage_Push_Tar_Rec);
			O_Carriage_Tar_Pos 		:= Carriage.Axis_TGT_Position;
			Carriage_Pos_Reached 	:= Carriage.Axis_In_Pos;
			e_Carriage_Fault 		:= (*Carriage.Axis_Dev_Fault OR*) Carriage_Fault_HMI;
			
		1: //Service Mode
			//Actuation Servicing
			IF NOT Service_Mode THEN
				State := 0;
			END_IF
			
			
			O_Conveyor_1 		:= Conveyor_1_HMI;
			IF NOT O_Conveyor_1 THEN
				O_Conveyor_1 	:= Conveyor_1_Jog_HMI;
			END_IF
			O_Conveyor_2 		:= Conveyor_2_HMI;
			IF NOT O_Conveyor_2 THEN
				O_Conveyor_2 	:= Conveyor_2_Jog_HMI;
			END_IF
			O_Conveyor_3 		:= Conveyor_3_HMI;
			IF NOT O_Conveyor_3 THEN
				O_Conveyor_3 	:= Conveyor_3_Jog_HMI;
			END_IF
			O_Pusher_1 		:= Pusher_1_HMI;
			IF NOT O_Pusher_1 THEN
				O_Pusher_1 	:= Pusher_1_Jog_HMI;
			END_IF
			
			O_Turn_Pusher_ON 	:= Turn_Pusher_ON_HMI;
			O_Turn_Pusher_OFF 	:= Turn_Pusher_OFF_HMI;
			
			Carriage_Tar_Pos_Dis_HMI 	:= Carriage_Target_Pos_HMI;
			IF Carriage_Push_Origin_HMI THEN
				O_Carriage_Tar_Pos 		:= 0.0;
			ELSIF Carriage_Push_Target_HMI THEN
				O_Carriage_Tar_Pos 		:= Carriage_Target_Pos_HMI;
			END_IF
			
			//Sensor Servicing
			IR1_HMI 						:= I_IR_Sensor_1;
			IR2_HMI 						:= I_IR_Sensor_2;
			Turn_Pusher_F_HMI 				:= I_Turn_Push_B;
			Turn_Pusher_B_HMI 				:= I_Turn_Push_F;
			Pusher_1_F_HMI 					:= I_Pusher_1_F;
			Pusher_1_B_HMI 					:= I_Pusher_1_B;
			Carriage_Push_TarRech_HMI 		:= I_Carriage_Push_Tar_Rec;
			Carriage_Push_ActPos_Dis_HMI 	:= I_Carriage_Push_Act_Pos;
			
	END_CASE
	
			
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

