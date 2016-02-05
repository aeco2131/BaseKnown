if(isServer) then {
	if(alive target2) then {
	
		if(alive target1) then {
		
			if((target2 distance target1) < 70) then {
			
				target2_driver disableAI "MOVE";
				target2_car setVelocity [0,0,0];
				
				[] execVM "scripts\target1_moveTable.sqf";

				target2 forceWalk true;

				waitUntil{sleep 2; (speed target2_car) < 1};
				
				if(target2 in target2_car) then {
					target2 leaveVehicle target2_car;
					sleep 3;
				};
				
				target2 move getMarkerPos "entrance";
				target2 doMove getMarkerPos "entrance";
				target2 moveTo getMarkerPos "entrance";
				
				waitUntil{sleep 1; !alive target2 OR unitReady target2};
				
				target2_driver enableAI "MOVE";
				
				if(alive target2) then {
					target2 disableAI "MOVE";
					target2 setPosATL [6061.67,5626.77,0.00145531];
					target2 setDir 38;
					money attachTo [tisch1,[0,0,0.45]];
					
					target2onTable = true;
					
					if(target1onTable) then {
						[[5], "r3_clientHint"] call BIS_fnc_MP;
					};
				};
			} else {
				[] execVM "scripts\target2_escape.sqf";
			};	
		} else {
			[] execVM "scripts\target2_escape.sqf";
		};
	};
};