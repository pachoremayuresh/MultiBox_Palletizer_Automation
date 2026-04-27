/* Automation Studio generated header file */
/* Do not edit ! */
/* Gen_Device  */

#ifndef _GEN_DEVICE_
#define _GEN_DEVICE_
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
 #define Dev_Without_Feedback 64
 #define Dev_With_Enable_Feedback 16
 #define Dev_With_Disable_Feedback 32
 #define Dev_With_Double_Feedback 48
 #define Dev_With_Single_Actuation 1
 #define Dev_With_Double_Actuation 3
 #define Dev_With_DA_No_Retain 2
 #define Dev_Feedback_Mask 240
 #define Dev_Actuation_Mask 15
#else
 _GLOBAL_CONST signed short Dev_Without_Feedback;
 _GLOBAL_CONST signed short Dev_With_Enable_Feedback;
 _GLOBAL_CONST signed short Dev_With_Disable_Feedback;
 _GLOBAL_CONST signed short Dev_With_Double_Feedback;
 _GLOBAL_CONST signed short Dev_With_Single_Actuation;
 _GLOBAL_CONST signed short Dev_With_Double_Actuation;
 _GLOBAL_CONST signed short Dev_With_DA_No_Retain;
 _GLOBAL_CONST signed short Dev_Feedback_Mask;
 _GLOBAL_CONST signed short Dev_Actuation_Mask;
#endif




/* Datatypes and datatypes of function blocks */
typedef enum DeviceStateType
{	Dev_Disabled_State,
	Dev_Enable_Phase_State,
	Dev_Enabled_State,
	Dev_Disable_Phase_State
} DeviceStateType;

typedef struct Gen_Device
{
	/* VAR_INPUT (analog) */
	signed short Dev_Operation;
	signed short Dev_Type;
	signed short Dev_Enable_Time;
	signed short Dev_Disable_Time;
	/* VAR_IN_OUT (analog and digital) */
	plcbit* Dev_Enable_Request;
	plcbit* Dev_Disable_Request;
	/* VAR (analog) */
	enum DeviceStateType Dev_State;
	signed short Dev_Timer;
	signed short INIT;
	signed short RUN;
	/* VAR_INPUT (digital) */
	plcbit Dev_Enabled_Sensor;
	plcbit Dev_Disabled_Sensor;
	plcbit Dev_Clock;
	plcbit Dev_Diagnose_Enable;
	plcbit Dev_Enable_Preset;
	plcbit Dev_Enable;
	plcbit Dev_Disable;
	/* VAR_OUTPUT (digital) */
	plcbit Dev_Enabled;
	plcbit Dev_Disabled;
	plcbit Dev_Enabled_Sensor_Fault;
	plcbit Dev_Disabled_Sensor_Fault;
	plcbit Dev_Actuator_Fault;
	plcbit Dev_Fault;
	plcbit Dev_Not_Initialized;
	/* VAR (digital) */
	plcbit Dev_Timeout;
} Gen_Device_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void Gen_Device(struct Gen_Device* inst);


#ifdef __cplusplus
};
#endif
#endif /* _GEN_DEVICE_ */

