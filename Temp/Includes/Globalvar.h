/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1745391935_1_
#define _BUR_1745391935_1_

#include <bur/plctypes.h>

/* Constants */
#ifdef _REPLACE_CONST
#else
#endif


/* Variables */
_GLOBAL struct Blink Alarm_Detected;
_GLOBAL struct Blink Warning_Detected;
_GLOBAL struct Blink R_Unlocked;
_GLOBAL struct Blink Aux_Unlocked;
_GLOBAL plcbit Aux_Reset_Unlocked;
_GLOBAL plcbit Reset_Unlocked;
_GLOBAL plcstring P_Current_State[81];
_GLOBAL plcbit Pallet_Conv_2_Fault_HMI;
_GLOBAL plcbit Pallet_Conv_1_Fault_HMI;
_GLOBAL plcbit Pallet_Fork_Fault_HMI;
_GLOBAL plcbit Pallet_Lifter_Fault_HMI;
_GLOBAL plcstring C_Current_State[81];
_GLOBAL plcbit Crane_Pusher_Z_Fault_HMI;
_GLOBAL plcbit Crane_Pusher_X_Fault_HMI;
_GLOBAL plcbit Box_Holder_Fault_HMI;
_GLOBAL plcbit Vacuum_Fault_HMI;
_GLOBAL plcbit Cartboard_Fault_HMI;
_GLOBAL plcbit Box_Crane_Fault_HMI;
_GLOBAL plcbit Gantry_Crane_Fault_HMI;
_GLOBAL plcstring F_Current_State[81];
_GLOBAL plcbit End_Layer;
_GLOBAL plcbit C_Layer_Counter;
_GLOBAL signed short Box_Counter;
_GLOBAL plcbit Pusher_1_Fault_HMI;
_GLOBAL plcbit Carriage_Fault_HMI;
_GLOBAL plcbit Turn_Pusher_Fault_HMI;
_GLOBAL plcbit Conveyor_1_Fault_HMI;
_GLOBAL plcbit Conveyor_2_Fault_HMI;
_GLOBAL plcbit Conveyor_3_Fault_HMI;
_GLOBAL plcbit P_Ready;
_GLOBAL plcbit P_Restart;
_GLOBAL plcbit P_On_Phase_Stop;
_GLOBAL plcbit P_Immediate_Stop;
_GLOBAL plcbit P_Reset_Config;
_GLOBAL plcbit P_Emergency_Stop;
_GLOBAL plcbit Start_Pallet;
_GLOBAL plcbit C_Ready;
_GLOBAL plcbit C_Restart;
_GLOBAL plcbit C_On_Phase_Stop;
_GLOBAL plcbit C_Immediate_Stop;
_GLOBAL plcbit C_Emergency_Stop;
_GLOBAL plcbit C_Reset_Config;
_GLOBAL plcbit Start_Crane;
_GLOBAL plcbit F_Ready;
_GLOBAL plcbit F_Restart;
_GLOBAL plcbit F_On_Phase_Stop;
_GLOBAL plcbit F_Immediate_Stop;
_GLOBAL plcbit F_Reset_Config;
_GLOBAL plcbit F_Emergency_Stop;
_GLOBAL plcbit Start_Feeder;
_GLOBAL plcbit P_Exit_En;
_GLOBAL plcstring M_Current_State[81];
_GLOBAL plcbit Second_Layer;
_GLOBAL plcbit Load_Boxes_On_The_P;
_GLOBAL plcbit Load_Boxes_On_The_C;
_GLOBAL plcbit Boxes_On_The_C;
_GLOBAL plcbit Boxes_On_The_P;
_GLOBAL plcbit P_Exit_Done;
_GLOBAL plcbit Hold_Boxes;
_GLOBAL plcbit On_Phase_Stop;
_GLOBAL plcbit Immediate_Stop;
_GLOBAL plcbit Emergency_Stop;
_GLOBAL plcbit Start_Machine;
_GLOBAL plcbit En_Machine;
_GLOBAL plcbit Service_Mode;
_GLOBAL plcstring Fault[24][81];
_GLOBAL plcbit e_Conveyor_5_Fault;
_GLOBAL plcbit e_Conveyor_4_Fault;
_GLOBAL plcbit e_Box_Holder_Fault;
_GLOBAL plcbit e_Cartboard_Fault;
_GLOBAL plcbit e_Conveyor_3_Fault;
_GLOBAL plcbit e_Conveyor_2_Fault;
_GLOBAL plcbit e_Conveyor_1_Fault;
_GLOBAL plcbit e_Pallet_Lifter_Fault;
_GLOBAL plcbit e_Box_Crane_Fault;
_GLOBAL plcbit e_Gantry_Crane_Fault;
_GLOBAL plcbit e_Carriage_Fault;
_GLOBAL plcbit e_Pallet_Fork_Fault;
_GLOBAL plcbit e_Vacuum_Fault;
_GLOBAL plcbit e_Crane_Pusher_z_Fault;
_GLOBAL plcbit e_Crane_Pusher_x_Fault;
_GLOBAL plcbit e_Feeder_Pusher_Fault;
_GLOBAL plcbit e_Turn_Pusher_Fault;
_GLOBAL signed short Pallet_Counter;
_GLOBAL signed short Crane_Cartboard_Counter;
_GLOBAL plcbit Out_Of_Material;
_GLOBAL signed short Operation_Type;
_GLOBAL float Pallet_Lifter_Act_Pos_HMI;
_GLOBAL plcstring Priority_1_HMI[81];
_GLOBAL plcstring Priority_2_HMI[81];
_GLOBAL plcstring Priority_3_HMI[81];
_GLOBAL plcstring Priority_4_HMI[81];
_GLOBAL plcbit Emergency_Stop_HMI;
_GLOBAL plcbit On_Phase_Stop_HMI;
_GLOBAL plcbit IR_4_HMI;
_GLOBAL plcbit IR_3_HMI;
_GLOBAL plcbit Pallet_Holder_State_HMI;
_GLOBAL float Pallet_Lifter_TGT_dis_HMI;
_GLOBAL float Pallet_Lifter_TGT_HMI;
_GLOBAL plcbit Pallet_Lifter_TGT_pos_HMI;
_GLOBAL plcbit Pallet_Lifter_Origin_pos_HMI;
_GLOBAL plcbit Conveyor_5_S2_HMI;
_GLOBAL plcbit Conveyor_5_S1_HMI;
_GLOBAL plcbit Conveyor_4_HMI;
_GLOBAL plcbit Conveyor_4_Jog_HMI;
_GLOBAL plcbit Pallet_fork_HMI;
_GLOBAL float box_crane_Act_Pos_HMI;
_GLOBAL float gantry_crane_Act_Pos_HMI;
_GLOBAL plcbit vaccume_box_crane_state_HMI;
_GLOBAL float box_crane_TGT_dis_HMI;
_GLOBAL float box_crane_TGT_HMI;
_GLOBAL plcbit box_crane_Origin_pos_HMI;
_GLOBAL plcbit box_crane_TGT_pos_HMI;
_GLOBAL float gantry_crane_TGT_dis_HMI;
_GLOBAL float gantry_crane_TGT_HMI;
_GLOBAL plcbit gantry_crane_TGT_pos_HMI;
_GLOBAL plcbit gantry_crane_Origin_pos_HMI;
_GLOBAL plcbit pusher_x_EN_HMI;
_GLOBAL plcbit pusher_z_EN_HMI;
_GLOBAL plcbit Slide_rail_right_EN_HMI;
_GLOBAL plcbit Cartboard_Trig_HMI;
_GLOBAL plcbit vaccume_box_crane_grip_HMI;
_GLOBAL float Carriage_Push_ActPos_Dis_HMI;
_GLOBAL plcbit Carriage_Push_TarRech_HMI;
_GLOBAL plcbit Pusher_1_B_HMI;
_GLOBAL plcbit Pusher_1_F_HMI;
_GLOBAL plcbit Turn_Pusher_B_HMI;
_GLOBAL plcbit Turn_Pusher_F_HMI;
_GLOBAL plcbit IR2_HMI;
_GLOBAL plcbit IR1_HMI;
_GLOBAL float Carriage_Tar_Pos_Dis_HMI;
_GLOBAL float Carriage_Target_Pos_HMI;
_GLOBAL plcbit Carriage_Push_Target_HMI;
_GLOBAL plcbit Carriage_Push_Origin_HMI;
_GLOBAL plcbit Turn_Pusher_OFF_HMI;
_GLOBAL plcbit Turn_Pusher_ON_HMI;
_GLOBAL plcbit Conveyor_3_HMI;
_GLOBAL plcbit Conveyor_2_HMI;
_GLOBAL plcbit Pusher_1_HMI;
_GLOBAL plcbit Conveyor_1_HMI;
_GLOBAL plcbit Conveyor_3_Jog_HMI;
_GLOBAL plcbit Conveyor_2_Jog_HMI;
_GLOBAL plcbit Pusher_1_Jog_HMI;
_GLOBAL plcbit Conveyor_1_Jog_HMI;
_GLOBAL plcbit Service_Mode_HMI;
_GLOBAL float O_Conveyor_5_vel;
_GLOBAL plcbit O_Conveyor_4;
_GLOBAL plcbit O_Pallet_Holder;
_GLOBAL float O_Pallet_lift_Tar_Pos;
_GLOBAL plcbit O_Pusher_x;
_GLOBAL plcbit O_Pusher_z;
_GLOBAL plcbit O_Box_Holder;
_GLOBAL plcbit O_Vacuum_Grip_act;
_GLOBAL plcbit O_Cartboard_Trig;
_GLOBAL float O_Box_Crane_Tar_Pos;
_GLOBAL float O_Gantry_Crane_Tar_Pos;
_GLOBAL float O_Carriage_Tar_Pos;
_GLOBAL plcbit O_Turn_Pusher_OFF;
_GLOBAL plcbit O_Turn_Pusher_ON;
_GLOBAL plcbit O_Conveyor_3;
_GLOBAL plcbit O_Conveyor_2;
_GLOBAL plcbit O_Pusher_1;
_GLOBAL plcbit O_Conveyor_1;
_GLOBAL plcbit I_IR_Sensor_4;
_GLOBAL plcbit I_IR_Sensor_3;
_GLOBAL plcbit I_Pallet_holder_State;
_GLOBAL float I_Pallet_lift_Act_Pos;
_GLOBAL plcbit I_Vacuum_retention_act;
_GLOBAL float I_Box_Crane_Act_Pos;
_GLOBAL float I_Gantry_Crane_Act_Pos;
_GLOBAL plcbit I_Turn_Push_F;
_GLOBAL plcbit I_Turn_Push_B;
_GLOBAL plcbit I_Pusher_1_F;
_GLOBAL plcbit I_Pusher_1_B;
_GLOBAL plcbit I_Carriage_Push_Tar_Rec;
_GLOBAL float I_Carriage_Push_Act_Pos;
_GLOBAL plcbit I_IR_Sensor_2;
_GLOBAL plcbit I_IR_Sensor_1;





__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/Global.var\\\" scope \\\"global\\\"\\n\"");
__asm__(".ascii \"iecfile \\\"Logical/Libraries/Blink/Blink.fun\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1745391935_1_ */

