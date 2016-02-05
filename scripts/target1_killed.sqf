if(isServer) then {

	if(alive target2 && target2onTable) then {
		[] execVM "scripts\alarm.sqf";
	};
	
	if(!target1onTable && isNil "inteltaken") then {
		intel setPosATL [(getPosATL target1 select 0) +0.7,(getPosATL target1 select 1) +0.7,(getPosATL target1 select 2) + 0.5];
	};
	
	["target1Task", "SUCCEEDED", false] call BIS_fnc_taskSetState;

	sleep 1;
	
	[] call createIntel_task;
	
	waitUntil{sleep 2; !isNil "inteltaken"};
	
	["intelTask", "SUCCEEDED", true] call BIS_fnc_taskSetState;	

	sleep 15;
	
	if(!alive target2 && !isNil "moneytaken") then {
		[] call createExtraction_task;
	};	
};