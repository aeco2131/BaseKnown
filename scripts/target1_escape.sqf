if(isServer) then {
		
	if(alive target1 && !target1escape_fired) then {
	
		target1escape_fired = true;
		
		if(target1onTable) then {
			detach intel;
			intel setPos getMarkerPos "tmp_respawn";
			target1onTable = false;
		};
		
		target1 addItemToUniform "6Rnd_45ACP_Cylinder";
		target1 addItemToUniform "6Rnd_45ACP_Cylinder";
		target1 addItemToUniform "6Rnd_45ACP_Cylinder";		
		target1 addWeapon "hgun_Pistol_heavy_02_F";
		target1 addHandgunItem "optic_Yorris";
		
		target1 enableAI "MOVE";
		target1 setBehaviour "CARELESS";
		target1 setCombatMode "BLUE";
		target1 setSpeedMode "FULL";
		target1 forceWalk false;
		
		if(alive target1_driver) then {
			target1_driver setBehaviour "CARELESS";
			target1_driver setCombatMode "GREEN";
			target1_driver setSpeedMode "FULL";
		};
		
		_rndEsc = floor(random 3);
		
		if(canMove target1_car && _rndEsc == 1) then {
		
			if(alive target1_driver) then {
				target1 assignAsCargo target1_car;
				[target1] orderGetIn true;
			} else {
				target1 assignAsDriver target1_car;
				[target1] orderGetIn true;				
			};
			
			waitUntil{sleep 1; !alive target1 OR unitReady target1};
			
			if(alive target1 && !alive target1_driver) then {
				target1 assignAsDriver target1_car;
				if(target1 in target1_car) then {
					target1 moveInDriver target1_car;
				} else {
					[target1] orderGetIn true;
				};
			};
			
			waitUntil{sleep 1; !alive target1 OR target1 in target1_car OR !canMove target1_car};
			
			if(alive target1 && target1 in target1_car && canMove target1_car) then {
			
				_escPos1 = getMarkerPos "target1_escape1";
				target1_car move _escPos1;
				target1_car doMove _escPos1;	
				
				waitUntil{sleep 2; !alive target1 OR !canMove target1_car OR (target1_car distance _escPos1) < 100};
				
				if(alive target1) then {
					if(!canMove target1_car OR !alive target1_driver && (target1 distance target_lz) < 250) then {
						target1 leaveVehicle target1_car;
						target1 doMove getPos target_lz;
						target1 moveTo getPos target_lz;
						[] spawn target1_escapeByHeli;
					} else {
						if(alive target1 && target1 in target1_car) then {
							["target1Task", "FAILED", true] call BIS_fnc_taskSetState;
							sleep 2;
							["End5",false, 3] call r3_endMissionMP;
						};
					};
				};					
			} else {
				if(alive target1) then {
					if(!canMove target1_car) then {
						target1 leaveVehicle target1_car;
						target1 doMove getPos target_lz;
						[] call target1_escapeByHeli;
					};
				};
			};
		} else {
			if(canMove quad1) then {
				target1 assignAsDriver quad1;
				[target1] orderGetIn true;
				
				waitUntil{sleep 1; !alive target1 OR unitReady target1};
				
				if(target1 in quad1 && alive target1) then {
				
					_escPos3 = getMarkerPos "target1_escape3";
					target1 move _escPos3;
					target1 doMove _escPos3;
					
					waitUntil{sleep 1; !alive target1 OR unitReady target1};
					
					target1 leaveVehicle quad1;
					
					if(alive target1) then {
						_ne = target1 nearEntities ["man", 30];
						{
							if(side _x == EAST) then {
								if(_x != target1) then {
									[_x] joinSilent target1;
								};
							};
							sleep 0.1;
						}forEach _ne;
					};
				};
			} else {
				target1 doMove getPos target_lz;
				[] call target1_escapeByHeli;
			};
		};		
	};
};