if(isServer) then {

	if(alive target1 && target1onTable) then {
		[] execVM "scripts\alarm.sqf";
	};
	
	if(!target2onTable && isNil "moneytaken") then {
		money setPosATL [(getPosATL target2 select 0) +0.7,(getPosATL target2 select 1) +0.7,(getPosATL target2 select 2) + 0.5];
	};
	
	["target2Task", "SUCCEEDED", false] call BIS_fnc_taskSetState;

	if(alive t2s1) then {
		if(t2s1 in target2_car) then {t2s1 leaveVehicle target2_car};
		t2s1 setBehaviour "COMBAT";
		t2s1 setCombatMode "RED";
		t2s1 setSpeedMode "FULL";
	};
		
	if(alive t2s2) then {
		if(t2s2 in target2_car) then {t2s2 leaveVehicle target2_car};
		t2s2 setBehaviour "COMBAT";
		t2s2 setCombatMode "RED";
		t2s2 setSpeedMode "FULL";
	};

	if(alive target2_driver) then {
		if(target2_driver in target2_car) then {target2_driver leaveVehicle target2_car};
		target2_driver setBehaviour "COMBAT";
		target2_driver setCombatMode "RED";
		target2_driver setSpeedMode "FULL";
	};
	
	sleep 1;
	
	[] call createMoney_task;
	
	waitUntil{sleep 2; !isNil "moneytaken"};
	
	["moneyTask", "SUCCEEDED", true] call BIS_fnc_taskSetState;
	
	sleep 15;
	
	if(!alive target1 && !isNil "inteltaken") then {
		[] call createExtraction_task;
	};
};