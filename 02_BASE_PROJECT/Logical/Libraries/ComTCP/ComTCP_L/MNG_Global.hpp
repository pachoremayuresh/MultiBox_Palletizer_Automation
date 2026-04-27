
#ifndef  _MNGGLOBAL_HPP_
#define _MNGGLOBAL_HPP_

#include <mng_globalTYP.h>


    typedef struct {

		signed short NumSignals;

        /* BOOL Emergency_Button_ButtonToggle */
        BOOL Emergency_Button_ButtonToggle;
        /* BOOL Yellow_Button_ButtonPress */
        BOOL Yellow_Button_ButtonPress;
        /* BOOL White_Button_ButtonPress */
        BOOL White_Button_ButtonPress;
        /* BOOL Start_Button_ButtonPress */
        BOOL Start_Button_ButtonPress;
        /* BOOL Stop_Button_ButtonPress */
        BOOL Stop_Button_ButtonPress;
        /* REAL Knob_0_AXIS */
        REAL Knob_0_AXIS;
        /* REAL Knob_1_AXIS */
        REAL Knob_1_AXIS;
        /* REAL Knob_2_AXIS */
        REAL Knob_2_AXIS;
        /* REAL Knob_3_AXIS */
        REAL Knob_3_AXIS;
        /* REAL Shaft_1_AXIS */
        REAL Shaft_1_AXIS;
        /* BOOL Shaft_1_LBK */
        BOOL Shaft_1_LBK;
        /* BOOL Shaft_1_LFR */
        BOOL Shaft_1_LFR;
        /* REAL Shaft_0_AXIS */
        REAL Shaft_0_AXIS;
        /* BOOL Shaft_0_LBK */
        BOOL Shaft_0_LBK;
        /* BOOL Shaft_0_LFR */
        BOOL Shaft_0_LFR;

        } ComTCP_INPUTS_32BIT_FWRD;


    typedef struct {

		signed short NumSignals;

        /* UDINT Yellow_light_Key */
        UDINT Yellow_light_Key;
        /* UDINT Stop_light_Key */
        UDINT Stop_light_Key;
        /* UDINT White_light_Key */
        UDINT White_light_Key;
        /* UDINT Green_light_Key */
        UDINT Green_light_Key;
        /* REAL Shaft_0_ACT_POS */
        REAL Shaft_0_ACT_POS;
        /* REAL Shaft_1_ACT_POS */
        REAL Shaft_1_ACT_POS;

        } ComTCP_OUTPUTS_32BIT_FWRD;



#endif
