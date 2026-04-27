
#include "MNG_InternalTyp.hpp"

unsigned long int MNG_CpyMsgToInp(MNG_RawDatagram * pFromServer, ComTCP_INPUTS_32BIT_FWRD *pSimInputs) {

    MNG_DatagramType datagramType;
	unsigned long int DWordBuffer;
        unsigned long int byteCount;
	unsigned long int numSignalsInMessage;


	byteCount = N_TO_HUDINT((pFromServer->Header).ByteCount);
	datagramType = static_cast<MNG_DatagramType>(N_TO_HUDINT((pFromServer->Header).DatagramType));
	if (datagramType != MNG_Raw32BitImage) {
		return 0;
	}

    pSimInputs->NumSignals = 15;

    numSignalsInMessage = N_TO_HUDINT(pFromServer->Payload[0]);
        if ((static_cast<long int>(numSignalsInMessage) != pSimInputs->NumSignals) ||
	(byteCount != 4 + numSignalsInMessage * 4)) {
		return 0;
	}

    /* BOOL Emergency_Button_ButtonToggle */
    pSimInputs->Emergency_Button_ButtonToggle = (pFromServer->Payload[1] != 0);

    /* BOOL Yellow_Button_ButtonPress */
    pSimInputs->Yellow_Button_ButtonPress = (pFromServer->Payload[2] != 0);

    /* BOOL White_Button_ButtonPress */
    pSimInputs->White_Button_ButtonPress = (pFromServer->Payload[3] != 0);

    /* BOOL Start_Button_ButtonPress */
    pSimInputs->Start_Button_ButtonPress = (pFromServer->Payload[4] != 0);

    /* BOOL Stop_Button_ButtonPress */
    pSimInputs->Stop_Button_ButtonPress = (pFromServer->Payload[5] != 0);

    /* FLOAT32 Knob_0_AXIS */
    DWordBuffer = N_TO_HUDINT(pFromServer->Payload[6]);
    brsmemcpy((unsigned long int)&(pSimInputs->Knob_0_AXIS), (unsigned long int)&(DWordBuffer), 4);

    /* FLOAT32 Knob_1_AXIS */
    DWordBuffer = N_TO_HUDINT(pFromServer->Payload[7]);
    brsmemcpy((unsigned long int)&(pSimInputs->Knob_1_AXIS), (unsigned long int)&(DWordBuffer), 4);

    /* FLOAT32 Knob_2_AXIS */
    DWordBuffer = N_TO_HUDINT(pFromServer->Payload[8]);
    brsmemcpy((unsigned long int)&(pSimInputs->Knob_2_AXIS), (unsigned long int)&(DWordBuffer), 4);

    /* FLOAT32 Knob_3_AXIS */
    DWordBuffer = N_TO_HUDINT(pFromServer->Payload[9]);
    brsmemcpy((unsigned long int)&(pSimInputs->Knob_3_AXIS), (unsigned long int)&(DWordBuffer), 4);

    /* FLOAT32 Shaft_1_AXIS */
    DWordBuffer = N_TO_HUDINT(pFromServer->Payload[10]);
    brsmemcpy((unsigned long int)&(pSimInputs->Shaft_1_AXIS), (unsigned long int)&(DWordBuffer), 4);

    /* BOOL Shaft_1_LBK */
    pSimInputs->Shaft_1_LBK = (pFromServer->Payload[11] != 0);

    /* BOOL Shaft_1_LFR */
    pSimInputs->Shaft_1_LFR = (pFromServer->Payload[12] != 0);

    /* FLOAT32 Shaft_0_AXIS */
    DWordBuffer = N_TO_HUDINT(pFromServer->Payload[13]);
    brsmemcpy((unsigned long int)&(pSimInputs->Shaft_0_AXIS), (unsigned long int)&(DWordBuffer), 4);

    /* BOOL Shaft_0_LBK */
    pSimInputs->Shaft_0_LBK = (pFromServer->Payload[14] != 0);

    /* BOOL Shaft_0_LFR */
    pSimInputs->Shaft_0_LFR = (pFromServer->Payload[15] != 0);


return N_TO_HUDINT((pFromServer->Header).Counter); // return counter
}
