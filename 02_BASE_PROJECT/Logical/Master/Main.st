
PROGRAM _INIT
	(* Insert code here *)
	Master_Param.Acceleration := 10000;
	Master_Param.Deceleration := 10000;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	IF Sensor_Trigger THEN
		Do_Cut 	:= TRUE;
	END_IF
			
	IF Do_Cut AND Done_Cut THEN
		Do_Cut 		:= FALSE;
		Done_Cut 	:= FALSE;
	END_IF
	
	CASE State OF
		0: //Standstill
			M_MoveVelocity := FALSE;
			M_Stop:= FALSE;
			IF NOT Error_Command AND Start_Command AND Man_Mode_OFF THEN 
				State := 1;
			END_IF
			
			IF Manual_Mode_Trigger THEN
				State := 2;
			END_IF
			
		1://Moving Conveyor
			M_MoveVelocity 	:= TRUE;
			M_Stop			:= FALSE;
			M_Jog_Positive 	:= FALSE;
			M_Jog_Negative 	:= FALSE;
			IF Conv_Speed <> M_Velocity THEN
				M_Velocity 	:= Conv_Speed;
				M_Update 	:= TRUE;
			ELSE
				M_Update 	:= FALSE;
			END_IF
			
			IF Stop_Command OR Error_Command THEN
				State := 3;
			END_IF
			
			IF Manual_Mode_Trigger THEN
				Man_Mode_OFF 	:= FALSE;
				State 			:= 2;
			END_IF
			
		2://Manual Motion
			Power_Axis 		:= TRUE;
			M_MoveVelocity	:= FALSE;
			M_Stop 			:= FALSE;
			IF Conv_Left_Man_HMI_Trigger THEN
				M_Jog_Positive := FALSE;
				M_Jog_Negative := TRUE;
			ELSIF Conv_Right_Man_HMI_Trigger THEN
				M_Jog_Positive := TRUE;
				M_Jog_Negative := FALSE;
			ELSE
				M_Jog_Positive := FALSE;
				M_Jog_Negative := FALSE;
			END_IF
			
			IF NOT Manual_Mode_Trigger THEN
				Power_Axis 		:= FALSE;
				Start_Command 	:= FALSE;
				M_MoveVelocity	:= FALSE;
				M_Jog_Positive 	:= FALSE;
				M_Jog_Negative 	:= FALSE;
				M_Stop 			:= FALSE;
				State 			:= 0;
			END_IF
			IF Stop_Command OR Error_Command THEN
				State := 3;
			END_IF
			
		3://Stop
			M_MoveVelocity 	:= FALSE;
			M_Stop			:= TRUE;
			M_Jog_Positive 	:= FALSE;
			M_Jog_Negative 	:= FALSE;
			State 			:= 0;
	END_CASE
	

	Master_Param.Velocity 	:= M_Velocity;
	Master_Param.Jog		:= M_Jog_Param;
	
	M_Jog_Param.Acceleration 	:= 5000;
	M_Jog_Param.Deceleration 	:= 5000;
	M_Jog_Param.Velocity		:= Conv_Jog_Velocity;
	M_Jog_Param.LowerLimit		:= -1000;
	M_Jog_Param.UpperLimit		:= +1000;
	
	//Calling Axis Basic Function
	Master(	MpLink 			:= ADR(gAxisBasic_Master), 
			Enable 			:= TRUE,
			ErrorReset		:= Reset_Command,
			Parameters 		:= ADR(Master_Param),
			Update			:= M_Update,
			Axis 			:= ADR(gAxis01), 
			Power 			:= Power_Axis,
			Home 			:= Home_Axis,
			MoveVelocity 	:= M_MoveVelocity,
			MoveAbsolute 	:= M_MoveAbsolute,
			MoveAdditive 	:= M_MoveAdditive,
			JogPositive 	:= M_Jog_Positive,
			JogNegative		:= M_Jog_Negative,
			Stop 			:= M_Stop);
	
	M_Active 			:= Master.Active;
	M_Error				:= Master.Error;
	M_Actual_Position	:= Master.Position;
	M_Actual_Velocity 	:= Master.Velocity;
	M_Homed 			:= Master.IsHomed;
	M_Powered 			:= Master.PowerOn;
	M_Stoped 			:= Master.Stopped;

END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

