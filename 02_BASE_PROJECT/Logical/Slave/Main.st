
PROGRAM _INIT
	(* Insert code here *)
	Coupling_Param.RatioDenominator := 360.0;
	Coupling_Param.RatioNumerator 	:= 360.0;
	
	//Cam graph to be linked
	Coupling_Param.Cam.CamTable[0] 	:= 'MyCam';
	Coupling_Param.Cam.CamTable[1]	:= 'MyCamBis';
	
	Coupling_Param.Cam.CamTableID 	:= 1;
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	CASE State OF
		0: // Synced Cutting using CAM
			IF C_Synced THEN
				Done_Cut := TRUE;
			END_IF
			
			IF Manual_Mode_Trigger THEN
				Man_Mode_OFF 	:= FALSE;
				State 			:= 1;
			END_IF
			
		1: //Manual Mode
			Power_Axis 		:= TRUE;
			S_MoveVelocity 	:= FALSE;
			S_Stop 			:= FALSE;
			IF Blade_Down_Man_HMI_Trigger THEN
				S_Jog_Positive := FALSE;
				S_Jog_Negative := TRUE;
			ELSIF Blade_Up_Man_HMI_Trigger THEN
				S_Jog_Positive := TRUE;
				S_Jog_Negative := FALSE;
			ELSE
				S_Jog_Positive := FALSE;
				S_Jog_Negative := FALSE;
			END_IF
			IF NOT Manual_Mode_Trigger THEN
				IF S_Actual_Position <> 0.0 THEN
					S_Velocity 		:= 50;
					S_MoveAbsolute 	:= TRUE;
					S_Position 		:= 0.0;
					S_Direction 	:= mpAXIS_DIR_SHORTEST_WAY;
					S_MoveVelocity 	:= FALSE;	
					S_Jog_Positive 	:= FALSE;
					S_Jog_Negative 	:= FALSE;
					S_Stop 			:= FALSE;
				END_IF
				IF S_Actual_Position = 0.0 THEN
					Man_Mode_OFF 	:= TRUE;
					Power_Axis 		:= FALSE;
					S_MoveVelocity 	:= FALSE;
					S_MoveAbsolute 	:= FALSE;	
					S_Jog_Positive 	:= FALSE;
					S_Jog_Negative 	:= FALSE;
					S_Stop 			:= FALSE;
					State 			:= 0;
				END_IF
			END_IF
		
	END_CASE
	
	
	Slave_Param.Jog 			:= S_Jog_Param;
	Slave_Param.Acceleration 	:= 1000;
	Slave_Param.Deceleration 	:= 1000;
	Slave_Param.Velocity 		:= S_Velocity;
	Slave_Param.Position 		:= S_Position;
	Slave_Param.Direction 		:= S_Direction;

	S_Jog_Param.Acceleration 	:= 5000;
	S_Jog_Param.Deceleration 	:= 5000;
	S_Jog_Param.Velocity		:= Blade_Jog_Velocity;
	S_Jog_Param.LowerLimit		:= -1000;
	S_Jog_Param.UpperLimit		:= +1000;		
	
	//Calling FSM_AXIS Function
	Slave(	MpLink 			:= ADR(gAxisBasic_Slave), 
			Enable 			:= TRUE,
			ErrorReset		:= Reset_Command,
			Parameters 		:= ADR(Slave_Param),
			Axis 			:= ADR(gAxis02), 
			Power 			:= Power_Axis,
			Home 			:= Home_Axis,
			MoveVelocity 	:= S_MoveVelocity,
			MoveAbsolute 	:= S_MoveAbsolute,
			MoveAdditive 	:= S_MoveAdditive,
			JogPositive 	:= S_Jog_Positive,
			JogNegative 	:= S_Jog_Negative,
			Stop 			:= S_Stop);
		
	S_Active 			:= Slave.Active;
	S_Error				:= Slave.Error;
	S_Homed 			:= Slave.IsHomed;
	S_Powered 			:= Slave.PowerOn;
	S_Stoped 			:= Slave.Stopped;
	
	Coupling(	MpLink 			:= ADR(gAxisBasic_Slave), 
				Enable 			:= TRUE,
				Cam 			:= Do_Cut,
				ErrorReset 		:= Reset_Command,
				Gear 			:= 1,
				Parameters 		:= ADR(Coupling_Param),
				MpLinkMaster 	:= ADR(gAxisBasic_Master));
	
	C_Synced 			:= Coupling.InSync;
	C_Error 			:= Coupling.Error;
	S_Actual_Position 	:= Coupling.Info.SlavePosition;
	S_Actual_Velocity 	:= Coupling.Info.SlaveVelocity;
	
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

