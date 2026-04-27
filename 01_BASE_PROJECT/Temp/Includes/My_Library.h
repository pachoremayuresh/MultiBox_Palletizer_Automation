/* Automation Studio generated header file */
/* Do not edit ! */
/* My_Library  */

#ifndef _MY_LIBRARY_
#define _MY_LIBRARY_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Datatypes and datatypes of function blocks */
typedef struct FSM_LED
{
	/* VAR_INPUT (analog) */
	plcstring LED_State[81];
	/* VAR (analog) */
	struct TON Timer;
	signed short State;
	/* VAR_OUTPUT (digital) */
	plcbit LED_Light;
} FSM_LED_typ;

typedef struct FSM_AXIS
{
	/* VAR_INPUT (analog) */
	unsigned long Axis_Name;
	float Deceleration;
	float Velocity;
	float Acceleration;
	unsigned char Direction;
	float Distance;
	float Position;
	/* VAR_OUTPUT (analog) */
	float Actual_Position;
	float Actual_Velocity;
	/* VAR (analog) */
	struct MC_ReadStatus MCRS;
	struct MC_Power MCP;
	struct MC_Home MCH;
	struct MC_Stop MCS;
	struct MC_Reset MCR;
	struct MC_ReadActualPosition MCRAP;
	struct MC_ReadActualVelocity MCRAV;
	struct MC_MoveVelocity MCMV;
	struct MC_MoveAdditive MCMAdd;
	struct MC_MoveAbsolute MCMA;
	signed short State;
	float Old_Velocity;
	/* VAR_INPUT (digital) */
	plcbit Home;
	plcbit Power;
	plcbit Move_Velocity;
	plcbit Move_Absolute;
	plcbit Move_Additive;
	plcbit Stop;
	plcbit Reset_Error;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Power_ON;
	plcbit Stop_Done;
	plcbit Is_Homed;
	plcbit Move_Abs_Done;
	plcbit Move_Add_Done;
	plcbit Error;
	/* VAR (digital) */
	plcbit RS_Valid;
	plcbit RS_Error;
	plcbit RS_Errorstop;
	plcbit RS_Disabled;
	plcbit P_Enable;
	plcbit P_Status;
	plcbit P_Error;
	plcbit H_Execute;
	plcbit H_Done;
	plcbit H_Error;
	plcbit S_Execute;
	plcbit S_Done;
	plcbit S_Error;
	plcbit R_Execute;
	plcbit R_Done;
	plcbit R_Error;
	plcbit RAP_Valid;
	plcbit RAP_Error;
	plcbit RAV_Valid;
	plcbit RAV_Error;
	plcbit V_Execute;
	plcbit V_Error;
	plcbit Add_Execute;
	plcbit Add_Done;
	plcbit Add_Error;
	plcbit A_Execute;
	plcbit A_Done;
	plcbit A_Error;
	plcbit Move_Absolute_Old;
	plcbit Move_Additive_Old;
} FSM_AXIS_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void FSM_LED(struct FSM_LED* inst);
_BUR_PUBLIC void FSM_AXIS(struct FSM_AXIS* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MY_LIBRARY_ */

