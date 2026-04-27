/* Automation Studio generated header file */
/* Do not edit ! */
/* Blink  */

#ifndef _BLINK_
#define _BLINK_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Datatypes and datatypes of function blocks */
typedef struct Blink
{
	/* VAR_INPUT (analog) */
	plcstring LED_State[81];
	/* VAR (analog) */
	struct TON Timer;
	signed short State;
	/* VAR_OUTPUT (digital) */
	plcbit LED_Light;
} Blink_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void Blink(struct Blink* inst);


#ifdef __cplusplus
};
#endif
#endif /* _BLINK_ */

