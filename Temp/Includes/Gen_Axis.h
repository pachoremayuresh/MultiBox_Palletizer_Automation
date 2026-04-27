/* Automation Studio generated header file */
/* Do not edit ! */
/* Gen_Axis  */

#ifndef _GEN_AXIS_
#define _GEN_AXIS_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Constants */
#ifdef _REPLACE_CONST
 #define Axis_Idle 0U
 #define Axis_Change_Velocity 1U
 #define Axis_Change_Position 2U
 #define Axis_Emergency_Stop_Request 3U
#else
 _GLOBAL_CONST plcword Axis_Idle;
 _GLOBAL_CONST plcword Axis_Change_Velocity;
 _GLOBAL_CONST plcword Axis_Change_Position;
 _GLOBAL_CONST plcword Axis_Emergency_Stop_Request;
#endif




/* Datatypes and datatypes of function blocks */
typedef enum AxisStateType
{	Axis_Check_Command,
	Axis_Wait_TGT_Position,
	Axis_Wait_TGT_Velocity,
	Axis_Fault_State
} AxisStateType;

typedef struct Gen_Axis
{
	/* VAR_INPUT (analog) */
	plcword Axis_Command;
	float Axis_Act_Position;
	float Axis_Act_Velocity;
	float New_Set_Point;
	signed short Axis_Dev_Timer;
	/* VAR_OUTPUT (analog) */
	float Axis_TGT_Velocity;
	float Axis_TGT_Position;
	/* VAR (analog) */
	enum AxisStateType Axis_State;
	signed short Axis_Timer;
	/* VAR_INPUT (digital) */
	plcbit Axis_TGT_Sensor;
	plcbit Axis_Reset;
	/* VAR_OUTPUT (digital) */
	plcbit Axis_In_Pos;
	plcbit Axis_In_Vel;
	plcbit Axis_Dev_Fault;
} Gen_Axis_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void Gen_Axis(struct Gen_Axis* inst);


#ifdef __cplusplus
};
#endif
#endif /* _GEN_AXIS_ */

