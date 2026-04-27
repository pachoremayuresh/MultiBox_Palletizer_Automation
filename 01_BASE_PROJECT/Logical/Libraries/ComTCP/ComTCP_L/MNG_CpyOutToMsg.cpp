
#include "MNG_InternalTyp.hpp"

unsigned long int MNG_CpyOutToMsg(MNG_RawDatagram * pToServer, unsigned long int counter, ComTCP_OUTPUTS_32BIT_FWRD *pSimOutputs ) {

    
        unsigned long int DWordBuffer;
	
        pSimOutputs->NumSignals = 6;
        (pToServer->Header).ByteCount    = H_TO_NUDINT(28);
        (pToServer->Header).DatagramType = H_TO_NUDINT(MNG_Raw32BitImage);
        (pToServer->Header).SentTime = H_TO_NUDINT(0);  // Todo
        (pToServer->Header).Counter = H_TO_NUDINT(counter);
        pToServer->Payload[0] = H_TO_NUDINT(pSimOutputs->NumSignals);

    
    /* Yellow_light_Key : UINT32 */
    pToServer->Payload[1] = H_TO_NUDINT(pSimOutputs->Yellow_light_Key);


    /* Stop_light_Key : UINT32 */
    pToServer->Payload[2] = H_TO_NUDINT(pSimOutputs->Stop_light_Key);


    /* White_light_Key : UINT32 */
    pToServer->Payload[3] = H_TO_NUDINT(pSimOutputs->White_light_Key);


    /* Green_light_Key : UINT32 */
    pToServer->Payload[4] = H_TO_NUDINT(pSimOutputs->Green_light_Key);


    /* Shaft_0_ACT_POS : FLOAT32 */
    brsmemcpy((unsigned long int)&(DWordBuffer), (unsigned long int)&(pSimOutputs->Shaft_0_ACT_POS), 4);
    pToServer->Payload[5] = H_TO_NUDINT(DWordBuffer);


    /* Shaft_1_ACT_POS : FLOAT32 */
    brsmemcpy((unsigned long int)&(DWordBuffer), (unsigned long int)&(pSimOutputs->Shaft_1_ACT_POS), 4);
    pToServer->Payload[6] = H_TO_NUDINT(DWordBuffer);


	return 0;
}
