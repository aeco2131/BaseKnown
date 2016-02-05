if(isServer) then {

	if(!alarm_fired) then {
	
		alarm_fired = true;
		
		if(alive target1) then {
			[[target1,"whistle"], "say3DMP"] call BIS_fnc_MP;
			_smoke = "SmokeShell" createVehicle getMarkerPos "smoke1";
		} else {
			if(alive target2 && target2onTable) then {
				[[target2,"whistle"], "say3DMP"] call BIS_fnc_MP;
			};
		};
		
		[] spawn {
			if(alive target1_driver OR alive target1_gunner) then {
				_smoke = "SmokeShell" createVehicle getMarkerPos "smoke2"; 
			};
			
			if(alive smoker4 && floor(random 2) == 1) then {
				_smoke = "SmokeShell" createVehicle getMarkerPos "smoke4"; 
			};
			
			if(alive target2 && floor(random 2) == 1) then {
				_smoke = "SmokeShell" createVehicle getMarkerPos "smoke3"; 
			};
			
			if(alive target1_driver) then { [target1_driver] orderGetIn true };
			if(alive target1_gunner) then { [target1_gunner] orderGetIn true };
		};
		
		[] spawn {
			if(alive target1_pilot && canMove target1_heli) then {
			
				target1_pilot enableAI "MOVE";
				target1_pilot setBehaviour "CARELESS";
				target1_pilot setCombatMode "BLUE";
				
				target1_pilot doMove getPos target_lz;
				target1_pilot moveTo getPos target_lz;
				target1_heli flyInHeight 150;
				
				waitUntil{sleep 1; !alive target1_pilot OR !canMove target1_heli OR (target1_heli distance target_lz) < 400};
				
				if(alive target1_pilot && canMove target1_heli && (alive target1 OR alive target2)) then {
					target1_heli land "LAND";
					
					waitUntil{sleep 1; (getPosATL target1_heli select 2) < 5};
					
					target1_heli_ready = true;
					
					if(floor(random 2) == 1) then {
						pfighter1 enableAI "MOVE";
						pfighter2 enableAI "MOVE";
						pfighter1 moveInCargo target1_heli;
						pfighter2 moveInCargo target1_heli;
						sleep 3;
						pfighter1 leaveVehicle target1_heli;
						pfighter2 leaveVehicle target1_heli;
						moveOut pfighter1;
						moveOut pfighter2;
						sleep 1;
						pfighter1 move getPos target2;
						pfighter1 doMove getPos target2;
					};
					
				} else {
					if(alive target1_pilot && canMove target1_heli) then {
					
						if(floor(random 2) == 1) then {
							target1_heli flyInHeight 250;
							target1_heli setSpeedMode "LIMITED";
							sleep 4;
							pfighter1 addBackpackGlobal "B_Parachute";
							pfighter2 addBackpackGlobal "B_Parachute";
							pfighter1 enableAI "MOVE";
							pfighter2 enableAI "MOVE";
							pfighter1 moveInCargo target1_heli;
							pfighter2 moveInCargo target1_heli;
							sleep 1;
							pfighter1 leaveVehicle target1_heli;
							sleep 0.5;
							pfighter2 leaveVehicle target1_heli;
							moveOut pfighter1;
							moveOut pfighter2;
							target1_heli setSpeedMode "FULL";
							pfighter1 move getPos target2;
							pfighter1 doMove getPos target2;
						};
					
						target1_pilot doMove getMarkerPos "target1_escape2";
						target1_pilot moveTo getMarkerPos "target1_escape2";
						
						waitUntil{sleep 2; !alive target1_pilot OR unitReady target1_pilot};
						
						if(unitReady target1_pilot) then {
							deleteVehicle target1_pilot;
							deleteVehicle target1_heli;
						};
					};
				};
			};
		};
		
		if(alive target1) then {
			[] execVM "scripts\target1_escape.sqf";
		};
		
		sleep 0.5;
		
		if(target2onTable OR (target2 distance target1) < 300) then {
			[] execVM "scripts\target2_escape.sqf";
		};
	};
};



