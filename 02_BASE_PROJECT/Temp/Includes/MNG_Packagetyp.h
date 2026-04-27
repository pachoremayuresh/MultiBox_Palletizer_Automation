/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1723250665_4_
#define _BUR_1723250665_4_

#include <bur/plctypes.h>

/* Datatypes and datatypes of function blocks */
typedef struct ComTCP_INPUTS_32BIT
{	signed short NumSignals;
	plcbit Emergency_Button_ButtonToggle;
	plcbit Yellow_Button_ButtonPress;
	plcbit White_Button_ButtonPress;
	plcbit Start_Button_ButtonPress;
	plcbit Stop_Button_ButtonPress;
	float Knob_0_AXIS;
	float Knob_1_AXIS;
	float Knob_2_AXIS;
	float Knob_3_AXIS;
	float Shaft_1_AXIS;
	plcbit Shaft_1_LBK;
	plcbit Shaft_1_LFR;
	float Shaft_0_AXIS;
	plcbit Shaft_0_LBK;
	plcbit Shaft_0_LFR;
} ComTCP_INPUTS_32BIT;

typedef struct ComTCP_OUTPUTS_32BIT
{	signed short NumSignals;
	unsigned long Yellow_light_Key;
	unsigned long Stop_light_Key;
	unsigned long White_light_Key;
	unsigned long Green_light_Key;
	float Shaft_0_ACT_POS;
	float Shaft_1_ACT_POS;
} ComTCP_OUTPUTS_32BIT;






__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/MNG_Package.typ\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1723250665_4_ */

