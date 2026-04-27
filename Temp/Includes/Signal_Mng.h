/* Automation Studio generated header file */
/* Do not edit ! */
/* Signal_Mng  */

#ifndef _SIGNAL_MNG_
#define _SIGNAL_MNG_
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
 #define Init 0
 #define Run 1
 #define Start_Configuration 2
 #define Configuration 3
 #define Start_Generation 4
 #define Generation 5
 #define Alarm 1
 #define Anomaly 2
 #define Warning 3
 #define Information 4
 #define Aux_Reset 512
 #define Unconditioned_Reset 16384
 #define Auto_Conditioned_Reset 8192
 #define Auto_Provisional_Reset 4096
 #define Auto_Priority_Reset 2048
 #define Auto_Reset 1024
 #define Signal_Type_Mask 7
 #define Sign_None 0U
 #define Sign_Emergency_Stop 1U
 #define Sign_Immediate_Stop 2U
 #define Sign_On_Phase_Stop 4U
 #define Sign_Machine_Out_Of_Phase 256U
 #define Sign_Machine_Inhibition 512U
 #define Sign_Materials_Run_Out_Lamp 1024U
 #define Sign_Materials_Run_Out_Buzzer 2048U
 #define Sign_IO_Diagostic_Inhibition 32768U
#else
 _GLOBAL_CONST signed short Init;
 _GLOBAL_CONST signed short Run;
 _GLOBAL_CONST signed short Start_Configuration;
 _GLOBAL_CONST signed short Configuration;
 _GLOBAL_CONST signed short Start_Generation;
 _GLOBAL_CONST signed short Generation;
 _GLOBAL_CONST signed long Alarm;
 _GLOBAL_CONST signed long Anomaly;
 _GLOBAL_CONST signed long Warning;
 _GLOBAL_CONST signed long Information;
 _GLOBAL_CONST signed long Aux_Reset;
 _GLOBAL_CONST signed long Unconditioned_Reset;
 _GLOBAL_CONST signed long Auto_Conditioned_Reset;
 _GLOBAL_CONST signed long Auto_Provisional_Reset;
 _GLOBAL_CONST signed long Auto_Priority_Reset;
 _GLOBAL_CONST signed long Auto_Reset;
 _GLOBAL_CONST signed long Signal_Type_Mask;
 _GLOBAL_CONST plcdword Sign_None;
 _GLOBAL_CONST plcdword Sign_Emergency_Stop;
 _GLOBAL_CONST plcdword Sign_Immediate_Stop;
 _GLOBAL_CONST plcdword Sign_On_Phase_Stop;
 _GLOBAL_CONST plcdword Sign_Machine_Out_Of_Phase;
 _GLOBAL_CONST plcdword Sign_Machine_Inhibition;
 _GLOBAL_CONST plcdword Sign_Materials_Run_Out_Lamp;
 _GLOBAL_CONST plcdword Sign_Materials_Run_Out_Buzzer;
 _GLOBAL_CONST plcdword Sign_IO_Diagostic_Inhibition;
#endif




/* Datatypes and datatypes of function blocks */
#ifdef _BUR_USE_DECLARATION_IN_IEC
typedef struct Signal_Mng
{
	/* VAR_INPUT (analog) */
	signed short Operation_Type;
	signed long Signal_Type;
	signed short Signal_Code;
	plcdword Signal_Output;
	/* VAR_OUTPUT (analog) */
	plcdword Signal_Outputs;
	plcword Signal_Priority_Code;
	signed short Number_of_Alarms;
	signed short Number_of_Anomalies;
	signed short Number_of_Warnings;
	signed short Number_of_Information;
	signed short Active_Signal_Codes[30];
	signed short Number_of_Active_Alarms;
	signed short Number_of_Active_Anomalies;
	signed short Number_of_Active_Warning;
	signed short Number_of_Active_Information;
	signed short First_Signal_Index;
	signed short First_Active_Signal_Index;
	signed short Second_Active_Signal_Index;
	signed short Third_Active_Signal_Index;
	signed short Fourth_Active_Signal_Index;
	/* VAR (analog) */
	signed short Last_Signal_Index;
	signed short Last_Active_Signal_Index;
	signed short Index;
	signed short Base_Index;
	signed short i;
	signed short Last_Information_Index;
	signed short Last_Anomaly_Index;
	signed short Last_Warning_Index;
	signed short d;
	signed short Active_Signal[5];
	/* VAR_INPUT (digital) */
	plcbit Activation_Signal;
	plcbit Auto_Reset_Signal;
	plcbit Reset;
	plcbit Key_Reset;
	/* VAR_OUTPUT (digital) */
	plcbit Reset_Enable;
	plcbit Aux_Reset_Enable;
	plcbit Signal_Type_Alarm;
	plcbit Signal_Type_Anomaly;
	plcbit Signal_Type_Warning;
	plcbit Signal_Type_Information;
	plcbit Signal_Mng_Error;
	/* VAR (digital) */
	plcbit Reset_Signals_Enable;
	plcbit Aux_Reset_Activation;
	plcbit Reset_Activation;
	plcbit Signal_Request;
	plcbit Signal_Ack_Request;
	plcbit Signals[23];
	plcbit Active_Signal_Request;
	plcbit Active_Signal_Request_Ack;
	plcbit Reset_Old;
	plcbit Key_Reset_Old;
	plcbit Condition;
	plcbit Aux_Reset_Required;
} Signal_Mng_typ;
#else
/* Data type Signal_Mng not declared. Data types with array elements whose starting indexes are not equal to zero cannot be used in ANSI C programs / libraries.*/
#endif



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void Signal_Mng(struct Signal_Mng* inst);


#ifdef __cplusplus
};
#endif
#endif /* _SIGNAL_MNG_ */

