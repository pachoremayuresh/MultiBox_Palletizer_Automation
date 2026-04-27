/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1728649116_1_
#define _BUR_1728649116_1_

#include <bur/plctypes.h>

/* Constants */
#ifdef _REPLACE_CONST
#else
#endif


/* Variables */
_GLOBAL float Conv_Jog_Velocity;
_GLOBAL float Blade_Jog_Velocity;
_GLOBAL plcbit Man_Mode_OFF;
_GLOBAL plcbit Manual_Mode_Trigger;
_GLOBAL plcbit Slow_Conv_Trigger;
_GLOBAL plcbit Conv_Right_Man_HMI_Trigger;
_GLOBAL plcbit Conv_Left_Man_HMI_Trigger;
_GLOBAL plcbit Blade_Down_Man_HMI_Trigger;
_GLOBAL plcbit Blade_Up_Man_HMI_Trigger;
_GLOBAL plcbit Slow_Blade_Trigger;
_GLOBAL plcbit Cutter_Lock_Trigger;
_GLOBAL plcbit Over_Ride_Trigger;
_GLOBAL plcbit Conv_Lock_Trigger;
_GLOBAL plcbit Sensor_Trigger;
_GLOBAL plcbit Cutter_Lock_HMI_Trigger;
_GLOBAL plcbit Conv_Lock_HMI_Trigger;
_GLOBAL plcbit Reset_Trigger;
_GLOBAL plcbit Error_Trigger;
_GLOBAL plcbit Stop_Trigger;
_GLOBAL plcbit Start_Trigger;
_GLOBAL float Conv_Speed;
_GLOBAL plcbit S_Stoped;
_GLOBAL double S_Actual_Velocity;
_GLOBAL double S_Actual_Position;
_GLOBAL plcbit C_Error;
_GLOBAL plcbit S_Powered;
_GLOBAL plcbit S_Homed;
_GLOBAL plcbit S_Error;
_GLOBAL plcbit S_Active;
_GLOBAL struct MpAxisCoupling Coupling;
_GLOBAL struct MpAxisBasic Slave;
_GLOBAL plcbit M_Stoped;
_GLOBAL plcbit M_Powered;
_GLOBAL plcbit M_Homed;
_GLOBAL double M_Actual_Velocity;
_GLOBAL double M_Actual_Position;
_GLOBAL plcbit M_Error;
_GLOBAL plcbit M_Active;
_GLOBAL struct MpAxisBasic Master;
_GLOBAL plcbit Done_Cut;
_GLOBAL plcbit Do_Cut;
_GLOBAL plcbit Stop_Command;
_GLOBAL plcbit Start_Command;
_GLOBAL plcbit Error_Command;
_GLOBAL plcbit Reset_Command;
_GLOBAL plcbit Home_Axis;
_GLOBAL plcbit Power_Axis;
_GLOBAL plcbit Over_Ride_HMI;
_GLOBAL plcbit Man_Mode_HMI;
_GLOBAL signed short Dis_Cut_Depth_HMI;
_GLOBAL signed short Dis_Cut_Pos_HMI;
_GLOBAL float Dis_Cut_Speed_HMI;
_GLOBAL float Dis_Conv_Speed_HMI;
_GLOBAL plcbit LED_DI6_HMI;
_GLOBAL plcbit LED_DI5_HMI;
_GLOBAL plcbit LED_DI4_HMI;
_GLOBAL plcbit LED_DI3_HMI;
_GLOBAL plcbit LED_DI2_HMI;
_GLOBAL plcbit LED_DI1_HMI;
_GLOBAL plcbit Slow_Conv_HMI;
_GLOBAL plcbit Slow_Blade_HMI;
_GLOBAL plcbit Conv_Left_Man_HMI;
_GLOBAL plcbit Conv_Right_Man_HMI;
_GLOBAL plcbit Blade_Down_Man_HMI;
_GLOBAL plcbit Blade_Up_Man_HMI;
_GLOBAL float Cutting_Depth_HMI;
_GLOBAL float Cutting_Pos_HMI;
_GLOBAL float Cutter_Speed_HMI;
_GLOBAL float Conv_Speed_HMI;
_GLOBAL plcbit Cutter_Lock_HMI;
_GLOBAL plcbit Conv_Lock_HMI;
_GLOBAL plcbit Reset_Button_HMI;
_GLOBAL plcbit Sensor_Button_HMI;
_GLOBAL plcbit Stop_Button_HMI;
_GLOBAL plcbit Start_Button_HMI;
_GLOBAL plcbit Emergancy_Button_HMI;
_GLOBAL signed short Display;
_GLOBAL struct FSM_LED DI6;
_GLOBAL struct FSM_LED DI5;
_GLOBAL struct FSM_LED DI4;
_GLOBAL struct FSM_LED DI3;
_GLOBAL struct FSM_LED DI2;
_GLOBAL struct FSM_LED DI1;
_GLOBAL signed short Position;
_GLOBAL signed short Speed;
_GLOBAL plcbit Reset_Button;
_GLOBAL plcbit Sensor_Button;
_GLOBAL plcbit Stop_Button;
_GLOBAL plcbit Start_Button;
_GLOBAL plcbit Cutter_Lock;
_GLOBAL plcbit Conv_Lock;
_GLOBAL struct ACP10AXIS_typ gAxis02;
_GLOBAL struct ACP10AXIS_typ gAxis01;





__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/Global.var\\\" scope \\\"global\\\"\\n\"");
__asm__(".ascii \"iecfile \\\"Logical/Libraries/MpAxis/MpAxis.fun\\\" scope \\\"global\\\"\\n\"");
__asm__(".ascii \"iecfile \\\"Logical/Libraries/My_Library/My_Library.fun\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1728649116_1_ */

