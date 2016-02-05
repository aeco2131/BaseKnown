if(isServer) then {

	sleep 4;
	
	if(alive target2) then {
	
		if(canMove target2_car && alive target2_driver) then {
		
			target2_boot engineOn false;
			target2 setBehaviour "CARELESS";
			target2 setCombatMode "BLUE";		
			target2 setSpeedMode "NORMAL";
			target2 limitSpeed 100;
			target2 leaveVehicle target2_boot;
			sleep 1;
			target2 setPosATL [6514.02,4908.42,0.00156355];
			target2 setDir 350;
			target2 forceWalk true;
			target2 doMove getPos target2_car;
			target2 moveTo getPos target2_car;
			sleep 3;
			target2 assignAsCargo target2_car;
			sleep 1;
			[target2] orderGetIn true;
	
			sleep 1;
				
			if(alive t2s1 && alive t2s2) then {
				t2s1 assignAsCargo target2_car;
				t2s2 assignAsCargo target2_car;
				[t2s1,t2s2] orderGetIn true;
			};
				
			waitUntil{sleep 1; target2 in target2_car OR !alive target2 OR !alive target2_driver};
			
			if(alive target2 && alive target2_driver && canMove target2_car) then {
			
				target2_driver enableAI "MOVE";
				target2_driver assignAsDriver target2_car;
				[target2_driver] orderGetIn true;
				
			} else {
				[] execVM "scripts\target2_escape.sqf";
			};
		} else {
			[] execVM "scripts\target2_escape.sqf";
		};
	};
};