if(!isNull player) then {

	if!(["hostageTask"] call BIS_fnc_taskExists) then {
		[[], "createHostage_tasks", false] call BIS_fnc_MP;
	};

	if( "FirstAidKit" in (items player) OR "Medikit" in (items player) ) then {
	
		if(currentWeapon player != primaryWeapon player) then {
			player selectWeapon primaryWeapon player;
			sleep 3;
		};
				
		player playActionNow "medicStart";
		sleep 2;
		player playActionNow "medicStart";
		sleep 2;
		player playActionNow "medicStart";
		sleep 2;
		player playActionNow "medicStop";
		
		[[[player],"scripts\hostage_healed.sqf"],"BIS_fnc_execVM", false] call BIS_fnc_MP;
		
		if ("FirstAidKit" in (items player)) then {
			player removeItem "FirstAidKit";
		};
	} else {
		["<t color='#ff9000' shadow='2' size='0.7' font='PuristaLight'>You can't heal without MediKit or FirstAidKit !</t>", 0.6, 0.95, 5, 1] spawn BIS_fnc_dynamicText;
	};
};