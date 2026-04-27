
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	CASE Main_State OF
		Emergency_Stop_Seq:
			M_Current_State := 'Emergency Stop Sequence';
			En_Machine 		:= FALSE;
			Start_Machine 	:= FALSE;
			IF (NOT Emergency_Stop AND NOT F_Emergency_Stop AND NOT C_Emergency_Stop AND NOT P_Emergency_Stop) THEN
				F_Reset_Config 	:= TRUE;
				C_Reset_Config 	:= TRUE;
				P_Reset_Config 	:= TRUE;
				Restart_Req 	:= FALSE;
				Main_State 		:= Wait_Start;
			END_IF
			
		Stop_Seq:
			M_Current_State := 'Stop Sequence';
			En_Machine 		:= FALSE;
			Start_Machine 	:= FALSE;
			Stop_Request 	:= TRUE;
			IF( NOT Immediate_Stop AND NOT F_Immediate_Stop AND NOT C_Immediate_Stop AND NOT P_Immediate_Stop) AND (NOT On_Phase_Stop AND NOT F_On_Phase_Stop AND NOT C_On_Phase_Stop AND NOT P_On_Phase_Stop) THEN
				En_Machine 	:= TRUE;
				Restart_Req := TRUE;
				Main_State 	:= Wait_Start;
			END_IF
			
			IF Emergency_Stop AND (On_Phase_Stop_Req OR Immediate_Stop_Req) THEN
				On_Phase_Stop_Req 	:= FALSE;
				Immediate_Stop_Req 	:= FALSE;
				F_Immediate_Stop 	:= FALSE;
				F_On_Phase_Stop 	:= FALSE;
				C_Immediate_Stop 	:= FALSE;
				C_On_Phase_Stop 	:= FALSE;
				P_Immediate_Stop 	:= FALSE;
				P_On_Phase_Stop 	:= FALSE;
				Main_State 			:= Wait_Start;
			END_IF
			
			IF Immediate_Stop AND On_Phase_Stop_Req THEN
				On_Phase_Stop_Req 	:= FALSE;
				F_On_Phase_Stop 	:= FALSE;
				C_On_Phase_Stop 	:= FALSE;
				P_On_Phase_Stop 	:= FALSE;
				Main_State 			:= Wait_Start;
			END_IF

		Wait_For_Restart:
			M_Current_State := 'Wait For Restart';
			IF (NOT F_Restart AND NOT C_Restart AND NOT P_Restart) THEN
				Stop_Request 		:= FALSE;
				Restart_Req 	:= FALSE;
				Start_Feeder 	:= TRUE;
				Start_Crane 	:= TRUE;
				Start_Pallet 	:= TRUE;
				Main_State 		:= Old_State;
			END_IF

		Wait_Start:
			M_Current_State := 'Wait Start';
			IF (Start_Machine AND En_Machine AND Restart_Req) THEN
				F_Restart 	:= TRUE;
				C_Restart 	:= TRUE;
				P_Restart 	:= TRUE;
				Main_State 	:= Wait_For_Restart;
			END_IF
			
			IF (NOT F_Reset_Config AND NOT C_Reset_Config AND NOT P_Reset_Config) THEN
				En_Machine := TRUE;
			END_IF
			
			IF (Start_Machine AND En_Machine AND NOT Restart_Req) THEN
				Start_Feeder 	:= TRUE;
				Start_Crane 	:= TRUE;
				Start_Pallet 	:= TRUE;
				Main_State 		:= Box_In_Position;
			END_IF
			
			IF Emergency_Stop THEN
				F_Emergency_Stop 	:= TRUE;
				C_Emergency_Stop 	:= TRUE;
				P_Emergency_Stop 	:= TRUE;
				Main_State 			:= Emergency_Stop_Seq;
			END_IF
			
			IF Immediate_Stop THEN
				Immediate_Stop_Req 	:= TRUE;
				IF NOT Stop_Request THEN
					Old_State 		:= Main_State;
				END_IF
				F_Immediate_Stop 	:= TRUE;
				C_Immediate_Stop 	:= TRUE;
				P_Immediate_Stop 	:= TRUE;
				Main_State := Stop_Seq;
			END_IF
			
			IF On_Phase_Stop AND NOT Stop_Request THEN
				On_Phase_Stop_Req := TRUE;
				IF NOT Stop_Request THEN
					Old_State := Main_State;
				END_IF
				F_On_Phase_Stop 	:= TRUE;
				C_On_Phase_Stop 	:= TRUE;
				P_On_Phase_Stop 	:= TRUE;
				Main_State 			:= Stop_Seq;
			END_IF

		Box_In_Position:
			M_Current_State := 'Box In Position';
			P_Exit_Done 	:= FALSE;
			Boxes_On_The_P 	:= FALSE;
			IF (F_Ready AND C_Ready) THEN
				Load_Boxes_On_The_C := TRUE;
				Main_State 			:= Box_On_The_Crane;
			END_IF
			
			IF Emergency_Stop THEN
				F_Emergency_Stop 	:= TRUE;
				C_Emergency_Stop 	:= TRUE;
				P_Emergency_Stop 	:= TRUE;
				Main_State 			:= Emergency_Stop_Seq;
			END_IF
			
			IF Immediate_Stop THEN
				Immediate_Stop_Req 	:= TRUE;
				Old_State 			:= Main_State;
				F_Immediate_Stop 	:= TRUE;
				C_Immediate_Stop 	:= TRUE;
				P_Immediate_Stop 	:= TRUE;
				Main_State := Stop_Seq;
			END_IF
			
			IF On_Phase_Stop THEN
				On_Phase_Stop_Req 	:= TRUE;
				Old_State 			:= Main_State;
				F_On_Phase_Stop 	:= TRUE;
				C_On_Phase_Stop 	:= TRUE;
				P_On_Phase_Stop 	:= TRUE;
				Main_State 			:= Stop_Seq;
			END_IF

		Box_On_The_Crane:
			M_Current_State := 'Box On The Crane';
			IF Boxes_On_The_C THEN
				F_Ready 			:= FALSE;
				C_Ready 			:= FALSE;
				Load_Boxes_On_The_C := FALSE;
				Hold_Boxes 			:= TRUE;
				Main_State 			:= Wait_For_Pallet;
			END_IF
			
			IF Emergency_Stop THEN
				F_Emergency_Stop 	:= TRUE;
				C_Emergency_Stop 	:= TRUE;
				P_Emergency_Stop 	:= TRUE;
				Main_State 			:= Emergency_Stop_Seq;
			END_IF
			
			IF Immediate_Stop THEN
				Immediate_Stop_Req 	:= TRUE;
				Old_State 			:= Main_State;
				F_Immediate_Stop 	:= TRUE;
				C_Immediate_Stop 	:= TRUE;
				P_Immediate_Stop 	:= TRUE;
				Main_State 			:= Stop_Seq;
			END_IF
			
			IF On_Phase_Stop THEN
				On_Phase_Stop_Req 	:= TRUE;
				Old_State 			:= Main_State;
				F_On_Phase_Stop 	:= TRUE;
				C_On_Phase_Stop 	:= TRUE;
				P_On_Phase_Stop 	:= TRUE;
				Main_State 			:= Stop_Seq;
			END_IF

		Wait_For_Pallet:
			M_Current_State := 'Wait For Pallet';
			IF P_Ready THEN
				Boxes_On_The_C 		:= FALSE;
				Load_Boxes_On_The_P := TRUE;
				Main_State 			:= Box_On_The_Pallet;
			END_IF
			
			IF Emergency_Stop THEN
				F_Emergency_Stop 	:= TRUE;
				C_Emergency_Stop 	:= TRUE;
				P_Emergency_Stop 	:= TRUE;
				Main_State 			:= Emergency_Stop_Seq;
			END_IF
			
			IF Immediate_Stop THEN
				Immediate_Stop_Req 	:= TRUE;
				Old_State 			:= Main_State;
				F_Immediate_Stop 	:= TRUE;
				C_Immediate_Stop 	:= TRUE;
				P_Immediate_Stop 	:= TRUE;
				Main_State 			:= Stop_Seq;
			END_IF
			
			IF On_Phase_Stop THEN
				On_Phase_Stop_Req 	:= TRUE;
				Old_State 			:= Main_State;
				F_On_Phase_Stop 	:= TRUE;
				C_On_Phase_Stop 	:= TRUE;
				P_On_Phase_Stop 	:= TRUE;
				Main_State 			:= Stop_Seq;
			END_IF

		Box_On_The_Pallet:
			M_Current_State := 'Box On The Pallet';
			IF Boxes_On_The_P THEN
				Hold_Boxes 			:= FALSE;
				Load_Boxes_On_The_P := FALSE;
				IF Second_Layer THEN
					P_Exit_En 	:= TRUE;
					Main_State 	:= Pallet_Exit;
				END_IF
				IF NOT Second_Layer THEN
					Main_State 	:= Wait_Start;
				END_IF
			END_IF
			
			IF Emergency_Stop THEN
				F_Emergency_Stop 	:= TRUE;
				C_Emergency_Stop 	:= TRUE;
				P_Emergency_Stop 	:= TRUE;
				Main_State 			:= Emergency_Stop_Seq;
			END_IF
			
			IF Immediate_Stop THEN
				Immediate_Stop_Req 	:= TRUE;
				Old_State 			:= Main_State;
				F_Immediate_Stop 	:= TRUE;
				C_Immediate_Stop 	:= TRUE;
				P_Immediate_Stop 	:= TRUE;
				Main_State 			:= Stop_Seq;
			END_IF
			
			IF On_Phase_Stop THEN
				On_Phase_Stop_Req 	:= TRUE;
				Old_State 			:= Main_State;
				F_On_Phase_Stop 	:= TRUE;
				C_On_Phase_Stop 	:= TRUE;
				P_On_Phase_Stop 	:= TRUE;
				Main_State 			:= Stop_Seq;
			END_IF
				
		Pallet_Exit:
			M_Current_State := 'Pallet Exit';
			IF P_Exit_Done THEN
				P_Ready 		:= FALSE;
				P_Exit_En 		:= FALSE;
				Second_Layer 	:= FALSE;
				Main_State 		:= Wait_Start;
			END_IF
		
			IF Emergency_Stop THEN
				F_Emergency_Stop 	:= TRUE;
				C_Emergency_Stop 	:= TRUE;
				P_Emergency_Stop 	:= TRUE;
				Main_State 			:= Emergency_Stop_Seq;
			END_IF
			
			IF Immediate_Stop THEN
				Immediate_Stop_Req 	:= TRUE;
				Old_State 			:= Main_State;
				F_Immediate_Stop 	:= TRUE;
				C_Immediate_Stop 	:= TRUE;
				P_Immediate_Stop 	:= TRUE;
				Main_State 			:= Stop_Seq;
			END_IF
			
			IF On_Phase_Stop THEN
				On_Phase_Stop_Req 	:= TRUE;
				Old_State 			:= Main_State;
				F_On_Phase_Stop 	:= TRUE;
				C_On_Phase_Stop 	:= TRUE;
				P_On_Phase_Stop 	:= TRUE;
				Main_State 			:= Stop_Seq;
			END_IF
				
	END_CASE
	


	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

