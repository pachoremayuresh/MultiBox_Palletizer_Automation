
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	MyGenericAxisBasicFB_Master();
	
	
	
	
	
	MC_Power_0.Axis := ADR(gAxis01);
	MC_Power_0();
	
	
	
	MC_Home_0 			(Axis := ADR(gAxis01));
	MC_Stop_0			(Axis := ADR(gAxis01));
	MC_ReadStatus_0		(Axis := ADR(gAxis01));
	MC_MoveVelocity_0	(Axis := ADR(gAxis01));
	MC_MoveAdditive_0	(Axis := ADR(gAxis01));
	MC_MoveAbsolute_0	(Axis := ADR(gAxis01));
	MC_ReadActualPosition_0(Axis := ADR(gAxis01));
	MC_ReadActualVelocity_0(Axis := ADR(gAxis01));
	MC_Reset_0			(Axis := ADR(gAxis01));
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

