(* For Sensor Data Filter *)
FUNCTION_BLOCK S_filter
	IF Is_Bool THEN
		// BOOLEAN MODE filtering
		IF Sensor_Raw = last_State THEN
			counter := counter + 1;
		ELSE
			counter := 0;
			last_State := Sensor_Raw;
		END_IF;

		IF counter >= threshold_B THEN
			Sensor_Filtered := Sensor_Raw;
			counter := 0; // reset after output change
		END_IF;

	ELSE
		// REAL MODE: Exponential smoothing
		IF NOT init THEN
			Sensor_Data_Filtered := Sensor_Data;
			init := TRUE;
		ELSE
			Sensor_Data_Filtered := threshold_F * Sensor_Data + (1.0 - threshold_F) * Sensor_Data_Filtered;
		END_IF;
	END_IF;

END_FUNCTION_BLOCK
