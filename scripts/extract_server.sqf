if(isServer) then {

	_smokeObj = _this select 0; 

	if(!isNull _smokeObj) then {

		if(isNil "extractStarted") then {
		
			extractStarted = true;
			publicVariable "extractStarted";

			// Fire Message to Clients
			_output =
			"<t color='#20a71d' shadow='2' size='0.6' font='PuristaMedium'>Extraction STARTED !</t><br/>"+
			"<t color='#ffffff' shadow='2' size='0.6' font='PuristaMedium'>Wait for the chopper.</t>";
			[[_output, 0.6, 0.95, 4, 1],"BIS_fnc_dynamicText"] call BIS_fnc_MP;

			// Set Marker and LZ
			_extraction_point = [];
			_min_distance = 0;
			_max_distance = 50;
			while{count _extraction_point < 1} do {
				_extraction_point = (getPos _smokeObj) findEmptyPosition[_min_distance, _max_distance, "I_Heli_Transport_02_F" ];
				_max_distance = _max_distance + 50;
				_min_distance = _min_distance + 50;
				sleep 0.5;
			};
				
			lz = "Land_HelipadEmpty_F" createVehicle _extraction_point;
			
			_marker = createMarker ["ext_marker", position lz];
			"ext_marker" setMarkerText " Extraction";
			"ext_marker" setMarkerColor "ColorWEST";
			"ext_marker" setMarkerType "mil_circle";
			
			["extractionTask", getMarkerPos "ext_marker"] call BIS_fnc_taskSetDestination;
			sleep 1;
			["extractionTask", "ASSIGNED", false] call BIS_fnc_taskSetState;
			
			mohawk engineOn true;
			mohawk setFuel 1;	
			mohawk setBehaviour "CARELESS";
			mohawk setCombatMode "BLUE";
			mohawk enableAI "MOVE";
			mohawk flyInHeight 50;
			
			mohawk move (getPos lz);
			mohawk doMove (getPos lz);
			
			waitUntil{sleep 1; (mohawk distance lz) < 400};
			
			mohawk land "GET IN";
			
			waitUntil {sleep 1; (getPosATL mohawk select 2) < 10};
			
			mohawk flyInHeight 1;
			mohawk lock false;
			mohawk animateDoor ["CargoRamp_open",1];
			mohawk animateDoor ["Door_Back_L",1]; 
			mohawk animateDoor ["Door_Back_R",1];
					
			while { ({_x in mohawk} count units Deltaone) != (count units Deltaone) } do {
				mohawk flyInHeight 1;
				sleep 3;
			};
			
			mohawk animateDoor ["CargoRamp_open",0];
			mohawk animateDoor ["Door_Back_L",0]; 
			mohawk animateDoor ["Door_Back_R",0];
			mohawk lock true;

			mohawk move (getMarkerPos "mohawkEnd");
			mohawk flyInHeight 50;
			
			// Play Outro on All Clients
			[[[],"scripts\outro.sqf"],"BIS_fnc_execVM"] call BIS_fnc_MP;
			
			// Check tasks
			if(hostage in mohawk) then {
				["hostageTask", "SUCCEEDED", true] call BIS_fnc_taskSetState;	
			} else {
				if(alive hostage) then {
					["hostageTask", "CANCELED", true] call BIS_fnc_taskSetState;
					["optionalTask", "CANCELED", false] call BIS_fnc_taskSetState;
				};
			};
			
			sleep 3;
			
			if !(ammo1destroyed && ammo2destroyed && ammo3destroyed) then {
				["ammoTask", "CANCELED", true] call BIS_fnc_taskSetState;
				["optionalTask", "CANCELED", false] call BIS_fnc_taskSetState;
			};
			
			sleep 3;
			
			["extractionTask", "SUCCEEDED", true] call BIS_fnc_taskSetState;
			["missionTask", "SUCCEEDED", false] call BIS_fnc_taskSetState;
				
			sleep 15;	
			
			10 fadeMusic 0;
			10 fadeSound 0;
			10 fadeRadio 0;
			["End1",true, 10] call r3_endMissionMP;
		};
	};
};

