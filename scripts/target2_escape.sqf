if(isServer) then {
		
	if(alive target2 && !target2escape_fired) then {
	
		target2escape_fired = true;
		 
		if(target2onTable) then {
			detach money;
			money setPos getMarkerPos "tmp_respawn";
			target2onTable = false;
		};
		
		target2 addItemToUniform "6Rnd_45ACP_Cylinder";
		target2 addItemToVest "6Rnd_45ACP_Cylinder";
		target2 addItemToVest "6Rnd_45ACP_Cylinder";		
		target2 addWeapon "hgun_Pistol_heavy_02_F";
		target2 addHandgunItem "optic_Yorris";
		
		target2 enableAI "MOVE";
		target2 setCombatMode "BLUE";
		target2 setBehaviour "CARELESS";
		target2 setSpeedMode "FULL";
		target2 forceWalk false;
		
		if(target2 in target2_boot && canMove target2_boot) then {
			
			_escPos = getMarkerPos "target2_escape1";
			target2 move _escPos;
			target2 doMove _escPos;
			target2 moveTo _escPos;
			
			target2 setSpeedMode "NORMAL";
			target2_boot limitSpeed 200;
			
			waitUntil{sleep 1; !alive target2 OR (target2 distance _escPos) < 200};
			
			if(alive target2) then {
				["target2Task", "FAILED", true] call BIS_fnc_taskSetState;
				sleep 2;
				["End2",false, 3] call r3_endMissionMP;			
			};
			
		} else {
		
			if(canMove target2_car) then {
			
				if(target2 in target2_car) then {
					
					if(!alive target2_driver) then {
						target2 assignAsDriver target2_car;
						target2 moveInDriver target2_car;
					};
					
					if(alive t2s1 && alive t2s2) then {
						if(t2s1 in target2_car) then {t2s1 leaveVehicle target2_car};
						if(t2s2 in target2_car) then {t2s2 leaveVehicle target2_car};
						t2s1 setBehaviour "CPMBAT";
						t2s1 setCombatMode "RED";
						t2s1 setSpeedMode "FULL";
					};
					
					_escPos = getMarkerPos "target2_escape2";
					target2_car doMove _escPos;
					target2_car moveTo _escPos;					
					
					waitUntil{sleep 2; !alive target2 OR (target2_car distance _escPos) < 100};

					if(alive target2) then { 
						["target2Task", "FAILED", true] call BIS_fnc_taskSetState;
						sleep 2;
						["End6",false, 3] call r3_endMissionMP;
					};					
				} else {
					
					if(alive target2_driver) then {
						if!(target2_driver in target2_car) then {
							[target2_driver] orderGetIn true;
						};
						target2 assignAsCargo target2_car;
						[target2] orderGetIn true;
					} else {
						target2 assignAsDriver target2_car;
						[target2] orderGetIn true;
					};
					
					waitUntil{sleep 1; !alive target2 OR target2 in target2_car};
					
					if(!alive target2_driver && target2 in target2_car) then {
						target2 assignAsDriver target2_car;
						target2 moveInDriver target2_car;
					};		
					
					if(alive target2) then {
					
						_escPos = getMarkerPos "target2_escape2";
						target2_car move _escPos;
						target2_car doMove _escPos;
						target2_car moveTo _escPos;	
						
						waitUntil{sleep 2; !alive target2 OR !canMove target2_car OR !alive target2_driver OR (target2 distance _escPos) < 100};
						
						if(alive target2) then {
							if(!alive target2_driver && canMove target2_car) then {
								target2 moveInDriver target2_car;
								
								_escPos = getMarkerPos "target2_escape2";
								target2 move _escPos;
								target2 doMove _escPos;
								target2 moveTo _escPos;	
								
								waitUntil{sleep 2; !alive target2 OR (target2 distance _escPos) < 100};
								
								if(alive target2) then { 
									["target2Task", "FAILED", true] call BIS_fnc_taskSetState;
									sleep 2;
									["End6",false, 3] call r3_endMissionMP;
								};
							} else {
								if(!canMove target2_car && (target2 distance target_lz) < 250) then {
									target2 leaveVehicle target2_car;
									target2 doMove getPos target_lz;
									target2 moveTo getPos target_lz;
									[] spawn target2_escapeByHeli;
								} else {
									if(alive target2) then { 
										["target2Task", "FAILED", true] call BIS_fnc_taskSetState;
										sleep 2;
										["End6",false, 3] call r3_endMissionMP;
									};
								};
							};
						};
					};
				};	
			} else {
				if(target2onTable) then {
					if(alive target2) then {
						target2 doMove getPos target_lz;
						target2 moveTo getPos target_lz;
						[] spawn target2_escapeByHeli;
					};
				} else {
					_distanceBoot = target2 distance target2_boot;
					_distanceLZ = target2 distance target_lz;
					
					if(canMove target2_boot && (_distanceBoot < _distanceLZ)) then {
				
						target2 doMove getPos target2_boot;
						target2 moveTo getPos target2_boot;
						
						sleep 2;
						
						target2 assignAsDriver target2_boot;
						[target2] orderGetIn true;
						
						waitUntil{sleep 1; !alive target2 OR target2 in target2_boot};
						
						_escPos = getMarkerPos "target2_escape1";
						
						if(alive target2 && canMove target2_boot) then {
							target2 move _escPos;
							target2 doMove _escPos;
							target2 moveTo _escPos;	
						};
						
						waitUntil{sleep 1; !alive target2 OR (target2 distance _escPos) < 300};
						
						if(alive target2) then {
							["target2Task", "FAILED", true] call BIS_fnc_taskSetState;
							sleep 2;
							["End6",false, 3] call r3_endMissionMP;
						};	
					} else {
						if(alive target2) then {
							target2 doMove getPos target_lz;
							target2 moveTo getPos target_lz;
							[] spawn target2_escapeByHeli;
						};
					};
				};
			};
		};
	};
};
