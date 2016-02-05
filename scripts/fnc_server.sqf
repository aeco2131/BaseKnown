// SyncTime
if(isDedicated) then {
	r3_syncTime = { 
		setDate [2015, 5, 26, 7, 0];
	};
};

setSkill_normal_red = {
	_unit = _this select 0;
	
	_unit setSkill ["aimingAccuracy",0.45];
	_unit setSkill ["aimingShake",0.45];
	_unit setSkill ["aimingSpeed",0.3];
	_unit setSkill ["spotDistance",0.45];
	_unit setSkill ["spotTime",0.4];
	_unit setSkill ["courage",0.6];
};

setSkill_hard_red = {
	_unit = _this select 0;
	
	_unit setSkill ["aimingAccuracy",0.6];
	_unit setSkill ["aimingShake",0.6];
	_unit setSkill ["aimingSpeed",0.5];
	_unit setSkill ["spotDistance",0.65];
	_unit setSkill ["spotTime",0.65];
	_unit setSkill ["courage",0.8];
};

setSkill_normal_green = {
	_unit = _this select 0;
	
	_unit setSkill ["aimingAccuracy",0.5];
	_unit setSkill ["aimingShake",0.48];
	_unit setSkill ["aimingSpeed",0.5];
	_unit setSkill ["spotDistance",0.5];
	_unit setSkill ["spotTime",0.6];
	_unit setSkill ["courage",0.85];
};

setSkill_hard_green = {
	_unit = _this select 0;
	
	_unit setSkill ["aimingAccuracy",0.75];
	_unit setSkill ["aimingShake",0.7];
	_unit setSkill ["aimingSpeed",0.7];
	_unit setSkill ["spotDistance",0.6];
	_unit setSkill ["spotTime",0.65];
	_unit setSkill ["courage",0.9];
};

chk_dead = {
	_playerCount = 0;
	_downCount = 0;
	{
		if(isPlayer _x) then {
			_playerCount = _playerCount +1;
			if(!alive _x OR _x getVariable ["r3_unitIsDown",0] == 1) then {
				if(isNull(_x getVariable ["r3_unitPrivateMedic", objNull])) then {
					_downCount = _downCount +1;
				};
			};
			sleep 1;
		};
	} forEach units Deltaone;
	
	if(_downCount == _playerCount) then {
		["End3",false, 3] call r3_endMissionMP;
	};
};

target_damageEH = 
{
	private ["_unit", "_handleDamage","_handleNewDamage"];
	
	_unit = _this select 0;
	_handleDamage = _this select 2;
	_handleNewDamage = 0;
	
	if (alive _unit && ((damage _unit) + _handleDamage) >= 0.9) then {

		if((vehicle _unit) != _unit) then { moveOut _unit };
		
		_unit setVelocity [0,0,0];
		_handleNewDamage = 1;
			
	} else {
		_handleNewDamage = _handleDamage;
	};
	_handleNewDamage
};

target1_escapeByHeli = {
	waitUntil{sleep 2; !isNil "target1_heli_ready" OR !alive target1};
	
	if(alive target1) then {
		target1 assignAsCargo target1_heli;
		[target1] orderGetIn true;	
	};
	
	waitUntil{sleep 2; !alive target1 OR target1 in target1_heli};
	
	if(alive target1 && alive target1_pilot && canMove target1_heli) then {
	
		if(!alive target2 OR target2 in target1_heli OR target2 in target2_car OR !target2onTable) then {
		
			target1_pilot doMove getMarkerPos "target1_escape2";
			target1_pilot moveTo getMarkerPos "target1_escape2";

			waitUntil{sleep 2; !alive target1_pilot OR unitReady target1_pilot};
			
			if(unitReady target1_pilot) then {
				if(alive target1) then {
					["target1Task", "FAILED", true] call BIS_fnc_taskSetState;
					sleep 2;
					["End5",false, 3] call r3_endMissionMP;
				};
			};						
		};
	};
};

target2_escapeByHeli = {
	waitUntil{sleep 2; !isNil "target1_heli_ready" OR !alive target2};
	
	if(alive target2) then {
		target2 assignAsCargo target1_heli;
		[target2] orderGetIn true;	
	};
	
	waitUntil{sleep 2; !alive target2 OR target2 in target1_heli};
	
	if(alive target2 && alive target1_pilot && canMove target1_heli) then {
		
		if(!alive target1 OR target1 in target1_car) then {
		
			target1_pilot doMove getMarkerPos "target1_escape2";
			target1_pilot moveTo getMarkerPos "target1_escape2";

			waitUntil{sleep 2; !alive target1_pilot OR unitReady target1_pilot};
			
			if(unitReady target1_pilot) then {
				if(alive target1) then {
					["target1Task", "FAILED", true] call BIS_fnc_taskSetState;
					sleep 2;
					["End6",false, 3] call r3_endMissionMP;
				};
			};
		};
	};
};

ammoCache_damageEH = {
	_cache = _this select 0;
	_damage = _this select 2;
	_source = _this select 3;
	_ammo = _this select 4;
	_out = 0;
	
	if((_ammo == "SatchelCharge_Remote_Ammo") OR (_ammo == "DemoCharge_Remote_Ammo") OR (_ammo == "GrenadeHand")) then {
	
		_cache removeAllEventHandlers "HandleDamage";
		
		_cache spawn {

			sleep (random 0.2);
			_fireTime = 15 + floor(random 10);
			[[_this,_fireTime,"BigDestructionFire"], "r3_effect"] call BIS_fnc_MP;
			
			sleep (random 0.2);
			_smokeTime = 25 + floor(random 10);
			[[_this,_smokeTime,"ObjectDestructionSmokeSmallx"], "r3_effect"] call BIS_fnc_MP;	
			
			if(alive d_netz) then {d_netz setDamage 1};
			
			switch(_this) do {
				case d_ammo1: { ammo1destroyed = true };
				case d_ammo2: { ammo2destroyed = true };
				case d_ammo3: { ammo3destroyed = true };
			};
			
			sleep _smokeTime;
			_this setDamage 1;
			sleep 2;
			deleteVehicle _this;
		};
		_source addScore 10;
	};
	_out
};  

createGoats =
{
	goats = [];
	
	for "_i" from 1 to 10 do {
		_goat = createAgent ["Goat_random_F", getPos hirte, [], 20, "CAN_COLLIDE"];
		_goat setVariable ["BIS_fnc_animalBehaviour_disable", true];
		goats pushBack _goat;
	};
	
	_gcXmin = (getPos goat_center select 0) -20;
	_gcYmin = (getPos goat_center select 1) -20;
	_rndX = ((getPos goat_center select 0) + 20) - _gcXmin;
	_rndY = ((getPos goat_center select 1) + 20) - _gcYmin;
	
	while{true} do {
		_goat = goats call BIS_fnc_selectRandom;
	
		if(alive _goat) then {
			_newPosX =  floor(random _rndX) + _gcXmin;
			_newPosY =  floor(random _rndY) + _gcYmin;
			
			_goat moveTo [_newPosX, _newPosY, 0.1];

			sleep 10 + floor(random 10);
		};
	};
};

fireFlare = 
{
	_obj = _this select 0;
	_flareBrightness = 6;
	
	_flareX = (getPos _obj select 0) - floor(random 50); 
	_flareY = (getPos _obj select 1) + floor(random 50); 
	_height = 180 + floor(random 30);
	_veloX = floor(random 2);
	_veloY = floor(random 2);
	_flare = "F_20mm_Red" createVehicle [_flareX, _flareY, _height];
	_flare setVelocity [_veloX,_veloY, -5];
	sleep 3;
	_light = "#lightpoint" createVehicle getPos _flare; 
	_light setLightBrightness _flareBrightness; 
	_light setLightAmbient [1.0, 0.0, 0.0]; 
	_light setLightColor [1.0, 0.0, 0.0]; 
	_light lightAttachObject [_flare, [0,0,0]];

	while { (alive _flare)} do { 
			sleep 0.4;
			_flareBrightness = (_flareBrightness + 0.1);
			_light setLightBrightness _flareBrightness; 
	};
	deleteVehicle _light;
	deleteVehicle _flare;
};