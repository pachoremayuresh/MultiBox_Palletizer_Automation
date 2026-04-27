/* Automation Studio generated header file */
/* Do not edit ! */
/* S_filter  */

#ifndef _S_FILTER_
#define _S_FILTER_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Datatypes and datatypes of function blocks */
typedef struct S_filter
{
	/* VAR_INPUT (analog) */
	float Sensor_Data;
	float threshold_F;
	signed short threshold_B;
	/* VAR_OUTPUT (analog) */
	float Sensor_Data_Filtered;
	/* VAR (analog) */
	signed short counter;
	/* VAR_INPUT (digital) */
	plcbit Sensor_Raw;
	plcbit Is_Bool;
	/* VAR_OUTPUT (digital) */
	plcbit Sensor_Filtered;
	/* VAR (digital) */
	plcbit last_State;
	plcbit init;
} S_filter_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void S_filter(struct S_filter* inst);


#ifdef __cplusplus
};
#endif
#endif /* _S_FILTER_ */

