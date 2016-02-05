if(isServer) then {

	if(alive hirte && alive target1) then {
	
		[[1], "r3_clientHint"] call BIS_fnc_MP;
		
		sleep 3;
		
		if(!isNil {dog}) then {
			if(alive dog) then {
				[[dog,"dogBark"], "say3DMP"] call BIS_fnc_MP;
			};
		};
		
		sleep (2 + floor(random 15));
		
		_rnd = floor(random 2);
		
		if(_rnd == 1) then {
			
			hirte removeAllEventHandlers "killed";
			hirte enableAI "ANIM";
			
			sleep 2;
			
			_newGrp = createGroup EAST;
			[hirte] joinSilent _newGrp;
			
			hirte setBehaviour "CARELESS";
			hirte setCombatMode "BLUE";
			hirte setSpeedMode "FULL";
			
			hirte move getPos target1;
			hirte doMove getPos target1;
			
			waitUntil{sleep 2; !alive hirte OR !alive target1 OR unitReady hirte};
			
			if(alive hirte && alive target1 && (hirte distance target1) < 10) then {
			
				[[2], "r3_clientHint"] call BIS_fnc_MP;
				
				[] execVM "scripts\alarm.sqf";
				
				hirte addMagazine "30Rnd_65x39_caseless_mag";
				hirte addWeapon "arifle_Katiba_F";
				hirte addPrimaryWeaponItem "acc_flashlight";
				hirte addPrimaryWeaponItem "optic_Hamr";
				hirte addMagazine "30Rnd_65x39_caseless_mag";
				hirte addMagazine "30Rnd_65x39_caseless_mag";
				
				_ne = hirte nearEntities ["Man", 50];
				{
					if(side _x == EAST) then {
						if(!isNil {p1}) then {_x reveal [p1, 1.7]};
						if(!isNil {p2}) then {_x reveal [p2, 1.7]};
						if(!isNil {p3}) then {_x reveal [p3, 1.7]};
						if(!isNil {p4}) then {_x reveal [p4, 1.7]};
						
						_x setBehaviour "COMBAT";
						_x setCombatMode "RED";
						_x setSpeedMode "FULL";
						
						sleep 1;
					};
				}forEach _ne;
			};
		};
	};
};
