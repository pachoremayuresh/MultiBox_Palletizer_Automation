
FUNCTION_BLOCK Signal_Mng
	
	CASE Operation_Type OF
		
		Start_Configuration:
			Number_of_Alarms 		:= 0;
			Number_of_Anomalies 	:= 0;
			Number_of_Warnings 		:= 0;
			Number_of_Information 	:= 0;
			
		Configuration:
			CASE (Signal_Type AND Signal_Type_Mask) OF
				Alarm:
					Number_of_Alarms 		:= Number_of_Alarms + 1;
				Anomaly:
					Number_of_Anomalies		:= Number_of_Anomalies + 1;
				Warning:
					Number_of_Warnings 		:= Number_of_Warnings + 1;
				Information:
					Number_of_Information 	:= Number_of_Information + 1;
			END_CASE
			
		Start_Generation:
			Aux_Reset_Enable 		:= FALSE;
			Reset_Enable 			:= FALSE;
			Signal_Outputs 			:= Sign_None;
			Reset_Activation 		:= Reset AND NOT Reset_Old;
			Reset_Old 				:= Reset;
			Aux_Reset_Activation 	:= Key_Reset AND NOT Key_Reset_Old;
			Key_Reset_Old 			:= Key_Reset;
			
		Generation:
			CASE (Signal_Type AND Signal_Type_Mask) OF
				Alarm:
					Index 		:= Number_of_Active_Alarms;
					Base_Index 	:= 0;
					Condition 	:= TRUE;
					
				Anomaly:
					Index 		:= Number_of_Active_Anomalies;
					Base_Index 	:= Number_of_Alarms;
					Condition 	:= TRUE;
					
				Warning:
					Index 		:= Number_of_Active_Warning;
					Base_Index 	:= Number_of_Alarms + Number_of_Anomalies;
					Condition 	:= FALSE;
				
				Information:
					Index 		:= Number_of_Active_Information;
					Base_Index 	:= Number_of_Alarms + Number_of_Anomalies + Number_of_Warnings;
					Condition 	:= FALSE;
			END_CASE
			
			
			IF Activation_Signal AND NOT Signals[Signal_Code] THEN
				Signals[Signal_Code] 					:= TRUE;
				Index 									:= Index + 1;
				Active_Signal_Codes[Base_Index + Index] := Signal_Code;

			END_IF
			
			Aux_Reset_Required := ((Signal_Type AND Aux_Reset) = Aux_Reset);
			
			IF (Condition AND Signals[Signal_Code] AND NOT Activation_Signal AND (Active_Signal_Codes[Base_Index + 1] = Signal_Code) AND Aux_Reset_Required) THEN
				Aux_Reset_Enable 						:= TRUE;
			END_IF
			
			IF (Condition AND Signals[Signal_Code] AND NOT Activation_Signal AND (Active_Signal_Codes[Base_Index + 1] = Signal_Code) AND NOT Aux_Reset_Required) THEN
				Reset_Enable							:= TRUE;
			END_IF
			
			IF ((Reset_Activation OR NOT Condition) AND Signals[Signal_Code] AND NOT Activation_Signal AND (Active_Signal_Codes[Base_Index + 1] = Signal_Code) AND NOT Aux_Reset_Required) THEN
				Signals[Signal_Code] 					:= FALSE;
				
				FOR i := 2 TO Index DO
					Active_Signal_Codes[Base_Index + i-1] 	:= Active_Signal_Codes[Base_Index + i];
				END_FOR
				
				Active_Signal_Codes[Base_Index + Index] 	:= 0;
				Index 										:= Index - 1;
				Reset_Activation 							:= FALSE;
			END_IF
			
			IF ((Aux_Reset_Activation OR NOT Condition) AND Signals[Signal_Code] AND NOT Activation_Signal AND (Active_Signal_Codes[Base_Index + 1] = Signal_Code) AND Aux_Reset_Required) THEN
				Signals[Signal_Code] := FALSE;
				
				FOR i := 2 TO Index DO
					Active_Signal_Codes[Base_Index + i-1] := Active_Signal_Codes[Base_Index + i];
				END_FOR;
				
				Active_Signal_Codes[Base_Index + Index] := 0;
				Index := Index - 1;
				Aux_Reset_Activation := FALSE; 
			END_IF
			
			CASE (Signal_Type AND Signal_Type_Mask) OF
				Alarm:
					Number_of_Active_Alarms 		:= Index;
				Anomaly:
					Number_of_Active_Anomalies 		:= Index;
				Warning:
					Number_of_Active_Warning 		:= Index;
				Information:
					Number_of_Active_Information 	:= Index;
			END_CASE
			
			IF Signals[Signal_Code] THEN
				Signal_Outputs := Signal_Outputs OR Signal_Output;
			END_IF
			
		Run:
			FOR d := 1 TO 4 DO
				Active_Signal[d] := 0;
			END_FOR
			
			d := 1;
			FOR i := 1 TO 30 DO
				IF Active_Signal_Codes[i] > 0 THEN
					Active_Signal[d] := Active_Signal_Codes[i];
					d := d + 1;
				END_IF
				IF d > 4 THEN
					EXIT;
				END_IF
			END_FOR
							
				
			First_Active_Signal_Index 		:= Active_Signal[1];
			Second_Active_Signal_Index 		:= Active_Signal[2];
			Third_Active_Signal_Index 		:= Active_Signal[3];
			Fourth_Active_Signal_Index 		:= Active_Signal[4];
			
			Last_Information_Index := Number_of_Alarms + Number_of_Anomalies + Number_of_Warnings + Number_of_Active_Information;
			IF Number_of_Active_Information > 0 THEN
				Signal_Type_Information 	:= TRUE;
			ELSE
				Signal_Type_Information 	:= FALSE;
			END_IF
			
			Last_Anomaly_Index 				:= Number_of_Alarms + Number_of_Anomalies + Number_of_Active_Anomalies;
			IF Number_of_Active_Anomalies > 0 THEN
				Signal_Type_Anomaly 		:= TRUE;
			ELSE
				Signal_Type_Anomaly 		:= FALSE;
			END_IF
			
			Last_Warning_Index 				:= Number_of_Alarms + Number_of_Active_Warning;
			IF Number_of_Active_Warning > 0 THEN
				Signal_Type_Warning 		:= TRUE;
			ELSE
				Signal_Type_Warning 		:= FALSE;
			END_IF
			
			IF Number_of_Active_Alarms > 0 THEN
				Signal_Type_Alarm 			:= TRUE;
			ELSE
				Signal_Type_Alarm 			:= FALSE;
			END_IF
			
	END_CASE
	


END_FUNCTION_BLOCK

