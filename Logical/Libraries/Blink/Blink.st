(* For Turning LED ON/OFF/Blink *)
FUNCTION_BLOCK Blink
	
	IF LED_State = 'on' THEN
		LED_Light := TRUE;
	END_IF

	IF LED_State = 'off' THEN
		LED_Light := FALSE;
	END_IF
		
	IF LED_State = 'blink' THEN 
		
		CASE State OF
			
			0:
				Timer(IN := TRUE, PT := T#500ms);			
				IF Timer.Q = TRUE THEN
					Timer(IN 	:= FALSE);
					LED_Light 	:= TRUE;
					State 		:= 1;
				END_IF
				
			1:
				Timer(IN := TRUE, PT := T#500ms);			
				IF Timer.Q = TRUE THEN
					Timer(IN 	:= FALSE);
					LED_Light 	:= FALSE;
					State 		:= 0;
				END_IF
		END_CASE
		
		
	END_IF

END_FUNCTION_BLOCK
