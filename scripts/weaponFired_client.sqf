if(!isNull player) then {

	_runExtraction = false;
	_ammoUsed = _this select 4;

	if(_ammoUsed == "SmokeShellGreen") then {
	
		if(!alive target1) then {
			if(!alive target2) then {
				if(!isNil "moneytaken") then {
					if(!isNil "inteltaken") then {	
						if(isNil "extractStarted") then {
							_runExtraction = true;
						};
					};
				};
			};
		};
		
		if(_runExtraction) then {
		
			sleep 3;
			
			_smoke = getPos player nearObjects ["SmokeShellGreen", 400];
			_smokeObj = (_smoke select 0);
			
			if(!isNull _smokeObj) then {
				_readdSmokeShell = false;
				[[[_smokeObj],"scripts\extract_server.sqf"],"BIS_fnc_execVM",false] call BIS_fnc_MP;	
			} else {
				["<t color='#ff9000' shadow='2' size='0.6' font='PuristaMedium'>SmokeShell ERROR ! Please try again.</t>", 0.6, 0.95, 4, 1] spawn BIS_fnc_dynamicText;
				player addItemToVest "SmokeShellGreen";
				_readdSmokeShell = false;
			};	
		} else {
		
			sleep 3;
			
			_smoke = getPos player nearObjects ["SmokeShellGreen", 400];
			_smokeObj = (_smoke select 0);
			
			if(isNil "extractStarted") then {
				_output =
				"<t color='#ff0000' shadow='2' size='0.6' font='PuristaMedium'>Extraction ABORTED !</t><br/>"+
				"<t color='#ffffff' shadow='2' size='0.6' font='PuristaMedium'>Main mission not done yet.</t>";
				[_output, 0.6, 0.95, 4, 1] spawn BIS_fnc_dynamicText;
			} else {
				["<t color='#ff9000' shadow='2' size='0.6' font='PuristaMedium'>Extraction already started.</t>", 0.6, 0.95, 4, 1] spawn BIS_fnc_dynamicText;
			};
			
			if(!isNull _smokeObj) then { deleteVehicle _smokeObj };
			player addItemToVest "SmokeShellGreen";	
		};
	};
};
